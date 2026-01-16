module uart_rx (
    input  wire       clk,        // 27 MHz
    input  wire       rx,         // Вход с пина
    output reg        valid,      // Импульс: "байт получен"
    output reg  [7:0] data        // Сам байт
);

    // Настройка скорости 9600 при 27 МГц
    // 27000000 / 9600 = 2812 тактов на бит
    localparam TICK_MAX = 2812; 

    reg [1:0] state = 0;
    reg [11:0] cnt = 0;  // Счетчик тактов
    reg [2:0]  bit_idx = 0; // Номер бита (0..7)
    
    // Синхронизатор входа (чтобы глюки не ловить)
    reg rx_sync1 = 1;
    reg rx_sync2 = 1;

    always @(posedge clk) begin
        rx_sync1 <= rx;
        rx_sync2 <= rx_sync1; // Дальше работаем с rx_sync2
        
        valid <= 0; // Импульс только на 1 такт

        case (state)
            0: begin // IDLE: ждем падения в 0
                if (rx_sync2 == 0) begin
                    state <= 1;
                    cnt   <= TICK_MAX / 2; // Ждем половину бита, чтобы встать в центр
                    bit_idx <= 0;
                end
            end

            1: begin // Читаем старт-бит (середина)
                if (cnt == 0) begin
                    if (rx_sync2 == 0) begin // Если все еще 0 -> это реально старт
                        cnt <= TICK_MAX;     // Теперь ждем полный бит
                        state <= 2;
                    end else begin
                        state <= 0; // Ложная тревога
                    end
                end else begin
                    cnt <= cnt - 1;
                end
            end

            2: begin // Читаем 8 бит данных
                if (cnt == 0) begin
                    data[bit_idx] <= rx_sync2; // Запоминаем бит
                    cnt <= TICK_MAX;
                    
                    if (bit_idx == 7) begin
                        state <= 3; // Все биты считали
                    end else begin
                        bit_idx <= bit_idx + 1;
                    end
                end else begin
                    cnt <= cnt - 1;
                end
            end

            3: begin // Стоп-бит
                if (cnt == 0) begin
                    valid <= 1; // Готово!
                    state <= 0;
                end else begin
                    cnt <= cnt - 1;
                end
            end
        endcase
    end
endmodule