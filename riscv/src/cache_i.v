module cache_i(
    input wire clk,
    input wire rst,

    input wire                  request_i,
    input wire [`MemAddrBus]    addr_i,
    output reg [`RegBus]        data_o,
    output reg                  done_o,
    
    output reg                  request_o,
    output wire [`MemAddrBus]    addr_o,
    input wire [`ByteBus]       data_i,
    input wire                  done_i
);
    integer i;
    reg             cache_valid [`ICacheSize - 1 : 0];
    reg [`RegBus]   cache_data  [`ICacheSize - 1 : 0];
    reg [`ICacheTag] cache_tag   [`ICacheSize - 1 : 0];
    reg [`ByteBus]  cache_buffer[3 : 0];
    reg [2 : 0]     working_stage;
    reg miss;

    wire index = addr_i[`ICacheIndex];
    wire tag   = addr_i[`ICacheTag];

    initial begin
        
        for (i = 0; i < `ICacheSize; i = i + 1)
            cache_valid[i] <= `False;
    end

    always @ (*) begin
        if (rst) begin
            miss    <= `False;
            done_o  <= `True;
            data_o  <= 0;
            request_o <= `False;
            
        end else if (request_i) begin
            if (cache_valid[index] && tag == cache_tag[index]) begin
                data_o <= cache_data[index];
                done_o <= `True;
                miss   <= `False;
                request_o <= `False;
            end else begin
                done_o <= `False;
                miss   <= `True;
                request_o <= `True;
                data_o <= 0;
            end   
        end else begin
            miss    <= `False;
            done_o  <= `True;
            data_o  <= 0;
            request_o <= `False;
        end
    end

    assign addr_o = addr_i + working_stage;
    
    always @ (clk) begin
        if (rst) begin
            working_stage <= 0;
            for (i = 0; i < `ICacheSize; i = i + 1)
                cache_valid[i] <= `False;
        end else if (miss) begin
            if (done_i) begin
                if (working_stage + 1 < `ICacheBlockSize) begin
                    cache_buffer[working_stage] <= data_i;
                    working_stage <= working_stage + 1;
                end else if (working_stage + 1 == `ICacheBlockSize) begin
                    working_stage <= 0;
                    cache_valid[index] = `True;
                    cache_tag[index] = tag;
                    cache_data[index] = {
                        data_i, 
                        cache_buffer[2],
                        cache_buffer[1],
                        cache_buffer[0]
                    };
                end
            end
        end else begin
            working_stage = 0;
        end
    end

endmodule