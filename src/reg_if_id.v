module reg_if_id (
    input wire clk,
    input wire rst,
    input wire [`StallBus] stall,

    input wire [`InstAddrBus] pc_i,
    input wire [`InstBus] inst_i,

    output reg [`InstAddrBus] pc_o,
    output reg [`InstBus] inst_o
);

    always @ (posedge clk) begin
        if (rst || stall == Bubb) begin
            pc_o    <= 0;
            inst_o  <= 0;
        end else if (stall == Pass) begin
            pc_o    <= pc_i;
            inst_o  <= inst_i;
        end else if (stall == Hold) begin
            pc_o    <= pc_o;
            inst_o  <= inst_o;
        end
    end

endmodule