module top (
    input  wire clk,          // 27 MHz
    input  wire uart_rx,
    input  wire Button_S1, 
    input  wire Button_S2,
    input  wire Button_S3,
    output wire uart_tx,
    output SPI_SR_DI,
    output SPI_SR_NSS,
    output SPI_SR_CLK
);

    // -----------------------------
    // UART интерфейс
    // -----------------------------
    wire [7:0] rx_byte;
    wire       rx_ready;
    wire       tx_busy;

    reg        tx_start;
    reg [7:0]  tx_data;

    uart_rx u_rx (
        .clk(clk),
        .rx(uart_rx),
        .valid(rx_ready),
        .data(rx_byte)
    );

    uart_tx u_tx (
        .clk(clk),
        .start(tx_start),
        .data_in(tx_data),
        .tx(uart_tx),
        .busy(tx_busy)
    );

    // -----------------------------
    // FSM и буферы
    // -----------------------------
    localparam S_IDLE    = 2'd0;
    localparam S_RECEIVE = 2'd1;
    localparam S_SEND    = 2'd2;

    reg [1:0] state = S_IDLE;
    reg [31:0] rx_buffer = 32'd0;
    reg [31:0] tx_buffer = 32'd0;
    reg [1:0]  rx_count  = 2'd0;
    reg [1:0]  tx_count  = 2'd0;

    // Текущее число в двоичном виде для отображения/кнопок
    reg [31:0] value_bin = 32'd0;
    wire [31:0] value_bcd;
    bin2bcd b2b_inst (
        .bin(value_bin),
        .bcd(value_bcd)
    );

    // Индекс вводимой цифры по UART
    reg [2:0]  digit_idx     = 3'd0;

    // Фиксируем фронты кнопок
    reg btn3_prev = 1'b0;
    reg btn1_prev = 1'b0;
    reg btn2_prev = 1'b0;
    wire btn3_rise = Button_S3 & ~btn3_prev;
    wire btn1_rise = Button_S1 & ~btn1_prev;
    wire btn2_rise = Button_S2 & ~btn2_prev;

    // -----------------------------
    // Основная логика FSM
    // -----------------------------
    always @(negedge clk) begin
        tx_start <= 1'b0; // по умолчанию — не запускаем передачу

        // Обработка кнопок (+1/-1)
        btn3_prev <= Button_S3;
        btn1_prev <= Button_S1;
        btn2_prev <= Button_S2;

        if (btn1_rise) begin
            value_bin <= value_bin - 1'b1;
        end else if (btn2_rise) begin
            value_bin <= value_bin + 1'b1;
        end

        // Отправка текущего значения по кнопке S3 (4 байта, младший байт первым)
        if (btn3_rise && state == S_IDLE && !tx_busy) begin
            tx_buffer <= value_bin;
            tx_count  <= 0;
            state     <= S_SEND;
        end

        // Преобразуем ASCII-цифры сразу в число
        if (rx_ready) begin
            if (rx_byte == 8'h0A || rx_byte == 8'h0D) begin
                // Явное завершение ввода: сбрасываем счётчик и выходим из приема
                digit_idx <= 3'd0;
                rx_count  <= 2'd0;
                state     <= S_IDLE;
            end else if (rx_byte >= "0" && rx_byte <= "9") begin
                // Ограничиваемся 8 цифрами, при переполнении начинаем заново
                if (digit_idx == 3'd0)
                    value_bin <= rx_byte - "0";
                else
                    value_bin <= (value_bin * 10) + (rx_byte - "0");

                digit_idx <= (digit_idx == 3'd7) ? 3'd0 : digit_idx + 1'b1;
            end
        end

        case (state)

        S_IDLE: begin
            if (rx_ready && !(rx_byte == 8'h0A || rx_byte == 8'h0D)) begin
                rx_buffer[7:0] <= rx_byte; // 1-й байт
                rx_count <= 1;
                state <= S_RECEIVE;
            end
        end

        S_RECEIVE: begin
            if (rx_ready) begin
                if (rx_byte == 8'h0A || rx_byte == 8'h0D) begin
                    // Прерываем недополученное сообщение по переводу строки
                    rx_count <= 0;
                    state    <= S_IDLE;
                end else begin
                    case (rx_count)
                        2'd1: rx_buffer[15:8]  <= rx_byte; // 2-й байт
                        2'd2: rx_buffer[23:16] <= rx_byte; // 3-й байт
                        2'd3: rx_buffer[31:24] <= rx_byte; // 4-й байт
                    endcase

                    if (rx_count == 3) begin
                        // Все 4 байта получены (эхо)
                        tx_buffer <= {rx_byte, rx_buffer[23:0]};
                        tx_count  <= 0;
                        rx_count  <= 0;
                        state     <= S_SEND;
                    end else begin
                        rx_count <= rx_count + 1;
                    end
                end
            end
        end

        S_SEND: begin
            if (!tx_busy) begin
                case (tx_count)
                    2'd0: tx_data <= tx_buffer[7:0];    // 1-й
                    2'd1: tx_data <= tx_buffer[15:8];   // 2-й
                    2'd2: tx_data <= tx_buffer[23:16];  // 3-й
                    2'd3: tx_data <= tx_buffer[31:24];  // 4-й
                endcase
                tx_start <= 1'b1;

                if (tx_count == 3) begin
                    state <= S_IDLE;
                end else begin
                    tx_count <= tx_count + 1;
                end
            end
        end

        endcase
    end

display_595 disp (
    .clk(clk),
    .bcd(value_bcd),
    .SPI_SR_DI(SPI_SR_DI),
    .SPI_SR_CLK(SPI_SR_CLK),
    .SPI_SR_NSS(SPI_SR_NSS)
);
endmodule