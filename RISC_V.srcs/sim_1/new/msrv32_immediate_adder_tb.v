`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 10:12:40 PM
// Design Name: 
// Module Name: msrv32_immediate_adder_tb
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


module msrv32_immediate_adder_tb();
    reg [31:0] pc_in;
    reg [31:0] rs_1_in;
    reg iadder_src_in;
    reg [31:0] imm_in;
    wire [31:0] iadder_out;
    
    msrv32_immediate_adder uut(
        pc_in,
        rs_1_in,
        iadder_src_in,
        imm_in,
        iadder_out);
    
    initial begin
        pc_in=$random;
        rs_1_in=$random;
        imm_in=$random;
        iadder_src_in=1'b0;
        #10;
        iadder_src_in=1'b1;
        #10;
    end
endmodule
