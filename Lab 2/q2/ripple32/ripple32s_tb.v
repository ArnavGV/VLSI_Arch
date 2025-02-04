`timescale 1ns / 1ps

module ripple_adder32signed_tb;

    // Inputs
    reg signed [31:0] A;
    reg signed [31:0] B;
    reg Cin;

    // Outputs
    wire signed [31:0] sum;
    wire overflow;
    wire Cout;

    // Instantiate the Unit Under Test (UUT)
    ripple_adder32signed uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .sum(sum),
        .overflow(overflow),
        .Cout(Cout)
    );

    initial begin
        // Display header
        $display("Time\tA\t\t\t\t\tB\t\t\t\t\tCin\tSum\t\t\t\t\tCout\tOverflow");

        // Test Case 1: Simple addition without carry
        A = 32'sh00000001; B = 32'sh00000001; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 2: Addition with carry-in
        A = 32'sh7FFFFFFF; B = 32'sh00000001; Cin = 1'b1;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 3: Negative addition
        A = 32'shFFFFFFFF; B = 32'sh00000001; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 4: Overflow condition
        A = 32'sh40000000; B = 32'sh40000000; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 5: All zeros
        A = 32'sh00000000; B = 32'sh00000000; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 6: All ones
        A = 32'shFFFFFFFF; B = 32'shFFFFFFFF; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        $stop;
    end

endmodule