module uart_tx_fsm (
    input        clk,
    input        rst,
    input        tx_start,
    input  [7:0] din,
    input        baud_tick,

    output reg   txd,
    output reg   tx_done
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
        txd <= 1'b1; 
        tx_done <= 1'b0;
        shift_reg <= 8'd0;
        bit_cnt <= 4'd0;
    end else begin
        state <= next_state;

        case (state)
            IDLE: begin
                txd <= 1'b1;
                tx_done <= 1'b0;
                if (tx_start)
                    shift_reg <= din;
            end
            START: begin
                txd <= 1'b0;
            end
            DATA: begin
                if (baud_tick) begin
                    txd <= shift_reg[0];
                    shift_reg <= {1'b0, shift_reg[7:1]};
                    if (bit_cnt < 4'd7)
                        bit_cnt <= bit_cnt + 1;
                end
            end
            STOP: begin
                if (baud_tick)
                    txd <= 1'b1;
            end
            DONE: begin
                tx_done <= 1'b1;
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
            if (tx_start)
                next_state = START;
            else
                next_state = IDLE;
        end
        START: begin
            if (baud_tick)
                next_state = DATA;
            else
                next_state = START;
        end
        DATA: begin
            if (baud_tick && bit_cnt == 4'd7)
                next_state = STOP;
            else
                next_state = DATA;
        end
        STOP: begin
            if (baud_tick)
                next_state = DONE;
            else
                next_state = STOP;
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