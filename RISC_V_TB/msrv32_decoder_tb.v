`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2025 04:20:14 PM
// Design Name: 
// Module Name: msrv32_decoder_tb
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


module msrv32_decoder_tb();
reg trap_taken_in; 
    reg funct7_5_in; 
    reg [6:0] opcode_in; 
    reg [2:0] funct3_in; 
    reg [1:0] iadder_out_1_to_0_in; 
 
    wire [2:0] wb_mux_sel_out; 
    wire [2:0] imm_type_out; 
    wire [2:0] csr_op_out; 
    wire mem_wr_req_out; 
    wire [3:0] alu_opcode_out; 
    wire [1:0] load_size_out; 
    wire load_unsigned_out; 
    wire alu_src_out; 
    wire iadder_src_out; 
    wire csr_wr_en_out; 
    wire rf_wr_en_out; 
    wire illegal_instr_out; 
    wire misaligned_load_out; 
    wire misaligned_store_out; 
 
    msrv32_decoder uut ( 
        .trap_taken_in(trap_taken_in), 
        .funct7_5_in(funct7_5_in), 
        .opcode_in(opcode_in), 
        .funct3_in(funct3_in), 
        .iadder_out_1_to_0_in(iadder_out_1_to_0_in), 
        .wb_mux_sel_out(wb_mux_sel_out), 
        .imm_type_out(imm_type_out), 
        .csr_op_out(csr_op_out), 
        .mem_wr_req_out(mem_wr_req_out), 
        .alu_opcode_out(alu_opcode_out), 
        .load_size_out(load_size_out), 
        .load_unsigned_out(load_unsigned_out), 
        .alu_src_out(alu_src_out), 
        .iadder_src_out(iadder_src_out), 
        .csr_wr_en_out(csr_wr_en_out), 
        .rf_wr_en_out(rf_wr_en_out), 
        .illegal_instr_out(illegal_instr_out), 
        .misaligned_load_out(misaligned_load_out), 
        .misaligned_store_out(misaligned_store_out) 
    ); 
 
    initial begin 
        // Test case 1 
        trap_taken_in = 0; 
        funct7_5_in = 0; 
        opcode_in = 7'b0110011;  // is_op 
        funct3_in = 3'b000; 
        iadder_out_1_to_0_in = 2'b00; 
        #10; 
 
        // Test case 2 
        trap_taken_in = 0; 
        funct7_5_in = 0; 
        opcode_in = 7'b0010011;  // is_op_imm 
        funct3_in = 3'b010; 
        iadder_out_1_to_0_in = 2'b01; 
        #10; 
 
        // Test case 3 
        trap_taken_in = 0; 
        funct7_5_in = 1; 
        opcode_in = 7'b0000011;  // is_load 
        funct3_in = 3'b011; 
        iadder_out_1_to_0_in = 2'b10; 
        #10; 
 
        // Test case 4 
        trap_taken_in = 0; 
        funct7_5_in = 1; 
        opcode_in = 7'b0100011;  // is_store 
        funct3_in = 3'b111; 
        iadder_out_1_to_0_in = 2'b11; 
        #10;
         // Test case 5 
        trap_taken_in = 0; 
        funct7_5_in = 0; 
        opcode_in = 7'b1100011;  // is_branch 
        funct3_in = 3'b110; 
        iadder_out_1_to_0_in = 2'b00; 
        #10; 
 
        // Test case 6 
        trap_taken_in = 0; 
        funct7_5_in = 0; 
        opcode_in = 7'b1101111;  // is_jal 
        funct3_in = 3'b100; 
        iadder_out_1_to_0_in = 2'b01; 
        #10; 
 
        // Test case 7 
        trap_taken_in = 0; 
        funct7_5_in = 1; 
        opcode_in = 7'b1100111;  // is_jalr 
        funct3_in = 3'b010; 
        iadder_out_1_to_0_in = 2'b10; 
        #10; 
 
        // Test case 8 
        trap_taken_in = 1; 
        funct7_5_in = 1; 
        opcode_in = 7'b0110111;  // is_lui 
        funct3_in = 3'b001; 
        iadder_out_1_to_0_in = 2'b11; 
        #10; 
 
        $finish; 
    end 
endmodule
