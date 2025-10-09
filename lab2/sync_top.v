module sync_top(
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 57ea532 (review 3 labs, sync fork with upstream)
    input clk,
    input signal,
    output signal_sync
);
    
reg [1:0]sync;

always @(posedge clk)
   sync <= { sync[0], signal };


assign signal_sync = sync[1];
<<<<<<< HEAD
=======
);
    
>>>>>>> 0903dde (review 3 labs)
=======
>>>>>>> 57ea532 (review 3 labs, sync fork with upstream)

endmodule
