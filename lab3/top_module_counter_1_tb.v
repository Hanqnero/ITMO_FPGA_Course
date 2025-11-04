`timescale 1ns / 1ps

module counter_0_to_999_tb;

    reg clk = 0;
    reg reset = 0;
    wire [9:0] count;

    always #5 clk = ~clk;

    counter_0_to_999 dut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, counter_0_to_999_tb);
        #130
        reset = 1;  #10;
        reset = 0; 
        #20;
        $finish;
    end

endmodule
