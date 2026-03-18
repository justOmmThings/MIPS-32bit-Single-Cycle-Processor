`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2026 22:14:23
// Design Name: 
// Module Name: Control
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


module Control(
    input      [5:0] OpCode,
    output reg [1:0] ALUop,
    output reg       ALUSrc, 
    output reg       MemToReg, 
    output reg       RegDest, 
    output reg       RegWrite, 
    output reg       MemWrite, 
    output reg       MemRead, 
    output reg       Branch
);

    always @(*) begin
        // Default values to prevent latches
        RegDest   = 0;
        ALUSrc    = 0;
        MemToReg  = 0;
        RegWrite  = 0;
        MemRead   = 0;
        MemWrite  = 0;
        Branch    = 0;
        ALUop     = 2'b00;

        case (OpCode)
            6'b000000: begin // R-type
                RegDest  = 1;
                RegWrite = 1;
                ALUop    = 2'b10;
            end
            
            6'b100011: begin // LW (Load Word)
                ALUSrc   = 1;
                MemToReg = 1;
                RegWrite = 1;
                MemRead  = 1;
                ALUop    = 2'b00;
            end
            
            6'b101011: begin // SW (Store Word)
                ALUSrc   = 1;
                MemWrite = 1;
                ALUop    = 2'b00;
            end
            
            6'b001000: begin // addi (Add Immediate)
                ALUSrc   = 1;
                RegWrite = 1;
                MemToReg = 0;
                ALUop    = 2'b00;
            end
            
            6'b000100: begin // BEQ (Branch Equal)
                Branch   = 1;
                ALUop    = 2'b01;
            end

            default: begin
                // Handle unsupported instructions if necessary
            end
        endcase
    end

endmodule