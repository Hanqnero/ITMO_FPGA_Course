module full_add ( 
    input a, b, cin,
    output sum, cout );

    assign sum = a != b != cin;
    assign cout = a && b || a && cin || b && cin;

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

endmodule