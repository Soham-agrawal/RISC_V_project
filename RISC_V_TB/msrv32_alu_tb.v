`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 05:16:55 PM
// Design Name: 
// Module Name: msrv32_alu_tb
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


module msrv32_alu_tb();
reg [31:0] op_1_in_tb;
  reg [31:0] op_2_in_tb;
  reg [3:0] opcode_in_tb;
  
  // Outputs
  wire [31:0] result_out_tb;

  // Instantiate the msrv32_alu module
  msrv32_alu dut (
    .op_1_in(op_1_in_tb),
    .op_2_in(op_2_in_tb),
    .opcode_in(opcode_in_tb),
    .result_out(result_out_tb)
  );

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

  // Test cases
  initial begin
    // Test case 1: Addition
    op_1_in_tb = 10;
    op_2_in_tb = 20;
    opcode_in_tb = 4'b0000;
    #10;

    // Test case 2: Subtraction
    op_1_in_tb = 30;
    op_2_in_tb = 15;
    opcode_in_tb = 4'b1000;
    #10;

    // Test case 3: Unsigned less than
    op_1_in_tb = 5;
    op_2_in_tb = 10;
    opcode_in_tb = 4'b0010;
    #10;

    // Test case 4: Signed less than
    op_1_in_tb = -5;
    op_2_in_tb = 3;
    opcode_in_tb = 4'b0011;
    #10;

    // Test case 5: Bitwise AND
    op_1_in_tb = 8'hFF;
    op_2_in_tb = 8'h0F;
    opcode_in_tb = 4'b0111;
    #10;

    // Test case 6: Bitwise OR
    op_1_in_tb = 8'hFF;
    op_2_in_tb = 8'h0F;
    opcode_in_tb = 4'b0110;
    #10;

    // Test case 7: Bitwise XOR
    op_1_in_tb = 8'hFF;
    op_2_in_tb = 8'hF0;
    opcode_in_tb = 4'b0100;
    #10;

    // Test case 8: Logical right shift
    op_1_in_tb = 32'h80000000;
    op_2_in_tb = 5;
    opcode_in_tb = 4'b0001;
    #10;

    // Test case 9: Logical left shift
    op_1_in_tb = 32'h00000001;
    op_2_in_tb = 4;
    opcode_in_tb = 4'b0101;
    #10;

    // Test case 10: Arithmetic right shift
    op_1_in_tb = -32'h80000000;
    op_2_in_tb = 5;
    opcode_in_tb = 4'b1101;
    #10;

    // End simulation
    $finish;
  end
endmodule
