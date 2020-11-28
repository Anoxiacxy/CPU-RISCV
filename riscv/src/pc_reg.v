module pc_reg(
    input wire clk,
    input wire rst,
    input wire rdy,

    input wire[`StallBus] stall,

    output reg[`InstAddrBus] pc,
);
    always @ (posedge clk) begin
        if (rst == `ResetEnable) 
            
        else
            ce <= `ChipEnable;
    end



endmodule 