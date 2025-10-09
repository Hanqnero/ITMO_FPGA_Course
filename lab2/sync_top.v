module sync_top(
<<<<<<< HEAD
    input clk,
    input signal,
    output signal_sync
);
    
reg [1:0]sync;

always @(posedge clk)
   sync <= { sync[0], signal };

wire signal_sync;
assign signal_sync = sync[1];
=======
);
    
>>>>>>> 0903dde (review 3 labs)

endmodule
