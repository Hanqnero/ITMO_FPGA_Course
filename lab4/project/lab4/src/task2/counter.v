module counter (
    input  wire              clk,
    output reg  [26:0]       count
);
    
    reg [24:0] cycles = 25'b0;

    localparam CLOCKSPEED = 25'd26_999_999;

    always @(posedge clk) begin
            if (cycles == CLOCKSPEED) begin
                cycles <= 0;
                count <= count + 1;

            end else 
                cycles <= cycles + 1;
    end

endmodule
