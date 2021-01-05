 `include "config.v"
 module ctrl_ram (
    input wire clk,
    input wire rst,
    input wire branch_error,
    
    input wire                  inst_read,
    input wire [`MemAddrBus]    inst_addr,    
    output reg [`InstBus]       inst_data,
    output reg                  inst_done,
    output reg                  inst_wait,

    input wire                  mem_sign,
    input wire [2 : 0]          mem_len,
    input wire                  mem_read,
    input wire [`MemAddrBus]    mem_r_addr,
    output reg [`RegBus]        mem_r_data,
    output reg                  mem_r_done,
    output reg                  mem_r_wait,

    input wire                  mem_write,
    input wire [`MemAddrBus]    mem_w_addr,
    input wire [`ByteBus]       mem_w_data,
    output wire                  writting,
    output reg                  mem_w_wait,

    input wire                  io_buffer_full,
    output wire                  ram_r_w,
    output reg [`MemAddrBus]    ram_addr,
    input wire [`ByteBus]       ram_r_data,
    output wire [`ByteBus]      ram_w_data
    
);

    assign ram_r_w = writting;
    assign ram_w_data = mem_w_data;

    reg [2 : 0] working_type;
    reg [2 : 0] working_stage;
    reg [2 : 0] ahead_stage;
    reg [`MemAddrBus] ahead_addr;
    reg ahead, ahead_done;
    reg [`ByteBus] read_buffer[3 : 0];
    reg [`ByteBus] inst_buffer[3 : 0];

    wire read_pending = mem_read && !mem_r_done;
    wire inst_pending = inst_read && !inst_done;
    wire ahead_pending = ahead && !ahead_done;
    wire write_pending = mem_write;

    assign writting = working_type == `RamMemw;

    always @ (*) begin
        if (read_pending) working_type <= `RamMemr;
        else if (inst_pending) working_type <= `RamInst;
        else if (ahead_pending) working_type <= `RamAhad;
        else if (write_pending) working_type <= `RamMemw;
        else working_type <= `RamAval;
    end

    always @ (*) begin
        case (working_type)
            `RamMemr: ram_addr <= (ahead && working_stage == mem_len) ? 
                            ahead_addr + ahead_stage : mem_r_addr + working_stage;
            `RamInst: ram_addr <= (ahead && inst_addr == ahead_addr) ? 
                            ahead_addr + ahead_stage : inst_addr + working_stage;
            `RamAhad: ram_addr <= ahead_addr + ahead_stage;
            `RamMemw: ram_addr <= mem_w_addr;
            default: ram_addr <= 0;
        endcase
    end

    wire io = (ram_addr[17 : 16] == 2'b11);

    always @(posedge clk) begin
        if (rst) begin
            inst_done <= `False; 
            mem_r_done <= `False;
            inst_wait <= `False; 
            mem_r_wait <= `False; 
            mem_w_wait <= `False;
            ahead <= 0; 
            working_stage <= 0; 
            ahead_stage <= 0;
        end else begin
            case (working_type)
                `RamMemr: begin 
                    if (working_stage == 0) begin
                        inst_done <= 0; mem_r_done <= 0;
                        inst_wait <= 1; mem_r_wait <= 0; mem_w_wait <= 1;
                        working_stage <= 1;
                        if (io) 
                            ahead <= 0;
                        else if (!ahead_done) 
                            inst_buffer[ahead_stage - 1] <= ram_r_data;
                    end else if (working_stage < mem_len) begin
                        read_buffer[working_stage - 1] <= ram_r_data;
                        working_stage <= working_stage + 1;
                    end else begin
                        mem_r_done <= 1;
                        inst_wait <= 0; mem_w_wait <= 0;
                        working_stage <= 0;
                        case (mem_len)
                            1: mem_r_data <= {{24{mem_sign && ram_r_data[7]}}, ram_r_data};
                            2: mem_r_data <= {{16{mem_sign && ram_r_data[7]}}, ram_r_data, read_buffer[0]};
                            4: mem_r_data <= {ram_r_data, read_buffer[2], read_buffer[1], read_buffer[0]};
                        endcase
                        if (ahead && !ahead_done) begin
                            if (ahead_stage < 4)
                                ahead_stage <= ahead_stage+1;
                            else    
                                ahead_done <= `True;
                        end
                    end
                end
                `RamInst: begin
                    if (branch_error) begin
                        inst_done <= 0; mem_r_done <= 0;
                        inst_wait <= 0; mem_r_wait <= 0; mem_w_wait <= 0;
                        ahead <= 0; working_stage <= 0;
                    end else if (working_stage == 0) begin
                        if (!ahead || ahead_addr != inst_addr) begin
                            inst_done <= 0; mem_r_done <= 0;
                            inst_wait <= 0; mem_r_wait <= 1; mem_w_wait <= 1;
                            working_stage <= 1;
                        end else if (ahead_done) begin
                            inst_done <= 1; mem_r_done <= 0;
                            inst_wait <= 0; mem_r_wait <= 0; mem_w_wait <= 0;
                            working_stage <= 0;
                            inst_data <= {inst_buffer[3], inst_buffer[2], inst_buffer[1], inst_buffer[0]};
                            ahead_addr <= inst_addr + 4; ahead_stage <= 1; ahead_done <= 0;
                        end else if (ahead_stage[2]) begin
                            inst_done <= 1; mem_r_done <= 0;
                            inst_wait <= 0; mem_r_wait <= 0; mem_w_wait <= 0;
                            working_stage <= 0;
                            inst_data <= {ram_r_data, inst_buffer[2], inst_buffer[1], inst_buffer[0]};
                            ahead_addr <= inst_addr + 4; ahead_stage <= 1; ahead_done <= 0;
                        end else begin
                            inst_done <= 0; mem_r_done <= 0;
                            inst_wait <= 0; mem_r_wait <= 1; mem_w_wait <= 1;
                            inst_buffer[ahead_stage-1] <= ram_r_data;
                            working_stage <= ahead_stage+1;
                            ahead <= 0;
                        end
                    end else if (!working_stage[2]) begin
                        inst_buffer[working_stage-1] <= ram_r_data;
                        working_stage <= working_stage+1;
                    end else begin
                        inst_done <= 1;
                        mem_r_wait <= 0; mem_w_wait <= 0;
                        working_stage <= 0;
                        inst_data <= {ram_r_data, inst_buffer[2], inst_buffer[1], inst_buffer[0]};
                        ahead <= 1; ahead_addr <= inst_addr + 4; ahead_stage <= 1; ahead_done <= 0;
                    end
                end
                `RamAhad: begin
                    if (branch_error) begin
                        inst_done <= 0; mem_r_done <= 0;
                        ahead <= 0; working_stage <= 0; ahead_stage <= 0;
                    end else begin
                        inst_done <= 0; mem_r_done <= 0;
                        inst_buffer[ahead_stage-1] <= ram_r_data;
                        if (ahead_stage[2]) ahead_done <= 1;
                        else ahead_stage <= ahead_stage+1;
                    end
                end
                default: begin
                    inst_done <= 0; mem_r_done <= 0;
                end
            endcase
        end
    end

endmodule

