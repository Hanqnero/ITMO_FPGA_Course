`timescale 1ns / 1ps

module Analyse_tb;

    reg clk = 1;
    reg a, b;
    wire q, state;
	always #5 clk <= ~clk;
    Analyse an (
        .clk(clk),
        .a(a),
        .b(b),
        .state(state),
        .q(q)
    );
    initial begin
        $dumpfile("wave.vcd");
		$dumpvars(0, Analyse_tb);

        $display("Running testbench for two_of_four module...");
        $display("clk a | p q | Result");
        $display("-----------------------------");
        
        a <= 0;
        b <= 0;
        #40     //40
        a <= 0;
        b <= 1;
        #10     //50
        a <= 1;
        b <= 0;
        #10     //60
        a <= 1;
        b <= 1;
        #10     //70
        a <= 0;
        b <= 0;
        #10     //80
        a <= 1;
        b <= 1;
        #30     //110
        a <= 1;
        b <= 0;
        #10     //120
        a <= 0;
        b <= 1;
        #10     //130
        a <= 0;
        b <= 0;
        #30
        $display("-----------------------------");
        $finish;
    end

    initial begin
		$monitor("t<=%-4d: clk <= %d, a <= %d, b <= %d, q <= %d, state <= %d", $time, clk, a, b, q, state);
	end

endmodule