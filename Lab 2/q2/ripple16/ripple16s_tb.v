`timescale 1ns / 1ps

module ripplecarry_16signed_tb;

    // Inputs
    reg signed [15:0] A;
    reg signed [15:0] B;
    reg Cin;

    // Outputs
    wire signed [15:0] sum_out;
    wire overflow;
    wire Cout;

    // Instantiate the Unit Under Test (UUT)
    ripplecarry_16signed uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .sum_out(sum_out),
        .overflow(overflow),
        .Cout(Cout)
    );

    initial begin
        // Display header
        $display("Time\tA\t\t\tB\t\t\tCin\tSum\t\t\tCout\tOverflow");

        // Test Case 1: Simple addition without carry
        A = 16'sh0001; B = 16'sh0001; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 2: Addition with carry-in
        A = 16'sh7FFF; B = 16'sh0001; Cin = 1'b1;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 3: Negative addition
        A = 16'shFFFF; B = 16'sh0001; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 4: Overflow condition
        A = 16'sh4000; B = 16'sh4000; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 5: All zeros
        A = 16'sh0000; B = 16'sh0000; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 6: All ones
        A = 16'shFFFF; B = 16'shFFFF; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        $stop;
    end

endmodule