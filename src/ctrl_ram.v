 module ctrl_ram (
    input wire clk,
    input wire rst,
    
    input wire                  icache_hit,
    input wire                  dcache_hit,

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
    reg [2 : 0]         working_len;
    reg [2 : 0]         working_stage;
    reg [1 : 0]         working_type;
    reg [`MemAddrBus]   ahead_addr;
    reg [`MemAddrBus]   cur_addr;
    reg [`ByteBus]      working_r_buffer[3 : 0];
    reg [`ByteBus]      working_w_buffer[3 : 0];

    assign {working_w_buffer[3], working_w_buffer[2], 
            working_w_buffer[1], working_w_buffer[1]} = mem_w_data;

    assign ram_w_data = working_w_buffer[working_stage];
    assign ram_addr = cur_addr + working_stage;
    
    always @ (posedge clk) begin
        case (working_type) begin
            `RamAval: begin
                if (mem_write) begin
                    working_len = 1 << mem_len;
                    working_type = `RamMemw;
                    working_stage = 0;
                end else if (mem_read) begin
                    working_len = 1 << mem_len;
                    working_type = `RamMemr;
                    working_stage = 0;
                end else if (inst_read) begin
                    working_len = 4;
                    working_type = `RamInst;
                    working_stage = 0;
                end else begin
                    working_len = 0;
                    working_type = `RamAval;
                    working_stage = 0;
                end
            end
            `RamInst: begin
                working_r_buffer[working_stage] = ram_r_data;
                if (working_stage + 1 < working_len) begin
                    working_stage = working_stage + 1;    
                end else begin
                    working_stage = 0;
                    inst_done = `True;
                    working_type = `RamAval;
                end
            end
            
        end
    end

    always @ (*) begin
        case (working_type) begin
            `RamAval: begin
                ram_r_w <= `True;
                cur_addr <= ahead_addr;
            end
            `RamInst: begin
                ram_r_w <= `True;
                cur_addr <= inst_addr;
            end
            `RamMemr: begin
                ram_r_w <= `True;
                cur_addr <= mem_addr;
            end
            `RamMemw: begin
                ram_r_w <= `False;
                cur_addr <= mem_addr;
            end
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
