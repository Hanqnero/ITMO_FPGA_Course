module display_595 (
    input  wire        clk,
    input  wire [31:0] bcd,

    output wire        SPI_SR_DI,
    output wire        SPI_SR_CLK,
    output wire        SPI_SR_NSS
);
    reg [2:0] digit_select = 3'd0;

    reg [3:0] cur_bcd;
    always @* begin
        // Flip display order: digit_select 0 now shows the lowest nibble
        case (digit_select)
            3'd0: cur_bcd = bcd[3:0];
            3'd1: cur_bcd = bcd[7:4];
            3'd2: cur_bcd = bcd[11:8];
            3'd3: cur_bcd = bcd[15:12];
            3'd4: cur_bcd = bcd[19:16];
            3'd5: cur_bcd = bcd[23:20];
            3'd6: cur_bcd = bcd[27:24];
            3'd7: cur_bcd = bcd[31:28];
        endcase
    end

    wire [7:0] segs_decoded;
    bcd_to_7seg segdec (
        .bcd(cur_bcd),
        .seg(segs_decoded)
    );

    reg [7:0] digs_decoded;
    always @* begin
        case (digit_select)
            3'd0: digs_decoded = ~8'b11111110;
            3'd1: digs_decoded = ~8'b11111101;
            3'd2: digs_decoded = ~8'b11111011;
            3'd3: digs_decoded = ~8'b11110111;
            3'd4: digs_decoded = ~8'b11101111;
            3'd5: digs_decoded = ~8'b11011111;
            3'd6: digs_decoded = ~8'b10111111;
            3'd7: digs_decoded = ~8'b01111111;
        endcase
    end

    reg [15:0] refresh_cnt = 16'd0;
    wire      refresh_tick = (refresh_cnt == 16'd0);

    always @(posedge clk) begin
        refresh_cnt <= refresh_cnt + 1'b1;
    end

    reg        spi_start = 1'b0;
    reg [15:0] spi_data  = 16'd0;
    wire       spi_busy;

    spi_to_595 shifter (
        .clk       (clk),
        .start     (spi_start),
        .data      (spi_data),
        .busy      (spi_busy),
        .SPI_SR_DI (SPI_SR_DI),
        .SPI_SR_CLK(SPI_SR_CLK),
        .SPI_SR_NSS(SPI_SR_NSS)
    );

    always @(posedge clk) begin
        if (!spi_busy && refresh_tick) begin
            spi_data   <= {digs_decoded, segs_decoded}; 
            spi_start  <= 1'b1;                
            digit_select <= digit_select + 1'b1;     
        end else begin
            spi_start <= 1'b0;
        end
    end

endmodule
