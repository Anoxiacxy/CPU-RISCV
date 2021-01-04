module cache_i(
    input wire clk,
    input wire rst,
    input wire branch_error,
    
    input wire                  request_i,
    input wire [`MemAddrBus]    addr_i,
    output reg [`RegBus]        data_o,
    output reg                  done_o,
    
    output wire                  request_o,
    output reg [`MemAddrBus]    addr_o,
    input wire [`RegBus]       data_i,
    input wire                  done_i,
    input wire                  wait_i
);
    reg [`ICacheSize - 1 : 0]       cache_valid;
    reg [`RegBus]   cache_data      [`ICacheSize - 1 : 0];
    reg [`ICacheTag] cache_tag      [`ICacheSize - 1 : 0];
    reg [`ByteBus]  cache_buffer[2 : 0];
    
    reg miss, request_t;

    wire [`ICacheIndex] index = addr_i[`ICacheIndex];
    wire [`ICacheTag]   tag   = addr_i[`ICacheTag];

    initial begin
        cache_valid <= 0;
    end

    always @ (*) begin
        if (rst || !request_i) begin
            miss    <= `False;
            done_o  <= `True;
            data_o  <= 0;
        end else begin
            if (cache_valid[index] && tag == cache_tag[index]) begin
                data_o <= cache_data[index];
                done_o <= `True;
                miss   <= `False;
            end else if (done_i) begin
                data_o <= data_i;
                miss <= `False;
                done_o <= `True;
            end else begin
                done_o <= `False;
                miss   <= `True;
                data_o <= 0;
            end  
        end 
    end
    
    always @ (posedge clk) begin
        addr_o <= addr_i;
        request_t <= miss && !rst && !branch_error;
    end

    assign request_o = request_t && !wait_i;

    always @ (posedge clk) begin
        if (rst) begin 
            cache_valid <= 0;
        end else if (done_i) begin
            cache_valid[index] = `True;
            cache_tag[index] = tag;
            cache_data[index] = data_i;
        end
    end

endmodule