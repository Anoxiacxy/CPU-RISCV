module pcreg (
    input wire clk,
    input wire rst,
    input wire [1:0] stall,

    input wire branch,
    input wire [`InstAddrBus] target,
    input wire [`InstAddrBus] pc_i,
    output reg [`InstAddrBus] pc_o
);

    always @ (posedge clk) begin
        if (rst || stall == Bubb) begin
            pc_o <= `ZeroWord;
        end else if (stall == Pass) begin
            if (branch)
                pc_o <= target;
            else
                pc_o <= pc_i;
        end else if (stall == Hold) begin
            pc_o <= pc_o;
        end
    end
    
endmodule