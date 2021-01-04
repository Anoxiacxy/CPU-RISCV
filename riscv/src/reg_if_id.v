module reg_if_id (
    input wire clk,
    input wire rst,
    input wire [`StallBus] stall,
    input wire branch_error,

    input wire [`InstAddrBus]   pc_i,
    input wire [`InstBus]       inst_i,
    input wire                  predict_result_i,
    input wire [`InstAddrBus]   next_pc_i,

    output reg [`InstAddrBus]   pc_o,
    output reg [`InstBus]       inst_o,
    output reg                  predict_result_o,
    output reg [`InstAddrBus]   next_pc_o
);

    always @ (posedge clk) begin
        if (rst || stall == `Bubb || branch_error) begin
            pc_o        <= 0;
            inst_o      <= 0;
            next_pc_o   <= 0;
            predict_result_o <= 0;
        end else if (stall == `Pass) begin
            pc_o        <= pc_i;
            inst_o      <= inst_i;
            next_pc_o   <= next_pc_i;
            predict_result_o <= predict_result_i;
        end else if (stall == `Hold) begin
            
        end
    end

endmodule