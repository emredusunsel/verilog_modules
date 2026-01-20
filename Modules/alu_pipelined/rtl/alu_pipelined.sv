
import alu_pipelined_pkg::*;

module alu_pipelined (
    input   logic               clk_i,
    input   logic               rst_ni,
    input   logic               valid_i,
    input   logic   [WIDTH-1:0] A_i,
    input   logic   [WIDTH-1:0] B_i,
    input   logic   [3:0]       ALUControl_i,
    output  logic               valid_o,
    output  logic   [WIDTH-1:0] Result_o,
    output  logic               Z_o,
    output  logic               N_o,
    output  logic               C_o,
    output  logic               OF_o
);

    logic [WIDTH-1:0]   A_r1, B_r1;
    logic [3:0]         ALUControl_r1;
    logic               valid_r1;

    logic [WIDTH-1:0]   Result_r2, Result_step;
    logic               Z_r2, Z_step;
    logic               N_r2, N_step;
    logic               C_r2, C_step;
    logic               OF_r2, OF_step;
    logic               valid_r2;

    always_ff @(posedge clk_i or negedge rst_ni) begin : stage1
        if (!rst_ni) begin
            valid_r1 <= 1'b0;
        end else begin
            A_r1            <= A_i;
            B_r1            <= B_i;
            ALUControl_r1   <= ALUControl_i;
            valid_r1        <= valid_i;
        end
    end

    alu alu (
        .A_i            (A_r1),
        .B_i            (B_r1),
        .ALUControl_i   (ALUControl_r1),
        .Z_o            (Z_step),
        .C_o            (C_step),
        .N_o            (N_step),
        .OF_o           (OF_step),
        .Result_o       (Result_step)
    );

    always_ff @(posedge clk_i or negedge rst_ni) begin : stage2
        if (!rst_ni) begin
            Result_r2   <= '0;
            Z_r2        <= 0;
            N_r2        <= 0;
            C_r2        <= 0;
            OF_r2       <= 0;
            valid_r2    <= 0;
        end else begin
            if (valid_r1) begin
                Result_r2   <= Result_step;
                Z_r2        <= Z_step;
                N_r2        <= N_step;
                C_r2        <= C_step;
                OF_r2       <= OF_step;
            end
            valid_r2 <= valid_r1;
        end
    end

    assign Result_o = Result_r2;
    assign Z_o      = Z_r2;
    assign N_o      = N_r2;
    assign C_o      = C_r2;
    assign OF_o     = OF_r2;
    assign valid_o  = valid_r2;

endmodule
