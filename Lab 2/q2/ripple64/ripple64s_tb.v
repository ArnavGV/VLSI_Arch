`timescale 1ns / 1ps

module tb_ripple_adder_64signed();

    // Testbench signals
    reg signed [63:0] A;
    reg signed [63:0] B;
    wire [63:0] data_out;
    wire overflow;

    // Instantiate the DUT (Device Under Test)
    ripple_adder_64signed uut (
        .A(A),
        .B(B),
        .data_out(data_out),
        .overflow(overflow)
    );

    // Testbench process
    initial begin
        // Initialize inputs
        A = 64'd0;
        B = 64'd0;

        // Test case 1: Add two small numbers
        #10 A = 64'd15; B = 64'd20;
        #10;
        $display("Test 1: A = %d, B = %d, Sum = %d, Overflow = %b", A, B, data_out, overflow);

        // Test case 2: Add two large numbers
        #10 A = 64'd9223372036854775807; B = 64'd9223372036854775807;
        #10;
        $display("Test 2: A = %d, B = %d, Sum = %d, Overflow = %b", A, B, data_out, overflow);

        // Test case 3: Add a large and small number
        #10 A = 64'd4294967295; B = 64'd1;
        #10;
        $display("Test 3: A = %d, B = %d, Sum = %d, Overflow = %b", A, B, data_out, overflow);

        // Test case 4: Add two zero values
        #10 A = -64'd69; B = 64'd23;
        #10;
        $display("Test 4: A = %d, B = %d, Sum = %d, Overflow = %b", A, B, data_out, overflow);

        // Test case 5: Add numbers resulting in overflow
        #10 A = 64'b1000000000000000000000000000000010000000000000000000000000000000; B = 64'd1;
        #10;
        $display("Test 5: A = %h, B = %h, Sum = %h, Overflow = %b", A, B, data_out, overflow);

        // Finish simulation
        #10;
        $finish;
    end

endmodule