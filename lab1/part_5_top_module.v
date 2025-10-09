<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> c1b5d48 (lab 1 done)
module part_5_top_module (
    input [31:0]a, input [31:0]b, input sub, 
    output [31:0] sum
);
<<<<<<< HEAD

    wire [31:0] b_xor_sub;
    assign b_xor_sub = b ^ {32{sub}};

    wire [15:0] s1;
    wire c1;
    add16 a1(
        .a(a[15:0]), .b(b_xor_sub[15:0]), .cin(sub),
        .sum(sum[15:0]), .cout(c1)
    );

    wire [15:0] s2;
    add16 a2(
        .a(a[31:16]), .b(b_xor_sub[31:16]), .cin(c1),
        .sum(sum[31:16])
    );

endmodule
=======
module part_5_top_module (input [31:0]a, input [31:0]b, input sub, output [31:0] sum);
=======
>>>>>>> c1b5d48 (lab 1 done)

    wire [31:0] b_xor_sub;
    assign b_xor_sub = b ^ {32{sub}};

<<<<<<< HEAD
endmodule
>>>>>>> 0903dde (review 3 labs)
=======
    wire [15:0] s1;
    wire c1;
    add16 a1(
        .a(a[15:0]), .b(b_xor_sub[15:0]), .cin(sub),
        .sum(sum[15:0]), .cout(c1)
    );

    wire [15:0] s2;
    add16 a2(
        .a(a[31:16]), .b(b_xor_sub[31:16]), .cin(c1),
        .sum(sum[31:16])
    );

endmodule
>>>>>>> c1b5d48 (lab 1 done)
