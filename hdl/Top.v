`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2026 12:09:11
// Design Name: 
// Module Name: Top
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


module Top(input Clk, ResetBar);
    wire [31:0] PC_In, PC_Out;
    wire [31:0] Instr;
    wire [31:0] ReadData1, ReadData2, WriteData;
    wire [31:0] ExtImm, ALU_In2, ALU_Result;
    wire [31:0] MemReadData;
    wire [31:0] PC_Plus4, BranchAddr;
    wire [4:0]  WriteReg;
    wire [3:0]  ALU_Op;
    wire [1:0]  ALU_Control_In;
    wire        Zero, PCSrc;
    
    wire RegDest, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch; // Control Signal
    
    // Instruction Fetch (IF)
    Program_Counter pc_unit (Clk, ResetBar, PC_In, PC_Out);
    Instruction_Memory imem (PC_Out, Instr);
    assign PC_Plus4 = PC_Out + 4;
    
    // Instruction Decode (ID)
    
    Control main_control (Instr[31:26], ALU_Control_In, ALUSrc, MemToReg, RegDest, RegWrite,  MemWrite, MemRead, Branch);
    Mux #(5) reg_dest_mux (Instr[20:16], Instr[15:11], RegDest, WriteReg);
    Register_File rf (Clk, ResetBar, RegWrite, Instr[25:21], Instr[20:16], WriteReg, WriteData, ReadData1, ReadData2);
    Sign_Extender se (Instr[15:0], ExtImm);
    
    // Execution (EX)

    Mux #(32) alu_src_mux (ReadData2, ExtImm, ALUSrc, ALU_In2);
    ALU_Control alu_control (ALU_Control_In, Instr[5:0], ALU_Op);
    ALU main_alu (ReadData1, ALU_In2, ALU_Op, ALU_Result, Zero);
    
    // Branch Logic
    
    assign PCSrc = Zero & Branch;
    assign BranchAddr = PC_Plus4 + (ExtImm << 2);
    Mux #(32) pc_mux (PC_Plus4, BranchAddr, PCSrc, PC_In);
    
    // Memory and Write Backs (MEM & WB)
    
    Data_Memory dmem (ALU_Result, ReadData2, Clk, ResetBar, MemRead, MemWrite, MemReadData);
    Mux #(32) mem_to_reg_mux (ALU_Result, MemReadData, MemToReg, WriteData);

endmodule
