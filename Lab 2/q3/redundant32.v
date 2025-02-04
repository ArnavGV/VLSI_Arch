`timescale 1ns / 1ps
module redundant_adder_32_bit(
input signed [31:0] A,B,
output reg signed [31:0] data_out,
output reg zero_flag
    );
wire [31:0] data; 
wire [7:0] intermediate1,intermediate2,intermediate3,intermediate4,intermediate5, intermediate6;
wire carry1,carry2,carry3,carry4,carry5,carry6,carry7,carry8,carry9,carry10;
ripple_carry_8bit R1 ( .A(A[7:0]) , .B(B[7:0]) ,.Cin(1'b0),.data_out(data[7:0]) , .overflow(),.Cout(carry1));
//
ripple_carry_8bit R2( .A(A[15:8]), .B(B[15:8]), .Cin(1'b0),.data_out( intermediate1) , .overflow(), .Cout(carry2));
ripple_carry_8bit R3( .A(A[15:8]), .B(B[15:8]), .Cin(1'b1),.data_out( intermediate2) , .overflow(),.Cout(carry3));
//
ripple_carry_8bit R4( .A(A[23:16]), .B(B[23:16]), .Cin(1'b0),.data_out( intermediate3) , .overflow(), .Cout(carry5));
ripple_carry_8bit R5( .A(A[23:16]), .B(B[23:16]), .Cin(1'b1),.data_out( intermediate4) , .overflow(),.Cout(carry6));
//
ripple_carry_8bit R6( .A(A[31:24]), .B(B[31:24]), .Cin(1'b0),.data_out( intermediate5) , .overflow(), .Cout(carry8));
ripple_carry_8bit R7( .A(A[31:24]), .B(B[31:24]), .Cin(1'b1),.data_out( intermediate6) , .overflow(),.Cout(carry9));
//
mux2_8line l1( .A(intermediate1),.B(intermediate2) , .sel(carry1) ,.mux2_8out(data[15:8]));
mux2 l2 ( .A( carry2) , .B(carry3) , .sel(carry1) , .mux2_out(carry4));
//
mux2_8line l3( .A(intermediate3),.B(intermediate4) , .sel(carry4) ,.mux2_8out(data[23:16]));
mux2 l4 ( .A( carry5) , .B(carry6) , .sel(carry4) , .mux2_out(carry7));
//
mux2_8line l5( .A(intermediate5),.B(intermediate6) , .sel(carry7) ,.mux2_8out(data[31:24]));
//mux2 l6 ( .A( carry5) , .B(carry6) , .sel(carry4) , .mux2_out(carry7));
always @(*) begin 
data_out<= data;
zero_flag<= ~(|data);
end
endmodule
// defining the structual modelling of the 2:1 MUX
module mux2 (
input A,B,sel,
output mux2_out 
);
wire int1,int2,sel_not;
not n1( sel_not , sel) ;
and a1(int1, sel_not,A);
and a2( int2, sel,B);
or o1 (mux2_out, int1,int2);
endmodule 

//Structural model of mux with 8-bit lines
module mux2_8line ( 
input [7:0] A,B,
input sel,
output [7:0] mux2_8out 
);
mux2 inst0 ( A[0],B[0],sel ,mux2_8out[0]);
mux2 inst1 ( A[1],B[1],sel ,mux2_8out[1]);
mux2 inst2 ( A[2],B[2],sel ,mux2_8out[2]);
mux2 inst3 ( A[3],B[3],sel ,mux2_8out[3]);
mux2 inst4 ( A[4],B[4],sel ,mux2_8out[4]);
mux2 inst5 ( A[5],B[5],sel ,mux2_8out[5]);
mux2 inst6 ( A[6],B[6],sel ,mux2_8out[6]);
mux2 inst7 ( A[7],B[7],sel ,mux2_8out[7]);
endmodule