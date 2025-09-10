`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 09:42:23 PM
// Design Name: 
// Module Name: msrv32_wr_en_generator
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


module msrv32_wr_en_generator(
    input flush_in,
    input rf_wr_en_reg_in,
    input csr_wr_en_reg_in,
    output wr_en_integer_file_out,
    output wr_en_csr_file_out
    );
    assign wr_en_integer_file_out = flush_in? 1'b0: rf_wr_en_reg_in;
    assign wr_en_csr_file_out = flush_in? 1'b0: csr_wr_en_reg_in;
endmodule
