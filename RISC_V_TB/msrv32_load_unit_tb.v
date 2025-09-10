`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 05:12:06 PM
// Design Name: 
// Module Name: msrv32_load_unit_tb
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


module msrv32_load_unit_tb();
reg ahb_resp_in;
reg [31:0] ms_riscv32_mp_dmdata_in;
reg [1:0] iadder_out_1_to_0_in;
reg load_unsigned_in;
reg [1:0] load_size_in;
wire [31:0] lu_output_out;

msrv32_load_unit uut (
    .ahb_resp_in(ahb_resp_in),
    .ms_riscv32_mp_dmdata_in(ms_riscv32_mp_dmdata_in),
    .iadder_out_1_to_0_in(iadder_out_1_to_0_in),
    .load_unsigned_in(load_unsigned_in),
    .load_size_in(load_size_in),
    .lu_output_out(lu_output_out)
);

initial begin
    ahb_resp_in = 0;
    ms_riscv32_mp_dmdata_in = 0;
    iadder_out_1_to_0_in = 0;
    load_unsigned_in = 0;
    load_size_in = 0;
    #100;

    ms_riscv32_mp_dmdata_in = 32'h12345678;
    iadder_out_1_to_0_in = 2'b00;
    load_unsigned_in = 0;
    load_size_in = 2'b00;
    #10;

    iadder_out_1_to_0_in = 2'b01;
    load_unsigned_in = 1;
    #10;

    iadder_out_1_to_0_in = 2'b10;
    load_unsigned_in = 0;
    #10;

    iadder_out_1_to_0_in = 2'b11;
    load_unsigned_in = 1;
    #10;

    iadder_out_1_to_0_in = 2'b00;
    load_unsigned_in = 0;
    load_size_in = 2'b01;
    #10;

    iadder_out_1_to_0_in = 2'b10;
    load_unsigned_in = 1;
    #10;

    iadder_out_1_to_0_in = 2'b00;
    load_size_in = 2'b10;
    #10;

    ahb_resp_in = 1;
    #10;

    ahb_resp_in = 0;
    #10;

    iadder_out_1_to_0_in = 2'b10;
    load_unsigned_in = 0;
    load_size_in = 2'b01;
    #10;

    $stop;
end
endmodule
