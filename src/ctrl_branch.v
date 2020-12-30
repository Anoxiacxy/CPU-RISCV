`include "config.v"

module ctrl_branch(
    input wire clk,
    input wire rst,

    input wire [`InstAddrBus]   pc_i,
    output reg [`InstAddrBus]   pc_o,
    output reg                  predict_result,

    input wire [`InstAddrBus]   pc_b,
    input wire [`InstAddrBus]   pc_n,
    input wire                  actual_result,
    input wire                  update,
);
    reg [1 : 0] bht [`BhtNum - 1 : 0];

    reg [`InstAddrBus]          btb_target  [`BtbNum - 1 : 0];
    reg [31 : `LogBtbNum + 2]   btb_tag     [`BtbNum - 1 : 0];
    reg                         btb_valid   [`BtbNum - 1 : 0];

    initial begin
        integer i;
        for (i = 0; i < BhtNum; i = i + 1)  bht[i] <= 2'b01;
        for (i = 0; i < BtbNum; i = i + 1)  btb_valid <= 0;
    end
    
    wire [`BhtIndex]    bht_index_i = pc_i[`BhtIndex];
    wire [`BtbIndex]    btb_index_i = pc_i[`BtbIndex];
    wire [`BtbTag]      btb_tag_i   = pc_i[`BtbTag];

    always @ (*) begin
        if (rst) begin
            pc_o <= 0;
            predict_result <= `False;
        end else if (btb_valid[btb_index_i] 
                    && btb_tag[btb_index_i] == btb_tag_i
                    && bht[bht_index_i][1]) 
        begin
            pc_o <= btb_target[btb_index_i];
            predict_result <= `True;
        end else begin
           pc_o <= pc_i + 4;
           predict_result <= `False; 
        end
    end

    wire [`BhtIndex]    bht_index_b = pc_b[`BhtIndex];
    wire [`BtbIndex]    btb_index_b = pc_b[`BtbIndex];
    wire [`BtbTag]      btb_tag_b   = pc_b[`BtbTag];

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < BhtNum; i = i + 1)  bht[i] <= 2'b01;
        end else if (update) begin
            if (actual_result && bht[bht_index_b] != 3)
                bht[bht_index_b] <= bht[bht_index_b] + 1;
            if (!actual_result && bht[bht_index_b] != 0)
                bht[bht_index_b] <= bht[bht_index_b] - 1;
        end 
    end

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < BtbNum; i = i + 1)  btb_valid <= 0;
        end else if (update) begin
            if (actual_result) begin
                if (!btb_valid[btb_index_b] || btb_tag[btb_index_b] != btb_tag_b) begin
                    btb_tag[btb_index_b] <= btb_tag_b;
                    btb_target[btb_index_b] <= pc_n;
                    btb_valid[btb_index_b] <= `True;
                end
            end 
        end
    end

endmodule