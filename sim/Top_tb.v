`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2026 22:33:44
// Design Name: 
// Module Name: Top_tb
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


`timescale 1ns / 1ps

module Top_tb();

    // --- Inputs to the Top Module ---
    reg Clk;
    reg ResetBar;

    // --- Instantiate the Unit Under Test (UUT) ---
    Top uut (
        .Clk(Clk), 
        .ResetBar(ResetBar)
    );

    // --- Clock Generation (100MHz / 10ns period) ---
    always begin
        #5 Clk = ~Clk;
    end

    // --- Main Simulation Block ---
    initial begin
        // 1. Initialize Inputs
        Clk = 0;
        ResetBar = 0; // Start in Reset

        // 2. Wait for global reset and then release
        #25;
        ResetBar = 1; 
        
        $display("--- Starting MIPS Simulation ---");
        $display("Time | PC | Instruction | ALU Result");

        // 3. Monitor signals in the console
        // Note: 'uut.pc_unit.PCOut' assumes your PC module instance is named 'pc_unit'
        forever begin
            @(posedge Clk);
            #1; // Wait for logic to settle
            $display("%t | %h | %h | %h", $time, uut.PC_Out, uut.Instr, uut.ALU_Result);
            
            // Optional: Stop simulation after a certain PC is reached or time elapsed
            if (uut.PC_Out > 32'h00000014) begin
                #20;
                $display("--- Simulation Finished ---");
                $display("Checking Data Memory at Address 4 (Index 1): %h", uut.dmem.DATA_MEM[1]);
                $finish;
            end
        end
    end

endmodule
