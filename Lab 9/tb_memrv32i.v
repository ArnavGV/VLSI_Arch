`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2025 17:50:52
// Design Name: 
// Module Name: tb_memrv32i
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

module tb_rv32i_mem_stage;
    reg [31:0] dm_adr;
    reg [1:0] access_sz;
    reg s_us;
    reg [31:0] sd_32;
    reg [1:0] acc_type;
    wire [31:0] ld_32;

    rv32i_mem_stage dut (
        .dm_adr(dm_adr),
        .access_sz(access_sz),
        .s_us(s_us),
        .sd_32(sd_32),
        .acc_type(acc_type),
        .ld_32(ld_32)
    );

    initial begin
        // Initialize memory with known pattern for testing
        dut.mem_d[0] = 32'hAABBCCDD;
        dut.mem_d[1] = 32'h11223344;
        dut.mem_d[2] = 32'h55667788;
        dut.mem_d[3] = 32'h99AABBCC;

        // Test LB (aligned)
        dm_adr = 32'd0; access_sz = 2'b00; s_us = 1'b0; acc_type = 2'b01;
        #50;
        $display("LB (aligned): ld_32 = %h", ld_32);

        // Test LB (misaligned)
        dm_adr = 32'd1; access_sz = 2'b00; s_us = 1'b0; acc_type = 2'b01;
        #50;
        $display("LB (misaligned): ld_32 = %h", ld_32);

        // Test LBU (aligned)
        dm_adr = 32'd0; access_sz = 2'b00; s_us = 1'b1; acc_type = 2'b01;
        #50;
        $display("LBU (aligned): ld_32 = %h", ld_32);

        // Test LH (aligned)
        dm_adr = 32'd0; access_sz = 2'b01; s_us = 1'b0; acc_type = 2'b01;
        #50;
        $display("LH (aligned): ld_32 = %h", ld_32);

        // Test LH (misaligned)
        dm_adr = 32'd1; access_sz = 2'b01; s_us = 1'b0; acc_type = 2'b01;
        #50;
        $display("LH (misaligned): ld_32 = %h", ld_32);

        // Test LHU (aligned)
        dm_adr = 32'd0; access_sz = 2'b01; s_us = 1'b1; acc_type = 2'b01;
        #50;
        $display("LHU (aligned): ld_32 = %h", ld_32);

        // Test LW (aligned)
        dm_adr = 32'd0; access_sz = 2'b10; s_us = 1'b0; acc_type = 2'b01;
        #50;
        $display("LW (aligned): ld_32 = %h", ld_32);

        // Test LW (misaligned)
        dm_adr = 32'd1; access_sz = 2'b10; s_us = 1'b0; acc_type = 2'b01;
        #50;
        $display("LW (misaligned): ld_32 = %h", ld_32);

        // Test SB (aligned)
        dm_adr = 32'd4; access_sz = 2'b00; sd_32 = 32'h000000EE; acc_type = 2'b10;
        #50;
        $display("SB (aligned): mem_d[1] = %h", dut.mem_d[1]);

        // Test SB (misaligned)
        dm_adr = 32'd5; access_sz = 2'b00; sd_32 = 32'h000000FF; acc_type = 2'b10;
        #50;
        $display("SB (misaligned): mem_d[1] = %h", dut.mem_d[1]);

        // Test SH (aligned)
        dm_adr = 32'd8; access_sz = 2'b01; sd_32 = 32'h0000DEAD; acc_type = 2'b10;
        #50;
        $display("SH (aligned): mem_d[2] = %h", dut.mem_d[2]);

        // Test SH (misaligned)
        dm_adr = 32'd9; access_sz = 2'b01; sd_32 = 32'h0000BEEF; acc_type = 2'b10;
        #50;
        $display("SH (misaligned): mem_d[2] = %h, mem_d[3] = %h", dut.mem_d[2], dut.mem_d[3]);

        // Test SW (aligned)
        dm_adr = 32'd12; access_sz = 2'b10; sd_32 = 32'hCAFEBABE; acc_type = 2'b10;
        #50;
        $display("SW (aligned): mem_d[3] = %h", dut.mem_d[3]);

        // Test SW (misaligned)
        dm_adr = 32'd13; access_sz = 2'b10; sd_32 = 32'hDEADC0DE; acc_type = 2'b10;
        #50;
        $display("SW (misaligned): mem_d[3] = %h, mem_d[4] = %h", dut.mem_d[3], dut.mem_d[4]);

        $finish;
    end
endmodule

