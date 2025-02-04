`timescale 1ns / 1ps
module ripple_adder32signed(
input signed [31:0] A,B,
input Cin, 
output reg signed [31:0] sum,
output reg overflow,
output reg Cout
    );
wire [31:0] sum_out;
wire Cout_16;
wire overflow_out;
wire carry_out_final;
ripplecarry_16signed adder16_1  ( .A(A[15:0]) , .B(B[15:0]) , .sum_out(sum_out[15:0]) ,.Cin(Cin), .Cout(Cout_16) , .overflow());
ripplecarry_16signed adder16_2  ( .A(A[31:16]) , .B(B[31:16]) , .sum_out(sum_out[31:16]) ,.Cin(Cout_16), .Cout(carry_out_final) , .overflow(overflow_out));
    
always @(*) 
    begin 
    sum<= sum_out;
    overflow<= overflow_out;
    Cout<= carry_out_final;
    end
    
    
    
endmodule