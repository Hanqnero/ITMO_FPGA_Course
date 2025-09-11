module part_3_top_module (input [31:0]a, input [31:0]b, input cin, output [31:0] sum);

    nbit_add #(32) a32 (a, b, cin, sum, cout);

endmodule