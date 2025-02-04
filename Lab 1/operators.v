`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2025 14:22:20
// Design Name: 
// Module Name: operators
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


module ArithOp(
    input [3:0] in1, in2,
    output reg [3:0] res1, res2, res3, res4, res5
    );
    always@(*)
    begin 
    res1 = in1+in2;
    res2 = in1-in2;
    res3 = in1*in2;
    res4 = in1/in2;
    res5 = in1%in2;
    end
endmodule


module LogicOp(
input [3:0] in1,in2,
output reg [3:0] res1,res2,res3);
always@(*)
begin
res1 = !in1;
res2 = in1 && in2;
res3 = in1 || in2;
end
endmodule


module BitwiseOp(input [3:0] in1,in2,
output reg [3:0] res1,res2,res3,res4,res5);
always@(*)
begin
res1 = ~in1;
res2 = in1 & in2;
res3 = in1 | in2;
res4 = in1 ^ in2;
res5 = in1 ^~ in2;
end
endmodule

module RedOp(input [3:0] in1,
output reg [3:0] res1,res2,res3,res4,res5,res6);
always@(*)
begin
res1 = &in1;
res2 = ~&in1;
res3 = |in1;
res4 = ~|in1;
res5 = ^in1;
res6 = ~^in1;
end
endmodule

module ShiftOp(input [3:0] in1,
output reg [3:0] res1,res2,res3);
parameter shift = 1 ;
always@(*)
begin
res1=in1 >> shift;
res2=in1 << shift;
res3=in1 >>> shift;
end
endmodule


module RelationalEqualityOp(
    input [3:0] in1, in2, // 4-bit input operands
    output reg gt, lt, ge, le, // relational outputs
    output reg eq, neq, c_eq, c_neq // equality outputs
);
    always @(*) begin
        // Relational operators
        gt = (in1 > in2);
        lt = (in1 < in2);
        ge = (in1 >= in2);
        le = (in1 <= in2);

        // Equality operators
        eq = (in1 == in2);
        neq = (in1 != in2);
        c_eq = (in1 === in2); // Case equality (X propagation)
        c_neq = (in1 !== in2); // Case inequality (X propagation)
    end
endmodule

module ConcatRepCondOp(
    input [3:0] in1, in2,  // 4-bit inputs
    input sel,              // Selector for conditional operator
    output reg [7:0] concat_res, // Concatenation result
    output reg [7:0] rep_res,    // Replication result
    output reg cond_res          // Conditional result
);
    always @(*) begin
        
        concat_res = {in1, in2}; // Concatenate in1 and in2 (result is 8 bits)

        rep_res = {4{in1}}; // Replicate the value of in1 4 times (result is 16 bits)

        cond_res = (sel) ? in1 : in2; // Conditional operator
    end
endmodule
