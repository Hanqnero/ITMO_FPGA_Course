module lab4_top(
    input ButtonS0,
    input ButtonS1,
    input ButtonS2,
 
    output LED0,
    output LED1,
    output LED2,
    output LED3,
    output LED4,
    output LED5,
    output LED6,
    output LED7,

    input Clock,

    output SPI_SR_DI,
    output SPI_SR_NSS,
    output SPI_SR_CLK
);

lab4_task1 t1(
    .ButtonS0(ButtonS0),
    .ButtonS1(ButtonS1),
    .ButtonS2(ButtonS2),

    .LED0(LED0),
    .LED1(LED1),
    .LED2(LED2),
    .LED3(LED3),
    .LED4(LED4),
    .LED5(LED5),
    .LED6(LED6),
    .LED7(LED7)
);

lab4_task2 t2(
    .Clock(Clock),

    .SPI_SR_DI(SPI_SR_DI),
    .SPI_SR_NSS(SPI_SR_NSS),
    .SPI_SR_CLK(SPI_SR_CLK)
);

endmodule