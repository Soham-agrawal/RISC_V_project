`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 05:36:30 PM
// Design Name: 
// Module Name: branch_unit
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


module branch_unit(
    input [31:0] rs1_in,
    input [31:0] rs2_in,
    input [4:0] opcode_6_to_2_in,
    input [2:0] funct3_in,
    output reg branch_taken_out
    );
    wire signed [31:0] rs1, rs2;
    assign rs1=rs1_in;
    assign rs2=rs2_in;
    always @(*) begin
    case(opcode_6_to_2_in) 
        5'b11000: begin
            case(funct3_in)
                3'b000: branch_taken_out = (rs1 == rs2);
                3'b001: branch_taken_out = (rs1 != rs2);
                3'b100: branch_taken_out = (rs1 < rs2);
                3'b101: branch_taken_out = (rs1 >= rs2);
                3'b110: branch_taken_out = (rs1_in < rs2_in);
                3'b111: branch_taken_out = (rs1_in >= rs2_in);
                default: branch_taken_out = 1'b0;
                endcase
        end
        5'b11011: branch_taken_out = 1;
        5'b11001: branch_taken_out = 1;
        default: branch_taken_out =0;
        endcase 
    end
endmodule
