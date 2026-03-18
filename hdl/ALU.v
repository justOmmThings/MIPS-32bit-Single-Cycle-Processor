`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 11:55:25
// Design Name: 
// Module Name: ALU
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


module ALU(input [31:0] Data1, Data2,
           input [3:0] ALUop,
           output reg [31:0] DataOut,
           output Zero);
           
    always @(*) begin
        case (ALUop)
            4'b0000: DataOut = Data1 & Data2;
            4'b0001: DataOut = Data1 | Data2;
            4'b0010: DataOut = Data1 + Data2;
            4'b0110: DataOut = Data1 - Data2;
            4'b0111: DataOut = (Data1 < Data2) ? 1'b1 : 1'b0;
            4'b1100: DataOut = ~(Data1 | Data2);
            default: DataOut = 32'b0;
        endcase  
    end
    
    assign Zero = (DataOut == 0);          
           
endmodule
