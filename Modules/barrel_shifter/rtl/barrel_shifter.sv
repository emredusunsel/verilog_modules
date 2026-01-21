
import barrel_shifter_pkg::*;

module barrel_shifter (
    input   logic   [WIDTH-1:0]         data_i,
    input   logic   [$clog2(WIDTH)-1:0] shamt_i,
    input   logic                       dir_i,      // 0: left, 1: right
    input   logic                       arith_i,    // 0: logical, 1: arithmetic
    output  logic   [WIDTH-1:0]         data_o
);

    logic   [WIDTH-1:0] stage   [$clog2(WIDTH)];

    genvar i;
    for (i = 0; i < $clog2(WIDTH); i = i + 1) begin : gen_shift
        if (i == 0) begin : gen_init
            assign stage[i] = shamt_i[i] ? (data_i << 2*i) : data_i;
        end else begin : gen_step
            assign stage[i] = shamt_i[i] ? (stage[i-1] << 2*i) : stage[i-1];
        end
    end

    assign data_o = stage[$clog2(WIDTH)];

endmodule
