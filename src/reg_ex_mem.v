module reg_ex_mem(
    input wire clk,
    input wire rst,
    input wire [`StallBus] stall,

    input wire [`RegAddrBus]    rd_addr_i,
    input wire                  rd_write_i,
    input wire                  rd_load_i, 
    input wire [`RegBus]        rd_data_i, 

    output reg                  rd_load_o, //

    output reg [`RegAddrBus]    rd_addr_o1, //
    output reg                  rd_write_o1, //
    output reg [`RegBus]        rd_data_o1, //

    output reg [`RegAddrBus]    rd_addr_o2, //
    output reg                  rd_write_o2, //
    output reg [`RegBus]        rd_data_o2, //

    input wire [`MemAddrBus]    mem_addr_i, 
    input wire [`MemDataBus]    mem_data_i,
    input wire [`OpBus]         op_i,
    input wire [`CatagoryBus]   catagory_i,

    output reg [`MemAddrBus]    mem_addr_o, 
    output reg [`MemDataBus]    mem_data_o,
    output reg [`OpBus]         op_o,
    output reg [`CatagoryBus]   catagory_o,
);
    always @ (posedge clk or posedge rst) begin
        if (rst || stall == `Bubb) begin
            rd_load_o <= 0;
            rd_addr_o1 <= 0;
            rd_write_o1 <= 0;
            rd_data_o1 <= 0;
            rd_addr_o2 <= 0;
            rd_write_o2 <= 0;
            rd_data_o2 <= 0;
            mem_addr_o <= 0;
            mem_data_o <= 0;
            op_o <= 0;
            catagory_o <= 0;
        end else if (stall == `Pass) begin
            rd_load_o <= rd_load_i;
            rd_addr_o1 <= rd_addr_i;
            rd_write_o1 <= rd_write_i;
            rd_data_o1 <= rd_data_i;
            rd_addr_o2 <= rd_addr_i;
            rd_write_o2 <= rd_write_i;
            rd_data_o2 <= rd_data_i;
            mem_addr_o <= mem_addr_i;
            mem_data_o <= mem_data_i;
            op_o <= op_i;
            catagory_o <= catagory_i;
        end else if (stall == `Hold) begin
            
        end
    end

endmodule