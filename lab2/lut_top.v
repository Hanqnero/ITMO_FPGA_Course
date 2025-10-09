module lut_top (
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 57ea532 (review 3 labs, sync fork with upstream)
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z 
<<<<<<< HEAD
);
    
    reg [7:0] Q;
    
    assign Z = Q[{A, B, C}];
   	
    always @(posedge clk) begin
        
        if (enable) Q <= {Q[6:0], S};
       
    end
=======

);
    

>>>>>>> 0903dde (review 3 labs)
=======
);
    
    reg [7:0] Q;
    
    assign Z = Q[{A, B, C}];
   	
    always @(posedge clk) begin
        
        if (enable) Q <= {Q[6:0], S};
       
    end
>>>>>>> 57ea532 (review 3 labs, sync fork with upstream)
endmodule
