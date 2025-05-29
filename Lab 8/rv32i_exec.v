`timescale 1ns/1ps
module rv32i_ex1 (
    input  [31:0] rs1_d, rs2i_d, imm_d, pc_v, off_v,
    input  [3:0]  op_a, op_s,
    input  [2:0]  op_l,
    input  [1:0]  sel_r,
    input  [2:0]  bra_c,
    input         b_rs1_pc,
    output reg [31:0] res_d_op, res_brt_dma,
    output reg        res_bra
);

reg [32:0] res_d_op_a_33; // 33 bits for carry out in arithmetic
reg [31:0] res_d_op_a_32, res_d_op_l_32, res_d_op_s_32;

always @(*) begin
    // Default assignments for all outputs and internal regs
    res_d_op_a_33 = 33'b0;
    res_d_op_a_32 = 32'b0;
    res_d_op_l_32 = 32'b0;
    res_d_op_s_32 = 32'b0;
    res_d_op      = 32'b0;
    res_brt_dma   = 32'b0;
    res_bra       = 1'b0;

    // Arithmetic operations
    casez (op_a)
        4'b0000: begin // ADD
            res_d_op_a_33 = {1'b0, rs1_d} + {1'b0, rs2i_d};
            res_d_op_a_32 = res_d_op_a_33[31:0];
        end
        4'b1000: begin // SUB
            res_d_op_a_33 = {1'b0, rs1_d} - {1'b0, rs2i_d};
            res_d_op_a_32 = res_d_op_a_33[31:0];
        end
        4'b?010: begin // SLT (signed)
            res_d_op_a_33 = {1'b0, rs1_d} - {1'b0, rs2i_d};
            res_d_op_a_32 = {31'b0, res_d_op_a_33[32]};
        end
        4'b?011: begin // SLTU (unsigned)
            res_d_op_a_33 = {1'b0, rs1_d} - {1'b0, rs2i_d};
            res_d_op_a_32 = {31'b0, ~res_d_op_a_33[32]};
        end
        default: begin // Default ADD
            res_d_op_a_33 = {1'b0, rs1_d} + {1'b0, rs2i_d};
            res_d_op_a_32 = res_d_op_a_33[31:0];
        end
    endcase

    // Logical operations
    case (op_l)
        3'b100: res_d_op_l_32 = rs1_d ^ rs2i_d; // XOR
        3'b110: res_d_op_l_32 = rs1_d | rs2i_d; // OR
        3'b111: res_d_op_l_32 = rs1_d & rs2i_d; // AND
        default: res_d_op_l_32 = rs1_d ^ rs2i_d; // Default XOR
    endcase

    // Shift operations
    casez (op_s)
        4'b0001: res_d_op_s_32 = rs1_d << rs2i_d[4:0]; // SLL
        4'b0101: res_d_op_s_32 = rs1_d >> rs2i_d[4:0]; // SRL
        4'b1101: res_d_op_s_32 = $signed(rs1_d) >>> rs2i_d[4:0]; // SRA
        default: res_d_op_s_32 = rs1_d << rs2i_d[4:0]; // Default SLL
    endcase

    // Branch condition evaluation
    case (bra_c)
        3'b000: res_bra = (res_d_op_a_33[31:0] == 32'b0); // BEQ
        3'b001: res_bra = (res_d_op_a_33[31:0] != 32'b0); // BNE
        3'b100: res_bra = res_d_op_a_33[32];              // BLT
        3'b101: res_bra = ~res_d_op_a_33[32];             // BGE
        3'b110: res_bra = ~res_d_op_a_33[32];             // BLTU
        3'b111: res_bra = res_d_op_a_33[32];              // BGEU
        default: res_bra = 1'b0;
    endcase

    // Select result for data operation
    case (sel_r)
        2'b00: res_d_op = res_d_op_a_32;
        2'b01: res_d_op = res_d_op_l_32;
        2'b10: res_d_op = res_d_op_s_32;
        default: res_d_op = rs2i_d;
    endcase

    // Branch target or data memory address calculation
    case (b_rs1_pc)
        1'b0: res_brt_dma = rs1_d + off_v;
        1'b1: res_brt_dma = pc_v + off_v;
        default: res_brt_dma = rs1_d + off_v;
    endcase
end

endmodule
