`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 05:24:27 PM
// Design Name: 
// Module Name: msrv32_wb_mux_sel_unit_tb
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


module msrv32_wb_mux_sel_unit_tb();
reg alu_src_reg_in;
    reg [2:0] wb_mux_sel_reg_in;
    reg [31:0] alu_result_in;
    reg [31:0] lu_output_in;
    reg [31:0] imm_reg_in;
    reg [31:0] iadder_out_reg_in;
    reg [31:0] csr_data_in;
    reg [31:0] pc_plus_4_reg_in;
    reg [31:0] rs2_reg_in;
    
    // Outputs
    wire [31:0] wb_mux_out;
    wire [31:0] alu_2nd_src_mux_out;

    // Instantiate the unit under test
    msrv32_wb_mux_sel_unit dut (
        .alu_src_reg_in(alu_src_reg_in),
        .wb_mux_sel_reg_in(wb_mux_sel_reg_in),
        .alu_result_in(alu_result_in),
        .lu_output_in(lu_output_in),
        .imm_reg_in(imm_reg_in),
        .iadder_out_reg_in(iadder_out_reg_in),
        .csr_data_in(csr_data_in),
        .pc_plus_4_reg_in(pc_plus_4_reg_in),
        .rs2_reg_in(rs2_reg_in),
        .wb_mux_out(wb_mux_out),
        .alu_2nd_src_mux_out(alu_2nd_src_mux_out)
    );

    // Initial stimulus
    initial begin
        // Test Case 1
        alu_src_reg_in = 1'b0;
        wb_mux_sel_reg_in = 3'b000;
        alu_result_in = 32'h12345678;
        lu_output_in = 32'hABCDEFAB;
        imm_reg_in = 32'h0000FFFF;
        iadder_out_reg_in = 32'h87654321;
        csr_data_in = 32'h98765432;
        pc_plus_4_reg_in = 32'hABCDDCBA;
        rs2_reg_in = 32'h11223344;
        #10;

        // Test Case 2
        alu_src_reg_in = 1'b1;
        wb_mux_sel_reg_in = 3'b001;
        #10;

        // Test Case 3
        alu_src_reg_in = 1'b0;
        wb_mux_sel_reg_in = 3'b010;
        #10;

        // Test Case 4
        alu_src_reg_in = 1'b1;
        wb_mux_sel_reg_in = 3'b011;
        #10;

        // Test Case 5
        alu_src_reg_in = 1'b0;
        wb_mux_sel_reg_in = 3'b100;
        #10;

        // Test Case 6
        alu_src_reg_in = 1'b1;
        wb_mux_sel_reg_in = 3'b101;
        #10;

        // Test Case 7
        alu_src_reg_in = 1'b0;
        wb_mux_sel_reg_in = 3'b110;
        #10;

        $finish;
    end
endmodule
