module full_add ( 
    input a, b, cin,
    output sum, cout );

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    assign sum = a != b != cin;
    assign cout = a && b || a && cin || b && cin;
=======
    // write code here
>>>>>>> 0903dde (review 3 labs)
=======
    // assign sum = a ^ b ^ cin;
    // assign cout = a & b | a & cin | b & cin;

    assign {cout, sum} = a + b + cin;
>>>>>>> fbf8fdd (apply teacher feedback)

endmodule

// Не по заданию чисто тест генерации

module nbit_add #(
    parameter N=8
) (
    input [N-1:0] a, b,
    input cin,
    output [N-1:0] sum,
    output cout
);
    wire [N:0] carry;
    assign carry[0] = cin;
    genvar i;

    generate
        for (i = 0; i < N; i = i + 1) begin
            full_add a(a[i], b[i], carry[i], sum[i], carry[i+1]);
        end
    endgenerate

    assign cout = carry[N+1];
=======
    assign sum = a != b != cin;
    assign cout = a && b || a && cin || b && cin;
>>>>>>> c1b5d48 (lab 1 done)

endmodule