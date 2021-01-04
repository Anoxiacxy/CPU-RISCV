module reg_file (
    input wire rst,
    input wire clk,
    
    input wire[`RegAddrBus] w_addr,
    input wire write_request,
    input wire[`RegBus]     w_data,

    input wire[`RegAddrBus] r_addr1,
    input wire read_request1,
    output reg[`RegBus]     r_data1,

    input wire[`RegAddrBus] r_addr2,
    input wire read_request2,
    output reg[`RegBus]     r_data2,

    input wire[`RegAddrBus] r_addr3,
    input wire read_request3,
    output reg[`RegBus]     r_data3,

    input wire[`RegAddrBus] r_addr4,
    input wire read_request4,
    output reg[`RegBus]     r_data4
);
    reg[`RegBus] register[`RegNum - 1 : 0];
    integer i;

    always @ (posedge clk) begin
        if (!rst) begin
            if (write_request && w_addr)
                register[w_addr] <= w_data;
        end else begin
            for (i = 0; i < `RegNum; i = i + 1)
                register[i] <= 0;            
        end
    end

    always @ (*) begin
        if (!rst && read_request1 && r_addr1) begin
            if (write_request && (w_addr == r_addr1))
                r_data1 <= w_data;
            else
                r_data1 <= register[r_addr1];
        end else
            r_data1 <= 0;
    end

    always @ (*) begin
        if (!rst && read_request2 && r_addr2) begin
            if (write_request && (w_addr == r_addr2))
                r_data2 <= w_data;
            else
                r_data2 <= register[r_addr2];
        end else
            r_data2 <= 0;
    end

    always @ (*) begin
        if (!rst && read_request3 && r_addr3) begin
            if (write_request && (w_addr == r_addr3))
                r_data3 <= w_data;
            else
                r_data3 <= register[r_addr3];
        end else
            r_data3 <= 0;
    end

    always @ (*) begin
        if (!rst && read_request4 && r_addr4) begin
            if (write_request && (w_addr == r_addr4))
                r_data4 <= w_data;
            else
                r_data4 <= register[r_addr4];
        end else
            r_data4 <= 0;
    end

endmodule