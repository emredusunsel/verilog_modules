
module full_adder (
    input           in1_i,
    input           in2_i,
    input           c_i,
    output  logic   s_o,
    output  logic   c_o
);

    assign s_o = (in1_i ^ in2_i) ^ (c_i);
    assign c_o = (in1_i & in2_i) | ((in1_i ^ in2_i) & c_i);

endmodule
