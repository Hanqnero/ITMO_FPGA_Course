module part_4_top_module (input [31:0]a, input [31:0]b, input cin, output [31:0] sum, output cout);

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> c1b5d48 (lab 1 done)
    wire c1;
    add16 a1(
        .a(a[15:0]), .b(b[15:0]), .cin(1'b0),
        .sum(sum[15:0]), .cout(c1)
    );
<<<<<<< HEAD

    wire [15:0] s1;
    add16 a2(
        .a(a[31:16]), .b(b[31:16]), .cin(1'b0),
        .sum(s1)
    );

    wire [15:0] s2;
    add16 a3(
        .a(a[31:16]), .b(b[31: 16]), .cin(1'b1),
        .sum(s2)
    );

    reg [15:0] mult1;
    always @(*) begin
        case (c1)
            1'b0: mult1 <= s1;
            1'b1: mult1 <= s2;
        endcase
    end

    assign sum[31:16] = mult1;



endmodule
=======
    // write code here

endmodule
>>>>>>> 0903dde (review 3 labs)
=======

    wire [15:0] s1;
    add16 a2(
        .a(a[31:16]), .b(b[31:16]), .cin(1'b0),
        .sum(s1)
    );

    wire [15:0] s2;
    add16 a3(
        .a(a[31:16]), .b(b[31: 16]), .cin(1'b1),
        .sum(s2)
    );

    reg [15:0] mult1;
    always @(*) begin
        case (c1)
            1'b0: mult1 <= s1;
            1'b1: mult1 <= s2;
        endcase
    end

    assign sum[31:16] = mult1;



endmodule
>>>>>>> c1b5d48 (lab 1 done)
