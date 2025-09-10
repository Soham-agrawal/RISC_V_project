`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 09:34:08 PM
// Design Name: 
// Module Name: msrv32_imm_generator_tb
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


module msrv32_imm_generator_tb( );
    reg [31:7] instr_in;
    reg [2:0] imm_type_in;
    wire [31:0] imm_out;
    integer i;
    msrv32_imm_generator uut(
        instr_in,
        imm_type_in,
        imm_out);
    initial begin
        instr_in=$random;
        for(i=0; i<=7; i=i+1)
        begin
            imm_type_in=i;
            #10;
        end
    end
endmodule
