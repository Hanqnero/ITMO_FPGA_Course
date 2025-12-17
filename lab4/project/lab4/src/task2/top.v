module lab4_task2(
    input Clock,

    output SPI_SR_DI,
    output SPI_SR_NSS,
    output SPI_SR_CLK

);

localparam CLOCK_SPEED = 25'd26_999_999; 

// 25 bits are enough to hold cycle count for the clock speed
// 27 bits are to hold 9999 9999


//wire [26:0] count_bin;
//counter #( .SIZE(27) ) base_counter(
//    .clk(Clock),
//    .reset(0),
//    .stop(27'd99999999),
//    .count(count_bin)
//);

// bcd size is calculated as: n + 4*ceil(n//3)
// 32 bits are enough to hold the bcd

wire [31:0] count_bcd;
bin2bcd bin2bcd_converter (
    .bin(27'h000005),
    .bcd(count_bcd)
);

display_595 disp (
    .clk(Clock),
    .bcd(count_bcd),
    .SPI_SR_DI(SPI_SR_DI),
    .SPI_SR_CLK(SPI_SR_CLK),
    .SPI_SR_NSS(SPI_SR_NSS)
);


endmodule
