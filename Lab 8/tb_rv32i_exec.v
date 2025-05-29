`timescale 1ns/1ps

module tb_rv32i_ex1;

    // DUT Inputs
    reg [31:0] rs1_d, rs2i_d, imm_d, pc_v, off_v;
    reg [3:0] op_a, op_s;
    reg [2:0] op_l;
    reg [1:0] sel_r;
    reg [2:0] bra_c;
    reg       b_rs1_pc;

    // DUT Outputs
    wire [31:0] res_d_op, res_brt_dma;
    wire        res_bra;

    // Instantiate the DUT
    rv32i_ex1 dut (
        .rs1_d(rs1_d), .rs2i_d(rs2i_d), .imm_d(imm_d),
        .op_a(op_a), .op_l(op_l), .op_s(op_s), .sel_r(sel_r),
        .bra_c(bra_c), .pc_v(pc_v), .off_v(off_v), .b_rs1_pc(b_rs1_pc),
        .res_d_op(res_d_op), .res_brt_dma(res_brt_dma), .res_bra(res_bra)
    );

    // Test procedure
    initial begin
        $display("==== RV32I_EX1 Execute Stage Testbench ====");
        
        // Test ADD
        rs1_d = 32'd10; rs2i_d = 32'd20; op_a = 4'b0000; op_l = 3'b000; op_s = 4'b0000;
        sel_r = 2'b00; bra_c = 3'b000; pc_v = 32'd100; off_v = 32'd4; b_rs1_pc = 1'b0;
        #1;
        $display("ADD: rs1=%0d, rs2=%0d => res_d_op=%0d", rs1_d, rs2i_d, res_d_op);

        // Test SUB
        rs1_d = 32'd50; rs2i_d = 32'd20; op_a = 4'b1000; sel_r = 2'b00;
        #1;
        $display("SUB: rs1=%0d, rs2=%0d => res_d_op=%0d", rs1_d, rs2i_d, res_d_op);

        // Test SLT (signed less than)
        rs1_d = -32'd5; rs2i_d = 32'd2; op_a = 4'b0010; sel_r = 2'b00;
        #1;
        $display("SLT: rs1=%0d, rs2=%0d => res_d_op=%0d", rs1_d, rs2i_d, res_d_op);

        // Test SLTU (unsigned less than)
        rs1_d = 32'd2; rs2i_d = 32'd5; op_a = 4'b0011; sel_r = 2'b00;
        #1;
        $display("SLTU: rs1=%0d, rs2=%0d => res_d_op=%0d", rs1_d, rs2i_d, res_d_op);

        // Test AND
        rs1_d = 32'hA5A5A5A5; rs2i_d = 32'hFF00FF00; op_l = 3'b111; sel_r = 2'b01;
        #1;
        $display("AND: rs1=0x%h, rs2=0x%h => res_d_op=0x%h", rs1_d, rs2i_d, res_d_op);

        // Test OR
        rs1_d = 32'hA5A5A5A5; rs2i_d = 32'hFF00FF00; op_l = 3'b110; sel_r = 2'b01;
        #1;
        $display("OR: rs1=0x%h, rs2=0x%h => res_d_op=0x%h", rs1_d, rs2i_d, res_d_op);

        // Test XOR
        rs1_d = 32'hA5A5A5A5; rs2i_d = 32'hFF00FF00; op_l = 3'b100; sel_r = 2'b01;
        #1;
        $display("XOR: rs1=0x%h, rs2=0x%h => res_d_op=0x%h", rs1_d, rs2i_d, res_d_op);

        // Test SLL (shift left logical)
        rs1_d = 32'h00000001; rs2i_d = 32'd8; op_s = 4'b0001; sel_r = 2'b10;
        #1;
        $display("SLL: rs1=0x%h, shamt=%0d => res_d_op=0x%h", rs1_d, rs2i_d[4:0], res_d_op);

        // Test SRL (shift right logical)
        rs1_d = 32'h80000000; rs2i_d = 32'd4; op_s = 4'b0101; sel_r = 2'b10;
        #1;
        $display("SRL: rs1=0x%h, shamt=%0d => res_d_op=0x%h", rs1_d, rs2i_d[4:0], res_d_op);

        // Test SRA (shift right arithmetic)
        rs1_d = 32'hF0000000; rs2i_d = 32'd4; op_s = 4'b1101; sel_r = 2'b10;
        #1;
        $display("SRA: rs1=0x%h, shamt=%0d => res_d_op=0x%h", rs1_d, rs2i_d[4:0], res_d_op);

        // Test BEQ (branch if equal)
        rs1_d = 32'd10; rs2i_d = 32'd10; op_a = 4'b1000; bra_c = 3'b000; sel_r = 2'b00;
        #1;
        $display("BEQ: rs1=%0d, rs2=%0d => res_bra=%b", rs1_d, rs2i_d, res_bra);

        // Test BNE (branch if not equal)
        rs1_d = 32'd10; rs2i_d = 32'd20; op_a = 4'b1000; bra_c = 3'b001; sel_r = 2'b00;
        #1;
        $display("BNE: rs1=%0d, rs2=%0d => res_bra=%b", rs1_d, rs2i_d, res_bra);

        // Test branch target calculation (rs1 base)
        rs1_d = 32'd100; off_v = 32'd12; b_rs1_pc = 1'b0;
        #1;
        $display("Branch Target (rs1): rs1=%0d, off_v=%0d => res_brt_dma=%0d", rs1_d, off_v, res_brt_dma);

        // Test branch target calculation (pc base)
        pc_v = 32'd400; off_v = 32'd16; b_rs1_pc = 1'b1;
        #1;
        $display("Branch Target (pc): pc_v=%0d, off_v=%0d => res_brt_dma=%0d", pc_v, off_v, res_brt_dma);
        
        // Test ADDI (add immediate)
    rs1_d = 32'd10; imm_d = 32'd7; rs2i_d = imm_d; op_a = 4'b0000; sel_r = 2'b00;
    $display("\nTesting ADDI (Add Immediate)");
    #1;
    $display("ADDI: rs1=%0d, imm=%0d => res_d_op=%0d", rs1_d, imm_d, res_d_op);

    // Test ORI (or immediate)
    rs1_d = 32'hA5A5A5A5; imm_d = 32'h0000FFFF; rs2i_d = imm_d; op_l = 3'b110; sel_r = 2'b01;
    $display("\nTesting ORI (Or Immediate)");
    #1;
    $display("ORI: rs1=0x%h, imm=0x%h => res_d_op=0x%h", rs1_d, imm_d, res_d_op);

    // Test ANDI (and immediate)
    rs1_d = 32'hA5A5A5A5; imm_d = 32'h0000FFFF; rs2i_d = imm_d; op_l = 3'b111; sel_r = 2'b01;
    $display("\nTesting ANDI (And Immediate)");
    #1;
    $display("ANDI: rs1=0x%h, imm=0x%h => res_d_op=0x%h", rs1_d, imm_d, res_d_op);

    // Test SLLI (shift left logical immediate)
    rs1_d = 32'h00000001; imm_d = 32'd8; rs2i_d = imm_d; op_s = 4'b0001; sel_r = 2'b10;
    $display("\nTesting SLLI (Shift Left Logical Immediate)");
    #1;
    $display("SLLI: rs1=0x%h, shamt=%0d => res_d_op=0x%h", rs1_d, imm_d[4:0], res_d_op);
        
        $display("==== End of Testbench ====");
        $finish;
    end

endmodule
