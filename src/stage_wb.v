module stage_wb(
    input wire [`RegAddrBus]    rd_addr_i,
    input wire                  rd_write_i,
    input wire [`RegBus]        rd_data_i,

    output reg [`RegAddrBus]    rd_addr_o,
    output reg                  rd_write_o,
    output reg [`RegBus]        rd_data_o
);
    assign rd_addr_o = rd_addr_i;
    assign rd_data_o = rd_data_i;
    assign rd_write_o = rd_write_i;
endmodule