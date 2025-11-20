module lab4_task1(
    input  Clock,

    input ButtonS0,
    input ButtonS1,
    input ButtonS2,
 
    output LED0,
    output LED1,
    output LED2,
    output LED3,
    output LED4,
    output LED5

);

/** NOTE:
Кнопка в разомкнутом состоянии выводит значение 1, в нажатом 0;
**/

wire ButtonS0_on = !ButtonS0;
wire ButtonS1_on = !ButtonS1;
wire ButtonS2_on = !ButtonS2;

/** 
так должны гореть светодиоды при всех комбинациях кнопок
здесь слева-направо 

---     00100000
--C     10111111
-B-     00010101
-BC     10111111
A--     00011111
A-C     10110101
AB-     00110110
ABC     11110101


F1      01111101
F2      01011010
F3      01111111
F4      01011000
F5      01111111
F6      11010111
F7      00000001
F8      01010101

**/

localparam F1_tt = 8'b01111101;
localparam F2_tt = 8'b01011010;
localparam F3_tt = 8'b01111111;
localparam F4_tt = 8'b01011000;
localparam F5_tt = 8'b01111111;
localparam F6_tt = 8'b11010111;
localparam F7_tt = 8'b00000001;
localparam F8_tt = 8'b01010101;


/** NOTE:
Чтобы зажечь лампочку нужно подать на пин 0 а не 1;
поэтому таблицы истиности инвертированы через ~ в параметрах модулей;

Таблица истиности задается слева-направо
(000) -> INIT[0]


входы модуля LUT3 тоже инвертированы
I0 отвечает за младший вход C таблицы истиности
I2 за старший

**/


LUT3 #(.INIT(~F1_tt)) f1 (
    .I0(ButtonS2_on),
    .I1(ButtonS1_on),
    .I2(ButtonS0_on),
    .F(LED0)
);


LUT3 #(.INIT(~F2_tt)) f2(
    .I0(ButtonS2_on),
    .I1(ButtonS1_on),
    .I2(ButtonS0_on),
    .F(LED1)
);


LUT3 #(.INIT(~F3_tt)) f3(
    .I0(ButtonS2_on),
    .I1(ButtonS1_on),
    .I2(ButtonS0_on),
    .F(LED2)
);


LUT3 #(.INIT(~F4_tt)) f4(
    .I0(ButtonS2_on),
    .I1(ButtonS1_on),
    .I2(ButtonS0_on),
    .F(LED3)
);


LUT3 #(.INIT(~F5_tt)) f5(
    .I0(ButtonS2_on),
    .I1(ButtonS1_on),
    .I2(ButtonS0_on),
    .F(LED4)
);


LUT3 #(.INIT(~F6_tt)) f6(
    .I0(ButtonS2_on),
    .I1(ButtonS1_on),
    .I2(ButtonS0_on),
    .F(LED5)
);

endmodule
