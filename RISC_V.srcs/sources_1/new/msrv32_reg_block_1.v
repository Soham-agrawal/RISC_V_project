`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 07:59:27 PM
// Design Name: 
// Module Name: msrv32_reg_block_1
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


module msrv32_reg_block_1(
    input [31:0] pc_mux_in,
    input ms_riscv32_mp_clk_in,
    input ms_riscv32_mp_rst_in,
    output reg [31:0] pc_out
    );
    always @(posedge ms_riscv32_mp_clk_in or posedge ms_riscv32_mp_rst_in)
        begin
        if(ms_riscv32_mp_rst_in)
            pc_out<=32'h00000000;
        else
            pc_out<=pc_mux_in;   
    end
endmodule
