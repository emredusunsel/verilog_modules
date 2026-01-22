
import onehot_to_binary_pkg::*;

module tb_onehot_to_binary;

    logic   [STATE_W-1:0]   onehot_i;
    logic   [BIN_W-1:0]     bin_o;
    logic                   valid_o;

    onehot_to_binary dut (
        .onehot_i   (onehot_i),
        .bin_o      (bin_o),
        .valid_o    (valid_o)
    );

    initial begin
        onehot_i = 8'b00100000;
        #10;
        onehot_i = 8'b10000000;
        #10;
        onehot_i = 8'b11111111;
        #10;
        $finish;
    end

endmodule
