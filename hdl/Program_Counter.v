`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 11:53:15
// Design Name: 
// Module Name: Program_Counter
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


module Program_Counter(input Clk, ResetBar,
                       input [31:0] PCIn,
                       output reg [31:0] PCOut);
                       
    always @(posedge Clk or negedge ResetBar) begin
        if (!ResetBar) PCOut <= 0;
        else PCOut <= PCIn;
    end                       
                       
endmodule
