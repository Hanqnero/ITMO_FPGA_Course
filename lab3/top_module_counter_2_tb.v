`timescale 1ns / 1ps

module shift_count_reg_tb;

    reg clk = 0;
    reg shift_ena = 0;
    reg count_ena = 0;
    reg data = 0;
    wire [3:0] q;

    // Генерация тактового сигнала
    always #5 clk = ~clk;

    // Подключение DUT
    shift_count_reg dut (
        .clk(clk),
        .shift_ena(shift_ena),
        .count_ena(count_ena),
        .data(data),
        .q(q)
    );

    initial begin
        $dumpfile("shift_count.vcd");
        $dumpvars(0, shift_count_reg_tb);

        // Начальное состояние
        data = 1; shift_ena = 1; count_ena = 0;
        #10;  // Сдвиги нескольких бит
        data = 0; #10;
        data = 1; #10;
        data = 1; #10;

        // Переход в режим счётчика
        shift_ena = 0; #50;
        count_ena = 1;
        #50;

        $finish;
    end

endmodule
