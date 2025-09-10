`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2025 08:37:49 PM
// Design Name: 
// Module Name: msrv32_machine_control_tb
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


`timescale 1ns/1ps

module msrv32_machine_control_tb();

    // Inputs
    reg clk;
    reg rst;
    reg eirq, tirq, sirq;
    reg illegal_instr;
    reg misaligned_load;
    reg misaligned_store;
    reg misaligned_instr;
    reg [4:0] opcode_6_to_2;
    reg [2:0] funct3;
    reg [6:0] funct7;
    reg [4:0] rs1_addr, rs2_addr, rd_addr;
    reg mie;
    reg meie, mtie, msie;
    reg meip, mtip, msip;

    // Outputs
    wire i_or_e_out;
    wire [3:0] cause_out;
    wire instret_inc_out;
    wire mie_clear_out;
    wire mie_set_out;
    wire misaligned_exception_out;
    wire set_epc_out;
    wire set_cause_out;
    wire flush_out;
    wire trap_taken_out;
    wire [1:0] pc_src_out;

    // DUT instantiation
    msrv32_machine_control dut (
    .ms_riscv32_mp_clk_in(clk),
    .ms_riscv32_mp_rst_in(rst),
    .ms_riscv32_mp_eirq_in(eirq),
    .ms_riscv32_mp_tirq_in(tirq),
    .ms_riscv32_mp_sirq_in(sirq),
    .illegal_instr_in(illegal_instr),
    .misaligned_load_in(misaligned_load),
    .misaligned_store_in(misaligned_store),
    .misaligned_instr_in(misaligned_instr),
    .opcode_6_to_2_in(opcode_6_to_2),
    .funct3_in(funct3),
    .funct7_in(funct7),
    .rs1_addr_in(rs1_addr),
    .rs2_addr_in(rs2_addr),
    .rd_addr_in(rd_addr),
    .mie_in(mie),
    .i_or_e_out(i_or_e_out),
    .cause_out(cause_out),
    .instret_inc_out(instret_inc_out),
    .mie_clear_out(mie_clear_out),
    .mie_set_out(mie_set_out),
    .misaligned_exception_out(misaligned_exception_out),
    .set_epc_out(set_epc_out),
    .set_cause_out(set_cause_out),
    .flush_out(flush_out),
    .trap_taken_out(trap_taken_out),
    .meie_in(meie),
    .mtie_in(mtie),
    .msie_in(msie),
    .meip_in(meip),
    .mtip_in(mtip),
    .msip_in(msip),
    .pc_src_out(pc_src_out)
);


    // Clock generation
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $dumpfile("msrv32_machine_control_tb.vcd");
        $dumpvars(0, msrv32_machine_control_tb);

        // Initialize inputs
        clk = 0;
        rst = 1;
        eirq = 0; tirq = 0; sirq = 0;
        illegal_instr = 0;
        misaligned_load = 0;
        misaligned_store = 0;
        misaligned_instr = 0;
        opcode_6_to_2 = 0;
        funct3 = 0;
        funct7 = 0;
        rs1_addr = 0;
        rs2_addr = 0;
        rd_addr = 0;
        mie = 0;
        meie = 0; mtie = 0; msie = 0;
        meip = 0; mtip = 0; msip = 0;

        // Reset
        #12 rst = 0;

        // Case 1: Normal execution (no trap)
        #10;

        // Case 2: Illegal instruction exception
        illegal_instr = 1; #10;
        illegal_instr = 0; #10;

        // Case 3: Misaligned load exception
        misaligned_load = 1; #10;
        misaligned_load = 0; #10;

        // Case 4: Misaligned store exception
        misaligned_store = 1; #10;
        misaligned_store = 0; #10;

        // Case 5: Misaligned instruction exception
        misaligned_instr = 1; #10;
        misaligned_instr = 0; #10;

        // Case 6: External interrupt
        mie = 1; meie = 1; meip = 1; #10;
        meip = 0; #10;

        // Case 7: Timer interrupt
        mtie = 1; mtip = 1; #10;
        mtip = 0; #10;

        // Case 8: Software interrupt
        msie = 1; msip = 1; #10;
        msip = 0; #10;

        // Case 9: Return to normal (instruction retirement increments)
        mie = 0; meie = 0; mtie = 0; msie = 0;
        #20;

        $finish;
    end

endmodule

