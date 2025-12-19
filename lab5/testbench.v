// tb_top.v
`timescale 1ns / 1ps

module tb_top;

    // Clock & reset
    reg clk = 0;
    reg rst = 1;

    // UART signals
    reg  rxd = 1;  // idle = 1
    wire txd;

    // Button inputs
    reg  btn_inc = 0;
    reg  btn_dec = 0;
    reg  btn_send = 0;  // required by top (even though not in port list)

    // LED output
    wire [7:0] led;

    // DUT instantiation
    top uut (
        .clk(clk),
        .rst(rst),
        .rxd(rxd),
        .txd(txd),
        .btn_inc(btn_inc),
        .btn_dec(btn_dec),
        .led(led)
    );

    // 27 MHz clock: period = 37.037 ns → half = 18.518 ns
    always #18.518 clk = ~clk;

    // UART bit period @ 115200 baud = 1 / 115200 ≈ 8680.555... ns
    task send_uart_byte;
        input [7:0] data;
        begin
            // Start bit
            rxd = 0;
            #8680.556;

            // 8 data bits, LSB first
            for (integer i = 0; i < 8; i = i + 1) begin
                rxd = data[i];
                #8680.556;
            end

            // Stop bit
            rxd = 1;
            #8680.556;
        end
    endtask

    initial begin
        // Enable VCD dump
        $dumpfile("tb_top.vcd");
        $dumpvars(0, tb_top);

        // Monitor LED changes
        $monitor("Time = %0t | led = 0x%02h (%0d)", $time, led, led);

        // Apply reset
        #100 rst = 0;

        // Initial delay
        #200;

        // Send test byte
        $display("Sending UART byte 0xA5...");
        send_uart_byte(8'hA5);

        // Test inc
        #10000;
        $display("Pressing INC button...");
        btn_inc = 1;
        #100;
        btn_inc = 0;

        // Test dec
        #10000;
        $display("Pressing DEC button...");
        btn_dec = 1;
        #100;
        btn_dec = 0;

        // Final wait
        #50000;
        $display("Simulation finished.");
        $finish;
    end

endmodule