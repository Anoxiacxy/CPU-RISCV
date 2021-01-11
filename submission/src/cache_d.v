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
    output reg [`RegBus]        data_o,
    input wire [`RegBus]        data_i,
    output reg                  done_o,
    // ctrl_mem
    output reg                  sign_o,
    output reg                  read_o,
    output reg [2 : 0]          len_o,
    output reg [`MemAddrBus]    r_addr_o,
    input wire  [`RegBus]       r_data_i,
    input wire                  r_done_i,
    input wire                  r_wait_i,

    output wire                 write_o,
    output wire [`MemAddrBus]   w_addr_o,
    output wire [`ByteBus]      w_data_o,
    input wire                  w_wait_i,
    input wire                  writting
);
    reg [`DCacheSize - 1 : 0]            cache_valid;
    reg [`DCacheSize - 1 : 0]            cache_dirty;
    reg [`RegBus]   cache_data  [`DCacheSize - 1 : 0];
    reg [`DCacheTag] cache_tag   [`DCacheSize - 1 : 0];
    reg [`RegBus]       buffer;
    wire [`ByteBus]     buffer_data[3 : 0];
    reg [`MemAddrBus]   buffer_addr;
    reg [2 : 0]         buffer_len;
    
    reg read_t;
    reg write_t;
    wire w_wait_t;
    reg [2 : 0]     stage;
    reg             working;
    assign buffer_data[3] = buffer[31:24];
    assign buffer_data[2] = buffer[23:16];
    assign buffer_data[1] = buffer[15: 8];
    assign buffer_data[0] = buffer[7 : 0];
    assign w_addr_o = buffer_addr + stage;
    assign w_data_o = buffer_data[stage];
    assign w_wait_t = (working || write_t);
    assign write_o  = w_wait_t && !w_wait_i;

    always @ (posedge clk) begin
        if (rst) begin
            stage <= 0;
            working <= `False;
        end else if (write_t) begin
            if (stage + writting == buffer_len) begin
                stage <= 0;
                working <= `False;
            end else begin
                stage <= stage + writting;
                working <= `True;
            end 
        end else if (write_o) begin
            if (stage + writting == buffer_len) begin
                stage <= 0;
                working <= `False;
            end else begin
                stage <= stage + writting;
            end 
        end
    end

    wire [`DCacheIndex]     index  = addr_i[`DCacheIndex];
    wire [`DCacheTag]       tag    = addr_i[`DCacheTag];
    wire [`DCacheOffset]    offset = addr_i[`DCacheOffset];

    wire buffer_miss = !w_wait_t || (buffer_addr - buffer_addr[`DCacheOffset] != (addr_i - offset));       

    wire io = (addr_i[17 : 16] == 2'b11);
    
    initial begin
        cache_dirty <= 0;
        cache_valid <= 0;
    end

    /*
    always @ (*) begin
        if (io) begin
            data_o <= io_r_data;        
        end else begin
            case (len_i) 
                0 : data_o <= {
                        {24{sign_i && cur_r_data[offset][7]}}, 
                        cur_r_data[offset]
                    };
                1 : data_o <= {
                        {16{sign_i && cur_r_data[offset + 1][7]}}, 
                        cur_r_data[offset + 1], 
                        cur_r_data[offset]
                    };
                2 : data_o <= {
                        cur_r_data[3], 
                        cur_r_data[2], 
                        cur_r_data[1], 
                        cur_r_data[0]
                    };
                default: data_o <= 0;
            endcase    
        end
    end
    */  
    
    reg load_request;
    reg write_request;
    reg store_request;
    reg flush_request;

    always @ (*) begin
        load_request = `False;
        write_request = `False;
        store_request  = `False;
        flush_request = `False;
        data_o = 0;
        done_o = `False;
        if (rst) begin
            data_o = 0;
        end else if (read_i) begin
            if (io) begin
                if (r_done_i) begin
                    done_o = `True;
                    data_o = r_data_i;
                end else begin
                    load_request = `True;
                end
            end if (cache_valid[index] && tag == cache_tag[index]) begin 
                if (len_i == 0)
                    data_o = cache_data[index][offset*8+:8]; 
                else if (len_i == 1) 
                    data_o = cache_data[index][offset*8+:16];
                else 
                    data_o = cache_data[index];
                done_o = `True;
            end else if (len_i != 2) begin 
                if (r_done_i) begin
                    data_o = r_data_i;
                    done_o = `True;
                end else begin
                    load_request = `True;
                end
            end else begin
                if (r_done_i) begin
                    data_o = r_data_i;
                    done_o = `True;
                end else if (!cache_dirty[index]) begin
                    load_request = `True;
                end else if (!w_wait_t) begin
                    flush_request = cache_valid[index];
                    load_request = `True;
                end else if (buffer_addr == {cache_tag[index], index, 2'b00}) begin
                    load_request = `True;
                end
            end
        end else if (write_i) begin
            if (io) begin
                if (!w_wait_t) begin
                    done_o = `True;
                    store_request = `True;
                end
            end
            if (cache_valid[index] && tag == cache_tag[index]) begin
                done_o = `True;
                write_request = `True;
            end else if (len_i != 2) begin
                if (!w_wait_t) begin
                    done_o = `True;
                    store_request = `True;
                end
            end else begin
                if (!cache_dirty[index]) begin
                    write_request = `True;
                    done_o = `True;
                end else if (!w_wait_t) begin
                    flush_request = cache_valid[index];
                    write_request = `True;
                    done_o = `True;
                end
            end
        end
    end

    reg update;
    always @ (posedge clk) begin
        read_t <= load_request && buffer_miss;
        update <= (len_i == 2);
        sign_o <= sign_i;
        len_o <= (1 << len_i);
        r_addr_o <= addr_i;
    end

    always @ (*) begin 
        read_o = read_t && !r_wait_i;
    end

    always @ (posedge clk) begin
        if (rst) begin
            write_t <= `False;
            buffer_len <= 0;
            buffer_addr <= 0;
            buffer <= 0;
        end else if (store_request || flush_request) begin
            write_t <= `True;
            buffer_len <= flush_request ? 4 : (1 << len_i);
            buffer_addr <= flush_request ? {cache_tag[index], index, 2'b00} : addr_i;
            buffer <= flush_request ? cache_data[index] : data_i;
        end else begin
            write_t <= `False;
        end
    end

    always @ (posedge clk) begin
        if (rst) begin
            cache_valid <= 0;
            cache_dirty <= 0;
        end else if (write_request) begin
            cache_dirty[index] <= `True;
            if (len_i == 0)
                cache_data[index][offset*8+: 8] <= data_i[7 : 0]; 
            else if (len_i == 1) begin
                cache_data[index][offset*8+: 16] <= data_i[15 : 0];
            end else begin
                cache_data[index] <= data_i;
                cache_tag[index] <= tag;
                cache_valid[index] <= `True;
            end
        end else if (r_done_i && update && read_t) begin
            cache_valid[index] <= `True;
            cache_dirty[index] <= `False;
            cache_tag[index] <= tag;
            cache_data[index] <= r_data_i;
        end
    end

endmodule