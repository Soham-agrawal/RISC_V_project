`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2025 10:22:41 PM
// Design Name: 
// Module Name: msrv32_integer_file_tb
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



module msrv32_integer_file_tb(); 
reg ms_riscv32_mp_clk_in; 
reg ms_riscv32_mp_rst_in; 
reg [4:0] rs_2_addr_in; 
reg [4:0] rd_addr_in; 
reg wr_en_in; 
reg [31:0] rd_in; 
reg [4:0] rs_1_addr_in; 
 
// Outputs 
wire [31:0] rs_1_out; 
wire [31:0] rs_2_out; 
 
// Instantiate the Unit Under Test (UUT) 
msrv32_integer_file uut ( 
    .ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in),  
    .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in),  
    .rs_2_addr_in(rs_2_addr_in),  
    .rd_addr_in(rd_addr_in),  
    .wr_en_in(wr_en_in),  
    .rd_in(rd_in),  
    .rs_1_addr_in(rs_1_addr_in),  
    .rs_1_out(rs_1_out),  
    .rs_2_out(rs_2_out) 
); 
 
// Clock generation 
initial begin 
    ms_riscv32_mp_clk_in = 0; 
    forever #5 ms_riscv32_mp_clk_in = 
~ms_riscv32_mp_clk_in; // 10ns period 
end 
initial  begin  
    ms_riscv32_mp_rst_in = 1; 
    rs_2_addr_in = 0; 
    rd_addr_in = 0; 
    wr_en_in = 0; 
    rd_in = 0; 
    rs_1_addr_in = 0; 
    #10; 
    ms_riscv32_mp_rst_in = 0; 
    wr_en_in = 1; 
    // Test Case 1: Write to register 1 and read it back 
    #10; 
    wr_en_in = 1; 
    rd_addr_in = 5'd1; 
    rd_in = 32'hA5A5A5A5; 
     
    #10; 
    wr_en_in = 1; 
    rs_1_addr_in = 5'b10111; 
    rs_2_addr_in = 5'b00001; 
     #10; 
    wr_en_in = 1; 
    rd_addr_in = 5'd2; 
    rd_in = 32'h5A5A5A5A; 
     
    #10; 
    wr_en_in = 0; 
    rs_1_addr_in = 5'd2; 
    rs_2_addr_in = 5'd2; 
     
    #10; 
    wr_en_in = 1; 
    rd_addr_in = 5'd3; 
    rd_in = 32'h12345678; 
     
    #10; 
    wr_en_in = 0; 
    rs_1_addr_in = 5'd3; 
    rs_2_addr_in = 5'd3; 
    #10; 
    wr_en_in = 1; 
    rd_addr_in = 5'd6; 
    rd_in = 32'hF0F0F0F0; 
 
    #10; 
    wr_en_in = 0; 
    rs_1_addr_in = 5'd6; 
    rs_2_addr_in = 5'd6; 
        #10; 
    wr_en_in = 1; 
    rd_addr_in = 5'd7; 
    rd_in = 32'hAAAAAAAA; 
 
    #10; 
    wr_en_in = 0; 
    rs_1_addr_in = 5'd7; 
    rs_2_addr_in = 5'd7; 
     
        #10; 
    wr_en_in = 1; 
    rd_addr_in = 5'd8; 
    rd_in = 32'h55555555; 
 
    #10; 
    wr_en_in = 0; 
    rs_1_addr_in = 5'd8; 
    rs_2_addr_in = 5'd8; 
     
    #10; 
    wr_en_in = 1; 
    rd_addr_in = 5'd9; 
    rd_in = 32'hFFFFFFFF; 
 
    #10; 
    wr_en_in = 0; 
    rs_1_addr_in = 5'd9; 
    rs_2_addr_in = 5'd9; 
     
    #10; 
    wr_en_in = 1; 
    rd_addr_in = 5'd10; 
    rd_in = 32'h00000000; 
 
    #10; 
    wr_en_in = 0; 
    rs_1_addr_in = 5'd10; 
    rs_2_addr_in = 5'd10; 
    #10; 
    $stop; 
     
end 
endmodule 
