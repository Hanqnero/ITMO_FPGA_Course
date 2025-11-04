`timescale 1ns / 1ps

module Analyse_tb;

    reg a, b, c, d;
    wire q;
    Analyse an (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .q(q)
    );

    initial begin
        $dumpfile("wave.vcd");
		$dumpvars(0, Analyse_tb);

        $display("Running testbench for two_of_four module...");
        $display("a b c d | q | Result");
        $display("-----------------------------");

        a <= 0;
        b <= 0;
        c <= 0;
        d <= 0;

        #5
        {a,b,c,d} <= 4'b0001;

        #5
        {a,b,c,d} <= 4'b0010;

        #5
        {a,b,c,d} <= 4'b0011;

        #5
        {a,b,c,d} <= 4'b0100;
        
        #5
        {a,b,c,d} <= 4'b0101;

        #5
        {a,b,c,d} <= 4'b0110;
        
        #5
        {a,b,c,d} <= 4'b0111;

        #5 
        {a,b,c,d} <= 4'b1000;
        
        #5 
        {a,b,c,d} <= 4'b1001;

        #5 
        {a,b,c,d} <= 4'b1010;
        
        #5 
        {a,b,c,d} <= 4'b1011;
        
        #5 
        {a,b,c,d} <= 4'b1100;

        #5 
        {a,b,c,d} <= 4'b1101;

        #5 
        {a,b,c,d} <= 4'b1110;

        #5 
        {a,b,c,d} <= 4'b1111;

        #5 
        {a,b,c,d} <= 4'b0000;
        
        #5 
        {a,b,c,d} <= 4'b0001;

        $display("-----------------------------");
        $finish;
    end

    initial begin
		$monitor("t=%-4d: a = %d, b = %d, c = %d, d = %d, q = %d", $time, a, b, c, d, q);
	end

endmodule