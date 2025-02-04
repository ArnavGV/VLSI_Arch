`timescale 1ns / 1ps
module ripple_adder_64unsigned(
input [63:0] A,B,
output reg [63:0] data_out ,
output reg overflow 
    );
    
wire [63:0] sum_out;
wire Cout_32;
wire overflow_out;
ripple_adder32unsigned adder32_1  ( .A(A[31:0]) , .B(B[31:0]) , .sum(sum_out[31:0]) ,.Cin(0), .Cout(Cout_32) , .overflow());
ripple_adder32unsigned adder32_2  ( .A(A[63:32]) , .B(B[63:32]) , .sum(sum_out[63:32]) ,.Cin(Cout_32), .Cout() , .overflow(overflow_out));

always @(*) begin 

data_out <= sum_out;
overflow<= overflow_out;
end
    
endmodule