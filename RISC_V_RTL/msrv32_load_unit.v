`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 05:09:27 PM
// Design Name: 
// Module Name: msrv32_load_unit
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


module msrv32_load_unit(
    input ahb_resp_in,
    input [31:0] ms_riscv32_mp_dmdata_in,
    input [1:0] iadder_out_1_to_0_in,
    input load_unsigned_in,
    input [1:0] load_size_in,
    output [31:0] lu_output_out
    );
    wire [15:0] data_half_load_unit;
wire [23:0] byte_ext_load_unit;
wire [15:0] half_ext_load_unit;
wire [31:0] load_size_load_unit;
reg [7:0] load_data_byte;
assign  data_half_load_unit = (iadder_out_1_to_0_in[1])? ms_riscv32_mp_dmdata_in[31:16] : ms_riscv32_mp_dmdata_in[15:0];

always @(*)
    begin
        case(iadder_out_1_to_0_in)
            2'b00 : load_data_byte<=ms_riscv32_mp_dmdata_in[7:0];
            2'b01 : load_data_byte<=ms_riscv32_mp_dmdata_in[15:8];
            2'b10 : load_data_byte<=ms_riscv32_mp_dmdata_in[23:16];
            2'b11 : load_data_byte<=ms_riscv32_mp_dmdata_in[31:24];
        endcase
    end
assign byte_ext_load_unit =(load_unsigned_in) ? 24'b0 : {24{load_data_byte[7]}};  
assign half_ext_load_unit =(load_unsigned_in) ? 16'b0 : {16{load_data_byte[15]}}; 
assign load_size_load_unit =(load_size_in==2'b00) ? {byte_ext_load_unit,load_data_byte} :
(load_size_in==2'b00)? {half_ext_load_unit, data_half_load_unit}: (load_size_in==2'b10)? ms_riscv32_mp_dmdata_in :  ms_riscv32_mp_dmdata_in;
assign lu_output_out = (ahb_resp_in) ? 32'bz: load_size_load_unit;
               
endmodule
