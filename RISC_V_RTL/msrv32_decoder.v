`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2025 04:19:48 PM
// Design Name: 
// Module Name: msrv32_decoder
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


module msrv32_decoder(
    input trap_taken_in,
    input funct7_5_in,
    input [6:0] opcode_in,
    input [2:0] funct3_in,
    input [1:0] iadder_out_1_to_0_in,
    output [2:0] wb_mux_sel_out,
    output [2:0] imm_type_out,
    output [2:0] csr_op_out,
    output mem_wr_req_out,
    output [3:0] alu_opcode_out,
    output [1:0] load_size_out,
    output load_unsigned_out,
    output alu_src_out,
    output iadder_src_out,
    output csr_wr_en_out,
    output rf_wr_en_out,
    output illegal_instr_out,
    output misaligned_load_out,
    output misaligned_store_out
    );
    reg is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori;
    reg is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem;
    wire is_csr;
    wire is_implemented_instr;
    wire mal_word;
    wire mal_half;
    
    assign alu_opcode_out[2:0] = funct3_in;
    assign alu_opcode_out[3] = funct7_5_in & ~(is_addi| is_slti| is_sltiu| is_andi| is_ori| is_xori);
    assign load_size_out = funct3_in[1:0];
    assign load_unsigned_out = funct3_in[2];
    assign alu_src_out = opcode_in[4];
    assign iadder_src_out = is_load | is_store | is_jalr;
    assign is_csr = is_system & (funct3_in[2]| funct3_in[1]|funct3_in[0]);
    assign csr_wr_en_out = is_csr;
    assign rf_wr_en_out = is_lui| is_auipc | is_jalr | is_jal | is_op | is_load | is_csr | is_op_imm;
    assign wb_mux_sel_out[0] = is_load | is_auipc | is_jal | is_jalr;
    assign wb_mux_sel_out[1] = is_lui | is_auipc;
    assign wb_mux_sel_out[2] = is_csr | is_jal | is_jalr;
    assign imm_type_out[0] = is_op_imm | is_load | is_jalr | is_branch | is_jal;
    assign imm_type_out[1] = is_store | is_branch | is_csr;
    assign imm_type_out[2] = is_lui | is_auipc | is_jal| is_csr;
    assign is_implemented_instr = is_branch| is_jal| is_jalr| is_auipc| is_lui| is_op| is_op_imm| is_load| is_store| is_system| is_misc_mem;
    assign illegal_instr_out = ~opcode_in[1] | ~opcode_in[0] | ~is_implemented_instr;
    assign csr_op_out = funct3_in;
    assign misaligned_load_out = (mal_word | mal_half) & is_load;
    assign misaligned_store_out = (mal_word | mal_half) & is_store;
    assign mal_word = funct3_in[1] & ~funct3_in[0] & (iadder_out_1_to_0_in[0]| iadder_out_1_to_0_in[1]); 
    assign mal_half = ~funct3_in[1] & funct3_in[0] & iadder_out_1_to_0_in[0];
    assign mem_wr_req_out = is_store & ~trap_taken_in & ~mal_word & ~mal_half;
    always @(*) begin
        case(opcode_in[6:2])
            5'b11000: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b10000000000;
            5'b11011: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b01000000000;
            5'b11001: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00100000000;
            5'b00101: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00010000000;
            5'b01101: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00001000000;
            5'b01100: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00000100000;
            5'b00100: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00000010000;
            5'b00000: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00000001000;
            5'b01000: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00000000100;
            5'b11100: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00000000010;
            5'b00011: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00000000001;
            default: {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem}= 11'b00000000000;
            endcase
      end
    always @(*) begin
        case(funct3_in)
            3'b000: {is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori} = {is_op_imm,1'b0,1'b0,1'b0,1'b0,1'b0};
            3'b010: {is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori} = {1'b0,is_op_imm,1'b0,1'b0,1'b0,1'b0};
            3'b011: {is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori} = {1'b0,1'b0,is_op_imm,1'b0,1'b0,1'b0};
            3'b111: {is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori} = {1'b0,1'b0,1'b0,is_op_imm,1'b0,1'b0};
            3'b110: {is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori} = {1'b0,1'b0,1'b0,1'b0,is_op_imm,1'b0};
            3'b100: {is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori} = {1'b0,1'b0,1'b0,1'b0,1'b0,is_op_imm};
            default: {is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori}=6'd0;
            endcase
         end
endmodule
