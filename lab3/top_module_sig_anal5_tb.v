`timescale 1ns / 1ps

module Analyze_tb; 
    reg clk = 1;
    always #5 clk = !clk;

    reg a = 1;
    wire [2:0] q;

    Analyze an (
        .clk(clk),
        .a(a),
        .q(q)
    );

    initial begin
        $dumpfile("wave.vcd");
		$dumpvars(0, Analyze_tb);

        $display("Running testbench for two_of_four module...");
        $display("clk a | q | Result");
        $display("-----------------------------");

        #40
        a <= 0;

        #115
        a <= 1;

        #25
        a <= 0;

        #50

        $display("-----------------------------");
        $finish;
    end

    initial begin
		$monitor("t=%-4d: clk = %d, a = %d, q = %d", $time, clk, a, q);
	end
endmodule