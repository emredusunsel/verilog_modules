
import alu_pipelined_pkg::*;

module tb_alu_pipelined;

    logic clk_i, rst_ni, valid_i;
    logic [WIDTH-1:0]   A_i, B_i;
    logic [3:0] ALUControl_i;
    logic Z_o, C_o, N_o, OF_o;
    logic [WIDTH-1:0] Result_o;
    logic valid_o;

    alu_pipelined dut(
        .clk_i (clk_i),
        .rst_ni (rst_ni),
        .valid_i (valid_i),
        .A_i (A_i),
        .B_i (B_i),
        .ALUControl_i (ALUControl_i),
        .valid_o (valid_o),
        .Result_o (Result_o),
        .Z_o (Z_o),
        .N_o (N_o),
        .C_o (C_o),
        .OF_o (OF_o)
    );

    initial clk_i = 0;
    always #5 clk_i = ~clk_i;

    initial begin
        valid_i = 1;
        rst_ni = 1;
        A_i = 8'h5;
        B_i = 8'h8;
        ALUControl_i = ALU_ADD;
        @(posedge clk_i);
        @(posedge clk_i);
        A_i = 8'h14;
        B_i = 8'h3;
        ALUControl_i = ALU_ADD;
        @(posedge clk_i);
        A_i = 8'h0;
        B_i = 8'h9;
        ALUControl_i = ALU_ADD;
        @(posedge clk_i);
        A_i = 8'h5;
        B_i = 8'h8;
        ALUControl_i = ALU_SUB;
        @(posedge clk_i);
        A_i = 8'h14;
        B_i = 8'h3;
        ALUControl_i = ALU_SUB;
        @(posedge clk_i);
        A_i = 8'h0;
        B_i = 8'h9;
        ALUControl_i = ALU_SUB;
        @(posedge clk_i);
        A_i = 8'h7;
        B_i = 8'h7;
        ALUControl_i = ALU_SUB;
        @(posedge clk_i);
        @(posedge clk_i);

        $finish;
    end

endmodule
