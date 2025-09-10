`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2025 09:51:12 PM
// Design Name: 
// Module Name: msrv32_pc
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


module msrv32_pc(
input		    rst_in,
input [1:0]	    pc_src_in,
input [31:0]	epc_in,
input [31:0]	trap_address_in,
input		    branch_taken_in,
input [30:0]	iaddr_in,
input 		    ahb_ready_in,
input [31:0]	pc_in,
output [31:0]	iaddr_out,
output [31:0]	pc_plus_4_out,
output		    misaligned_instr_out,
output reg [31:0] pc_mux_out
);

parameter boot_address= 32'd0;

wire [31:0] next_pc;
wire [31:0] mux_to_mux;
assign pc_plus_4_out= pc_in + 32'h00000004;

assign next_pc= branch_taken_in ? {iaddr_in[30:0],1'b0}:(pc_in + 32'h00000004);

always @(*)
    begin
	case (pc_src_in)
	    2'b00: 
		pc_mux_out<= boot_address;
	    2'b01:
		pc_mux_out<= epc_in;
	    2'b10:
	    pc_mux_out<= trap_address_in;
	    2'b11:
		pc_mux_out<= next_pc;
		default:
		pc_mux_out<= boot_address;
	endcase
 end
assign mux_to_mux = ahb_ready_in? pc_mux_out: iaddr_out;
assign iaddr_out= rst_in ? boot_address: mux_to_mux;

assign misaligned_instr_out= next_pc[0] & branch_taken_in;

endmodule




