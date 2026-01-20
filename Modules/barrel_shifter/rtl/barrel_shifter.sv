
module barrel_shifter #(
    parameter int WIDTH = 32
) (
    input   logic   [        WIDTH-1:0] data_i,
    input   logic   [$clog2(WIDTH)-1:0] shamt_i,
    input   logic   [              1:0] stype_i,
    output  logic   [        WIDTH-1:0] data_o
);


endmodule
