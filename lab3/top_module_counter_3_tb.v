`timescale 1ns / 1ps

module tb_sequence_detector_1101;

    reg clk;
    reg reset;
    reg data;
    wire start_shifting;

    sequence_detector_1101 fsm (
        .clk(clk),
        .reset(reset),
        .data(data),
        .start_shifting(start_shifting)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("fsm_mini.vcd");
		$dumpvars(0, tb_sequence_detector_1101);

        clk = 0;
        reset = 1;
        data = 0;
        #10 reset = 0;      //10
        
        #10 data = 1;       //20
        
        #10 data = 0;       //30
        
        #10 data = 1;       //40
        
        #50 data = 0;       //90
        
        #10 data = 1;       //100
        
        #20 data = 0;       //120
        
        #20 data = 1; 
        reset = 1;          //140
        
        #40
        $display("Simulation finished.");
        $finish;
    end
endmodule