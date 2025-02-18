`timescale 1ns / 1ps

module moore_fsm_tb;
    reg clk;
    reg rst;
    reg [5:0] ip;
    wire [2:0] out;
    wire err;
    
    // Instantiate the FSM module
    moore_fsm uut (
        .clk(clk),
        .rst(rst),
        .ip(ip),
        .out(out),
        .err(err)
    );
    
    // Clock generation
    always #5 clk = ~clk; // 10ns clock period
    
    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        ip = 6'b000000;
        #10;
        
        // Release reset
        rst = 0;
        
        // Apply test vectors
        ip = 6'b111000; #10;
        ip = 6'b011000; #10;
        ip = 6'b001100; #10;
        ip = 6'b001110; #10;
        ip = 6'b000110; #10;
        ip = 6'b000111; #10;
        ip = 6'b110011; #10; // Invalid input, should trigger error
        
        // End simulation
        #20;
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor("Time = %t | State = %b | Input = %b | Output = %b | Error = %b", 
                 $time, uut.state, ip, out, err);
    end
endmodule
