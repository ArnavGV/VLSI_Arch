`timescale 1ns / 1ps

module ArithOp_tb;

    // Testbench variables
    reg [3:0] in1, in2; // 4-bit inputs
    wire [3:0] res1, res2, res3, res4, res5; // 4-bit outputs

    // Instantiate the ArithOp module
    ArithOp uut (
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
        // Monitor the outputs
        $monitor("Time: %0t | in1: %d, in2: %d | res1 (+): %d, res2 (-): %d, res3 (*): %d, res4 (/): %d, res5 (%%): %d",
                 $time, in1, in2, res1, res2, res3, res4, res5);

        // Apply test cases
        in1 = 4'd5; in2 = 4'd3; #10; // Test 1: Addition, Subtraction, etc.
        in1 = 4'd7; in2 = 4'd2; #10; // Test 2: Multiplication, Division
        in1 = 4'd9; in2 = 4'd1; #10; // Test 3: Division by 1
        in1 = 4'd8; in2 = 4'd0; #10; // Test 4: Division/Modulo by 0
        in1 = 4'd0; in2 = 4'd6; #10; // Test 5: Zero Operand
        in1 = 4'd4; in2 = 4'd4; #10; // Test 6: Equal Operands
        
        // End simulation
        $stop;
    end

endmodule
