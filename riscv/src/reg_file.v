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
    output reg[`RegBus]     r_data2
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
endmodule