`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2025 09:56:15 PM
// Design Name: 
// Module Name: msrv32_csr_file
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


module msrv32_csr_file(
    input i_or_e_in,
    input [3:0] cause_in,
    input instret_inc_in,
    input mie_clear_in,
    input mie_set_in,
    input set_epc_in,
    input set_cause_in,
    input ms_riscv32_mp_clk_in,
    input ms_riscv32_mp_rst_in,
    output reg meie_out,
    output reg mtie_out,
    output reg msie_out,
    output reg meip_out,
    output reg mtip_out,
    output reg msip_out,
    input ms_riscv32_mp_eirq_in,
    input ms_riscv32_mp_sirq_in,
    input ms_riscv32_mp_tirq_in,
    output reg [31:0] csr_data_out,
    input [63:0] ms_riscv32_mp_rc_in,
    output reg mie_out,
    input wr_en_in,
    input [11:0] csr_addr_in,
    input [2:0] csr_op_in,
    input [4:0] csr_uimm_in,
    input [31:0] csr_data_in,
    input [31:0] pc_in,
    input [31:0] iadder_in,
    output reg [31:0] trap_address_out,
    output reg [31:0] epc_out
    );
     // CSR registers
    reg [31:0] mstatus;
    reg [31:0] mie;
    reg [31:0] mtvec;
    reg [31:0] mscratch;
    reg [31:0] mepc;
    reg [31:0] mcause;
    reg [31:0] mtval;
    reg [31:0] mip;
    reg [63:0] minstret;
    reg [63:0] mcycle;

    // CSR address mapping
    localparam ADDR_MSTATUS  = 12'h300;
    localparam ADDR_MIE      = 12'h304;
    localparam ADDR_MTVEC    = 12'h305;
    localparam ADDR_MSCRATCH = 12'h340;
    localparam ADDR_MEPC     = 12'h341;
    localparam ADDR_MCAUSE   = 12'h342;
    localparam ADDR_MTVAL    = 12'h343;
    localparam ADDR_MIP      = 12'h344;
    localparam ADDR_MINSTRET = 12'hB02;
    localparam ADDR_MCYCLE   = 12'hB00;

    // Interrupt Enable bits
    localparam MIE_BIT = 3;
    localparam MEIE_BIT = 11;
    localparam MTIE_BIT = 7;
    localparam MSIE_BIT = 3;

    // Interrupt Pending bits
    localparam MEIP_BIT = 11;
    localparam MTIP_BIT = 7;
    localparam MSIP_BIT = 3;

    // CSR operations
    localparam CSR_RW  = 3'b001;
    localparam CSR_RS  = 3'b010;
    localparam CSR_RC  = 3'b011;
    localparam CSR_RWI = 3'b101;
    localparam CSR_RSI = 3'b110;
    localparam CSR_RCI = 3'b111;

    // Reset all registers
    always @(posedge ms_riscv32_mp_clk_in or posedge ms_riscv32_mp_rst_in) begin
        if (ms_riscv32_mp_rst_in) begin
            mstatus  <= 32'b0;
            mie      <= 32'b0;
            mtvec    <= 32'b0;
            mscratch <= 32'b0;
            mepc     <= 32'b0;
            mcause   <= 32'b0;
            mtval    <= 32'b0;
            mip      <= 32'b0;
            minstret <= 64'b0;
            mcycle   <= 64'b0;
        end else begin
            // Update mcycle and minstret
            mcycle <= mcycle + 1;
            if (instret_inc_in) begin
                minstret <= minstret + 1;
            end

            // Handle CSR write operations
            if (wr_en_in) begin
                case (csr_addr_in)
                    ADDR_MSTATUS:  mstatus  <= csr_data_in;
                    ADDR_MIE:      mie      <= csr_data_in;
                    ADDR_MTVEC:    mtvec    <= csr_data_in;
                    ADDR_MSCRATCH: mscratch <= csr_data_in;
                    ADDR_MEPC:     mepc     <= csr_data_in;
                    ADDR_MCAUSE:   mcause   <= csr_data_in;
                    ADDR_MTVAL:    mtval    <= csr_data_in;
                    ADDR_MIP:      mip      <= csr_data_in;
                    ADDR_MINSTRET: minstret <= csr_data_in;
                    ADDR_MCYCLE:   mcycle   <= csr_data_in;
                endcase
            end

            // Update MIE
            if (mie_clear_in) begin
                mie[MIE_BIT] <= 0;
            end
            if (mie_set_in) begin
                mie[MIE_BIT] <= 1;
            end

            // Update MEPC and MCAUSE on exception or interrupt
            if (set_epc_in) begin
                mepc <= pc_in;
            end
            if (set_cause_in) begin
                mcause <= {i_or_e_in, cause_in};
            end
        end
    end

    // CSR read operations
    always @(*) begin
        case (csr_addr_in)
            ADDR_MSTATUS:  csr_data_out = mstatus;
            ADDR_MIE:      csr_data_out = mie;
            ADDR_MTVEC:    csr_data_out = mtvec;
            ADDR_MSCRATCH: csr_data_out = mscratch;
            ADDR_MEPC:     csr_data_out = mepc;
            ADDR_MCAUSE:   csr_data_out = mcause;
            ADDR_MTVAL:    csr_data_out = mtval;
            ADDR_MIP:      csr_data_out = mip;
            ADDR_MINSTRET: csr_data_out = minstret[31:0];
            ADDR_MCYCLE:   csr_data_out = mcycle[31:0];
            default:       csr_data_out = 32'b0;
        endcase
    end

    // Output signals
    always @(*) begin
        mie_out          = mie[MIE_BIT];
        epc_out          = mepc;
        trap_address_out = mtvec;
        meie_out         = mie[MEIE_BIT];
        mtie_out         = mie[MTIE_BIT];
        msie_out         = mie[MSIE_BIT];
        meip_out         = mip[MEIP_BIT];
        mtip_out         = mip[MTIP_BIT];
        msip_out         = mip[MSIP_BIT];
    end
    
endmodule
