module stage_mem(
    input wire [`RegAddrBus]    rd_addr_i, 
    input wire                  rd_write_i,
    input wire [`RegBus]        rd_data_i, 

    output reg [`RegAddrBus]    rd_addr_o, //
    output reg                  rd_write_o, //
    output reg [`RegBus]        rd_data_o, //

    input wire  [`MemAddrBus]   mem_addr_i, 
    input wire  [`MemDataBus]   mem_data_i,
    input wire  [`OpBus]        op, 
    input wire  [`CatagoryBus]  catagory,

    output reg                  mem_read,
    output reg                  mem_write,
    output reg                  mem_signed,
    output reg  [`MemAddrBus]   mem_addr_o,
    output reg  [1 : 0]         mem_len_o
    input wire                  mem_r_data,
    output reg                  mem_w_data,
    input wire                  mem_done,    
    
    output reg  stall_o
);
    assign rd_addr_o = rd_addr_i;
    assign rd_write_o = rd_write_i;
    assign rd_load_o = rd_load_i;
    assign rd_data_o = catagory == `CatagoryLoad ? mem_r_data : rd_data_i;

    assign mem_addr_o = mem_addr_i;
    assign mem_signed = op[2];
    assign mem_len_o  = op[1 : 0];
    assign mem_w_data = mem_data_i;

    assign stall_o = !mem_done;

    always @ (*) begin
        case (catagory) begin
            `CatagoryLoad: begin
                mem_read <= `True;
                mem_write <= `False;
            end
            `CatagoryStore: begin
                mem_read <= `False;
                mem_write <= `True;
            end
            default: begin
                mem_read <= `False;
                mem_write <= `False;
            end
        end
    end    
endmodule