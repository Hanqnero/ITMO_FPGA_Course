module full_add ( 
    input a, b, cin,
    output sum, cout );

    // assign sum = a ^ b ^ cin;
    // assign cout = a & b | a & cin | b & cin;

    assign {cout, sum} = a + b + cin;

endmodule