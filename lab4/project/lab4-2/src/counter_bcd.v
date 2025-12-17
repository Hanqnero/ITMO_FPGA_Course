module counter_bcd (
    input  wire       Clock,
    output wire [31:0] bcd,
    output reg pulse
);
    parameter count_value = 25'd26_999_999;

    reg [24:0] count_value_reg = 25'd0;
    reg        count_value_flag;
    reg [26:0] num = 27'd0;

    always @(posedge Clock) begin
        if (count_value_reg == count_value) begin
            count_value_reg  <= 25'd0;
            count_value_flag <= 1'b1;
            pulse <= 1'b1;
        end else begin
            count_value_reg  <= count_value_reg + 1'b1;
            count_value_flag <= 1'b0;
            pulse <= 1'b0;
        end
    end

    always @(posedge Clock) begin
        if (count_value_flag)
            num <= num + 1'b1;
    end

    bin_to_bcd bcd_converter (
        .bin(num),
        .bcd(bcd)
    );

endmodule
