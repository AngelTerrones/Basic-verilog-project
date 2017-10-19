`timescale 1ns / 1ps
/*
 ******************************************************************************
 * Autor: Ángel Terrones <aterrones@usb.ve>
 * Módulo: Driver 7-segmentos
 ******************************************************************************
 */
module driver(
    input [3:0]      valor_i,
    output [3:0]     anodos_o,
    output reg [7:0] segmentos_o
    );

assign anodos_o = 4'b1110;

always @(*) begin
    case (valor_i)
        //                     abcdefg.
        4'h0: segmentos_o = 8'b00000011;
        4'h1: segmentos_o = 8'b10011111;
        4'h2: segmentos_o = 8'b00100101;
        4'h3: segmentos_o = 8'b00001101;
        4'h4: segmentos_o = 8'b10011001;
        4'h5: segmentos_o = 8'b01001001;
        4'h6: segmentos_o = 8'b01000001;
        4'h7: segmentos_o = 8'b00011111;
        4'h8: segmentos_o = 8'b00000001;
        4'h9: segmentos_o = 8'b00001001;
        4'ha: segmentos_o = 8'b00010001;
        4'hb: segmentos_o = 8'b11000001;
        4'hc: segmentos_o = 8'b01100011;
        4'hd: segmentos_o = 8'b10000101;
        4'he: segmentos_o = 8'b01100001;
        4'hf: segmentos_o = 8'b01110001;
    endcase
end

endmodule
// ****************************************************************************
// EOF
// ****************************************************************************