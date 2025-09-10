`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 09:53:54 PM
// Design Name: 
// Module Name: msrv2_wr_en_generator_tb
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


module msrv32_wr_en_generator_tb( );
reg flush_in; 
reg rf_wr_en_reg_in; 
reg csr_wr_en_reg_in;
// Outputs 
wire wr_en_integer_file_out; 
wire wr_en_csr_file_out; 
 
// Instantiate the Unit Under Test (UUT) 
msrv32_wr_en_generator uut ( 
    .flush_in(flush_in), 
    .rf_wr_en_reg_in(rf_wr_en_reg_in), 
    .csr_wr_en_reg_in(csr_wr_en_reg_in), 
    .wr_en_integer_file_out(wr_en_integer_file_out), 
    .wr_en_csr_file_out(wr_en_csr_file_out) 
); 
 
initial 
begin 
    // Initialize Inputs 
    flush_in = 0; 
    rf_wr_en_reg_in = 0; 
    csr_wr_en_reg_in = 0; 
    #15; 
    flush_in = 0; 
    rf_wr_en_reg_in = 1; 
    csr_wr_en_reg_in = 1; 
    #15; 
    flush_in = 1; 
    rf_wr_en_reg_in = 1; 
    csr_wr_en_reg_in = 1; 
    #15; 
    flush_in = 1; 
    rf_wr_en_reg_in = 0; 
    csr_wr_en_reg_in = 1; 
    #15; 
    flush_in = 0; 
    rf_wr_en_reg_in = 0; 
    csr_wr_en_reg_in = 1; 
    #15; 
    flush_in = 0; 
    rf_wr_en_reg_in = 1; 
    csr_wr_en_reg_in = 0; 
    #15; 
    flush_in = 1; 
    rf_wr_en_reg_in = 1;
    csr_wr_en_reg_in = 0; 
    #15; 
    flush_in = 0; 
    rf_wr_en_reg_in = 1; 
    csr_wr_en_reg_in = 1; 
    #15 
    $finish; 
end
endmodule
