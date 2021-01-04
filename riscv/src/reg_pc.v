module reg_pc (
    input wire clk,
    input wire rst,
    input wire [`StallBus] stall,

    input wire                  branch_error,
    input wire [`InstAddrBus]   branch_npc,

    input wire [`InstAddrBus] pc_i,
    output reg [`InstAddrBus] pc_o
);

    always @ (posedge clk) begin
        if (rst || stall == `Bubb) begin
            pc_o <= `ZeroWord;
        end else if (branch_error) begin
            pc_o <= branch_npc;
        end else if (stall == `Pass) begin 
            pc_o <= pc_i;
        end else if (stall == `Hold) begin
            
        end
    end
    
endmodule