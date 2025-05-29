`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2025 17:47:52
// Design Name: 
// Module Name: rv32i_mem
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


module rv32i_mem_stage (
    input  [31:0] dm_adr,      // data memory address (little endian)
    input  [1:0]  access_sz,   // access size: 00=byte, 01=half, 10=word
    input         s_us,        // signed (0) / unsigned (1) load
    input  [31:0] sd_32,       // store data (from rs2)
    input  [1:0]  acc_type,    // 01=load, 10=store, else no access
    output reg [31:0] ld_32    // loaded data to rd
);

    reg [31:0] mem_d [0:255]; // 256 words (1024 bytes)

    // Initialize memory (for simulation)
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1)
            mem_d[i] = 32'h0;
    end

    // LOAD function
    function automatic [31:0] mem_d_load;
        input [31:0] mem_data_byte_adr;
        input [1:0]  data_size;
        input        s_us;
        reg [7:0] w1b3, w1b2, w1b1, w1b0, w2b3, w2b2, w2b1, w2b0;
        reg [1:0] boff;
        reg [31:0] w1, w2;
    begin
        boff = mem_data_byte_adr[1:0];
        w1 = mem_d[mem_data_byte_adr[31:2]];
        w2 = mem_d[mem_data_byte_adr[31:2] + 1];
        {w1b3, w1b2, w1b1, w1b0} = w1;
        {w2b3, w2b2, w2b1, w2b0} = w2;
        case (data_size)
            2'b00: // LB/LBU
                case (boff)
                    2'b00: mem_d_load = s_us ? {24'b0, w1b0} : {{24{w1b0[7]}}, w1b0};
                    2'b01: mem_d_load = s_us ? {24'b0, w1b1} : {{24{w1b1[7]}}, w1b1};
                    2'b10: mem_d_load = s_us ? {24'b0, w1b2} : {{24{w1b2[7]}}, w1b2};
                    2'b11: mem_d_load = s_us ? {24'b0, w1b3} : {{24{w1b3[7]}}, w1b3};
                endcase
            2'b01: // LH/LHU
                case (boff)
                    2'b00: mem_d_load = s_us ? {16'b0, w1b1, w1b0} : {{16{w1b1[7]}}, w1b1, w1b0};
                    2'b01: mem_d_load = s_us ? {16'b0, w1b2, w1b1} : {{16{w1b2[7]}}, w1b2, w1b1};
                    2'b10: mem_d_load = s_us ? {16'b0, w1b3, w1b2} : {{16{w1b3[7]}}, w1b3, w1b2};
                    2'b11: mem_d_load = s_us ? {16'b0, w2b0, w1b3} : {{16{w2b0[7]}}, w2b0, w1b3};
                endcase
            2'b10: // LW
                case (boff)
                    2'b00: mem_d_load = {w1b3, w1b2, w1b1, w1b0};
                    2'b01: mem_d_load = {w2b0, w1b3, w1b2, w1b1};
                    2'b10: mem_d_load = {w2b1, w2b0, w1b3, w1b2};
                    2'b11: mem_d_load = {w2b2, w2b1, w2b0, w1b3};
                endcase
            default: begin
                $display("Illegal data size in %m");
                mem_d_load = 32'b0;
            end
        endcase
    end
    endfunction

    // STORE function
    task automatic mem_d_store;
        input [31:0] mem_data_byte_adr;
        input [31:0] data_value_32_bit;
        input [1:0]  data_size;
        reg [1:0] boff;
    begin
        boff = mem_data_byte_adr[1:0];
        case (data_size)
            2'b00: // SB
                case (boff)
                    2'b00: mem_d[mem_data_byte_adr[31:2]][7:0]   = data_value_32_bit[7:0];
                    2'b01: mem_d[mem_data_byte_adr[31:2]][15:8]  = data_value_32_bit[7:0];
                    2'b10: mem_d[mem_data_byte_adr[31:2]][23:16] = data_value_32_bit[7:0];
                    2'b11: mem_d[mem_data_byte_adr[31:2]][31:24] = data_value_32_bit[7:0];
                endcase
            2'b01: // SH
                case (boff)
                    2'b00: mem_d[mem_data_byte_adr[31:2]][15:0]   = data_value_32_bit[15:0];
                    2'b01: mem_d[mem_data_byte_adr[31:2]][23:8]   = data_value_32_bit[15:0];
                    2'b10: mem_d[mem_data_byte_adr[31:2]][31:16]  = data_value_32_bit[15:0];
                    2'b11: begin
                        mem_d[mem_data_byte_adr[31:2]][31:24]      = data_value_32_bit[7:0];
                        mem_d[mem_data_byte_adr[31:2]+1][7:0]      = data_value_32_bit[15:8];
                    end
                endcase
            2'b10: // SW
                case (boff)
                    2'b00: mem_d[mem_data_byte_adr[31:2]]        = data_value_32_bit;
                    2'b01: begin
                        mem_d[mem_data_byte_adr[31:2]][31:8]      = data_value_32_bit[23:0];
                        mem_d[mem_data_byte_adr[31:2]+1][7:0]     = data_value_32_bit[31:24];
                    end
                    2'b10: begin
                        mem_d[mem_data_byte_adr[31:2]][31:16]     = data_value_32_bit[15:0];
                        mem_d[mem_data_byte_adr[31:2]+1][15:0]    = data_value_32_bit[31:16];
                    end
                    2'b11: begin
                        mem_d[mem_data_byte_adr[31:2]][31:24]     = data_value_32_bit[7:0];
                        mem_d[mem_data_byte_adr[31:2]+1][23:0]    = data_value_32_bit[31:8];
                    end
                endcase
            default: $display("Illegal data size in %m");
        endcase
    end
    endtask

    // Main MEM stage logic
    always @(*) begin
        case (acc_type)
            2'b01: ld_32 = mem_d_load(dm_adr, access_sz, s_us);
            2'b10: begin
                mem_d_store(dm_adr, sd_32, access_sz);
                ld_32 = 32'b0;
            end
            default: begin
                $display("Illegal access type in %m");
                ld_32 = 32'b0;
            end
        endcase
    end

endmodule
