`timescale 1ns / 1ps

module ripple_adder32unsigned_tb;

    // Inputs
    reg [31:0] A;
    reg [31:0] B;
    reg Cin;

    // Outputs
    wire [31:0] sum;
    wire overflow;
    wire Cout;

    // Instantiate the Unit Under Test (UUT)
    ripple_adder32unsigned uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .sum(sum),
        .overflow(overflow),
        .Cout(Cout)
    );

    initial begin
        // Test cases
        $display("Time\tA\t\t\t\tB\t\t\t\tCin\tSum\t\t\t\tCout\tOverflow");

        // Test Case 1: Simple addition without carry
        A = 32'h00000001; B = 32'h00000001; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 2: Addition with carry-in
        A = 32'hFFFFFFFF; B = 32'h00000001; Cin = 1'b1;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 3: Overflow condition
        A = 32'h7FFFFFFF; B = 32'h00000001; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 4: No overflow
        A = 32'h40000000; B = 32'h40000000; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 5: All zeros
        A = 32'h00000000; B = 32'h00000000; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        // Test Case 6: All ones
        A = 32'hFFFFFFFF; B = 32'hFFFFFFFF; Cin = 1'b0;
        #10;
        $display("%0dns\t%h\t%h\t%b\t%h\t%b\t%b", $time, A, B, Cin, sum, Cout, overflow);

        $stop;
    end

endmodule
