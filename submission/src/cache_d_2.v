`include "config.v"
module cache_d(
    input wire clk,
    input wire rst,
    // stage_mem
    input wire                  sign_i,
    input wire [1 : 0]          len_i,
    input wire                  read_i,
    input wire                  write_i,
    input wire [`MemAddrBus]    addr_i,
    output reg  [`RegBus]       data_o,
    
    input wire [`RegBus]        data_i,
    output reg                  done_o,
    // ctrl_mem
    output reg                  sign_o,
    output reg                  read_o,
    output reg [2 : 0]          r_len_o,
    output reg [`MemAddrBus]    r_addr_o,
    input wire [`RegBus]       r_data_i,
    input wire                  r_done_i,
    input wire                  r_wait_i,

    output wire                 write_o,
    output reg  [2 : 0]          w_len_o,
    output wire [`MemAddrBus]   w_addr_o,
    output wire [`RegBus]       w_data_o,
    input wire                  w_wait_i,
    input wire                  w_done_i,
);

    reg [`DCacheSize - 1 : 0]            cache_valid;
    reg [`DCacheSize - 1 : 0]            cache_dirty;
    reg [`RegBus]   cache_data  [`DCacheSize - 1 : 0];
    reg [`DCacheTag] cache_tag   [`DCacheSize - 1 : 0];

    assign io_request = (read_i || write_i) && (addr_i[17 : 16] == 3);

    always @ (*) begin
        if (io_request) begin
            
        end else if (read_i) begin
            
        end else if (write_i) begin
            
        end
    end

    always @ (clk)


endmodule