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
    output wire                 writting,
    output reg                  mem_w_wait,

    input wire                  io_buffer_full,
    output wire                 ram_r_w,
    output reg [`MemAddrBus]    ram_addr,
    input wire [`ByteBus]       ram_r_data,
    output wire [`ByteBus]      ram_w_data
    
);

    assign ram_r_w = writting;
    assign ram_w_data = writting ? mem_w_data : 0;

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
    wire write_pending = mem_write && !io_buffer_full;

    assign writting = working_type == `RamMemw;

    always @ (*) begin
        if (read_pending) working_type = `RamMemr;
        else if (inst_pending) working_type = `RamInst;
        else if (write_pending) working_type = `RamMemw;
        else if (ahead_pending) working_type = `RamAhad;
        else working_type = `RamAval;
    end

    always @ (*) begin
        case (working_type)
            `RamMemr: ram_addr = (ahead && working_stage == mem_len) ? 
                            ahead_addr + ahead_stage : mem_r_addr + working_stage;
            `RamInst: ram_addr = (ahead && inst_addr == ahead_addr) ? 
                            ahead_addr + ahead_stage : inst_addr + working_stage;
            `RamAhad: ram_addr = ahead_addr + ahead_stage;
            `RamMemw: ram_addr = mem_w_addr;
            default: ram_addr = 0;
        endcase
    end
    
    wire io = mem_r_addr[17 : 16] == 3;
    
    always @(posedge clk) begin
        if (rst) begin
            inst_done <= `False; 
            mem_r_done <= `False;

            inst_wait <= `False; 
            mem_r_wait <= `False; 
            mem_w_wait <= `False;

            ahead <= `False;
            working_stage <= 0; 
            ahead_stage <= 0;
        end else begin
            case (working_type)
                `RamMemr: begin 
                    if (working_stage == mem_len) begin
                        mem_r_done <= `True;
                        inst_done <= `False;

                        mem_w_wait <= `False;
                        inst_wait <= `False; 
                        mem_w_wait <= `False;

                        working_stage <= 0;
                        // ahead_stage <= 

                        case (mem_len)
                            1: mem_r_data <= {{24{mem_sign && ram_r_data[7]}}, ram_r_data};
                            2: mem_r_data <= {{16{mem_sign && ram_r_data[7]}}, ram_r_data, read_buffer[0]};
                            4: mem_r_data <= {ram_r_data, read_buffer[2], read_buffer[1], read_buffer[0]};
                        endcase

                        if (ahead_pending) begin
                            if (ahead_stage < 4)
                                ahead_stage <= ahead_stage + 1;
                            else    
                                ahead_done <= `True;
                        end
                    end else if (working_stage == 0) begin
                        inst_done <= `False; 
                        mem_r_done <= `False;

                        inst_wait <= `True; 
                        mem_r_wait <= `False; 
                        mem_w_wait <= `True;

                        working_stage <= 1;
                        // ahead_stage <= 
                        if (ahead_pending) 
                            inst_buffer[ahead_stage - 1] <= ram_r_data;
                    end else begin
                        read_buffer[working_stage - 1] <= ram_r_data;
                        working_stage <= working_stage + 1;
                        
                        inst_done <= `False; 
                        mem_r_done <= `False;

                        inst_wait <= `True; 
                        mem_r_wait <= `False; 
                        mem_w_wait <= `True;
                    end 
                end
                `RamInst: begin
                    if (branch_error) begin
                        ahead <= `False; 
                        inst_done <= `False; 
                        mem_r_done <= `False;
                        ahead_done <= `False;

                        inst_wait <= `False; 
                        mem_r_wait <= `False; 
                        mem_w_wait <= `False;

                        working_stage <= 0;
                        ahead_stage <= 0;
                    end else begin
                        if (ahead && ahead_done && ahead_addr == inst_addr) begin
                            inst_data <= {
                                inst_buffer[3], 
                                inst_buffer[2], 
                                inst_buffer[1], 
                                inst_buffer[0]
                            }; 
                            ahead_addr <= inst_addr + 4;
                            ahead <= `True;
                            ahead_done <= `False;
                            
                            inst_done <= `True;

                            working_stage <= 0;
                            ahead_stage <= 0;
                            
                            inst_wait <= `False;
                            mem_r_wait <= `False;
                            mem_w_wait <= `False;

                        end else if (working_stage == 4 || (ahead_stage == 4 && ahead && ahead_addr == inst_addr)) begin
                            inst_data <= {
                                ram_r_data, 
                                inst_buffer[2], 
                                inst_buffer[1], 
                                inst_buffer[0]
                            };
                            
                            ahead_addr <= inst_addr + 4;
                            ahead <= `True;
                            ahead_done <= `False;
                            
                            inst_done <= `True;

                            working_stage <= 0;
                            ahead_stage <= 1;
                            
                            inst_wait <= `False;
                            mem_r_wait <= `False;
                            mem_w_wait <= `False;
                        end else if (working_stage == 0) begin
                            if (ahead && ahead_addr == inst_addr) begin
                                working_stage = ahead_stage + 1;
                                inst_buffer[ahead_stage - 1] = ram_r_data;

                                ahead <= `False;

                                ahead_stage = 0;

                                inst_wait <= `False;
                                mem_r_wait <= `True;
                                mem_w_wait <= `True;
                            end else begin
                                working_stage <= 1;
                                ahead_stage <= 0;

                                inst_wait <= `False;
                                mem_r_wait <= `True;
                                mem_w_wait <= `True;
                            end
                        end else begin
                            working_stage <= working_stage + 1;
                            inst_buffer[working_stage - 1] <= ram_r_data;
                            inst_done <= `False; 
                            mem_r_done <= `False;
    
                            inst_wait <= `False; 
                            mem_r_wait <= `True; 
                            mem_w_wait <= `True;
                        end
                    end
                end
                `RamAhad: begin
                    if (branch_error) begin
                        inst_done   <= `False; 
                        mem_r_done  <= `False;
                        ahead_done <= `False;

                        ahead <= `False; 

                        inst_wait <= `False;
                        mem_r_wait <= `False;
                        mem_w_wait <= `False;

                        working_stage <= 0; 
                        ahead_stage <= 0;
                    end else begin
                        if (ahead_stage == 4) begin
                            
                            inst_buffer[3] <= ram_r_data;    
                            ahead_stage <= 0;
                            working_stage <= 0;
                            
                            ahead_done <= `True; 
                            inst_done  <= `False; 
                            mem_r_done <= `False;
                            
                            inst_wait <= `False;
                            mem_r_wait <= `False;
                            mem_w_wait <= `False;
                        end else if (ahead_stage == 0) begin
                            ahead_stage <= 1;

                            inst_done  <= `False; 
                            mem_r_done <= `False;

                            inst_wait <= `False;
                            mem_r_wait <= `False;
                            mem_w_wait <= `False;
                        end else begin
                            inst_buffer[ahead_stage - 1] <= ram_r_data;
                            ahead_stage = ahead_stage + 1;

                            inst_done  <= `False; 
                            mem_r_done <= `False;

                            inst_wait <= `False;
                            mem_r_wait <= `False;
                            mem_w_wait <= `False;
                        end
                    end
                end
                default: begin
                    inst_done <= `False; 
                    mem_r_done <= `False;

                    working_stage <= 0;
                    ahead_stage <= 0;

                    inst_wait <= `False;
                    mem_r_wait <= `False;
                    mem_w_wait <= `False;
                end
            endcase
        end
    end

endmodule

