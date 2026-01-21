
import instr_decoder_pkg::*;

module instr_decoder (
    input   logic   [31:0]          instr_i,
    output  logic                   reg_write_en_o,
    output  logic                   branch_o,
    output  alu_op_e                alu_ctrl_o
);

    logic   [6:0]   opcode;
        // 0110011 R-type register-register ALU
        // 0010011 I-type immediate ALU
        // 1100011 B-type branch
        // 0000011 I-type load (lite)
        // 0100011 S-type store (lite)
    logic   [2:0]   funct3;
    logic   [6:0]   funct7;
        // 0000 ADD
        // 0001 SUB
        // 0010 AND
        // 0011 OR
        // 0100 XOR
        // 0101 SLT
        // 0110 SLL
        // 0111 SRL

    always_comb begin : alu_op_signal
        alu_ctrl_o = ALU_NOP;

        unique case (opcode)
            7'b0110011: begin   // R-type
                unique case (funct3)
                    3'b000: alu_ctrl_o = (funct7 == 7'b0100000) ? ALU_SUB : ALU_ADD;
                    3'b111: alu_ctrl_o = ALU_AND;
                    3'b110: alu_ctrl_o = ALU_OR;
                    3'b100: alu_ctrl_o = ALU_XOR;
                    3'b010: alu_ctrl_o = ALU_SLT;
                    3'b001: alu_ctrl_o = ALU_SLL;
                    3'b101: alu_ctrl_o = ALU_SRL;
                    default: alu_ctrl_o = ALU_NOP;
                endcase
            end

            7'b0010011: begin   // I-type
                unique case (funct3)
                    3'b000: alu_ctrl_o = ALU_ADD;
                    3'b111: alu_ctrl_o = ALU_AND;
                    3'b110: alu_ctrl_o = ALU_OR;
                    3'b100: alu_ctrl_o = ALU_XOR;
                    3'b010: alu_ctrl_o = ALU_SLT;
                    3'b001: alu_ctrl_o = ALU_SLL;
                    3'b101: alu_ctrl_o = ALU_SRL;
                    default: alu_ctrl_o = ALU_NOP;
                endcase
            end
        endcase
    end

    assign opcode           = instr_i[6:0];
    assign funct3           = instr_i[14:12];
    assign funct7           = instr_i[31:25];
    assign reg_write_en_o   = ( opcode == 7'b0110011 ||
                                opcode == 7'b0010011 ||
                                opcode == 7'b0000011) ? 1 : 0;
    assign branch_o         = ( opcode == 7'b1100011) ? 1 : 0;

endmodule
