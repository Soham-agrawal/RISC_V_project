`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2025 08:35:04 PM
// Design Name: 
// Module Name: msrv32_machine_control
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


module msrv32_machine_control(
    input ms_riscv32_mp_clk_in,
    input ms_riscv32_mp_rst_in,
    input ms_riscv32_mp_eirq_in,
    input ms_riscv32_mp_tirq_in,
    input ms_riscv32_mp_sirq_in,
    input illegal_instr_in,
    input misaligned_load_in,
    input misaligned_store_in,
    input misaligned_instr_in,
    input [4:0] opcode_6_to_2_in,
    input [2:0] funct3_in,
    input [6:0] funct7_in,
    input [4:0] rs1_addr_in,
    input [4:0] rs2_addr_in,
    input [4:0] rd_addr_in,
    input mie_in,
    output reg i_or_e_out,
    output reg [3:0] cause_out,
    output reg instret_inc_out,
    output reg mie_clear_out,
    output reg mie_set_out,
    output reg misaligned_exception_out,
    output reg set_epc_out,
    output reg set_cause_out,
    output reg flush_out,
    output reg trap_taken_out,
    input meie_in,
    input mtie_in,
    input msie_in,
    input meip_in,
    input mtip_in,
    input msip_in,
    output reg [1:0] pc_src_out
    );
    localparam CAUSE_INTERRUPT_EXTERNAL = 4'd11;
    localparam CAUSE_INTERRUPT_SOFTWARE = 4'd3;
    localparam CAUSE_INTERRUPT_TIMER = 4'd7;
    localparam CAUSE_ILLEGAL_INSTRUCTION = 4'd2;
    localparam CAUSE_MISALIGNED_INSTRUCTION = 4'd0;
    localparam CAUSE_MISALIGNED_STORE = 4'd6;
    localparam CAUSE_MISALIGNED_LOAD = 4'd4;  
    
    reg exception;
    reg interrupt;
    reg [3:0] cause;
    
    always @(*) begin
        exception = 1'b0;
        interrupt = 1'b0;
        cause = 4'd0;
        
        if(illegal_instr_in) begin
            exception = 1'b1;
            cause = CAUSE_ILLEGAL_INSTRUCTION;
        end
        else if(misaligned_load_in) begin
            exception = 1'b1;
            cause = CAUSE_MISALIGNED_LOAD;
        end
        else if(misaligned_store_in) begin
            exception = 1'b1;
            cause = CAUSE_MISALIGNED_STORE;
        end
        else if(misaligned_instr_in) begin
            exception = 1'b1;
            cause = CAUSE_MISALIGNED_INSTRUCTION;
        end
        
        if(mie_in) begin
            if(meie_in && meip_in) begin
                interrupt = 1'b1;
                cause = CAUSE_INTERRUPT_EXTERNAL;
            end
            if(mtie_in && mtip_in) begin
                interrupt = 1'b1;
                cause = CAUSE_INTERRUPT_TIMER;
            end
            if(msie_in && msip_in) begin
                interrupt = 1'b1;
                cause = CAUSE_INTERRUPT_SOFTWARE;
            end
        end
    end
    
    always @(posedge ms_riscv32_mp_clk_in or posedge ms_riscv32_mp_rst_in) begin
        if (ms_riscv32_mp_rst_in) begin
            i_or_e_out <= 1'b0;
            set_epc_out <= 1'b0;
            set_cause_out <= 1'b0;
            cause_out <= 4'b0000;
            instret_inc_out <= 1'b0;
            mie_clear_out <= 1'b0;
            mie_set_out <= 1'b0;
            misaligned_exception_out <= 1'b0;
            pc_src_out <= 2'b00;
            flush_out <= 1'b0;
            trap_taken_out <= 1'b0;
        end else begin
            // Update outputs based on exceptions and interrupts
            if (exception || interrupt) begin
                trap_taken_out <= 1'b1;
                i_or_e_out <= interrupt;
                set_epc_out <= 1'b1;
                set_cause_out <= 1'b1;
                cause_out <= cause;
                misaligned_exception_out <= misaligned_instr_in;
                pc_src_out <= 2'b10; // Assuming trap vector base address
                flush_out <= 1'b1;
            end else begin
                trap_taken_out <= 1'b0;
                set_epc_out <= 1'b0;
                set_cause_out <= 1'b0;
                cause_out <= 4'b0000;
                misaligned_exception_out <= 1'b0;
                pc_src_out <= 2'b00;
                flush_out <= 1'b0;
            end
            
            // Instruction retirement increment
            instret_inc_out <= ~trap_taken_out;

            // Manage MIE bit
            if (trap_taken_out) begin
                mie_clear_out <= 1'b1;
                mie_set_out <= 1'b0;
            end else begin
                mie_clear_out <= 1'b0;
                mie_set_out <= 1'b0;
            end
        end
            
    end
    
    
endmodule
