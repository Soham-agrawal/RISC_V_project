`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: maven silicon - VIT Vellore
// Engineer: VLSI Design
// 
// Testbench for msrv32_reg_block_2
//////////////////////////////////////////////////////////////////////////////////

module msrv32_reg_block_2_tb;

    // Inputs
    reg clk_in;
    reg reset_in;
    reg [4:0] rd_addr_in;
    reg [11:0] csr_addr_in;
    reg [31:0] rs1_in;
    reg [31:0] rs2_in;
    reg [31:0] pc_in;
    reg [31:0] pc_plus_4_in;
    reg branch_taken_in;
    reg [31:0] iadder_in;
    reg [3:0] alu_opcode_in;
    reg [1:0] load_size_in;
    reg load_unsigned_in;
    reg alu_src_in;
    reg csr_wr_en_in;
    reg rf_wr_en_in;
    reg [2:0] wb_mux_sel_in;
    reg [2:0] csr_op_in;
    reg [31:0] imm_in;

    // Outputs
    wire [4:0] rd_addr_reg_out;
    wire [11:0] csr_addr_reg_out;
    wire [31:0] rs1_reg_out;
    wire [31:0] rs2_reg_out;
    wire [31:0] pc_reg_out;
    wire [31:0] pc_plus_4_reg_out;
    wire [31:0] iadder_out_reg_out;
    wire [3:0] alu_opcode_reg_out;
    wire [1:0] load_size_reg_out;
    wire load_unsigned_reg_out;
    wire alu_src_reg_out;
    wire csr_wr_en_reg_out;
    wire rf_wr_en_reg_out;
    wire [2:0] wb_mux_sel_reg_out;
    wire [2:0] csr_op_reg_out;
    wire [31:0] imm_reg_out;

    // Instantiate DUT
    msrv32_reg_block_2 uut (
        .clk_in(clk_in),
        .reset_in(reset_in),
        .rd_addr_in(rd_addr_in),
        .csr_addr_in(csr_addr_in),
        .rs1_in(rs1_in),
        .rs2_in(rs2_in),
        .pc_in(pc_in),
        .pc_plus_4_in(pc_plus_4_in),
        .branch_taken_in(branch_taken_in),
        .iadder_in(iadder_in),
        .alu_opcode_in(alu_opcode_in),
        .load_size_in(load_size_in),
        .load_unsigned_in(load_unsigned_in),
        .alu_src_in(alu_src_in),
        .csr_wr_en_in(csr_wr_en_in),
        .rf_wr_en_in(rf_wr_en_in),
        .wb_mux_sel_in(wb_mux_sel_in),
        .csr_op_in(csr_op_in),
        .imm_in(imm_in),
        .rd_addr_reg_out(rd_addr_reg_out),
        .csr_addr_reg_out(csr_addr_reg_out),
        .rs1_reg_out(rs1_reg_out),
        .rs2_reg_out(rs2_reg_out),
        .pc_reg_out(pc_reg_out),
        .pc_plus_4_reg_out(pc_plus_4_reg_out),
        .iadder_out_reg_out(iadder_out_reg_out),
        .alu_opcode_reg_out(alu_opcode_reg_out),
        .load_size_reg_out(load_size_reg_out),
        .load_unsigned_reg_out(load_unsigned_reg_out),
        .alu_src_reg_out(alu_src_reg_out),
        .csr_wr_en_reg_out(csr_wr_en_reg_out),
        .rf_wr_en_reg_out(rf_wr_en_reg_out),
        .wb_mux_sel_reg_out(wb_mux_sel_reg_out),
        .csr_op_reg_out(csr_op_reg_out),
        .imm_reg_out(imm_reg_out)
    );

    // Clock generation
    always #5 clk_in = ~clk_in;

    initial begin
        // Initialize
        clk_in = 0;
        reset_in = 1;
        #10 reset_in = 0;

        // Test case 1
        rd_addr_in = 5'd1;
        csr_addr_in = 12'h002;
        rs1_in = 32'h0000_0003;
        rs2_in = 32'h0000_0004;
        pc_in = 32'h0000_0100;
        pc_plus_4_in = 32'h0000_0104;
        alu_opcode_in = 4'h3;
        load_size_in = 2'b01;
        load_unsigned_in = 1'b0;
        alu_src_in = 1'b1;
        csr_wr_en_in = 1'b0;
        rf_wr_en_in = 1'b1;
        wb_mux_sel_in = 3'b010;
        csr_op_in = 3'b001;
        imm_in = 32'h0000_1234;
        iadder_in = 32'h0000_2000;
        branch_taken_in = 0;
        #20;

        // Test case 2
        rd_addr_in = 5'd5;
        csr_addr_in = 12'h010;
        rs1_in = 32'hAAAA_BBBB;
        rs2_in = 32'hCCCC_DDDD;
        pc_in = 32'h0000_0200;
        pc_plus_4_in = 32'h0000_0204;
        alu_opcode_in = 4'hA;
        load_size_in = 2'b10;
        load_unsigned_in = 1'b1;
        alu_src_in = 1'b0;
        csr_wr_en_in = 1'b1;
        rf_wr_en_in = 1'b0;
        wb_mux_sel_in = 3'b100;
        csr_op_in = 3'b011;
        imm_in = 32'h0000_ABCD;
        iadder_in = 32'h0000_3000;
        branch_taken_in = 1;
        #20;

        // More test cases can be added here...

        $finish;
    end

endmodule
