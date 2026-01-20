
import register_file_pkg::*;

module register_file (
    input   logic                       clk_i,
    input   logic                       rst_ni,
    input   logic                       we_i,
    input   logic   [ADDR_WIDTH-1:0]    waddr_i,
    input   logic   [DATA_WIDTH-1:0]    wdata_i,
    input   logic   [ADDR_WIDTH-1:0]    raddr1_i,
    input   logic   [ADDR_WIDTH-1:0]    raddr2_i,
    output  logic   [DATA_WIDTH-1:0]    rdata1_o,
    output  logic   [DATA_WIDTH-1:0]    rdata2_o
);

    logic   [DATA_WIDTH-1:0] rx  [REG_COUNT];
    int i;

    always_ff @(posedge clk_i or negedge rst_ni) begin : write
        rx[0] <= '0;
        if (!rst_ni) begin
            for (i = 0; i < REG_COUNT; i = i + 1) begin
                rx[i] <= 0;
            end
        end else begin
            if ((we_i == 1) && (waddr_i != 0)) begin
                rx[waddr_i] <= wdata_i;
            end
        end
    end

    always_comb begin : read
        // Read Port 1
        if ((we_i == 1) && (waddr_i != 0) && (waddr_i == raddr1_i)) begin
            rdata1_o = wdata_i;
        end else begin
            rdata1_o = rx[raddr1_i];
        end
        // Read Port 2
        if ((we_i == 1) && (waddr_i != 0) && (waddr_i == raddr2_i)) begin
            rdata2_o = wdata_i;
        end else begin
            rdata2_o = rx[raddr2_i];
        end
    end

endmodule
