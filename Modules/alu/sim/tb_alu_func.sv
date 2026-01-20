
import alu_pkg::*;

module tb_alu_func;

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

    logic [WIDTH-1:0] exp_result;
    logic exp_z;
    logic exp_n;
    logic exp_c;
    logic exp_of;

    logic [WIDTH:0] temp;

    task automatic golden_model;
        logic [$clog2(WIDTH)-1:0] shamt;
        begin
            exp_result = '0;
            exp_c = 0;
            exp_of = 0;

            shamt = B_i[$clog2(WIDTH)-1:0];

            case (ALUControl_i)
                ALU_AND:  exp_result = A_i & B_i;
                ALU_OR:   exp_result = A_i | B_i;
                ALU_XOR:  exp_result = A_i ^ B_i;
                ALU_SLL:  exp_result = A_i << shamt;
                ALU_SRL:  exp_result = A_i >> shamt;
                ALU_SRA:  exp_result = $signed(A_i) >>> shamt;
                ALU_SLT:  exp_result = ($signed(A_i) < $signed(B_i));
                ALU_SLTU: exp_result = (A_i < B_i);

                default: exp_result = '0;
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
        end
    endtask

    task automatic force_test;
    int i, j, k;
        begin
            for (i = 0; i < 256 ; i = i + 1) begin
                for (j = 0; j < 256; j = j + 1) begin
                    for (k = 2; k < 10; k = k + 1) begin
                        A_i = i;
                        B_i = j;
                        ALUControl_i = k;
                        @(posedge clk);
                        golden_model();
                        @(posedge clk);
                        check_result();
                    end
                end
            end
        end
    endtask

    covergroup alu_cov @(posedge clk);

    opcode_cp : coverpoint ALUControl_i {
            bins hit = {2, 3, 4, 5, 6, 7, 8, 9};
        }

    a_cp : coverpoint A_i {
        bins zero = {0};
        bins max = {'1};
    }

    b_cp : coverpoint B_i {
            bins zero = {0};
            bins max  = {'1};
    }

    z_cp : coverpoint Z_o {
        bins hit = {0, 1};
    }

    n_cp : coverpoint N_o {
        bins hit = {0, 1};
    }

    endgroup

    alu_cov cov = new();

    initial begin
        A_i = '0;
        B_i = '0;
        ALUControl_i = ALU_AND;

        force_test();
        $display("Coverage = %0.2f %%", cov.get_coverage());
        $display("TEST PASSED");
        $finish;
    end

endmodule
