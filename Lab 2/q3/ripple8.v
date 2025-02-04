`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2025 12:53:47
// Design Name: 
// Module Name: ripple8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ripple_carry_8bit(
input signed [7:0] A, B,
input Cin,
output reg signed [7:0] data_out ,
output reg overflow ,
output reg Cout
    );
wire [7:0] carry_out;
wire [7:0] sum_out;
Full_Adder add1( .A(A[0]) , .B(B[0]) , .Cin(Cin) , .sum(sum_out[0]) , .Cout(carry_out[0]));
Full_Adder add2( .A(A[1]) , .B(B[1]) , .Cin(carry_out[0]) , .sum(sum_out[1]) , .Cout(carry_out[1]));
Full_Adder add3( .A(A[2]) , .B(B[2]) , .Cin(carry_out[1]) , .sum(sum_out[2]) , .Cout(carry_out[2]));
Full_Adder add4( .A(A[3]) , .B(B[3]) , .Cin(carry_out[2]) , .sum(sum_out[3]) , .Cout(carry_out[3]));
Full_Adder add5( .A(A[4]) , .B(B[4]) , .Cin(carry_out[3]) , .sum(sum_out[4]) , .Cout(carry_out[4]));
Full_Adder add6( .A(A[5]) , .B(B[5]) , .Cin(carry_out[4]) , .sum(sum_out[5]) , .Cout(carry_out[5]));
Full_Adder add7( .A(A[6]) , .B(B[6]) , .Cin(carry_out[5]) , .sum(sum_out[6]) , .Cout(carry_out[6]));
Full_Adder add8( .A(A[7]) , .B(B[7]) , .Cin(carry_out[6]) , .sum(sum_out[7]) , .Cout(carry_out[7]));

always @(*) begin 
data_out<= sum_out;
overflow<= carry_out[7]^carry_out[6];
Cout<= carry_out[7];
end
endmodule

// Declaring the full adder module 
module Full_Adder ( 
input A,B, Cin,
output reg sum, Cout
);
always @(*) begin
sum<= A^B^Cin ;
Cout <= (A&B)|( Cin &(A^B));
end
endmodule