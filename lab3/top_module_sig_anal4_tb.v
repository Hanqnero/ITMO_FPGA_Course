`timescale 1ns / 1ps

module Analyse_tb;

    reg clk=0;
    reg a, p, q;
	always #30 clk = !clk;
    Analyse an (
        .clk(clk),
        .a(a),
        .p(p),
        .q(q)
    );
    initial begin
        $dumpfile("wave.vcd");
		$dumpvars(0, Analyse_tb);

        $display("Running testbench for two_of_four module...");
        $display("clk a | p q | Result");
        $display("-----------------------------");
        
        a <= 0;
        #75

        // 1
        a <= 1;
        #5
        a <= 0;

        #5

        // 2
        a <= 1;
        #5
        a <= 0;

        #5

        // 3
        a <= 1;
        #5
        a <= 0;

        #5

        // 4
        a <= 1;
        #5
        a <= 0;

        #5

        // 5
        a <= 1;
        #5
        a <= 0;

        #5

        // 6
        a <= 1;
        #5
        a <= 0;

        #5

        // 7
        a <= 1;
        #5
        a <= 0;

        #30

        // 8
        a <= 1;
        #5
        a <= 0;

        #5

        // 9
        a <= 1;
        #5
        a <= 0;

        #5

        // 10
        a <= 1;
        #5
        a <= 0;

        #5

        // 11
        a <= 1;
        #5
        a <= 0;

        $display("-----------------------------");
        $finish;
    end

    initial begin
		$monitor("t=%-4d: clk = %d, a = %d, p = %d, q = %d", $time, clk, a, p, q);
	end

endmodule