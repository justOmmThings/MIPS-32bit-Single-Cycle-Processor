    `timescale 1ns / 1ps
    //////////////////////////////////////////////////////////////////////////////////
    // Company: 
    // Engineer: 
    // 
    // Create Date: 06.03.2026 12:20:58
    // Design Name: 
    // Module Name: Register_File
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
    
    
    module Register_File(input Clk, ResetBar, RegWrite,
                         input [4:0] ReadReg1, ReadReg2, WriteReg,
                         input [31:0] DataIn,
                         output [31:0] ReadRegData1, ReadRegData2);
        
        reg [31:0] REG_FILE_MEM [31:0];  
        integer i;
                       
        always @(posedge Clk or negedge ResetBar) begin
            if (!ResetBar) begin
                for (i = 0; i < 32; i = i + 1) begin
                    REG_FILE_MEM[i] <= 32'b0;
                end
            end
            else begin
                if (RegWrite && (WriteReg != 5'b0)) REG_FILE_MEM[WriteReg] <= DataIn;
            end
        end
        
        assign ReadRegData1 = REG_FILE_MEM[ReadReg1];
        assign ReadRegData2 = REG_FILE_MEM[ReadReg2];                         
    endmodule
