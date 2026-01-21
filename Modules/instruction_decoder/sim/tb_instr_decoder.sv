
import instr_decoder_pkg::*;

module tb_instr_decoder;

    logic   [31:0]  instr_i;
    logic           reg_write_en_o, branch_o;
    alu_op_e        alu_ctrl_o;

    instr_decoder dut (
        .instr_i        (instr_i),
        .reg_write_en_o (reg_write_en_o),
        .branch_o       (branch_o),
        .alu_ctrl_o     (alu_ctrl_o)
    );

    task automatic check_instr(
        input logic [31:0] instr,
        input alu_op_e exp_alu,
        input logic exp_reg_write,
        input logic exp_branch,
        input string name
    );
    begin
        instr_i = instr;
        #1;

        assert (alu_ctrl_o == exp_alu)
        else    $error("[%s] ALU CTRL FAIL: exp = %0d got = %0d",
                        name, exp_alu, alu_ctrl_o);

        assert (reg_write_en_o == exp_reg_write)
        else   $error("[%s] REG WRITE FAIL: exp = %0b got = %0b",
                        name, exp_reg_write, reg_write_en_o);

        assert (branch_o == exp_branch)
        else   $error("[%s] BRANCH FAIL: exp = %0b got = %0b",
                        name, exp_branch, branch_o);

        $display("PASS: %s", name);
    end
    endtask

    initial begin
        $display("---- Instruction Decoder TB START ----");

        // R-type ADD
        check_instr(
            {7'b0000000, 5'd0, 5'd0, 3'b000, 5'd0, 7'b00110011},
            ALU_ADD, 1'b1, 1'b0, "R-ADD"
        );

        // R-type SUB
        check_instr(
            {7'b0100000, 5'd0, 5'd0, 3'b000, 5'd0, 7'b0110011},
            ALU_SUB, 1'b1, 1'b0, "R-SUB"
        );

        // R-type AND
        check_instr(
            {7'b0000000, 5'd0, 5'd0, 3'b111, 5'd0, 7'b0110011},
            ALU_AND, 1'b1, 1'b0, "R-AND"
        );

        // I-type ADDI
        check_instr(
            {12'd5, 5'd0, 3'b000, 5'd0, 7'b0010011},
            ALU_ADD, 1'b1, 1'b0, "I-ADDI"
        );

        // I-type ORI
        check_instr(
            {12'd5, 5'd0, 3'b110, 5'd0, 7'b0010011},
            ALU_OR, 1'b1, 1'b0, "I-ORI"
        );

        // LOAD
        check_instr(
            {12'd0, 5'd0, 3'b010, 5'd0, 7'b0000011},
            ALU_NOP, 1'b1, 1'b0, "LOAD"
        );

        // STORE
        check_instr(
            {7'd0, 5'd0, 5'd0, 3'b010, 5'd0, 7'b0100011},
            ALU_NOP, 1'b0, 1'b0, "STORE"
        );

        // BRANCH (BEQ)
        check_instr(
            {7'd0, 5'd0, 5'd0, 3'b000, 5'd0, 7'b1100011},
            ALU_NOP, 1'b0, 1'b1, "BRANCH"
        );

        // ILLEGAL OPCODE
        check_instr(
            32'hFFFFFFFF,
            ALU_NOP, 1'b0, 1'b0, "ILLEGAL"
        );

        $display("---- ALL TESTS DONE ----");
        $finish;
    end

endmodule
