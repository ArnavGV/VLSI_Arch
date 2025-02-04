module shifter_32 (
    input  [31:0] a,      // operand
    input  [4:0]  b,      // shift amount
    input  [1:0]  c,      // shift type
    output reg [31:0] z   // shifted result
);

    // Intermediate results of cascaded shift stages 
    reg [31:0] z4, z3, z2, z1;
    // Mux controls for the 5 stages of 4:1 muxes
    reg [1:0] sel4, sel3, sel2, sel1, sel0;

    always @ (a, b, c) begin
        // Set up control signals (sel4, sel3, sel2, sel1, sel0) for the five stages 
        // of 4:1 muxes based on the shift type and the shift amount to be performed by each stage

        // Stage 4 control signals (operates on a shift of 16 or 0 bits)
        casex ({c, b[4]})
            3'bxx0: sel4 = 2'b11;
            3'b0x1: sel4 = 2'b10;
            3'b111: sel4 = 2'b01;
            3'b101: sel4 = 2'b00;
            default: sel4 = 2'b11;  // Default assignment (optional)
        endcase 

        // Stage 3 control signals (operates on a shift of 8 or 0 bits)
        casex ({c, b[3]})
            3'bxx0: sel3 = 2'b11;
            3'b0x1: sel3 = 2'b10;
            3'b111: sel3 = 2'b01;
            3'b101: sel3 = 2'b00;
            default: sel3 = 2'b11;
        endcase

        // Stage 2 control signals (operates on a shift of 4 or 0 bits)
        casex ({c, b[2]})
            3'bxx0: sel2 = 2'b11;
            3'b0x1: sel2 = 2'b10;
            3'b111: sel2 = 2'b01;
            3'b101: sel2 = 2'b00;
            default: sel2 = 2'b11;
        endcase

        // Stage 1 control signals (operates on a shift of 2 or 0 bits)
        casex ({c, b[1]})
            3'bxx0: sel1 = 2'b11;
            3'b0x1: sel1 = 2'b10;
            3'b111: sel1 = 2'b01;
            3'b101: sel1 = 2'b00;
            default: sel1 = 2'b11;
        endcase

        // Stage 0 control signals (operates on a shift of 1 or 0 bits)
        casex ({c, b[0]})
            3'bxx0: sel0 = 2'b11;
            3'b0x1: sel0 = 2'b10;
            3'b111: sel0 = 2'b01;
            3'b101: sel0 = 2'b00;
            default: sel0 = 2'b11;
        endcase

        // Shift stage 4: performs 16/0-bit shift of the specified type on the input
        case (sel4)
            2'b11: z4 = a;
            2'b10: z4 = {a[15:0], {16{1'b0}}};
            2'b01: z4 = {{16{a[31]}}, a[31:16]};
            2'b00: z4 = {{16{1'b0}}, a[31:16]};
            default: z4 = a;
        endcase

        // Shift stage 3: performs 8/0-bit shift of the specified type on its input
        case (sel3)
            2'b11: z3 = z4;
            2'b10: z3 = {z4[23:0], {8{1'b0}}};
            2'b01: z3 = {{8{z4[31]}}, z4[31:8]};
            2'b00: z3 = {{8{1'b0}}, z4[31:8]};
            default: z3 = z4;
        endcase

        // Shift stage 2: performs 4/0-bit shift of the specified type on its input
        case (sel2)
            2'b11: z2 = z3;
            2'b10: z2 = {z3[27:0], {4{1'b0}}};
            2'b01: z2 = {{4{z3[31]}}, z3[31:4]};
            2'b00: z2 = {{4{1'b0}}, z3[31:4]};  // Fixed: previously assigned to z3 by mistake
            default: z2 = z3;
        endcase

        // Shift stage 1: performs 2/0-bit shift of the specified type on its input
        case (sel1)
            2'b11: z1 = z2;
            2'b10: z1 = {z2[29:0], {2{1'b0}}};
            2'b01: z1 = {{2{z2[31]}}, z2[31:2]};
            2'b00: z1 = {{2{1'b0}}, z2[31:2]};
            default: z1 = z2;
        endcase

        // Shift stage 0: performs 1/0-bit shift of the specified type on its input
        case (sel0)
            2'b11: z = z1;
            2'b10: z = {z1[30:0], 1'b0};
            2'b01: z = {z1[31], z1[31:1]};
            2'b00: z = {1'b0, z1[31:1]};
            default: z = z1;
        endcase
    end

endmodule
