`timescale 1ns / 1ps

module redundant_adder_32_bit_tb;
    // Testbench signals
    reg signed [31:0] A, B;
    wire signed [31:0] data_out;
    wire zero_flag;
    
    // Instantiate the design under test (DUT)
    redundant_adder_32_bit uut (
        .A(A),
        .B(B),
        .data_out(data_out),
        .zero_flag(zero_flag)
    );
    
    // Test procedure
    initial begin
        $monitor("Time = %0t | A = %d | B = %d | Output = %d", $time, A, B, data_out);
        
        // Test case 1: Positive numbers
        A = 32'd50; B = 32'd25;
        #10;
        
        // Test case 2: Negative numbers
        A = -32'd100; B = -32'd50;
        #10;
        
        // Test case 3: Positive and negative
        A = 32'd75; B = -32'd30;
        #10;
        
        // Test case 4: Large positive numbers
        A = 32'd6700; B = -32'd6700;
        #10;
        
        // Test case 5: Large negative numbers
        A = -32'd2147483; B = -32'd1;
        #10;
        
        // Test case 6: Zero inputs
        A = 32'd0; B = 32'd0;
        #10;
        
        // End simulation
        $finish;
    end
endmodule