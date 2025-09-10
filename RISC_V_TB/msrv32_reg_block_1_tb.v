`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 08:10:07 PM
// Design Name: 
// Module Name: msrv32_reg_block_1_tb
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


module msrv32_reg_block_1_tb();
    reg [31:0] pc_mux_in;
    reg ms_riscv32_mp_clk_in;
    reg ms_riscv32_mp_rst_in;
    wire [31:0] pc_out;
    msrv32_reg_block_1 uut(
        pc_mux_in,
        ms_riscv32_mp_clk_in,
        ms_riscv32_mp_rst_in,
        pc_out);
    initial begin
        ms_riscv32_mp_clk_in=1'b0;
        #5;
        forever begin
            ms_riscv32_mp_clk_in=~ms_riscv32_mp_clk_in;
            #5;
        end
    end
    
    initial begin
        pc_mux_in=$random;
        ms_riscv32_mp_rst_in=1'b1;
        #10
        ms_riscv32_mp_rst_in=1'b0;
        #10
        pc_mux_in=$random;
        #10;
    end        
    
endmodule
