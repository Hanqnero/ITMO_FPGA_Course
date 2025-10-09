<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 57ea532 (review 3 labs, sync fork with upstream)
module ram_top #(parameter N = 6, M = 32)
    (input clk,
    input we,
    input [N-1:0] adr,
    input [M-1:0] din,
    output [M-1:0] dout);
<<<<<<< HEAD
    
    reg [M-1:0] mem [2**N-1:0];
    
    assign dout = adr == 0 ? 0 : mem[adr];
    
    always @(posedge clk)
        if (we) mem [adr] <= din;
        
=======
module ram_top(
);
    
>>>>>>> 0903dde (review 3 labs)
=======
    
    reg [M-1:0] mem [2**N-1:0];
    
    assign dout = adr == 0 ? 0 : mem[adr];
    
    always @(posedge clk)
        if (we) mem [adr] <= din;
        
>>>>>>> 57ea532 (review 3 labs, sync fork with upstream)

endmodule
