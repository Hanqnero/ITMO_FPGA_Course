module uart_rx_fsm (
    input        clk,
    input        rst,
    input        rxd,
    input        baud_tick,

    output reg [7:0] dout,
    output reg       data_ready
);

parameter IDLE  = 3'b000;
parameter START = 3'b001;
parameter DATA  = 3'b010;
parameter STOP  = 3'b011;
parameter DONE  = 3'b100;

reg [2:0] state, next_state;
reg [3:0] bit_cnt;
reg [7:0] shift_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
        bit_cnt <= 0;
        shift_reg <= 0;
        dout <= 0;
        data_ready <= 0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                data_ready <= 0;
            end
            START: begin
                bit_cnt <= 0;
                shift_reg <= 0;
            end
            DATA: begin
                if (baud_tick) begin
                    shift_reg <= {rxd, shift_reg[7:1]};
                    if (bit_cnt < 7) bit_cnt <= bit_cnt + 1;
                end
            end
            STOP: begin
                if (baud_tick) begin
                    dout <= shift_reg;
                    data_ready <= 1;
                end
            end
            DONE: begin
                data_ready <= 0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (!rxd) next_state = START;
        end
        START: begin
            if (baud_tick) next_state = DATA;
        end
        DATA: begin
            if (baud_tick && bit_cnt == 7) next_state = STOP;
        end
        STOP: begin
            if (baud_tick) next_state = DONE;
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule