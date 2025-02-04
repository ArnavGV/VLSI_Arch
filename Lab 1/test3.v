`timescale 1ns / 1ps

module BitwiseOp_tb;

    // Declare testbench variables
    reg [3:0] in1, in2;       // Inputs to the module
    wire [3:0] res1, res2, res3, res4, res5; // Outputs from the module

    // Instantiate the BitwiseOp module
    BitwiseOp uut (
        .in1(in1),
        .in2(in2),
        .res1(res1),
        .res2(res2),
        .res3(res3),
        .res4(res4),
        .res5(res5)
    );

    // Testbench logic
    initial begin
        // Monitor signals
        $monitor("Time: %0t | in1: %b, in2: %b | res1 (~in1): %b, res2 (in1 & in2): %b, res3 (in1 | in2): %b, res4 (in1 ^ in2): %b, res5 (in1 ^~ in2): %b",
                 $time, in1, in2, res1, res2, res3, res4, res5);

        // Apply test cases with a delay of 4 time units between them
        in1 = 4'b0000; in2 = 4'b0000; #4; // Test 1: Both inputs are zero
        in1 = 4'b1111; in2 = 4'b0000; #4; // Test 2: in1 is all ones, in2 is all zeros
        in1 = 4'b1010; in2 = 4'b0101; #4; // Test 3: Alternating bits
        in1 = 4'b1111; in2 = 4'b1111; #4; // Test 4: Both inputs are all ones
        in1 = 4'b1001; in2 = 4'b1100; #4; // Test 5: Random binary inputs
        in1 = 4'b0011; in2 = 4'b0110; #4; // Test 6: Other random binary inputs

        // End simulation
        $stop;
    end

endmodule
