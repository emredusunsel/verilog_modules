
import fwft_fifo_pkg::*;

module tb_fwft_fifo;

    logic   clk_i, rst_ni, wr_en_i, rd_en_i;
    logic   [DATA_WIDTH-1:0]    data_i, data_o;
    logic   full_o, empty_o;

    fifo_buffer dut(
        .clk_i      (clk_i),
        .rst_ni     (rst_ni),
        .wr_en_i    (wr_en_i),
        .rd_en_i    (rd_en_i),
        .data_i     (data_i),
        .data_o     (data_o),
        .full_o     (full_o),
        .empty_o    (empty_o)
    );

    initial clk_i = 0;
    always #5 clk_i = ~clk_i;

    task automatic wrt(input int i);
        int j;
        begin
            for (j = 0; j < i; j = j + 1) begin
                wr_en_i = 1;
                data_i  = $urandom;
                @(posedge clk_i);
                wr_en_i = 0;
                @(posedge clk_i);
            end
        end
    endtask

    task automatic rd(input int k);
        int l;
        begin
            for (l = 0; l < k; l = l + 1) begin
                rd_en_i = 1;
                @(posedge clk_i);
                rd_en_i = 0;
                @(posedge clk_i);
            end
        end
    endtask

    initial begin
        rd_en_i = 0;
        wr_en_i = 0;
        rst_ni = 0;
        @(posedge clk_i);
        rst_ni = 1;
        wrt(5);
        rd(5);
        wrt(8);
        rd(2);
        wrt(4);
        rd(12);
        wrt(20);
        #50;
        $finish;
    end

endmodule
