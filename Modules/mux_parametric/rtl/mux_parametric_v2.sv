
module mux_parametric_v2
import mux_pkg::*;
(
    input   logic   [WIDTH-1:0]                     mux_i [N],
    input   logic   [(N <= 1) ? 1 : $clog2(N)-1:0]  sel_i,
    output  logic   [WIDTH-1:0]                     mux_o
);

    assign mux_o = (sel_i < N) ? mux_i[sel_i] : '0;

endmodule
