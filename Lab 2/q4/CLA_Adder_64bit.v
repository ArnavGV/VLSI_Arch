`timescale 1ns / 1ps

module CLA_Adder_64bit(
    input [63:0] a, b,  // 64-bit operands
    input cin,         // Carry-in
    output [63:0] sum, // Sum output
    output cout        // Carry-out
);

// Generate and propagate signals
wire [63:0] g, p;
wire [15:0] g1, p1;
wire [3:0] g2, p2;
wire [3:0] c2;
wire [15:0] c1;
wire [63:0] c;

// Level-0: 1-bit adder component
assign g = a & b;  // Generate
assign p = a ^ b;  // Propagate

// Level-1: 4-bit CLA adder component
genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin
        assign g1[i] = g[4*i+3] | (p[4*i+3] & g[4*i+2]) | (p[4*i+3] & p[4*i+2] & g[4*i+1]) | (p[4*i+3] & p[4*i+2] & p[4*i+1] & g[4*i]);
        assign p1[i] = p[4*i+3] & p[4*i+2] & p[4*i+1] & p[4*i];
    end
endgenerate

// Level-2: 16-bit CLA adder component
generate
    for (i = 0; i < 4; i = i + 1) begin
        assign g2[i] = g1[4*i+3] | (p1[4*i+3] & g1[4*i+2]) | (p1[4*i+3] & p1[4*i+2] & g1[4*i+1]) | (p1[4*i+3] & p1[4*i+2] & p1[4*i+1] & g1[4*i]);
        assign p2[i] = p1[4*i+3] & p1[4*i+2] & p1[4*i+1] & p1[4*i];
    end
endgenerate

// Compute carry-in values
assign c2[0] = cin;
assign c2[1] = g2[0] | (p2[0] & c2[0]);
assign c2[2] = g2[1] | (p2[1] & g2[0]) | (p2[1] & p2[0] & c2[0]);
assign c2[3] = g2[2] | (p2[2] & g2[1]) | (p2[2] & p2[1] & g2[0]) | (p2[2] & p2[1] & p2[0] & c2[0]);

// Compute final carry-out
assign cout = g2[3] | (p2[3] & g2[2]) | (p2[3] & p2[2] & g2[1]) | (p2[3] & p2[2] & p2[1] & g2[0]) | (p2[3] & p2[2] & p2[1] & p2[0] & c2[0]);

// Compute carry-in values for Level-1 adders
assign c1[0] = c2[0]; // First carry input is directly from c2

generate
    for (i = 1; i < 16; i = i + 1) begin
        assign c1[i] = g1[i-1] | (p1[i-1] & c1[i-1]);
    end
endgenerate


// Compute carry-in values for Level-0 adders
assign c[0] = cin; // Initial carry-in

generate
    for (i = 1; i < 64; i = i + 1) begin
        assign c[i] = (i % 4 == 0) ? c1[i/4] : (g[i-1] | (p[i-1] & c[i-1]));
    end
endgenerate


// Compute final sum
generate
    for (i = 0; i < 64; i = i + 1) begin
        assign sum[i] = p[i] ^ c[i];
    end
endgenerate

endmodule
