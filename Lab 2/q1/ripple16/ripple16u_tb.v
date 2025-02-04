`timescale 1ns / 1ps

module ripplecarry_16unsigned_tb;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;
    reg Cin;

    // Outputs
    wire [15:0] sum_out;
    wire overflow;
    wire Cout;

    // Instantiate the Unit Under Test (UUT)
    ripplecarry_16unsigned uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .sum_out(sum_out),
        .overflow(overflow),
        .Cout(Cout)
    );

    initial begin
        // Test cases
        $display("Time\tA\t\tB\t\tCin\tSum\t\tCout\tOverflow");

        // Test Case 1: Simple addition without carry
        A = 16'h0001; B = 16'h0001; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 2: Addition with carry-in
        A = 16'hFFFF; B = 16'h0001; Cin = 1'b1;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 3: Overflow condition
        A = 16'h7FFF; B = 16'h0001; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 4: No overflow
        A = 16'h4000; B = 16'h4000; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 5: All zeros
        A = 16'h0000; B = 16'h0000; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        // Test Case 6: All ones
        A = 16'hFFFF; B = 16'hFFFF; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum_out, Cout, overflow);

        $stop;
    end

endmodule