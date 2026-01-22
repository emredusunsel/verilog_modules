
import comparator_pkg::*;

module tb_comparator;

    logic   [WIDTH-1:0] A_i, B_i;
    logic               signed_i;
    logic               eq_o, ne_o, gt_o, lt_o, ge_o, le_o;

    comparator dut (
        .A_i        (A_i),
        .B_i        (B_i),
        .signed_i   (signed_i),
        .eq_o       (eq_o),
        .ne_o       (ne_o),
        .gt_o       (gt_o),
        .lt_o       (lt_o),
        .ge_o       (ge_o),
        .le_o       (le_o)
    );

    initial begin
        signed_i = 1;
        A_i = 45;
        B_i = 45;
        #1;
        A_i = 56;
        B_i = 45;
        #1;
        A_i = 36;
        B_i = 45;
        #1;
        A_i = -45;
        B_i = 45;
        #1;
        signed_i = 0;
        #1;
        $finish;
    end

endmodule
