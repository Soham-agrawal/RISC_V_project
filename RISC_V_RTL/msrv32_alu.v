`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 05:14:58 PM
// Design Name: 
// Module Name: msrv32_alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module msrv32_alu(
    input [31:0] op_1_in,
    input [31:0] op_2_in,
    input [3:0] opcode_in,
    output reg [31:0] result_out
    );
    wire signed [31:0] op_1_in_signed;
wire signed [31:0] op_2_in_signed;
assign op_1_in_signed = op_1_in;
assign op_2_in_signed = op_2_in;

always @(*)
begin 
case(opcode_in[3:0])
    4'b0000: result_out = op_1_in + op_2_in;                   // Addition
        4'b1000: result_out = op_1_in - op_2_in;                   // Subtraction
        4'b0010: result_out = (op_1_in < op_2_in) ? 32'b1 : 32'b0; // Unsigned less than
        4'b0011: result_out = (op_1_in_signed < op_2_in_signed) ? 32'b1 : 32'b0; // Signed less than
        4'b0111: result_out = op_1_in & op_2_in;                   // Bitwise AND
        4'b0110: result_out = op_1_in | op_2_in;                   // Bitwise OR
        4'b0100: result_out = op_1_in ^ op_2_in;                   // Bitwise XOR
        4'b0001: result_out = op_1_in >> op_2_in[4:0];             // Logical right shift
        4'b0101: result_out = op_1_in << op_2_in[4:0];             // Logical left shift
        4'b1101: result_out = op_1_in_signed >>> op_2_in[4:0]; 
     default  : result_out = 32'b0;
   
endcase
end
endmodule
