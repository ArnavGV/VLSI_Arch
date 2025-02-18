`timescale 1ns / 1ps

/*
output frame = 3 bits {AC, Fan, Heater}, So out=3'b110 means AC and Fan are ON, and Heater is OFF
input frame = 6 bits {Tgt27, Tgt23, Tgt18, Tlt23, Tlt22, Tlt15}
*/

module moore_fsm(
    input rst,
    input clk,
    input [5:0] ip,
    output reg [2:0] out,
    output reg err
    );
    reg [2:0] state, next_state;
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b110;
    parameter S4 = 3'b111;        
 
   // Synchronous state transition
    always @(posedge clk) begin
        if (rst) begin
            state <= S0;
            err=1'b0;
        end 
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(state, ip) begin
    case(state)
    S0: begin
        if      (ip == 6'b111000) next_state= S3;
        else if (ip == 6'b011000) next_state=S2;
        else if (ip == 6'b001100) next_state=S0;
        else if (ip == 6'b001110) next_state=S0;
        else if (ip == 6'b000110) next_state=S0;
        else if (ip == 6'b000111) next_state=S1;
        else                   next_state=S4;
        end
                   
    S1: begin
        if      (ip == 6'b111000) next_state= S3;
        else if (ip == 6'b011000) next_state=S2;
        else if (ip == 6'b001100) next_state=S0;
        else if (ip == 6'b001110) next_state=S0;
        else if (ip == 6'b000110) next_state=S1;
        else if (ip == 6'b000111) next_state=S1;
        else                   next_state=S4;
        end
                   
    S2: begin
        if      (ip == 6'b111000) next_state= S3;
        else if (ip == 6'b011000) next_state=S2;
        else if (ip == 6'b001100) next_state=S2;
        else if (ip == 6'b001110) next_state=S0;
        else if (ip == 6'b000110) next_state=S0;
        else if (ip == 6'b000111) next_state=S1;
        else                   next_state=S4;
        end
                   
    S3: begin
        if      (ip == 6'b111000) next_state= S3;
        else if (ip == 6'b011000) next_state=S2;
        else if (ip == 6'b001100) next_state=S2;
        else if (ip == 6'b001110) next_state=S0;
        else if (ip == 6'b000110) next_state=S0;
        else if (ip == 6'b000111) next_state=S1;
        else             next_state=S4;
       end
        
        default: next_state = S0;
     endcase   
    end
    
    always@(state) begin
    case(state)
      S0 : out = S0;
      S1 : out = S1;
      S2 : out = S2;
      S3 : out = S3;
      S4 : begin
            err = 1'b1;
            out = S0;
            end
      default : out = S0;
    endcase
  end
endmodule

















