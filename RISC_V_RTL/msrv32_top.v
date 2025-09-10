module msrv32_top(
    input ms_riscv32_mp_clk_in,
    input ms_riscv32_mp_rst_in,
    input [63:0] ms_riscv32_mp_rc_in,
    output [31:0] ms_riscv32_mp_imaddr_out,
    input [31:0] ms_riscv32_mp_instr_in,
    input ms_riscv32_mp_instr_hready_in,
    output [31:0] ms_riscv32_mp_dmaddr_out,
    output [31:0] ms_riscv32_mp_dmdata_out,
    output ms_riscv32_mp_dmwr_req_out,
    output [3:0] ms_riscv32_mp_dmwr_mask_out,
    input [31:0] ms_riscv32_mp_data_in,
    input ms_riscv32_mp_data_hready_in,
    input ms_riscv32_mp_hresp_in,
    output [1:0] ms_riscv32_mp_data_htrans_out,
    input ms_riscv32_mp_eirq_in,
    input ms_riscv32_mp_tirq_in,
    input ms_riscv32_mp_sirq_in
);

// Internal wires and registers
wire [31:0] iaddr;
wire [31:0] pc;
wire [31:0] pc_plus_4;
wire misaligned_instr;
wire [31:0] pc_mux;
wire branch_taken;
wire [1:0] pc_src;
wire [31:0] epc;
wire [31:0] trap_address;

// Decoding/Instruction wires
wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;
wire [4:0] rs1_addr;
wire [4:0] rs2_addr;
wire [4:0] rd_addr;
wire [11:0] csr_addr;
wire [31:7] instr_31_to_7;

// Integer register wires
wire [31:0] rs1, rs2;

// Immediate
wire [31:0] imm;

// Control signals
wire flush;
wire iadder_src;
wire mem_wr_req;
wire illegal_instr;
wire misaligned_load, misaligned_store;
wire [2:0] wb_mux_sel;
wire [2:0] imm_type;
wire [2:0] csr_op;
wire load_unsigned, csr_wr_en, rf_wr_en;
wire [3:0] alu_opcode;
wire [1:0] load_size;
wire wr_en_integer_file, wr_en_csr_file;

// Register block 2 signals
wire [4:0] rd_addr_reg;
wire [11:0] csr_addr_reg;
wire [31:0] rs1_reg, rs2_reg, pc_reg2, pc_plus_4_reg;
wire [3:0] alu_opcode_reg;
wire [1:0] load_size_reg;
wire load_unsigned_reg, alu_src_reg, csr_wr_en_reg, rf_wr_en_reg;
wire [2:0] wb_mux_sel_reg, csr_op_reg;
wire [31:0] imm_reg, iadder_out_reg;

// Immediate adder
wire [31:0] iadder_out;

// Branch
wire branch_taken_wire;

// Store Unit
wire [31:0] su_data_out, su_d_addr;
wire [3:0] su_wr_mask;
wire su_wr_req;

// CSR
wire i_or_e, set_cause, set_epc, instret_inc, mie_clear, mie_set, misaligned_exception, mie;
wire meie_out, mtie_out, msie_out, meip_out, mtip_out, msip_out;
wire [3:0] cause;

// Load Unit
wire [31:0] lu_output;

// ALU
wire [31:0] alu_result;

// WB mux
wire [31:0] wb_mux_out, alu_2nd_src_mux;

// Trap
wire trap_taken;

// Machine control
wire flush_wire;

// PC
msrv32_pc PC(
    .rst_in(ms_riscv32_mp_rst_in),
    .pc_src_in(pc_src),
    .epc_in(epc),
    .trap_address_in(trap_address),
    .branch_taken_in(branch_taken),
    .iaddr_in(iadder_out[30:0]),
    .ahb_ready_in(ms_riscv32_mp_instr_hready_in),
    .pc_in(pc),
    .iaddr_out(ms_riscv32_mp_imaddr_out),
    .pc_plus_4_out(pc_plus_4),
    .misaligned_instr_out(misaligned_instr),
    .pc_mux_out(pc_mux)
);

msrv32_reg_block_1 REG1 (
    .pc_mux_in(pc_mux),
    .ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in),
    .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in),
    .pc_out(pc)
);

msrv32_instruction_mux IM (
    .flush_in(flush),
    .ms_riscv32_mp_instr_in(ms_riscv32_mp_instr_in),
    .opcode_out(opcode),
    .funct3_out(funct3),
    .funct7_out(funct7),
    .rs1addr_out(rs1_addr),
    .rs2addr_out(rs2_addr),
    .rdaddr_out(rd_addr),
    .csr_addr_out(csr_addr),
    .instr_out(instr_31_to_7)
);

msrv32_store_unit SU (
    .funct3_in(funct3[1:0]),
    .iadder_in(iadder_out),
    .rs2_in(rs2),
    .mem_wr_req_in(mem_wr_req),
    .ahb_ready_in(ms_riscv32_mp_data_hready_in),
    .ms_riscv32_mp_dmdata_out(ms_riscv32_mp_dmdata_out),
    .ms_riscv32_mp_dmaddr_out(ms_riscv32_mp_dmaddr_out),
    .ms_riscv32_mp_dmwr_mask_out(ms_riscv32_mp_dmwr_mask_out),
    .ms_riscv32_mp_dmwr_req_out(ms_riscv32_mp_dmwr_req_out),
    .ahb_htrans_out(ms_riscv32_mp_data_htrans_out)
);

msrv32_decoder DEC (
    .trap_taken_in(trap_taken),
    .funct7_5_in(funct7),
    .opcode_in(opcode),
    .funct3_in(funct3),
    .iadder_out_1_to_0_in(iadder_out[1:0]),
    .wb_mux_sel_out(wb_mux_sel),
    .imm_type_out(imm_type),
    .csr_op_out(csr_op),
    .mem_wr_req_out(mem_wr_req),
    .alu_opcode_out(alu_opcode),
    .load_size_out(load_size),
    .load_unsigned_out(load_unsigned),
    .alu_src_out(alu_src),
    .iadder_src_out(iadder_src),
    .csr_wr_en_out(csr_wr_en),
    .rf_wr_en_out(rf_wr_en),
    .illegal_instr_out(illegal_instr),
    .misaligned_load_out(misaligned_load),
    .misaligned_store_out(misaligned_store)
);

msrv32_imm_generator IMG (
    .instr_in(instr_31_to_7),
    .imm_type_in(imm_type),
    .imm_out (imm)
);

msrv32_immediate_adder IMM_ADDER (
    .pc_in(pc),
    .rs_1_in(rs1),
    .iadder_src_in(iadder_src),
    .imm_in(imm),
    .iadder_out(iadder_out)
);

// Branch Unit
branch_unit BU (
    .rs1_in(rs1),
    .rs2_in(rs2),
    .opcode_6_to_2_in(opcode[6:2]),
    .funct3_in(funct3),
    .branch_taken_out(branch_taken)
);

msrv32_integer_file IRF (
    .ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in),
    .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in),
    .rs_2_addr_in(rs2_addr),
    .rd_addr_in(rd_addr_reg),
    .wr_en_in(wr_en_integer_file),
    .rd_in(wb_mux_out),
    .rs_1_addr_in(rs1_addr),
    .rs_1_out(rs1),
    .rs_2_out(rs2)
);

msrv32_wr_en_generator WREN (
    .flush_in(flush),
    .rf_wr_en_reg_in(rf_wr_en_reg),
    .csr_wr_en_reg_in(csr_wr_en_reg),
    .wr_en_integer_file_out(wr_en_integer_file),
    .wr_en_csr_file_out(wr_en_csr_file)
);

msrv32_csr_file CSRF (
    .i_or_e_in(i_or_e),
    .cause_in(cause),
    .instret_inc_in(instret_inc),
    .mie_clear_in(mie_clear),
    .mie_set_in(mie_set),
    .set_epc_in(set_epc),
    .set_cause_in(set_cause),
    .ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in),
    .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in),
    .meie_out(meie_out),
    .mtie_out(mtie_out),
    .msie_out(msie_out),
    .meip_out(meip_out),
    .mtip_out(mtip_out),
    .msip_out(msip_out),
    .ms_riscv32_mp_eirq_in(ms_riscv32_mp_eirq_in),
    .ms_riscv32_mp_sirq_in(ms_riscv32_mp_sirq_in),
    .ms_riscv32_mp_tirq_in(ms_riscv32_mp_tirq_in),
    .csr_data_out(),
    .ms_riscv32_mp_rc_in(ms_riscv32_mp_rc_in),
    .mie_out(mie),
    .wr_en_in(wr_en_csr_file),
    .csr_addr_in(csr_addr_reg),
    .csr_op_in(csr_op_reg),
    .csr_uimm_in(imm_reg[4:0]),
    .csr_data_in(rs1_reg),
    .pc_in(pc_reg2),
    .iadder_in(iadder_out_reg),
    .trap_address_out(trap_address),
    .epc_out(epc)
);

msrv32_machine_control MC (
    .ms_riscv32_mp_clk_in(ms_riscv32_mp_clk_in),
    .ms_riscv32_mp_rst_in(ms_riscv32_mp_rst_in),
    .ms_riscv32_mp_eirq_in(ms_riscv32_mp_eirq_in),
    .ms_riscv32_mp_tirq_in(ms_riscv32_mp_tirq_in),
    .ms_riscv32_mp_sirq_in(ms_riscv32_mp_sirq_in),
    .illegal_instr_in(illegal_instr),
    .misaligned_load_in(misaligned_load),
    .misaligned_store_in(misaligned_store),
    .misaligned_instr_in(misaligned_instr),
    .opcode_6_to_2_in(opcode[6:2]),
    .funct3_in(funct3),
    .funct7_in(funct7),
    .rs1_addr_in(rs1_addr),
    .rs2_addr_in(rs2_addr),
    .rd_addr_in(rd_addr),
    .mie_in(mie),
    .meie_in(meie_out),
    .mtie_in(mtie_out),
    .msie_in(msie_out),
    .meip_in(meip_out),
    .mtip_in(mtip_out),
    .msip_in(msip_out),
    .i_or_e_out(i_or_e),
    .cause_out(cause),
    .instret_inc_out(instret_inc),
    .mie_clear_out(mie_clear),
    .mie_set_out(mie_set),
    .misaligned_exception_out(misaligned_exception),
    .set_epc_out(set_epc),
    .set_cause_out(set_cause),
    .flush_out(flush),
    .trap_taken_out(trap_taken),
    .pc_src_out(pc_src)
);

msrv32_reg_block_2 REG2 (
    .clk_in(ms_riscv32_mp_clk_in),
    .reset_in(ms_riscv32_mp_rst_in),
    .rd_addr_in(rd_addr),
    .csr_addr_in(csr_addr),
    .rs1_in(rs1),
    .rs2_in(rs2),
    .pc_in(pc),
    .pc_plus_4_in(pc_plus_4),
    .branch_taken_in(branch_taken),
    .iadder_in(iadder_out),
    .alu_opcode_in(alu_opcode),
    .load_size_in(load_size),
    .load_unsigned_in(load_unsigned),
    .alu_src_in(alu_src),
    .csr_wr_en_in(csr_wr_en),
    .rf_wr_en_in(rf_wr_en),
    .wb_mux_sel_in(wb_mux_sel),
    .csr_op_in(csr_op),
    .imm_in(imm),
    .rd_addr_reg_out(rd_addr_reg),
    .csr_addr_reg_out(csr_addr_reg),
    .rs1_reg_out(rs1_reg),
    .rs2_reg_out(rs2_reg),
    .pc_reg_out(pc_reg2),
    .pc_plus_4_reg_out(pc_plus_4_reg),
    .alu_opcode_reg_out(alu_opcode_reg),
    .load_size_reg_out(load_size_reg),
    .load_unsigned_reg_out(load_unsigned_reg),
    .alu_src_reg_out(alu_src_reg),
    .csr_wr_en_reg_out(csr_wr_en_reg),
    .rf_wr_en_reg_out(rf_wr_en_reg),
    .wb_mux_sel_reg_out(wb_mux_sel_reg),
    .csr_op_reg_out(csr_op_reg),
    .imm_reg_out(imm_reg),
    .iadder_out_reg_out(iadder_out_reg)
);

msrv32_load_unit LU (
    .ahb_resp_in(ms_riscv32_mp_hresp_in),
    .ms_riscv32_mp_dmdata_in(ms_riscv32_mp_data_in),
    .iadder_out_1_to_0_in(iadder_out_reg[1:0]),
    .load_unsigned_in(load_unsigned_reg),
    .load_size_in(load_size_reg),
    .lu_output_out(lu_output)
);

msrv32_alu ALU (
    .op_1_in(rs1_reg),
    .op_2_in(alu_2nd_src_mux),
    .opcode_in(alu_opcode_reg),
    .result_out(alu_result)
);

msrv32_wb_mux_sel_unit WBMUX(
    .alu_src_reg_in(alu_src_reg),
    .wb_mux_sel_reg_in(wb_mux_sel_reg),
    .alu_result_in(alu_result),
    .lu_output_in(lu_output),
    .imm_reg_in(imm_reg),
    .iadder_out_reg_in(iadder_out_reg),
    .csr_data_in(),
    .pc_plus_4_reg_in(pc_plus_4_reg),
    .rs2_reg_in(rs2_reg),
    .wb_mux_out(wb_mux_out),
    .alu_2nd_src_mux_out(alu_2nd_src_mux)
);

endmodule
