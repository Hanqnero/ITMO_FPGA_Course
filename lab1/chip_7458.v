module chip_7458 ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    
    wire temp1;
    assign temp1 = (p2a & p2b);

<<<<<<< HEAD
<<<<<<< HEAD
    wire temp2;
<<<<<<< HEAD
    assign temp2 = (p2c && p2d);
=======
    // write code here
>>>>>>> 0903dde (review 3 labs)
=======
    wire temp2;
    assign temp2 = (p2c && p2d);
>>>>>>> c1b5d48 (lab 1 done)
=======
    assign temp2 = (p2c & p2d);
>>>>>>> fbf8fdd (apply teacher feedback)

    wire temp3;
    assign temp3 = (p1a & p1c & p1b);

    wire temp4;
    assign temp4 = (p1f & p1e & p1d);


    assign p2y = (temp1 | temp2);
    assign p1y = (temp3 | temp4);


endmodule