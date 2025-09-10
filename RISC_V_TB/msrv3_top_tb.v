`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 05:27:51 PM
// Design Name: 
// Module Name: msrv3_top_tb
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


module msrv3_top_tb();
reg ms_riscv32_mp_clk_in;
  reg ms_riscv32_mp_rst_in;
  reg ms_riscv32_mp_rc_in;
  reg [31:0] ms_riscv32_mp_instr_in;
  reg ms_riscv32_mp_instr_hready_in;
  reg [31:0] ms_riscv32_mp_data_in;
  reg ms_riscv32_mp_data_hready_in;
  reg ms_riscv32_mp_hresp_in;
  reg ms_riscv32_mp_eirq_in;
  reg ms_riscv32_mp_tirq_in;
  reg ms_riscv32_mp_sirq_in;

  // Outputs
  wire [31:0] ms_riscv32_mp_imaddr_out;
  wire [31:0] ms_riscv32_mp_dmaddr_out;
  wire [31:0] ms_riscv32_mp_dmdata_out;
  wire ms_riscv32_mp_dmwr_req_out;
  wire [3:0] ms_riscv32_mp_dmwr_mask_out;
  wire [1:0] ms_riscv32_mp_data_htrans_out;

  // Instantiate the Unit Under Test (UUT)
  msrv32_top uut (
    .ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in), 
    .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in), 
    .ms_riscv32_mp_rc_in(ms_riscv32_mp_rc_in), 
    .ms_riscv32_mp_imaddr_out(ms_riscv32_mp_imaddr_out), 
    .ms_riscv32_mp_instr_in(ms_riscv32_mp_instr_in), 
    .ms_riscv32_mp_instr_hready_in(ms_riscv32_mp_instr_hready_in), 
    .ms_riscv32_mp_dmaddr_out(ms_riscv32_mp_dmaddr_out), 
    .ms_riscv32_mp_dmdata_out(ms_riscv32_mp_dmdata_out), 
    .ms_riscv32_mp_dmwr_req_out(ms_riscv32_mp_dmwr_req_out), 
    .ms_riscv32_mp_dmwr_mask_out(ms_riscv32_mp_dmwr_mask_out), 
    .ms_riscv32_mp_data_in(ms_riscv32_mp_data_in), 
    .ms_riscv32_mp_data_hready_in(ms_riscv32_mp_data_hready_in), 
    .ms_riscv32_mp_hresp_in(ms_riscv32_mp_hresp_in), 
    .ms_riscv32_mp_data_htrans_out(ms_riscv32_mp_data_htrans_out), 
    .ms_riscv32_mp_eirq_in(ms_riscv32_mp_eirq_in), 
    .ms_riscv32_mp_tirq_in(ms_riscv32_mp_tirq_in), 
    .ms_riscv32_mp_sirq_in(ms_riscv32_mp_sirq_in)
  );

  // Clock generation
  always #5 ms_riscv32_mp_clk_in = ~ms_riscv32_mp_clk_in;

  // Test procedure
  initial begin
    // Initialize Inputs
    ms_riscv32_mp_clk_in = 0;
    ms_riscv32_mp_rst_in = 1;
    ms_riscv32_mp_rc_in = 0;
    ms_riscv32_mp_instr_in = 0;
    ms_riscv32_mp_instr_hready_in = 1;
    ms_riscv32_mp_data_in = 0;
    ms_riscv32_mp_data_hready_in = 1;
    ms_riscv32_mp_hresp_in = 0;
    ms_riscv32_mp_eirq_in = 0;
    ms_riscv32_mp_tirq_in = 0;
    ms_riscv32_mp_sirq_in = 0;

    // Apply reset
    #10 ms_riscv32_mp_rst_in = 0;

    // Test Case 1: ADD x1, x2, x3 (x1 = x2 + x3)
    ms_riscv32_mp_instr_in = 32'b0000000_00011_00010_000_00001_0110011;
    #10;

    // Test Case 2: SUB x4, x5, x6 (x4 = x5 - x6)
    ms_riscv32_mp_instr_in = 32'b0100000_00110_00101_000_00100_0110011;
    #10;

    // Test Case 3: AND x7, x8, x9 (x7 = x8 & x9)
    ms_riscv32_mp_instr_in = 32'b0000000_01001_01000_111_00111_0110011;
    #10;

    // Test Case 4: OR x10, x11, x12 (x10 = x11 | x12)
    ms_riscv32_mp_instr_in = 32'b0000000_01100_01011_110_01010_0110011;
    #10;

    // Test Case 5: XOR x13, x14, x15 (x13 = x14 ^ x15)
    ms_riscv32_mp_instr_in = 32'b0000000_01111_01110_100_01101_0110011;
    #10;

    // Test Case 6: SLL x16, x17, x18 (x16 = x17 << x18)
    ms_riscv32_mp_instr_in = 32'b0000000_10010_10001_001_10000_0110011;
    #10;

    // Test Case 7: SRL x19, x20, x21 (x19 = x20 >> x21)
    ms_riscv32_mp_instr_in = 32'b0000000_10101_10100_101_10111_0110011;
    #10;

    // Test Case 8: SRA x22, x23, x24 (x22 = x23 >>> x24)
    ms_riscv32_mp_instr_in = 32'b0100000_11000_10111_101_11010_0110011;
    #10;

    // Test Case 9: SLT x25, x26, x27 (x25 = (x26 < x27) ? 1 : 0)
    ms_riscv32_mp_instr_in = 32'b0000000_11011_11010_010_11001_0110011;
    #10;

    // Test Case 10: SLTU x28, x29, x30 (x28 = (x29 < x30) ? 1 : 0)
    ms_riscv32_mp_instr_in = 32'b0000000_11110_11101_011_11100_0110011;
    #10;

    // End of test
    $stop;
  end
endmodule
