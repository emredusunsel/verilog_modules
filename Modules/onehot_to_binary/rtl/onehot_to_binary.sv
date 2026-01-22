
import onehot_to_binary_pkg::*;

module onehot_to_binary (
    input   logic   [STATE_W-1:0]   onehot_i,
    output  logic   [BIN_W-1:0]     bin_o,
    output  logic                   valid_o
);

    integer i;

    always_comb begin : chk
        bin_o   = '0;

        for (i = 0; i < STATE_W; i = i + 1) begin
            if (onehot_i[i]) begin
                    bin_o = i;
            end
        end
    end

    assign valid_o = (onehot_i != 0) && ((onehot_i & (onehot_i - 1)) == 0);

endmodule
