module Analyse(
    input  wire clk,
    input  wire a,
    input  wire b,
    output reg q,
    output reg state
);
    
reg prev_a;
reg prev_b;


always @(*) begin
    case(state)
        0: q = a ^ b;  
        1: q = (~(a ^ b));  
        default: q = 0;
    endcase
end

always @(posedge clk) begin
    case(state)
        0: state <= (prev_a & prev_b);
        1: state <= (prev_a | prev_b);
        default: state <= 0;
    endcase
    prev_a <= a;
    prev_b <= b;
end
endmodule