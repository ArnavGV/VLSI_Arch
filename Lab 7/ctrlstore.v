//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 01:37:10 PM
// Design Name: 
// Module Name: ctrlstore
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


//Min Control Store RTL
/* Provides the control word stored at the rom address as a registered output 
at every positive edge of the clock. The control word register is cleared using an initial statement.
Later on a reset input can be used for the purpose of clearing the control word register */
module controlstore (address, clock, controlword);
    input [4:0] address;
    input clock;
    output [24:0] controlword;
    reg [24:0] controlword;
    reg [24:0] rom [0:31];
    //define the ROM data (control word) stored at each address (address <-> state ID)
    //format of control word:
    //asrccntl_adestcntl_bsrccntl_bdestcntl_alucntl_memcntl_irecntl_nssel_dbin
    initial begin
        rom [0] = 25  'b011_00_000_000_001_010_0_00_10111;		//start0
        // a <- pc; t1 <- pc+1; a -> ao, edb ->irf
        rom [1] = 25  'b011_00_000_000_001_001_0_00_00010;    	//abdm1
        // edb -> di; pc -> a ; +1 -> alu 
        rom [2] = 25  'b101_11_000_000_000_000_0_00_00011;		//abdm2
        // a -> pc; t1 -> a
        rom [3] = 25  'b010_00_111_000_010_000_0_00_00100;		//abdm3
        // a -> alu, b -> alu, add-n; di -> b; ry -> a
        rom [4] = 25  'b101_01_000_000_000_001_0_10_00000;		//abdm4
        // a -> ao, edb -> di; a -> t2; t1 -> a
        rom [5] = 25  'b000_00_010_100_000_101_0_10_00000;		//adrm1
        //  b -> ao, edb -> di; b -> t2; ry -> b
        rom [6] = 25  'b011_00_000_000_001_010_0_00_00111;		//brzz3
        // a -> ao, edb ->irf; +1 -> alu; pc -> a
        rom [7] = 25  'b000_00_101_011_000_000_1_01_00000;		//brzz2
        // b -> pc; t1 -> b
        rom [8] = 25  'b110_00_101_011_100_000_1_01_00000;		//ldrm2
        // a -> alu, 0 -> alu; b -> pc; t1 -> b; t2 -> a
        rom [9] = 25  'b010_00_000_000_001_010_0_11_00110;		//brzz1
        // a -> ao, edb ->irf; +1 -> alu; ry -> a
        rom [10] = 25 'b011_00_111_101_001_010_0_00_01000;	//ldrm1 /////
        // a -> ao, edb ->irf; +1 -> alu; b -> rx,t2; di -> b; pc -> a
        rom [11] = 25 'b001_00_110_000_100_111_0_00_00110;	//strm1
        // b -> ao, a -> do; a -> alu, 0 -> alu; t2 -> b; rx -> a
        rom [12] = 25 'b001_00_111_000_110_000_0_00_01101;	//oprm1
        // a -> alu, b -> alu, op-s; di -> b; rx -> a
        rom [13] = 25 'b101_00_110_000_000_111_0_00_00110;	//oprm2
        // b -> ao, a -> do; t2 -> b; t1 -> a
        rom [14] = 25 'b011_00_111_100_001_010_0_00_01000;	//test1
        // a -> ao, edb ->irf; +1 -> alu; b -> t2; di -> b; pc -> a
        rom [15] = 25 'b011_00_010_101_001_010_0_00_01000;	//ldrr1
        // a -> ao, edb ->irf; +1 -> alu; b -> rx,t2; ry -> b; pc -> a
        rom [16] = 25 'b011_00_001_110_001_010_0_00_01000;	//strr1
        // a -> ao, edb ->irf; +1 -> alu; b -> ry,t2; rx -> b; pc -> a
        rom [17] = 25 'b001_00_010_000_110_000_0_00_10010;	//oprr1
        // a -> alu, b -> alu, op-s; ry -> b; rx -> a
        rom [18] = 25 'b011_00_101_010_001_010_0_00_00111;	//oprr2
        // a -> ao, edb ->irf; +1 -> alu; b -> ry; t1 -> b; pc -> a
        rom [19] = 25 'b010_00_000_000_001_001_0_00_10100;	//popr1
        // a -> ao, edb -> di; +1 -> alu; ry -> a
        rom [20] = 25 'b101_10_111_001_000_000_0_00_00110;	//popr2
        // b -> rx; di -> b; a -> ry; t1 -> a
        rom [21] = 25 'b010_00_000_000_011_000_0_00_10110;	//push1
        // a -> alu, -1 -> alu, add-n; ry -> a
        rom [22] = 25 'b001_00_101_010_000_111_0_00_00110;	//push2
        // b -> ao, a -> do; b -> ry; t1 -> b; rx -> a
        rom [23] = 25 'b101_11_000_000_000_000_1_01_00000;	//start1
        // a -> pc; t1 -> a
        rom [24] = 25 'b010_00_101_001_001_001_0_00_11011; //aadd1
        //
        rom [25] = 25 'b010_00_000_000_011_000_0_00_11110; //aadd5
        //
        rom [26] = 25 'b001_00_001_000_010_000_0_00_11000; //aadd0
        //
        rom [27] = 25 'b101_10_111_100_000_000_0_00_11100; //aadd2
        //
        rom [28] = 25 'b110_00_000_000_100_000_0_00_11101; //aadd3
        //
        rom [29] = 25 'b001_00_110_000_010_000_0_11_11001; //aadd4
        //
        rom [30] = 25 'b011_00_101_010_001_010_0_00_11111; //aadd6
        //
        rom [31] = 25 'b000_00_101_011_000_000_1_01_00000; //aadd7
        //
        
        //contents at remaining ROM addresses are not used and are left undefined
    end
    initial begin
        //initialize the value of control word register
        controlword = 25 'b000_00_000_000_000_000_0_00_00000;
        $display("%b", controlword);
    end
    always @(posedge clock)
        controlword <=  rom [address];
endmodule
