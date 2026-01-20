
import register_file_pkg::*;

module tb_register_file;

    logic   clk_i, rst_ni, we_i;
    logic   [ADDR_WIDTH-1:0]    waddr_i;
    logic   [DATA_WIDTH-1:0]    wdata_i;
    logic   [ADDR_WIDTH-1:0]    raddr1_i, raddr2_i;
    logic   [DATA_WIDTH-1:0]    rdata1_o, rdata2_o;

    register_file dut(
        .clk_i      (clk_i),
        .rst_ni     (rst_ni),
        .we_i       (we_i),
        .waddr_i    (waddr_i),
        .wdata_i    (wdata_i),
        .raddr1_i   (raddr1_i),
        .raddr2_i   (raddr2_i),
        .rdata1_o   (rdata1_o),
        .rdata2_o   (rdata2_o)
    );

    initial clk_i = 0;
    always #5 clk_i = ~clk_i;

    task automatic fill;
        int i;
        begin
            we_i = 1;
            for (i = 0; i < REG_COUNT; i = i + 1) begin
                waddr_i = i;
                wdata_i = i + 1;
                @(posedge clk_i);
            end
            we_i = 0;
        end
    endtask

    task automatic read1;
        int j;
        begin
            for (j = 0; j < REG_COUNT; j = j + 1) begin
                raddr1_i = j;
                @(posedge clk_i);
            end
        end
    endtask

    task automatic read2;
        int k;
        begin
            for (k = 0; k < REG_COUNT; k = k + 1) begin
                raddr2_i = k;
                @(posedge clk_i);
            end
        end
    endtask

    initial begin
        rst_ni = 1;
        fill();
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        read1();
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        read2();
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        @(posedge clk_i);
        rst_ni = 0;
        @(posedge clk_i);
        rst_ni = 1;
        @(posedge clk_i);
        @(posedge clk_i);
        $finish;
    end

endmodule
