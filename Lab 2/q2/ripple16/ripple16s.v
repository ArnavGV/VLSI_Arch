`timescale 1ns / 1ps
module ripplecarry_16signed(
    input signed [15:0] A, B,
    input Cin,
    output reg signed [15:0] sum_out,
    output reg overflow,
    output reg Cout
);

    wire [15:0] carry_wire;  // Fixed size
    wire [15:0] ripple_out;

    Full_Adder_Module adder0  (.a(A[0]),  .b(B[0]),  .Cin(Cin),       .sum(ripple_out[0]),  .Cout(carry_wire[0]));
    Full_Adder_Module adder1  (.a(A[1]),  .b(B[1]),  .Cin(carry_wire[0]),  .sum(ripple_out[1]),  .Cout(carry_wire[1]));
    Full_Adder_Module adder2  (.a(A[2]),  .b(B[2]),  .Cin(carry_wire[1]),  .sum(ripple_out[2]),  .Cout(carry_wire[2]));
    Full_Adder_Module adder3  (.a(A[3]),  .b(B[3]),  .Cin(carry_wire[2]),  .sum(ripple_out[3]),  .Cout(carry_wire[3]));
    Full_Adder_Module adder4  (.a(A[4]),  .b(B[4]),  .Cin(carry_wire[3]),  .sum(ripple_out[4]),  .Cout(carry_wire[4]));
    Full_Adder_Module adder5  (.a(A[5]),  .b(B[5]),  .Cin(carry_wire[4]),  .sum(ripple_out[5]),  .Cout(carry_wire[5]));
    Full_Adder_Module adder6  (.a(A[6]),  .b(B[6]),  .Cin(carry_wire[5]),  .sum(ripple_out[6]),  .Cout(carry_wire[6]));
    Full_Adder_Module adder7  (.a(A[7]),  .b(B[7]),  .Cin(carry_wire[6]),  .sum(ripple_out[7]),  .Cout(carry_wire[7]));
    Full_Adder_Module adder8  (.a(A[8]),  .b(B[8]),  .Cin(carry_wire[7]),  .sum(ripple_out[8]),  .Cout(carry_wire[8]));
    Full_Adder_Module adder9  (.a(A[9]),  .b(B[9]),  .Cin(carry_wire[8]),  .sum(ripple_out[9]),  .Cout(carry_wire[9]));
    Full_Adder_Module adder10 (.a(A[10]), .b(B[10]), .Cin(carry_wire[9]),  .sum(ripple_out[10]), .Cout(carry_wire[10]));
    Full_Adder_Module adder11 (.a(A[11]), .b(B[11]), .Cin(carry_wire[10]), .sum(ripple_out[11]), .Cout(carry_wire[11]));
    Full_Adder_Module adder12 (.a(A[12]), .b(B[12]), .Cin(carry_wire[11]), .sum(ripple_out[12]), .Cout(carry_wire[12]));
    Full_Adder_Module adder13 (.a(A[13]), .b(B[13]), .Cin(carry_wire[12]), .sum(ripple_out[13]), .Cout(carry_wire[13]));
    Full_Adder_Module adder14 (.a(A[14]), .b(B[14]), .Cin(carry_wire[13]), .sum(ripple_out[14]), .Cout(carry_wire[14]));
    Full_Adder_Module adder15 (.a(A[15]), .b(B[15]), .Cin(carry_wire[14]), .sum(ripple_out[15]), .Cout(carry_wire[15]));

    always @(*) begin
        sum_out <= ripple_out;
        overflow <= carry_wire[14] ^ carry_wire[15];
        Cout <= carry_wire[15];
    end 
endmodule

module Full_Adder_Module(
input a,b,Cin,
output sum,Cout
    );
assign sum= a^b^Cin;
assign Cout= (a&b) | (Cin&(a^b));
endmodule