module spi_to_595 (
    input        clk,
    input        start,
    input  [15:0] data,    
    output reg   busy,       

    output reg   SPI_SR_DI, 
    output reg   SPI_SR_CLK,    
    output reg   SPI_SR_NSS     
);

    reg [15:0] shift_reg = 16'd0;
    reg [4:0]  bit_cnt   = 5'd0;

    localparam S_IDLE       = 2'd0;
    localparam S_SHIFT_LOW  = 2'd1;
    localparam S_SHIFT_HIGH = 2'd2;
    localparam S_LATCH      = 2'd3;

    reg [1:0] state = S_IDLE;

    always @(posedge clk) begin
        case (state)
            S_IDLE: begin
                SPI_SR_CLK <= 1'b0;
                SPI_SR_NSS <= 1'b0;
                busy       <= 1'b0;

                if (start) begin
                    busy      <= 1'b1;
                    shift_reg <= data;
                    bit_cnt   <= 5'd0;
                    state     <= S_SHIFT_LOW;
                end
            end

            S_SHIFT_LOW: begin
                SPI_SR_DI  <= shift_reg[0];
                SPI_SR_CLK <= 1'b0;
                state      <= S_SHIFT_HIGH;
            end

            S_SHIFT_HIGH: begin
                SPI_SR_CLK <= 1'b1;

                shift_reg  <= {1'b0, shift_reg[15:1]};
                bit_cnt    <= bit_cnt + 1'b1;

                if (bit_cnt == 5'd15)
                    state <= S_LATCH;
                else
                    state <= S_SHIFT_LOW;
            end

            S_LATCH: begin
                SPI_SR_CLK <= 1'b0;
                SPI_SR_NSS <= 1'b1;

                busy       <= 1'b0;
                state      <= S_IDLE; 
            end

            default: state <= S_IDLE;
        endcase
    end

endmodule
