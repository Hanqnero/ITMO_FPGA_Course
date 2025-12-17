module bin_to_bcd (
    input  wire [26:0] bin,
    output reg  [31:0] bcd 
);

    reg [58:0] temp;
    integer i;

    always @* begin
        temp = {32'd0, bin};

        for (i = 0; i < 27; i = i + 1) begin
            if (temp[58:55] > 4) temp[58:55] = temp[58:55] + 3;
            if (temp[54:51] > 4) temp[54:51] = temp[54:51] + 3;
            if (temp[50:47] > 4) temp[50:47] = temp[50:47] + 3;
            if (temp[46:43] > 4) temp[46:43] = temp[46:43] + 3;
            if (temp[42:39] > 4) temp[42:39] = temp[42:39] + 3;
            if (temp[38:35] > 4) temp[38:35] = temp[38:35] + 3;
            if (temp[34:31] > 4) temp[34:31] = temp[34:31] + 3;
            if (temp[30:27] > 4) temp[30:27] = temp[30:27] + 3;

            temp = temp << 1;
        end
        bcd = temp[58:27];
    end

endmodule
