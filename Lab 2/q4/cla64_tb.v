`timescale 1ns / 1ps

module CLA_Adder_64bit_tb;
    // Testbench signals
    reg [63:0] a, b;
    reg cin;
    wire [63:0] sum;
    wire cout;
    
    // Instantiate the CLA Adder module
    CLA_Adder_64bit uut (
        .a(a), 
        .b(b), 
        .cin(cin), 
        .sum(sum), 
        .cout(cout)
    );
    
    // Test procedure
    initial begin
        // Monitor the signals
        $monitor("Time = %0t | a = %h, b = %h, cin = %b | sum = %h, cout = %b", 
                 $time, a, b, cin, sum, cout);
        
        // Test Case 1: Simple addition
        a = 64'h0000000000000001; 
        b = 64'h0000000000000001; 
        cin = 0;
        #10;
        
        // Test Case 2: Carry generation
        a = 64'hFFFFFFFFFFFFFFFF;
        b = 64'h0000000000000001;
        cin = 0;
        #10;
        
        // Test Case 3: Large numbers addition
        a = 64'h123456789ABCDEF0;
        b = 64'h0FEDCBA987654321;
        cin = 1;
        #10;
        
        // Test Case 4: Zero addition
        a = 64'h0000000005000000;
        b = 64'h000000000F000000;
        cin = 0;
        #10;
        
        // Test Case 5: Random values
        a = 64'h0AAAAAAAA0AAAAAA;
        b = 64'h5555555555555555;
        cin = 1;
        #10;
        a = 64'h8000000000000000;
        b = 64'h8000000000000000;
        cin = 1;
        #10;
        // End simulation
        $finish;
    end
endmodule