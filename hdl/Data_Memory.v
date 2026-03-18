`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 12:06:31
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(input [31:0] DataAddr, DataIn,
                          input Clk, ResetBar, MemRead, MemWrite,
                          output [31:0] DataOut);
    reg [31:0] DATA_MEM [31:0];      
    integer i;               
    
    always @(posedge Clk or negedge ResetBar) begin
        if (!ResetBar) begin
            for (i = 0; i < 1024; i = i + 1) DATA_MEM[i] <= 32'b0;
        end
        else if (MemWrite) begin
            DATA_MEM[DataAddr[31:0]] <= DataIn;
        end
    end
    
    assign DataOut = (MemRead) ? DATA_MEM[DataAddr[31:0]] : 32'b0;     
endmodule
