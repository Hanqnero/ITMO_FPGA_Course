module part_3_top_module (input [31:0]a, input [31:0]b, input cin, output [31:0] sum);

<<<<<<< HEAD
<<<<<<< HEAD
    nbit_add #(32) a32 (a, b, cin, sum, cout);
=======
    // write code here
>>>>>>> 0903dde (review 3 labs)
=======
    wire c1;
    add16 a1(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(c1));
    add16 a2(.a(a[31:16]), .b(b[31:16]), .cin(c1), .sum(sum[31:16]));

>>>>>>> c1b5d48 (lab 1 done)

endmodule