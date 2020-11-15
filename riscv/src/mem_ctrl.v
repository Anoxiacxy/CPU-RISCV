module mem_ctrl (
    input wire clk,
    input wire rst,
    
    input wire                  inst_read,
    input wire [`MemAddrBus]    inst_addr,
    output reg                  inst_done,
    output reg [`MemDataBus]    inst_data,

    input wire                  mem_read,
    input wire                  mem_write,
    input wire                  mem_signed,
    input wire [`MemAddrBus]    mem_addr,
    input wire [1 : 0]          mem_len, 
    output reg [`MemDataBus]    mem_r_data,
    input wire [`MemDataBus]    mem_w_data,
    output reg                  mem_done,

    output reg                  ram_r_w,
    output reg [`RamAddrBus]    ram_addr,
    output reg [`ByteBus]       ram_w_data,
    input wire [`ByteBus]       ram_r_data
);

    reg [1 : 0]                 working_stage;
    reg [1 : 0]                 working_type;
    reg [`RamAddrBus]           ahead_addr;
    reg [`MemDataBus]           mem_ret[2 : 0];

    reg [`ByteBus]              cache[`CacheSize];


    always @ (*) begin
        working_type = 


        if (working_type == `INST) begin
            ram_addr = inst_addr + working_stage;
        end else if (working_type == `MEMR) begin
            ram_addr = mem_addr + working_stage;
        end else if (working_type == `MEMW) begin
            ram_addr = mem_addr + working_stage;
        end else begin // ahead
            ram_addr = ahead_addr + working_stage;
        end
    end

    always @ (posedge clk) begin
        if (rst) begin
            mem_done <= `True;
            mem_r_data <= `ZERO;
            ram_r_w <= `False;
            ram_addr <= `ZERO;
            ram_w_data <= `ZERO;
        end else if (working_type == `INST) begin
            if ()

        end else if (working_type == `MEMR) begin
            if () begin // TODO cache

            end else if (working_stage == mem_len) begin
                mem_done <= `True;
                case (mem_len) begin
                    0 : mem_r_data <= {{24{mem_signed && ram_r_data[7]}}, ram_r_data};
                    1 : mem_r_data <= {{16{mem_signed && ram_r_data[7]}}, ram_r_data, mem_ret[0]};
                    3 : mem_r_data <= {ram_r_data, mem_ret[2], mem_ret[1], mem_ret[0]};
                end
                working_stage <= 0;
            end else begin
                mem_done <= `False;
                mem_ret[working_stage] <= ram_r_data;
                working_stage <= working_stage + 1;
            end
        end else if (working_type == `MEMW) begin
            
        end else begin // ahead
            
        end
    end

endmodule
