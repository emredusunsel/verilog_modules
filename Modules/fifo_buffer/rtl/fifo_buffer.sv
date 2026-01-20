
import fifo_buffer_pkg::*;

module fifo_buffer (
    input   logic                       clk_i,
    input   logic                       rst_ni,
    input   logic                       wr_en_i,
    input   logic                       rd_en_i,
    input   logic   [DATA_WIDTH-1:0]    data_i,
    output  logic   [DATA_WIDTH-1:0]    data_o,
    output  logic                       full_o,
    output  logic                       empty_o
);

    logic   [DATA_WIDTH-1:0]        mem [DEPTH];
    logic   [$clog2(DEPTH)-1:0]     wr_ptr;
    logic   [$clog2(DEPTH)-1:0]     rd_ptr;
    logic   [$clog2(DEPTH+1)-1:0]   counter;

    always_ff @(posedge clk_i or negedge rst_ni) begin : fifo
        if (!rst_ni) begin
            data_o  <= '0;
            wr_ptr  <= '0;
            rd_ptr  <= '0;
            counter <= '0;
        end else begin
            case ({wr_en_i && !full_o, rd_en_i && !empty_o})

                2'b10 : begin   // write only
                    mem[wr_ptr] <= data_i;
                    wr_ptr      <= wr_ptr + 1;
                    counter     <= counter + 1;
                end

                2'b01: begin    // read only
                    data_o  <= mem[rd_ptr];
                    rd_ptr  <= rd_ptr + 1;
                    counter <= counter - 1;
                end

                2'b11: begin    // write & read
                    mem[wr_ptr] <= data_i;
                    data_o      <= mem[rd_ptr];
                    wr_ptr      <= wr_ptr + 1;
                    rd_ptr      <= rd_ptr + 1;
                end
                default: ;
            endcase
        end
    end

    assign  empty_o = (counter == 0);
    assign  full_o  = (counter == DEPTH);

endmodule
