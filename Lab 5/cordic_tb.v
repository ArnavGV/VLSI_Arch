module cordic_tb;
    reg signed [15:0] arguments [3:0];
    reg signed [15:0] argument;
    reg reset, clock;
    wire done;
    wire signed [15:0] x, y;
    real cos_fp, sin_fp;
    integer test_counter;
    cordic crdc(argument, reset, clock, x, y, done);
    always #50 clock = ~clock;
    always @(x, y) begin
        cos_fp = x / 16384.0;
        sin_fp = y / 16384.0;
    end
    initial begin
        clock = 1'b0;
        arguments[0] = 16'h0000; // 0 deg
        arguments[1] = 16'b0010000110000011; // 30 deg
        arguments[2] = 16'b0011001001000100; // 45 deg
        arguments[3] = 16'b0100001100000101; // 60 deg
        
        // Modified display with more information but keeping continuous monitoring
        $display("===== CORDIC ALGORITHM TESTBENCH =====");
        $monitor($time, " | Angle: %0d | cos = %.3f | sin = %.3f | done = %b", 
                 $itor(argument) * 60.0 / 17157.0, cos_fp, sin_fp, done);
                 
        #0 clock <= 1'b0; reset <= 1'b1; argument <= arguments[0]; $display("\n--- Test 0: 0 degrees ---");
        #150 reset <= 1'b0;
        #1750 reset <= 1'b1; argument <= arguments[1]; $display("\n--- Test 1: 30 degrees ---");
        #100 reset <= 1'b0;
        #1750 reset <= 1'b1; argument <= arguments[2]; $display("\n--- Test 2: 45 degrees ---");
        #100 reset <= 1'b0;
        #1750 reset <= 1'b1; argument <= arguments[3]; $display("\n--- Test 3: 60 degrees ---");
        #100 reset <= 1'b0;
        #1750 $display("\n===== TESTBENCH COMPLETED ====="); $finish;
    end
endmodule