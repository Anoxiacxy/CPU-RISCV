module pc_reg(
    input wire clk,
    input wire rst,

    input wire[`StallBus] stall,

    output reg[`InstAddrBus] pc,
);
    always @ (posedge clk) begin
        
    end



endmodule 