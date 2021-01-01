 module ctrl_ram (
    input wire                  inst_read,
    input wire [`MemAddrBus]    inst_addr,    
    output reg [`ByteBus]       inst_data,
    output reg                  inst_done;

    input wire                  io_buffer_full,
    input wire                  mem_read,
    input wire                  mem_write,
    input wire [`MemAddrBus]    mem_addr,
    output reg [`ByteBus]       mem_r_data,
    input wire [`ByteBus]       mem_w_data,
    output reg                  mem_done

    output reg                  ram_r_w,
    output reg [`RamAddrBus]    ram_addr,
    output reg [`ByteBus]       ram_w_data,
    input wire [`ByteBus]       ram_r_data
);

    assign inst_data = ram_r_data;
    assign mem_r_data= ram_r_data;
    assign ram_w_data = mem_w_data;

    always @ (*) begin
        if (mem_write) begin 
            ram_r_w <= 0;
        end else if (mem_read || inst_read) begin
            ram_addr <= 1;
        end
    end

    always @ (*) begin
        if (mem_read || mem_write) begin 
            ram_addr <= mem_addr;
            if (io_buffer_full)
                mem_done <= `False;
            else 
                mem_done <= `True;
            inst_done <= `False;
        end else if (inst_read) begin
            ram_addr <= inst_addr;
            mem_done <= `False;
            if (io_buffer_full)
                inst_done <= `False;
            else 
                inst_done <= `True;
        end
    end

endmodule
