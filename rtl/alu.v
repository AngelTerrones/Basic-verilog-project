`timescale 1ns / 1ps
/*
 ******************************************************************************
 * Autor:  Ángel Terrones
 * Módulo: ALU de 4-bits
 ******************************************************************************
 */
module alu(
    input [3:0]      a_i,
    input [3:0]      b_i,
    input [3:0]      op_i,
    output reg [3:0] result_o,
    output           invalid
    );

assign invalid = op_i > 4'ha;

always @(*) begin
    case (op_i)
        4'h0:    result_o = a_i + b_i;
        4'h1:    result_o = a_i - b_i;
        4'h2:    result_o = a_i & b_i;
        4'h3:    result_o = a_i | b_i;
        4'h4:    result_o = a_i ^ b_i;
        4'h5:    result_o = a_i;
        4'h6:    result_o = b_i;
        4'h7:    result_o = -a_i;
        4'h8:    result_o = -b_i;
        4'h9:    result_o = ~a_i;
        4'ha:    result_o = ~b_i;
        default: result_o = 4'b0;
    endcase
end

endmodule
// ****************************************************************************
// EOF
// ****************************************************************************
