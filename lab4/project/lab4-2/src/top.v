module top (
    input  wire Clock,
       
    output wire SPI_SR_DI, 
    output wire SPI_SR_CLK,  
    output wire SPI_SR_NSS,
    
    output reg LED1
);
    initial LED1 <= 0;

    wire [31:0] bcd;
    wire pulse;

   counter_bcd core (
        .Clock(Clock),
        .bcd  (bcd),
        .pulse(pulse)
    );

    display_595 disp (
        .clk       (Clock),
        .bcd       (bcd),
        .SPI_SR_DI (SPI_SR_DI),
        .SPI_SR_CLK(SPI_SR_CLK),
        .SPI_SR_NSS(SPI_SR_NSS)
    );

endmodule
