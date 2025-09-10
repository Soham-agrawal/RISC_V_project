`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2025 05:46:56 PM
// Design Name: 
// Module Name: msrv32_csr_file_tb
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


module msrv32_csr_file_tb();
// Inputs
reg i_or_e_in;
reg [3:0] cause_in;
reg instret_inc_in;
reg mie_clear_in;
reg mie_set_in;
reg set_epc_in;
reg set_cause_in;
reg ms_riscv32_mp_clk_in;
reg ms_riscv32_mp_rst_in;
reg ms_riscv32_mp_eirq_in;
reg ms_riscv32_mp_sirq_in;
reg ms_riscv32_mp_tirq_in;
reg wr_en_in;
reg [11:0] csr_addr_in;
reg [2:0] csr_op_in;
reg [4:0] csr_uimm_in;
reg [31:0] csr_data_in;
reg [31:0] pc_in;
reg [31:0] iadder_in;
reg [63:0] ms_riscv32_mp_rc_in;

// Outputs
wire meie_out, mtie_out, msie_out;
wire meip_out, mtip_out, msip_out;
wire [31:0] csr_data_out;
wire mie_out;
wire [31:0] trap_address_out;
wire [31:0] epc_out;

msrv32_csr_file uut(
    .i_or_e_in(i_or_e_in),
    .cause_in(cause_in),
    .instret_inc_in(instret_inc_in),
    .mie_clear_in(mie_clear_in),
    .mie_set_in(mie_set_in),
    .set_epc_in(set_epc_in),
    .set_cause_in(set_cause_in),
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
    .csr_data_out(csr_data_out),
    .ms_riscv32_mp_rc_in(ms_riscv32_mp_rc_in),
    .mie_out(mie_out),
    .wr_en_in(wr_en_in),
    .csr_addr_in(csr_addr_in),
    .csr_op_in(csr_op_in),
    .csr_uimm_in(csr_uimm_in),
    .csr_data_in(csr_data_in),
    .pc_in(pc_in),
    .iadder_in(iadder_in),
    .trap_address_out(trap_address_out),
    .epc_out(epc_out)
);

// Clock generator
always #5 ms_riscv32_mp_clk_in = ~ms_riscv32_mp_clk_in;

// Test procedure
initial begin
    $display("Starting CSR file testbench...");
    // Initialize inputs
    ms_riscv32_mp_clk_in = 0;
    ms_riscv32_mp_rst_in = 1; // Assert reset
    wr_en_in = 0;
    csr_addr_in = 12'h300;
    csr_op_in = 3'b001;
    csr_uimm_in = 5'b00000;
    csr_data_in = 32'h0;
    i_or_e_in = 0;
    cause_in = 4'h0;
    instret_inc_in = 0;
    mie_clear_in = 0;
    mie_set_in = 0;
    set_epc_in = 0;
    set_cause_in = 0;
    ms_riscv32_mp_eirq_in = 0;
    ms_riscv32_mp_sirq_in = 0;
    ms_riscv32_mp_tirq_in = 0;
    pc_in = 32'h0;
    iadder_in = 32'h0;
    ms_riscv32_mp_rc_in = 64'h0;

    // Release reset
    #20 ms_riscv32_mp_rst_in = 0;

    // Write and read mstatus (300h), mie (304h), mtvec (305h)
    wr_en_in = 1;
    csr_addr_in = 12'h300;    // mstatus
    csr_data_in = 32'hdeadbeef;
    #10 wr_en_in = 0;
    csr_addr_in = 12'h300;    // mstatus
    #10 $display("mstatus read: %h", csr_data_out);

    wr_en_in = 1;
    csr_addr_in = 12'h304;    // mie
    csr_data_in = 32'hcafebabe;
    #10 wr_en_in = 0;
    csr_addr_in = 12'h304;    // mie
    #10 $display("mie read: %h", csr_data_out);

    wr_en_in = 1;
    csr_addr_in = 12'h305;    // mtvec
    csr_data_in = 32'h0000abcd;
    #10 wr_en_in = 0;
    csr_addr_in = 12'h305;    // mtvec
    #10 $display("mtvec read: %h", csr_data_out);

    // Simulate setting MEPC on exception
    set_epc_in = 1;
    pc_in = 32'h4444abcd;
    #10 set_epc_in = 0;
    csr_addr_in = 12'h341;    // mepc
    #10 $display("mepc read: %h", csr_data_out);

    // Simulate cause (exception/interrupt)
    set_cause_in = 1;
    i_or_e_in = 1;
    cause_in = 4'd11;         // e.g., external interrupt
    #10 set_cause_in = 0;
    csr_addr_in = 12'h342;    // mcause
    #10 $display("mcause read: %h", csr_data_out);

    // Test MIE bit clear/set
    mie_clear_in = 1;
    #10 mie_clear_in = 0;
    mie_set_in = 1;
    #10 mie_set_in = 0;
    #10 $display("MIE bit: %b", mie_out);

    // End simulation
    $display("CSR file testbench finished.");
    $stop;
end



endmodule
