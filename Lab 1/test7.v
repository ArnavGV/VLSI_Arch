`timescale 1ns / 1ps

module ConcatRepCondOp_tb;

    // Declare testbench variables
    reg [3:0] in1, in2;   // 4-bit inputs
    reg sel;               // Selector for conditional operator
    wire [7:0] concat_res; // Concatenation result
    wire [7:0] rep_res;    // Replication result
    wire cond_res;         // Conditional result

    // Instantiate the ConcatRepCondOp module
    ConcatRepCondOp uut (
        .in1(in1),
        .in2(in2),
        .sel(sel),
        .concat_res(concat_res),
        .rep_res(rep_res),
        .cond_res(cond_res)
    );

    // Testbench logic
    initial begin
        // Monitor the results of the operations
        $monitor("Time: %0t | in1: %b, in2: %b, sel: %b | concat_res: %b, rep_res: %b, cond_res: %b",
                 $time, in1, in2, sel, concat_res, rep_res, cond_res);

        // Test cases with a delay of 4 time units between them
        in1 = 4'b1101; in2 = 4'b1010; sel = 1; #4; // Test 1: Conditional with sel = 1
        in1 = 4'b0110; in2 = 4'b1001; sel = 0; #4; // Test 2: Conditional with sel = 0
        in1 = 4'b0101; in2 = 4'b1100; sel = 1; #4; // Test 3: Conditional with sel = 1
        in1 = 4'b0001; in2 = 4'b1110; sel = 0; #4; // Test 4: Conditional with sel = 0

        in1 = 4'b0011; in2 = 4'b1100; #4; // Test 5: Concatenation (in1 and in2)
        in1 = 4'b1010; in2 = 4'b0101; #4; // Test 6: Concatenation (in1 and in2)
        
        in1 = 4'b1111; in2 = 4'b0000; #4; // Test 7: Replication (in1 repeated 4 times)
        in1 = 4'b0010; in2 = 4'b1011; #4; // Test 8: Replication (in1 repeated 4 times)

        // End simulation
        $stop;
    end

endmodule
