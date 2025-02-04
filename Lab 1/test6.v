`timescale 1ns / 1ps

module RelationalEqualityOp_tb;

    // Declare testbench variables
    reg [3:0] in1, in2;         // Inputs to the module
    wire gt, lt, ge, le;        // Relational outputs
    wire eq, neq, c_eq, c_neq;  // Equality outputs

    // Instantiate the RelationalEqualityOp module
    RelationalEqualityOp uut (
        .in1(in1),
        .in2(in2),
        .gt(gt),
        .lt(lt),
        .ge(ge),
        .le(le),
        .eq(eq),
        .neq(neq),
        .c_eq(c_eq),
        .c_neq(c_neq)
    );

    // Testbench logic
    initial begin
        // Monitor the results of the operations
        $monitor("Time: %0t | in1: %b, in2: %b | gt: %b, lt: %b, ge: %b, le: %b, eq: %b, neq: %b, c_eq: %b, c_neq: %b",
                 $time, in1, in2, gt, lt, ge, le, eq, neq, c_eq, c_neq);

        // Test cases with a delay of 4 time units between them
        in1 = 4'b0000; in2 = 4'b0001; #4; // Test 1: in1 < in2
        in1 = 4'b0010; in2 = 4'b0010; #4; // Test 2: in1 == in2
        in1 = 4'b0100; in2 = 4'b0011; #4; // Test 3: in1 > in2
        in1 = 4'b1111; in2 = 4'b0000; #4; // Test 4: in1 > in2
        in1 = 4'b1111; in2 = 4'b1110; #4; // Test 5: in1 >= in2
        in1 = 4'b0001; in2 = 4'b0000; #4; // Test 6: in1 > in2
        in1 = 4'b0010; in2 = 4'b0100; #4; // Test 7: in1 < in2
        in1 = 4'bXXXX; in2 = 4'b0000; #4; // Test 8: Case equality (with X)

        // End simulation
        $stop;
    end

endmodule
