`timescale 1ns / 1ps

module shifter_32_tb;

    // Inputs
    reg [31:0] a;     // Operand
    reg [4:0] b;      // Shift amount
    reg [1:0] c;      // Shift type

    // Output
    wire [31:0] z;

    // Instantiate the shifter_32 module
    shifter_32 uut (
        .a(a),
        .b(b),
        .c(c),
        .z(z)
    );

    // Test procedure
    initial begin
        // Monitor values
        $monitor("Time=%0t | a=%h | b=%d | c=%b | z=%h", $time, a, b, c, z);

        // Test Case 1: Logical Left Shift (b=4, c=2'b00)
        a = 32'hA5A5A5A5;  // Input pattern
        b = 5'd4;          // Shift amount = 4
        c = 2'b00;         // Logical left shift
        #4;

        // Test Case 2: Logical Right Shift (b=4, c=2'b01)
        a = 32'hF0F0F0F0;  // Input pattern
        b = 5'd4;          // Shift amount = 4
        c = 2'b01;         // Logical right shift
        #4;

        // Test Case 3: Arithmetic Right Shift (b=8, c=2'b10)
        a = 32'h80000000;  // Negative number (MSB=1)
        b = 5'd8;          // Shift amount = 8
        c = 2'b11;         // Arithmetic right shift
        #4;

        // Test Case 4: Signed Right Shift (b=16, c=2'b11)
        a = 32'h12345678;
        b = 5'd16;         // Shift amount = 16
        c = 2'b10;         // Unsigned shift
        #4;

        // Test Case 5: No shift (b=0, c=2'b00)
        a = 32'hDEADBEEF;
        b = 5'd0;          // No shift
        c = 2'b00;
        #4;

        // Test Case 6: Maximum Shift (b=31, c=2'b01)
        a = 32'hFFFFFFFF;
        b = 5'd31;         // Shift amount = 31
        c = 2'b01;         // Logical right shift
        #4;

        // Finish simulation
        $finish;
    end

endmodule
