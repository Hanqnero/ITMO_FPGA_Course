// top.v
module top (
    input        clk,        // 27 MHz
    input        rst,

    input        rxd,
    output       txd
);

// Baud tick generator (115200 @ 27 MHz)
reg [7:0] baud_counter;
wire baud_tick;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        baud_counter <= 0;
    end else begin
        if (baud_counter == 234 - 1) begin  // 27e6 / 115200 = 234
            baud_counter <= 0;
        end else begin
            baud_counter <= baud_counter + 1;
        end
    end
end
assign baud_tick = (baud_counter == 234 - 1);

// UART RX
wire [7:0] rx_byte;
wire       rx_done;
uart_rx_fsm u_rx (
    .clk(clk),
    .rst(rst),
    .rxd(rxd),
    .baud_tick(baud_tick),
    .dout(rx_byte),
    .data_ready(rx_done)
);

// UART TX
reg        tx_start;
reg [7:0]  tx_data_out;
wire       tx_done;
uart_tx_fsm u_tx (
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .din(tx_data_out),
    .baud_tick(baud_tick),
    .txd(txd),
    .tx_done(tx_done)
);

// === 8-byte circular buffer ===
reg [7:0] buffer [0:7];         
reg [2:0] wr_ptr;  // write pointer (0..7)

// Write received byte into buffer
always @(posedge clk or posedge rst) begin
    if (rst) begin
        wr_ptr <= 0;
        integer i;
        for (i = 0; i < 8; i = i + 1) buffer[i] <= 8'h00;
    end else if (rx_done) begin
        buffer[wr_ptr] <= rx_byte;
        wr_ptr <= wr_ptr + 1;  // circular (mod 8 via 3-bit counter)
    end
end

// === TX state machine: send all 8 bytes after each RX ===
reg [2:0] tx_index;
reg       tx_active;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        tx_start   <= 0;
        tx_active  <= 0;
        tx_index   <= 0;
    end else begin
        if (rx_done && !tx_active) begin
            // Start transmission sequence
            tx_active <= 1;
            tx_index  <= 0;
            tx_start  <= 1;
            tx_data_out <= buffer[0];
        end else if (tx_active) begin
            if (tx_start && tx_done) begin
                // Finished current byte
                if (tx_index == 7) begin
                    // Done all 8 bytes
                    tx_active <= 0;
                    tx_start  <= 0;
                end else begin
                    // Go to next byte
                    tx_index <= tx_index + 1;
                    tx_data_out <= buffer[tx_index + 1];
                    // tx_start stays high until next tx_done
                end
            end
            // Keep tx_start high until tx_done asserts
            if (!tx_done) begin
                tx_start <= 1;
            end 
        end else begin
            tx_start <= 0;
        end
    end
end

endmodule