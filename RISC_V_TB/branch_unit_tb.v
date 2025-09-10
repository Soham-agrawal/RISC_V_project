`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 05:58:55 PM
// Design Name: 
// Module Name: branch_unit_tb
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


module branch_unit_tb();
reg [31:0] rs1_in; 
reg [31:0] rs2_in; 
reg [6:0] opcode_in; 
reg [2:0] funct3_in; 
 
// Outputs 
wire branch_taken_out; 
 
// Instantiate the Unit Under Test (UUT) 
branch_unit uut ( 
    .rs1_in(rs1_in),  
    .rs2_in(rs2_in),  
    .opcode_6_to_2_in(opcode_6_to_2_in),  
    .funct3_in(funct3_in),  
    .branch_taken_out(branch_taken_out) 
); 
 
initial begin 
    // Initialize Inputs 
    rs1_in = 0; 
    rs2_in = 0; 
    opcode_in = 0; 
    funct3_in = 0; 
    #10; 
     
    rs1_in = 32'h00000001; 
    rs2_in = 32'h00000001; 
    opcode_in = 7'b1100011; // opcode for branch instructions 
    funct3_in = 3'b000; // BEQ 
    #10; 
    rs1_in = 32'h11000001; 
    rs2_in = 32'h0001001; 
opcode_in = 7'b110111; // opcode for branch instructions 
    funct3_in = 3'b100; // BEQ 
    #10; 
    rs1_in = 32'h01111111; 
    rs2_in = 32'h00000001; 
    opcode_in = 7'b1100011; // opcode for branch instructions 
    funct3_in = 3'b001; // BEQ 
    #10; 
    rs1_in = 32'h00000001; 
    rs2_in = 32'h00003002; 
    opcode_in = 7'b1100011;  
    funct3_in = 3'b101; // BNE 
    #10; 
    rs1_in = 32'h00000001; 
    rs2_in = 32'h00000002; 
    opcode_in = 7'b1100011;  
    funct3_in = 3'b100; // BLT 
    #10; 
    rs1_in = 32'h00000002; 
    rs2_in = 32'h00000001; 
    opcode_in = 7'b1100011;  
    funct3_in = 3'b101;  
    #10; 
    rs1_in = 32'h00000001; 
    rs2_in = 32'h00000002; 
    opcode_in = 7'b1100011; // opcode for branch instructions 
    funct3_in = 3'b110;  
    #10; 
    rs1_in = 32'h00000002; 
    rs2_in = 32'h00000001; 
    opcode_in = 7'b1100011; // opcode for branch instructions 
    funct3_in = 3'b111; // BGEU 
    #10; 
    opcode_in = 7'b1101111; // opcode for JAL 
    #10; 
    opcode_in = 7'b1100111; // opcode for JALR 
    #10; 
    $stop; 
    end 
endmodule
