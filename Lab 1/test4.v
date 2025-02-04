`timescale 1ns / 1ps

module RedOp_tb;

    // Declare testbench variables
    reg [3:0] in1;          // Input to the module
    wire [3:0] res1, res2, res3, res4, res5, res6; // Outputs from the module

    // Instantiate the RedOp module
    RedOp uut (
        .in1(in1),
        .res1(res1),
        .res2(res2),
        .res3(res3),
        .res4(res4),
        .res5(res5),
        .res6(res6)
    );

    // Testbench logic
    initial begin
        // Monitor signals
        $monitor("Time: %0t | in1: %b | res1 (&in1): %b, res2 (~&in1): %b, res3 (|in1): %b, res4 (~|in1): %b, res5 (^in1): %b, res6 (~^in1): %b",
                 $time, in1, res1, res2, res3, res4, res5, res6);

        // Apply test cases with a delay of 4 time units between them
        in1 = 4'b0000; #4; // Test 1: All zeros
        in1 = 4'b1111; #4; // Test 2: All ones
        in1 = 4'b1010; #4; // Test 3: Alternating bits
        in1 = 4'b1100; #4; // Test 4: Two bits set
        in1 = 4'b0110; #4; // Test 5: Different combination of bits set
        in1 = 4'b0101; #4; // Test 6: Another combination of bits set

        // End simulation
        $stop;
    end

endmodule
