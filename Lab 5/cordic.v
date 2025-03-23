`timescale 1ns/1ps

module cordic(input signed [15:0] argument, input reset, input clock, output reg signed [15:0] x, y, output reg done);
    reg signed [15:0] alpha;
    reg signed [15:0] cordic_angles [15:0];
    reg [3:0] iter;
    
    initial begin  //cordic angles generated using python
        cordic_angles[0] = 16'b0011001001000100; // in decimal: 12868
        cordic_angles[1] = 16'b0001110110101100; // in decimal: 7596
        cordic_angles[2] = 16'b0000111110101110; // in decimal: 4014
        cordic_angles[3] = 16'b0000011111110101; // in decimal: 2037
        cordic_angles[4] = 16'b0000001111111111; // in decimal: 1023
        cordic_angles[5] = 16'b0000001000000000; // in decimal: 512
        cordic_angles[6] = 16'b0000000100000000; // in decimal: 256
        cordic_angles[7] = 16'b0000000010000000; // in decimal: 128
        cordic_angles[8] = 16'b0000000001000000; // in decimal: 64
        cordic_angles[9] = 16'b0000000000100000; // in decimal: 32
        cordic_angles[10] = 16'b0000000000010000; // in decimal: 16
        cordic_angles[11] = 16'b0000000000001000; // in decimal: 8
        cordic_angles[12] = 16'b0000000000000100; // in decimal: 4
        cordic_angles[13] = 16'b0000000000000010; // in decimal: 2
        cordic_angles[14] = 16'b0000000000000001; // in decimal: 1
        cordic_angles[15] = 16'b0000000000000000; // in decimal: 0
        
        alpha = 16'h0000;
        x = 16'd9949; // K for n = 16
        y = 16'h0000;
        done = 1'b0;
        iter = 4'b0000;
    end

    always @(posedge clock) begin
        if(reset == 1'b1) begin
            alpha<=16'h0000;
            x<=16'd9949;
            y<=16'h0000;
            done<=1'b0;
            iter <= 4'b0000;
        end

        else if (iter < 15) begin
            if (argument >= alpha) begin
                x <= x - (y >>> iter);
                y <= y + (x >>> iter);
                alpha <= alpha + cordic_angles[iter];
            end
            else begin
                x <= x + (y >>> iter);
                y <= y- (x >>> iter);
                alpha <= alpha - cordic_angles[iter];
            end
            iter <= iter + 1;
        end
        else begin
            done <= 1'b1;
        end
    end
endmodule
