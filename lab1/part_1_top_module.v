module d_trigger (
    input wire clk,
    input wire d,
    output reg q
);
always @(posedge clk) begin
    q<=d;
end

endmodule

module part_1_top_module (input clk, input d, output q );
    
    wire t1_out, t2_out;


    d_trigger t1(
        .clk(clk),
        .d(d),
        .q(t1_out)
    );

    d_trigger t2(
        .clk(clk),
        .d(t1_out),
        .q(t2_out)
    );

    d_trigger t3(
        .clk(clk),
        .d(t2_out),
        .q(q)
    );

endmodule