`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 12:01:20
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(input [31:0] InstrAddr,
                          output reg [31:0] InstrMemOut);
    reg [31:0] INSTR_MEM [31:0];            
             
    initial begin
        $readmemh("instructions.mem", INSTR_MEM);
    end
    
    always @(*) begin
        InstrMemOut <= INSTR_MEM[InstrAddr >> 2];
    end                          
                          
endmodule
