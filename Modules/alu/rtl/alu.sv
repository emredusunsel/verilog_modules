
import alu_pkg::*;

module alu
(
    input   logic   [WIDTH-1:0] A_i,
    input   logic   [WIDTH-1:0] B_i,
    input   logic   [      3:0] ALUControl_i,
    output  logic               Z_o,            // Zero flag
    output  logic               C_o,            // Carry flag
    output  logic               N_o,            // Negative flag
    output  logic               OF_o,           // Overflow flag
    output  logic   [WIDTH-1:0] Result_o
);

    logic   [WIDTH:0]           temp;
    logic   [$clog2(WIDTH)-1:0] shamt;

    always_comb begin : alu
        C_o         = 0;
        OF_o        = 0;
        Result_o    = '0;
        temp        = '0;
        shamt       = B_i[$clog2(WIDTH)-1:0];
        case (ALUControl_i)
            ALU_ADD: begin
                temp        = {1'b0, A_i} + {1'b0, B_i};
                Result_o    = temp[WIDTH-1:0];
                C_o         = temp[WIDTH];
                OF_o        = (A_i[WIDTH-1] == B_i[WIDTH-1]) &&
                              (Result_o[WIDTH-1] != A_i[WIDTH-1]);
            end
            ALU_SUB: begin
                temp        = {1'b0, A_i} - {1'b0, B_i};
                Result_o    = temp[WIDTH-1:0];
                C_o         = ~temp[WIDTH];
                OF_o        = (A_i[WIDTH-1] != B_i[WIDTH-1]) &&
                              (Result_o[WIDTH-1] != A_i[WIDTH-1]);
            end
            ALU_AND:    Result_o    = A_i & B_i;
            ALU_OR:     Result_o    = A_i | B_i;
            ALU_XOR:    Result_o    = A_i ^ B_i;
            ALU_SLL:    Result_o    = A_i << shamt;         // same with SLA
            ALU_SRL:    Result_o    = A_i >> shamt;
            ALU_SRA:    Result_o    = $signed(A_i) >>> shamt;
            ALU_SLT: begin
                if ($signed(A_i) < $signed(B_i)) begin
                    Result_o[WIDTH-1:1] = '0;
                    Result_o[0]         = 1;
                end else begin
                    Result_o = '0;
                end
            end
            ALU_SLTU: begin
                if (A_i < B_i) begin
                    Result_o[WIDTH-1:1] = '0;
                    Result_o[0]         = 1;
                end else begin
                    Result_o = '0;
                end
            end
            default:    Result_o    = '0;                                       // default
        endcase
        Z_o     = (Result_o == 0) ? 1 : 0;
        N_o     = (Result_o[WIDTH-1] == 1) ? 1 : 0;
    end

endmodule
