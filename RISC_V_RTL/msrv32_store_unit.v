`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2025 09:29:28 PM
// Design Name: 
// Module Name: msrv32_store_unit
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


module msrv32_store_unit(
    input [1:0] funct3_in,
    input [31:0] iadder_in,
    input [31:0] rs2_in,
    input mem_wr_req_in,
    input ahb_ready_in,
    output [31:0] ms_riscv32_mp_dmdata_out,
    output [31:0] ms_riscv32_mp_dmaddr_out,
    output reg [3:0] ms_riscv32_mp_dmwr_mask_out,
    output ms_riscv32_mp_dmwr_req_out,
    output [1:0] ahb_htrans_out
    );
    reg [3:0] byt_wr_mask;
    wire [31:0] half_data_out;
reg [31:0] byt_data_out;
reg [31:0] data_out;
wire [3:0] half_wr_mask;
assign ahb_htrans_out = (ahb_ready_in)? 2'b01 :2'b00;
assign half_wr_mask = (iadder_in[1])?  {{2{mem_wr_req_in}},2'b0} : {2'b0,{2{mem_wr_req_in}}};
assign half_data_out = (iadder_in[1])? {rs2_in[15:0], {16{1'b0}}} : {{16{1'b0}},rs2_in[15:0]};
always @(*)
begin
    case(iadder_in[1:0])
        2'b00 : begin
                byt_wr_mask <= {3'b0,mem_wr_req_in};
                byt_data_out <= {{24{1'b0}}, rs2_in[7:0]};
            end
        2'b01 : begin
                byt_wr_mask <= {2'b0,mem_wr_req_in,1'b0};
                byt_data_out <= {{16{1'b0}}, rs2_in[7:0],{8{1'b0}}};
            end
        2'b10 : begin
                byt_wr_mask <= {1'b0,mem_wr_req_in,2'b0};
                byt_data_out <= {{8{1'b0}}, rs2_in[7:0],{16{1'b0}}};
            end
        2'b11 : begin
                byt_wr_mask <= {mem_wr_req_in,3'b00};
                byt_data_out <= {rs2_in[7:0],{24{1'b0}}};
            end
    endcase
    case(funct3_in[1:0])
        2'b00 : begin
                ms_riscv32_mp_dmwr_mask_out <= byt_wr_mask ;
                data_out <= byt_data_out;
            end
        2'b01 : begin
            ms_riscv32_mp_dmwr_mask_out <= half_wr_mask;
            data_out <= half_data_out;
        end
        2'b10 : begin
            ms_riscv32_mp_dmwr_mask_out <= {4{mem_wr_req_in}};
            data_out <= rs2_in;
        end
        2'b11 : begin
            ms_riscv32_mp_dmwr_mask_out <= {4{mem_wr_req_in}};
            data_out <= rs2_in;
        end
    endcase
end
assign ms_riscv32_mp_dmdata_out =(ahb_ready_in)? data_out: ms_riscv32_mp_dmdata_out;
assign ms_riscv32_mp_dmaddr_out = {iadder_in[31:2],2'b00};
assign ms_riscv32_mp_dmwr_req_out = mem_wr_req_in;

endmodule
