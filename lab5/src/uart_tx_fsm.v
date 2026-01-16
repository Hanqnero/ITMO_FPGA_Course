module uart_tx (
    input  wire       clk,      // 27 MHz
    input  wire       start,    // Команда "отправь!"
    input  wire [7:0] data_in,  // Что отправлять
    output reg        tx,       // Выход на пин
    output reg        busy      // 1, если занят
);

    localparam TICK_MAX = 2812; // То же самое (9600 bod)

    reg [1:0] state = 0;
    reg [11:0] cnt = 0;
    reg [2:0]  bit_idx = 0;
    reg [7:0]  saved_data = 0;

    // Начальное состояние для Gowin (важно для TX, чтобы не слал мусор при старте)
    initial begin
        tx = 1; 
        busy = 0;
    end

    always @(posedge clk) begin
        case (state)
            0: begin // IDLE
                tx <= 1; // Линия должна быть high, когда молчим
                if (start) begin
                    saved_data <= data_in;
                    busy <= 1;
                    cnt <= TICK_MAX;
                    state <= 1;
                    tx <= 0; // START bit (low)
                end else begin
                    busy <= 0;
                end
            end

            1: begin // DATA BITS
                if (cnt == 0) begin
                    tx <= saved_data[bit_idx]; // Выставляем бит
                    cnt <= TICK_MAX;
                    
                    if (bit_idx == 7) begin
                        bit_idx <= 0;
                        state <= 2;
                    end else begin
                        bit_idx <= bit_idx + 1;
                    end
                end else begin
                    cnt <= cnt - 1;
                end
            end

            2: begin // STOP BIT
                if (cnt == 0) begin
                    tx <= 1; // Стоп-бит (high)
                    cnt <= TICK_MAX;
                    state <= 3;
                end else begin
                    cnt <= cnt - 1;
                end
            end
            
            3: begin // Задержка стоп-бита
                 if (cnt == 0) begin
                    state <= 0;
                    busy <= 0;
                 end else begin
                    cnt <= cnt - 1;
                 end
            end
        endcase
    end

endmodule