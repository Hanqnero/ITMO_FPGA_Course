module full_add_16bit ( 
    input [0:15] a, b,
    input cin,
    output [0:15] sum,
    output cout );

    assign {cout, sum} = a + b + cin;
endmodule


module part_3_top_module (input [31:0]a, input [31:0]b, input cin, output [31:0] sum);

    wire t_cout, cout;

    full_add_16bit fa16_1 (.a(a[15:0]), .b(b[15:0]), .cin(cin), .sum(sum[15:0]), .cout(t_cout));
    full_add_16bit fa16_2 (.a(a[31:16]), .b(b[31:16]), .cin(t_cout), .sum(sum[31:16]), .cout(cout));


    //nbit_add #(32) a32 (a, b, cin, sum, cout);

endmodule