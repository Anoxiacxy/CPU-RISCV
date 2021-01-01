`include "config.v"
module cache_d(
    input wire clk,
    input wire rst,

    input wire                  sign_i,
    input wire [1 : 0]          len_i,
    input wire                  read_i,
    input wire                  write_i,
    input wire [`MemAddrBus]    addr_i,
    output reg [`RegBus]        r_data_o,
    input wire [`RegBus]        w_data_i,
    output reg                  done_o,
    
    output wire                  read_o,
    output wire                  write_o,
    output wire [`MemAddrBus]    addr_o,
    input wire [`ByteBus]       r_data_i,
    output wire [`ByteBus]       w_data_o,
    input wire                  done_i
);
    integer i;
    reg             cache_valid [`DCacheSize - 1 : 0];
    reg             cache_dirty [`DCacheSize - 1 : 0];
    reg [`RegBus]   cache_data  [`DCacheSize - 1 : 0];
    reg [`DCacheTag] cache_tag   [`DCacheSize - 1 : 0];
    reg [`ByteBus]  cache_buffer[3 : 0];
    reg [2 : 0]     working_stage;
    reg miss;       

    wire index  = addr_i[`DCacheIndex];
    wire tag    = addr_i[`DCacheTag];
    wire offset = addr_i[`DCacheOffset];

    initial begin
        for (i = 0; i < `DCacheSize; i = i + 1) begin
            cache_valid[i] <= `False;
            cache_dirty[i] <= `False;
        end
    end

    reg [`ByteBus]  cur_r_data[3 : 0];
    reg [`ByteBus]  cur_w_data[3 : 0];
    
    always @ (*) begin
        case (len_i) 
            0 : r_data_o <= {{24{sign_i && cur_r_data[offset][7]}}, cur_r_data[offset]};
            1 : r_data_o <= {{16{sign_i && cur_r_data[offset + 1][7]}}, cur_r_data[offset + 1], cur_r_data[offset]};
            2 : r_data_o <= {cur_r_data[3], cur_r_data[2], cur_r_data[1], cur_r_data[0]};
        endcase
    end

    always @ (*) begin {
            cur_w_data[3],
            cur_w_data[2],
            cur_w_data[1],
            cur_w_data[0]
        } <= w_data_i;
    end

    always @ (*) begin
        if (rst) begin
            done_o <= `True;
            miss <= `False;
        end else if (read_i) begin
            if (cache_valid[index]) begin
                if (tag == cache_tag[index]) begin {
                        cur_r_data[3], 
                        cur_r_data[2], 
                        cur_r_data[1], 
                        cur_r_data[0]
                    } <= cache_data[index];
                    done_o <= `True;
                    miss   <= `False;
                end else begin
                    done_o <= `False;
                    miss   <= `True;
                    cur_r_data[3] <= 0;
                    cur_r_data[2] <= 0;
                    cur_r_data[1] <= 0;
                    cur_r_data[0] <= 0;
                end       
            end else begin
                cache_dirty[index] <= `False;
                miss <= `True;
                done_o <= `False;
            end
        end else if (write_i) begin
            if (cache_valid[index]) begin
                if (tag == cache_tag[index]) begin
                    case (len_i) 
                        0 : cache_data[index] <= {cache_data[index][31 : 8], cur_w_data[offset]};
                        1 : cache_data[index] <= {cache_data[index][31 : 16], cur_w_data[offset + 1], cur_w_data[offset]};
                        2 : cache_data[index] <= {cur_w_data[3], cur_w_data[2], cur_w_data[1], cur_w_data[0]};
                    endcase
                    cache_dirty[index] <= `True;
                    done_o  <= `True;
                    miss    <= `False;
                end else begin           
                    done_o  <= `False;
                    miss    <= `True;
                end
            end else begin
                cache_dirty[index] <= `False;
                miss    <= `True;
                done_o  <= `False;
            end
        end else begin
            done_o  <= `True;
            miss    <= `False;
        end
    end

    wire [`ByteBus]  cur_cw_data[3 : 0];
    reg [`ByteBus]  cur_cr_data[3 : 0];

    assign {cur_cw_data[3], cur_cw_data[2], cur_cw_data[1], cur_cw_data[0]} = cache_data[index];

    assign addr_o = addr_i - offset + working_stage;
    assign w_data_o = cur_cw_data[working_stage];
    
    assign read_o = miss && !cache_dirty[index];
    assign write_o = miss && cache_dirty[index];

    always @ (clk) begin
        if (rst) begin
            for (i = 0; i < `DCacheSize; i = i + 1) begin
                cache_valid[i] <= `False;
                cache_dirty[i] <= `False;
            end
            working_stage <= 0;
        end else if (read_o) begin
            if (done_i) begin
                if (working_stage + 1 < `DCacheBlockSize) begin
                    cur_cr_data[working_stage] <= r_data_i;
                    working_stage <= working_stage + 1;
                end else if (working_stage + 1 == `DCacheBlockSize) begin
                    working_stage <= 0;
                    cache_valid[index] <= `True;
                    cache_tag[index] <= tag;
                    cache_data[index] <= {
                        r_data_i,
                        cur_cr_data[2],
                        cur_cr_data[1],
                        cur_cr_data[0]
                    };
                end
            end
        end else if (write_o) begin
            if (done_i) begin
                if (working_stage + 1 < `DCacheBlockSize) begin                    
                    working_stage <= working_stage + 1;
                end else if (working_stage + 1 == `DCacheBlockSize) begin
                    working_stage <= 0;
                    cache_valid[index] <= `False;
                end
            end
        end else begin
            working_stage = 0;
        end
    end

endmodule