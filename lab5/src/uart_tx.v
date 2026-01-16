// // top.v
// module top (
//     input        clk,        // 27 MHz
//     input        rst,

//     input        rxd,
//     output       txd,

//     input        btn_inc,    // +1
//     input        btn_dec,    // -1

//     output [7:0] led
// );

// // Baud tick generator (115200 @ 27 MHz)
// reg [7:0] baud_counter;
// wire baud_tick;
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         baud_counter <= 0;
//     end else begin
//         if (baud_counter == 234 - 1) begin      //  27 Mhz / 115200 = 234
//             baud_counter <= 0;
//         end else begin
//             baud_counter <= baud_counter + 1;
//         end
//     end
// end
// assign baud_tick = (baud_counter == 234 - 1);

// // UART modules
// wire [7:0] rx_byte;
// wire       rx_done;
// wire       tx_busy;
// reg        tx_start;

// uart_rx_fsm u_rx (
//     .clk(clk),
//     .rst(rst),
//     .rxd(rxd),
//     .baud_tick(baud_tick),
//     .dout(rx_byte),
//     .data_ready(rx_done)
// );

// uart_tx_fsm u_tx (
//     .clk(clk),
//     .rst(rst),
//     .tx_start(tx_start),
//     .din(rx_byte),          // дублируем принятый байт
//     .baud_tick(baud_tick),
//     .txd(txd),
//     .tx_done(tx_busy)
// );

// reg send_req, inc_req, dec_req;
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         send_req <= 0;
//         inc_req <= 0;
//         dec_req <= 0;
//     end else begin
//         inc_req <= btn_inc;
//         dec_req <= btn_dec;
//     end
// end

// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         tx_start <= 0;
//     end 
//     else if (tx_busy) begin
//             tx_start <= 0;
//     end
//     else begin 
//         tx_start <= 1 
//     end
// end

// // LED output and +/-1 logic
// reg [7:0] led_reg;
// always @(posedge clk or posedge rst) begin
//     if (rst) begin
//         led_reg <= 0;
//     end else begin
//         if (tx_busy) begin
//             led_reg <= rx_byte;
//         end else if (inc_req) begin
//             led_reg <= led_reg + 2;
//         end else if (dec_req) begin
//             led_reg <= led_reg - 1;
//         end
//     end
// end

// assign led = led_reg;

// endmodule