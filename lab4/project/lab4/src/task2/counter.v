module counter #(parameter SIZE = 27)(
    input  wire              clk,
    input  wire              reset,
    input  wire [SIZE-1:0]   stop,
    output reg  [SIZE-1:0]   count
);

    reg [24:0] cycles = 25'b0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cycles <= 0;
            count <= 0;
        end else begin
            if (cycles == stop) begin
                cycles <= 0;
                count <= count + 1;
            end else begin
                cycles <= cycles + 1;
            end
        end
    end

endmodule
