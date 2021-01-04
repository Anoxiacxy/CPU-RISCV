module reg_mem_wb(
    input wire clk,
    input wire rst,
    input wire [`StallBus] stall,

    input wire [`RegAddrBus]    rd_addr_i, //
    input wire                  rd_write_i, //
    input wire [`RegBus]        rd_data_i, //

    output reg [`RegAddrBus]    rd_addr_o, //
    output reg                  rd_write_o, //
    output reg [`RegBus]        rd_data_o, //
);

    always @ (posedge clk or posedge rst) begin
        if (rst || stall == `Bubb) begin
            rd_addr_o <= 0;
            rd_data_o <= 0;
            rd_write_o <= 0;
        end else if (stall == `Pass) begin
            rd_addr_o <= rd_addr_i;
            rd_data_o <= rd_data_i;
            rd_write_o <= rd_write_i;
        end else if (stall == `Hold) begin
            
        end
    end

endmodule