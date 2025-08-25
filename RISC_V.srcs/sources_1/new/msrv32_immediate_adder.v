`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 10:06:16 PM
// Design Name: 
// Module Name: msrv32_immediate_adder
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


module msrv32_immediate_adder(
    input [31:0] pc_in,
    input [31:0] rs_1_in,
    input iadder_src_in,
    input [31:0] imm_in,
    output [31:0] iadder_out
    );
    reg [31:0] mux_out;
    always @(*) begin
        case(iadder_src_in)
            1'b0: mux_out= pc_in;
            1'b1: mux_out= rs_1_in;
            default: mux_out=32'd0;
        endcase
     end
    assign iadder_out= mux_out + imm_in ;
endmodule
