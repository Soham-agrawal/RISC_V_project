`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2025 09:32:05 PM
// Design Name: 
// Module Name: msrv32_store_unit_tb
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


module msrv32_store_unit_tb();
reg [2:0] funct3_in;
reg [31:0] iadder_in;
reg [31:0] rs2_in;
reg mem_wr_req_in;
reg ahb_ready_in;

// Outputs
wire [31:0] ms_riscv32_mp_dmdata_out;
wire [31:0] ms_riscv32_mp_dmaddr_out;
wire [3:0] ms_riscv32_mp_dmwr_mask_out;
wire ms_riscv32_mp_dmwr_req_out;
wire [1:0] ahb_htrans_out;

// Instantiate the Unit Under Test (UUT)
msrv32_store_unit uut (
    .funct3_in(funct3_in), 
    .iadder_in(iadder_in), 
    .rs2_in(rs2_in), 
    .mem_wr_req_in(mem_wr_req_in), 
    .ahb_ready_in(ahb_ready_in), 
    .ms_riscv32_mp_dmdata_out(ms_riscv32_mp_dmdata_out), 
    .ms_riscv32_mp_dmaddr_out(ms_riscv32_mp_dmaddr_out), 
    .ms_riscv32_mp_dmwr_mask_out(ms_riscv32_mp_dmwr_mask_out), 
    .ms_riscv32_mp_dmwr_req_out(ms_riscv32_mp_dmwr_req_out), 
    .ahb_htrans_out(ahb_htrans_out)
);

initial begin
    // Initialize Inputs
    funct3_in = 0;
    iadder_in = 0;
    rs2_in = 0;
    mem_wr_req_in = 0;
    ahb_ready_in = 0;
    #10;
     funct3_in = 3'b000; // SB
    iadder_in = 32'h00000001; // Address offset
    rs2_in = 32'h000000FF; // Data to be written
    mem_wr_req_in = 1;
    ahb_ready_in = 1;
    #10;
    mem_wr_req_in = 0;
    ahb_ready_in = 0;
    #10;  
     funct3_in = 3'b001; // SH
    iadder_in = 32'h00000002; // Address offset
    rs2_in = 32'h0000FFFF; // Data to be written
    mem_wr_req_in = 1;
    ahb_ready_in = 1;
    #10;
    mem_wr_req_in = 0;
    ahb_ready_in = 0;
    #10;
    funct3_in = 3'b010; // SW
    iadder_in = 32'h00000004; // Address offset
    rs2_in = 32'hFFFFFFFF; // Data to be written
    mem_wr_req_in = 1;
    ahb_ready_in = 1;
    #10;
    mem_wr_req_in = 0;
    ahb_ready_in = 0;
    #10;
    funct3_in = 3'b010; // SW
    iadder_in = 32'h00000008; // Address offset
    rs2_in = 32'hAAAAAAAA; // Data to be written
    mem_wr_req_in = 1;
    ahb_ready_in = 0;
    #10;
    mem_wr_req_in = 0;
    ahb_ready_in = 1;
    #10;
    $stop;
end

endmodule
