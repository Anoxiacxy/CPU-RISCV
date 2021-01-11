`include "config.v"

module ctrl_branch(
    input wire clk,
    input wire rst,

    input wire [`InstAddrBus]   pc_i,
    output reg [`InstAddrBus]   pc_o1,
    output wire [`InstAddrBus]  pc_o2,
    output reg                  predict_result,

    input wire [`InstAddrBus]   branch_pc,
    input wire [`InstAddrBus]   branch_npc,
    input wire                  actual_result,
    input wire                  predict_update
);
    assign pc_o2 = pc_o1;
    reg [1 : 0] bht [`BhtNum - 1 : 0];

    reg [`InstAddrBus]          btb_target  [`BtbNum - 1 : 0];
    reg [31 : `LogBtbNum + 2]   btb_tag     [`BtbNum - 1 : 0];
    reg                         btb_valid   [`BtbNum - 1 : 0];
    
    integer i;
    
    wire [`BhtIndex]    bht_index_i = pc_i[`BhtIndex];
    wire [`BtbIndex]    btb_index_i = pc_i[`BtbIndex];
    wire [`BtbTag]      btb_tag_i   = pc_i[`BtbTag];

    always @ (*) begin
        if (rst) begin
            pc_o1 = 0;
            predict_result = `False;
        end else if (btb_valid[btb_index_i] 
                    && btb_tag[btb_index_i] == btb_tag_i
                    && bht[bht_index_i][1]) 
        begin
            pc_o1 = btb_target[btb_index_i];
            predict_result = `True;
        end else begin
           pc_o1 = pc_i + 4;
           predict_result = `False; 
        end
    end

    wire [`BhtIndex]    bht_index_b = branch_pc[`BhtIndex];
    wire [`BtbIndex]    btb_index_b = branch_pc[`BtbIndex];
    wire [`BtbTag]      btb_tag_b   = branch_pc[`BtbTag];

    always @ (posedge clk) begin
        if (rst) begin
            for (i = 0; i < `BhtNum; i = i + 1)  bht[i] <= 2'b01;
        end else if (predict_update) begin
            if (actual_result && bht[bht_index_b] != 3)
                bht[bht_index_b] = bht[bht_index_b] + 1;
            if (!actual_result && bht[bht_index_b] != 0)
                bht[bht_index_b] = bht[bht_index_b] - 1;
        end 
    end

    always @ (posedge clk) begin
        if (rst) begin
            for (i = 0; i < `BtbNum; i = i + 1)  btb_valid[i] <= 0;
        end else if (predict_update) begin
            if (actual_result) begin
                if (!btb_valid[btb_index_b] || btb_tag[btb_index_b] != btb_tag_b) begin
                    btb_tag[btb_index_b] = btb_tag_b;
                    btb_target[btb_index_b] = branch_npc;
                    btb_valid[btb_index_b] = `True;
                end
            end 
        end
    end

endmodule