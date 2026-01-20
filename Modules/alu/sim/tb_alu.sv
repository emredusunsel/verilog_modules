
import alu_pkg::*;

module tb_alu;

    localparam int WIDTH = alu_pkg::WIDTH;

    logic               clk;

    logic   [WIDTH-1:0] A_i, B_i;
    logic   [      3:0] ALUControl_i;
    logic               Z_o, C_o, N_o, OF_o;
    logic   [WIDTH-1:0] Result_o;

    alu dut(
        .A_i            (A_i),
        .B_i            (B_i),
        .ALUControl_i   (ALUControl_i),
        .Z_o            (Z_o),
        .C_o            (C_o),
        .N_o            (N_o),
        .OF_o           (OF_o),
        .Result_o       (Result_o)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    logic   [WIDTH-1:0] exp_result;
    logic               exp_z;
    logic               exp_n;
    logic               exp_c;
    logic               exp_of;

    logic   [WIDTH:0] temp;

    task automatic golden_model;
        logic [$clog2(WIDTH)-1:0] shamt;
        begin
            exp_result  = '0;
            exp_c       = 1'bx;
            exp_of      = 1'bx;

            shamt = B_i[$clog2(WIDTH)-1:0];

            case (ALUControl_i)
                ALU_ADD: begin
                    temp        = {1'b0, A_i} + {1'b0, B_i};
                    exp_result  = temp[WIDTH-1:0];
                    exp_c       = temp[WIDTH];
                    exp_of      = (A_i[WIDTH-1] == B_i[WIDTH-1]) &&
                                  (exp_result[WIDTH-1] != A_i[WIDTH-1]);
                end

                ALU_SUB: begin
                    temp        = {1'b0, A_i} - {1'b0, B_i};
                    exp_result  = temp[WIDTH-1:0];
                    exp_c       = ~temp[WIDTH];
                    exp_of      = (A_i[WIDTH-1] != B_i[WIDTH-1]) &&
                                  (exp_result[WIDTH-1] != A_i[WIDTH-1]);
                end

                ALU_AND:  exp_result = A_i & B_i;
                ALU_OR:   exp_result = A_i | B_i;
                ALU_XOR:  exp_result = A_i ^ B_i;
                ALU_SLL:  exp_result = A_i << shamt;
                ALU_SRL:  exp_result = A_i >> shamt;
                ALU_SRA:  exp_result = $signed(A_i) >>> shamt;
                ALU_SLT:  exp_result = ($signed(A_i) < $signed(B_i));
                ALU_SLTU: exp_result = (A_i < B_i);

                default:  exp_result = '0;
            endcase

            exp_z = (exp_result == 0);
            exp_n = exp_result[WIDTH-1];
        end
    endtask

    task automatic check_result;
        begin
            if (Result_o !== exp_result)
                $error("RESULT MISMATCH | op=%0d A=%h B=%h exp=%h got=%h",
                        ALUControl_i, A_i, B_i, exp_result, Result_o);

            if (Z_o !== exp_z)
                $error("Z FLAG MISMATCH | exp=%0b got=%0b", exp_z, Z_o);

            if (N_o !== exp_n)
                $error("N FLAG MISMATCH | exp=%0b got=%0b", exp_n, N_o);

            if (exp_c !== 1'bx && C_o !== exp_c)
                $error("C FLAG MISMATCH | exp=%0b got=%0b", exp_c, C_o);

            if (exp_of !== 1'bx && OF_o !== exp_of)
                $error("OF FLAG MISMATCH | exp=%0b got=%0b", exp_of, OF_o);
        end
    endtask

    task automatic force_test;
    int i, j, k;
        begin
            for (i = 0; i < 256 ; i = i + 1) begin
                for (j = 0; j < 256; j = j + 1) begin
                    for (k = 0; k < 10; k = k + 1) begin
                        A_i = i;
                        B_i = j;
                        ALUControl_i = k;
                        golden_model();
                        @(posedge clk);
                        check_result();
                        @(posedge clk);
                    end
                end
            end
        end
    endtask

    covergroup alu_cov @(posedge clk);

        opcode_cp : coverpoint ALUControl_i;

        a_cp : coverpoint A_i {
            bins zero = {0};
            bins max  = {'1};
        }

        b_cp : coverpoint B_i {
            bins zero = {0};
            bins max  = {'1};
        }

        ovf_cp : coverpoint OF_o {
            bins hit = {1};
        }

        c_cp : coverpoint C_o {
            bins hit = {0, 1};
        }

        cross opcode_cp, c_cp {
            ignore_bins no_c_ops =
                binsof(opcode_cp) intersect {
                    ALU_AND, ALU_OR, ALU_XOR,
                    ALU_SLL, ALU_SRL, ALU_SRA,
                    ALU_SLT, ALU_SLTU
                };
        }

        cross opcode_cp, ovf_cp {
            ignore_bins no_ovf_ops =
                binsof(opcode_cp) intersect {
                    ALU_AND, ALU_OR, ALU_XOR,
                    ALU_SLL, ALU_SRL, ALU_SRA,
                    ALU_SLT, ALU_SLTU
                };
        }
        cross opcode_cp, a_cp;
        cross opcode_cp, b_cp;

    endgroup

    alu_cov cov = new();

    initial begin
        A_i = '0;
        B_i = '0;
        ALUControl_i = ALU_ADD;

        force_test();

        $display("Coverage = %0.2f %%", cov.get_coverage());
        $display("TEST PASSED");
        $finish;
    end

endmodule
