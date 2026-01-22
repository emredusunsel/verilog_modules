
import comparator_pkg::*;

module comparator (
    input   logic   [WIDTH-1:0] A_i,
    input   logic   [WIDTH-1:0] B_i,
    input   logic               signed_i,   // 0:unsigned, 1:signed
    output  logic               eq_o,       // ==
    output  logic               ne_o,       // !=
    output  logic               gt_o,       // >
    output  logic               lt_o,       // <
    output  logic               ge_o,       // >=
    output  logic               le_o        // <=
);

    logic equal, greater, less;

    always_comb begin : comp
        equal = 0;
        greater = 0;
        less = 0;

        if (!signed_i) begin
            if (A_i == B_i)
                equal   = 1;
            else if (A_i > B_i)
                greater = 1;
            else if (A_i < B_i)
                less    = 1;
        end else begin
            if ($signed(A_i) == $signed(B_i))
                equal   = 1;
            else if ($signed(A_i) > $signed(B_i))
                greater = 1;
            else if ($signed(A_i) < $signed(B_i))
                less    = 1;
        end
    end

    assign eq_o = equal;
    assign ne_o = ~equal;
    assign gt_o = greater;
    assign lt_o = less;
    assign ge_o = greater   | equal;
    assign le_o = less      | equal;

endmodule
