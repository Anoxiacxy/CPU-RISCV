module reg_id_ex (
    input wire clk,
    input wire rst,
    input wire [`StallBus] stall,
    input wire branch_error,
    
    input wire [`InstAddrBus]   pc_i,
    output reg [`InstAddrBus]   pc_o,


    input wire [`RegBus]        rs1_data_i,
    input wire                  rs1_request_i,
    input wire [`RegAddrBus]    rs1_addr_i,
    input wire [`RegBus]        imm1_i,
    input wire imm_rs1_sel_i,
    input wire [`RegBus]        rs2_data_i,
    input wire                  rs2_request_i,
    input wire [`RegAddrBus]    rs2_addr_i,
    input wire [`RegBus]        imm2_i,
    input wire imm_rs2_sel_i,

    output reg [`RegBus]        rs1_data_o,
    output reg                  rs1_request_o,
    output reg [`RegAddrBus]    rs1_addr_o,
    output reg [`RegBus]        imm1_o,
    output reg imm_rs1_sel_o,
    output reg [`RegBus]        rs2_data_o,
    output reg                  rs2_request_o,
    output reg [`RegAddrBus]    rs2_addr_o,
    output reg [`RegBus]        imm2_o,
    output reg imm_rs2_sel_o,

    input wire [`RegAddrBus]    rd_addr_i,
    input wire                  rd_write_i,
    input wire                  rd_load_i,

    output reg [`RegAddrBus]    rd_addr_o,
    output reg                  rd_write_o,
    output reg                  rd_load_o,


    input wire [`OpBus]         op_i,
    input wire [`CatagoryBus]   catagory_i,

    output reg [`OpBus]         op_o,
    output reg [`CatagoryBus]   catagory_o,
    

    input wire branch_i,
    input wire jump_i,
    input wire [`InstAddrBus]   branch_addr_i,
    input wire                  branch_addr_change_i,
    input wire [`InstAddrBus]   branch_offset_i,

    output reg branch_o,
    output reg jump_o,
    output reg [`InstAddrBus]   branch_addr_o,
    output reg                  branch_addr_change_o,
    output reg [`InstAddrBus]   branch_offset_o,

    input wire predict_result_i,
    input wire npc_i,
    output reg predict_result_o, //
    output reg npc_o

);

    always @ (posedge clk or posedge rst) begin
        if (rst || stall == `Bubb || branch_error) begin
            pc_o <= 0;
            rs1_data_o <= 0;
            rs1_request_o <= 0;
            rs1_addr_o <= 0;
            imm1_o <= 0;
            imm_rs1_sel_o <= 0;
            rs2_data_o <= 0;
            rs2_request_o <= 0;
            rs2_addr_o <= 0;
            imm2_o <= 0;
            imm_rs2_sel_o <= 0;

            rd_addr_o <= 0;
            rd_write_o <= 0;
            rd_load_o <= 0;

            op_o <= 0;
            catagory_o <= 0;

            branch_o <= 0;
            jump_o <= 0;
            branch_addr_o <= 0;
            branch_addr_change_o <= 0;
            branch_offset_o <= 0;

            predict_result_o <= 0;
            npc_o <= 0;
        end else if (stall == `Pass) begin
            pc_o <= pc_i;
            rs1_data_o <= rs1_data_i;
            rs1_request_o <= rs1_request_i;
            rs1_addr_o <= rs1_addr_i;
            imm1_o <= imm1_i;
            imm_rs1_sel_o <= imm_rs1_sel_i;
            rs2_data_o <= rs2_data_i;
            rs2_request_o <= rs2_request_i;
            rs2_addr_o <= rs2_addr_i;
            imm2_o <= imm2_i;
            imm_rs2_sel_o <= imm_rs2_sel_i;

            rd_addr_o <= rd_addr_i;
            rd_write_o <= rd_write_i;
            rd_load_o <= rd_load_i;

            op_o <= op_i;
            catagory_o <= catagory_i;

            branch_o <= branch_i;
            jump_o <= jump_i;
            branch_addr_o <= branch_addr_i;
            branch_addr_change_o <= branch_addr_change_i;
            branch_offset_o <= branch_offset_i;

            predict_result_o <= predict_result_i;
            npc_o <= npc_i;
        end else if (stall == `Hold) begin
            
        end
    end

endmodule 