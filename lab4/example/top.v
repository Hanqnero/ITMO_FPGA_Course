module top (
    input  wire Clock,       
    output wire SPI_SR_DI, 
    output wire SPI_SR_CLK,  
    output wire SPI_SR_NSS   
);

    wire [31:0] bcd;

   counter_bcd core (
        .Clock(Clock),
        .bcd  (bcd)
    );

    display_595 disp (
        .clk       (Clock),
        .bcd       (bcd),
        .SPI_SR_DI (SPI_SR_DI),
        .SPI_SR_CLK(SPI_SR_CLK),
        .SPI_SR_NSS(SPI_SR_NSS)
    );

endmodule
