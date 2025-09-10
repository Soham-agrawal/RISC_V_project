`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2025 09:24:37 PM
// Design Name: 
// Module Name: msrv32_integer_file
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


module msrv32_integer_file(
    input ms_riscv32_mp_clk_in,
    input ms_riscv32_mp_rst_in,
    input [4:0] rs_2_addr_in,
    input [4:0] rd_addr_in,
    input wr_en_in,
    input [31:0] rd_in,
    input [4:0] rs_1_addr_in,
    output reg [31:0] rs_1_out,
    output reg [31:0] rs_2_out
    );
    reg [31:0] reg_file [31:0];
    wire mux_1, mux_2;
    integer i;
    always @(posedge ms_riscv32_mp_clk_in or posedge ms_riscv32_mp_rst_in) begin
        if (ms_riscv32_mp_rst_in) begin
            for(i=0; i<32;i=i+1) begin
                reg_file[i]<= 32'b0;
            end
        end
        else begin
            if(wr_en_in) begin
                reg_file[rd_addr_in] <= rd_in;
            end
        end         
    end
    
    always @(*) begin
        if (ms_riscv32_mp_rst_in) begin
            rs_1_out <= 32'b0;
            rs_2_out <= 32'b0;
        end
        else begin
            if(wr_en_in && rs_1_addr_in== rd_addr_in) begin
                rs_1_out <= rd_in;
            end
            else begin
                rs_1_out <= reg_file[rs_1_addr_in];
            end
            
            if(wr_en_in && rs_2_addr_in== rd_addr_in) begin
                rs_2_out <= rd_in;
            end
            else begin
                rs_2_out <= reg_file[rs_2_addr_in];
            end
        end         
    end
endmodule
 