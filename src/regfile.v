`include "config.v"
module regfile (
    input wire rst,
    input wire clk,
    
    input wire[`RegAddrBus] waddr,
    input wire we,
    input wire[`RegBus]     wdata,

    input wire[`RegAddrBus] raddr1,
    input wire re1,
    output reg[`RegBus]     rdata1,

    input wire[`RegAddrBus] raddr2,
    input wire re2,
    output reg[`RegBus]     rdata2,
)
    reg[`RegBus] register[`RegNum - 1 : 0];
    integer i;

    always @ (posedge clk) begin
        if (rst == `ResetDisable) begin
            if ((we == `WriteEnable) && (waddr != `RegAddrWidth'b0))
                reg[waddr] <= wdata;
        end else begin
            for (i = 0; i < `RegNum; i = i + 1)
                reg[i] <= `ZERO            
        end
    end

    always @ (*) begin
        if ((rst == `ResetDisable) && (re1 == `ReadEnable) && (raddr1 != `RegAddrWidth'b0)) begin
            if ((we == `WriteEnable) && (waddr == raddr1))
                rdata1 <= wdata;
            else
                rdata1 <= reg[raddr1];
        end else
            rdata1 <= `ZERO;
    end

    always @ (*) begin
        if ((rst == `ResetDisable) && (re2 == `ReadEnable) && (raddr2 != `RegAddrWidth'b0)) begin
            if ((we == `WriteEnable) && (waddr == raddr2))
                rdata2 <= wdata;
            else
                rdata2 <= reg[raddr2];
        end else
            rdata2 <= `ZERO;
    end

endmodule