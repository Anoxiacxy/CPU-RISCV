module reg_id_ex (
    input wire clk,
    input wire rst,
    input wire [`StallBus] stall,
    
    input wire [`InstAddrBus]   pc_i,
    input wire [`InstBus]   inst_i,

    output reg [`InstAddrBus]   pc_o,
    output reg [`InstBus]   inst_o,


    input wire [`RegBus]    rs1_data_i,
    input wire [`RegBus]    imm1_i,
    input wire imm_rs1_sel_i,
    input wire [`RegBus]    rs2_data_i,
    input wire [`RegBus]    imm2_i,
    input wire imm_rs2_sel_i,

    output reg [`RegBus]    rs1_data_o,
    output reg [`RegBus]    imm1_o,
    output reg imm_rs1_sel_o,
    output reg [`RegBus]    rs2_data_o,
    output reg [`RegBus]    imm2_o,
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
    input wire [`InstAddrBus]   branch_offset_i,

    output reg branch_o,
    output reg jump_o,
    output reg [`InstAddrBus]   branch_addr_o,
    output reg [`InstAddrBus]   branch_offset_o,

);

    always @ (posedge clk or posedge rst) begin
        if (rst || stall == `Bubb) begin
            pc_i <= 0;
        end else if (stall == `Pass) begin
            pc_o <= pc_i;
        end else if (stall == `Hold) begin
            pc_o <= pc_o;
        end
    end

endmodule 