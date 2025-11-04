`timescale 1ns/1ps
module top_fsm_tb;

    reg clk = 1;
    always #5 clk = ~clk;

    reg reset = 1; reg ack = 0;  
    reg count[3:0]; reg data = 0;
    wire done;
    wire counting;

    top_fsm FSM(
        .clk(clk),
        .reset(reset),
        .ack(ack),
        .data(data),
        .counting(counting),
        .done(done)
    );
    
    initial begin
        $dumpfile("final.vcd");
		$dumpvars(0, top_fsm_tb);
        $display("-----------------------------");
        #20 
        reset = 0; data = 1;    //10
        
        #10                     //20
        data = 0;
        
        #20                     //40
        data = 1;

        #20                     //60
        data = 0;               

        #10
        data = 1;               //70

        #10
        data = 0;               //80

        #30
        data = 1;               //110

        #15000
        #400
        $display("-----------------------------");
        $finish;
    end

endmodule