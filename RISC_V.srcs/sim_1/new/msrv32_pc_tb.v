`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2025 10:05:04 PM
// Design Name: 
// Module Name: msrv32_pc_tb
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


module msrv32_pc_tb();
reg		    rst_in;
reg  [1:0]	pc_src_in;
reg  [31:0]	epc_in;
reg  [31:0]	trap_address_in;
reg		    branch_taken_in;
reg  [30:0]	iaddr_in;
reg 		ahb_ready_in;
reg  [31:0]	pc_in;
wire [31:0]	iaddr_out;
wire [31:0]	pc_plus_4_out;
wire        misaligned_instr_out;
wire [31:0] pc_mux_out;

msrv32_pc uut(
rst_in,
pc_src_in,
epc_in,
trap_address_in,
branch_taken_in,
iaddr_in,
ahb_ready_in,
pc_in,
iaddr_out,
pc_plus_4_out,
misaligned_instr_out,
pc_mux_out);

initial begin
rst_in=1'b1;
pc_in=$random;
iaddr_in=$random;
epc_in=$random;
trap_address_in=$random;
pc_src_in=2'b00;
branch_taken_in=1'b0;
ahb_ready_in=1'b0;
#10
rst_in=1'b0;
#10
ahb_ready_in=1'b1;
#10 
pc_src_in=2'b01;
#10 
pc_src_in=2'b10;
#10 
pc_src_in=2'b11;
#10
branch_taken_in=1'b1;
#10;
end
endmodule
