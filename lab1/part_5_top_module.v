module full_add_16bit ( 
    input [0:15] a, b,
    input cin,
    output [0:15] sum,
    output cout );

    assign {cout, sum} = a + b + cin;
endmodule
module part_5_top_module (
    input [31:0]a, input [31:0]b, input sub, 
    output [31:0] sum
);

    wire [31:0] b_xor_sub;
    assign b_xor_sub = b ^ {32{sub}};

    wire [15:0] s1;
    wire c1;
    full_add_16bit a1(
        .a(a[15:0]), .b(b_xor_sub[15:0]), .cin(sub),
        .sum(sum[15:0]), .cout(c1)
    );

    wire [15:0] s2;
    full_add_16bit a2(
        .a(a[31:16]), .b(b_xor_sub[31:16]), .cin(c1),
        .sum(sum[31:16])
    );

endmodule
