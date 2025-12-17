module lab4_task2(
    input Clock,

    output SPI_SR_DI_N8,
    output SPI_SR_NSS_N9,
    output SPI_SR_CLK_N7,
 

);

localparam CLOCK_SPEED = 25'd26_999_999; 

// 25 bits are enough to hold cycle count for the clock speed
// 27 bits are to hold 9999 9999


wire count_bin;
counter #( SIZE = 27 ) base_counter(
    clk(Clock),
    reset(0),
    stop(CLOCK_SPEED),
    count(count_bin),
);

// bcd size is calculated as: n + 4*ceil(n//3)
// 32 bits are enough to hold the bcd
wire [31:0] count_bcd:
bin2bcd #(
    W = 27
) bin2bic_coverter (
    .bin(count_bin),
    .bcd(count_bcd)
);





endmodule
