`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2025 05:23:47 PM
// Design Name: 
// Module Name: msrv32_instruction_mux_tb
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


module msrv32_instruction_mux_tb; 
    // Inputs 
    reg flush_in; 
    reg [31:0] ms_riscv32_mp_instr_in; 
 
    // Outputs 
    wire [6:0] opcode_out; 
    wire [2:0] funct3_out; 
    wire [6:0] funct7_out; 
    wire [4:0] rs1addr_out; 
    wire [4:0] rs2addr_out; 
    wire [4:0] rdaddr_out; 
    wire [11:0] csr_addr_out; 
    wire [24:0] instr_out; 
 
    // Instantiate the Unit Under Test (UUT) 
    msrv32_instruction_mux uut ( 
        .flush_in(flush_in),  
        
.ms_riscv32_mp_instr_in(ms_riscv32_mp_instr_in),  
        .opcode_out(opcode_out),  
        .funct3_out(funct3_out),  
        .funct7_out(funct7_out),  
        .rs1addr_out(rs1addr_out),  
        .rs2addr_out(rs2addr_out),  
        .rdaddr_out(rdaddr_out),  
        .csr_addr_out(csr_addr_out),  
        .instr_out(instr_out) 
    );
    initial  
begin 
        // Initialize Inputs 
        flush_in = 0; 
        ms_riscv32_mp_instr_in = 32'h00000000; 
        #10; 
        flush_in = 1; 
        ms_riscv32_mp_instr_in = 32'h12345678; 
        #10; 
        flush_in = 1; 
        ms_riscv32_mp_instr_in = 32'h12345678; 
        #10; 
        flush_in = 0; 
        ms_riscv32_mp_instr_in = 32'h111111AA; 
        #10; 
        flush_in = 1; 
        ms_riscv32_mp_instr_in = 32'hFFFFFFAB; 
        #10; 
        flush_in = 1; 
        ms_riscv32_mp_instr_in = 32'h12345678; 
        #10; 
        flush_in = 0; 
        ms_riscv32_mp_instr_in = 32'h12121212; 
        #10; 
        flush_in = 0; 
        ms_riscv32_mp_instr_in = 32'h10100000; 
        #10; 
        flush_in = 1; 
        #10; 
        flush_in = 0; 
         
        $finish; 
end 
         
         
endmodule
