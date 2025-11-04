module Analyze (
    input clk, a;
    output reg [2:0] q;
);
    q = 4;

    reg a_old;

    always @(posedge clk) begin
        reg a_old <= a;
        if (!a_old) begin
            q = q+1;
            if (q >= 7) q = 0; 
        end
    end
    
endmodule