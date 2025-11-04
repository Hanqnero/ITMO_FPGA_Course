`timescale 1ns / 1ps

module Analyse_tb;

    reg [3:0] a, b, c, d, e;
    wire [3:0] q;
    Analyse an (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .q(q)
    );

    initial begin
        $dumpfile("wave.vcd");
		$dumpvars(0, Analyse_tb);

        $display("Running testbench for two_of_four module...");
        $display("a b c d e | q | Result");
        $display("-----------------------------");

        a <= 4'ha;
        b <= 4'hb;
        c <= 0;
        d <= 4'hd;
        e <= 4'he;

        repeat (16) begin
            #5
            c <= c+1;
        end

        $display("-----------------------------");
        $finish;
    end

    initial begin
		$monitor("t=%-4d: a = %d, b = %d, c = %d, d = %d, q = %d", $time, a, b, c, d, q);
	end

endmodule