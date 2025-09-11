
module d_trigger8(
        input clk, 
        input [7:0] d,
        output reg [7:0] q
    );
        
    always @(posedge clk) begin
        q <= d;
    end

endmodule

module part_2_top_module (
    input [7:0] d, 
    input [1:0]sel, 
    input clk, 
    output [7:0] q
);

    // write code here
    wire [7:0] t1_out, t2_out, t3_out;
    reg [7:0] res;
    assign q = res;


    d_trigger8 t1(
        .clk(clk),
        .d(d),
        .q(t1_out)
    );

    d_trigger8 t2(
        .clk(clk),
        .d(t1_out),
        .q(t2_out)
    );

    d_trigger8 t3(
        .clk(clk),
        .d(t2_out),
        .q(t3_out)
    );

    always @(*) begin
        case (sel)
            2'b00: res = d;
            2'b01: res = t1_out;
            2'b10: res = t2_out;
            2'b11: res = t3_out;
        endcase
    end

endmodule