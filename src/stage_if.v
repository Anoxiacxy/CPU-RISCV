module stage_if (
    input wire [`InstAddrBus] pc_i,

    output reg ram_request,
    output reg [`InstAddrBus] ram_pc_o,
    input wire [`InstBus] ram_inst_i,
    input wire ram_ready,

    output reg [`InstBus] inst_o,
    output reg [`InstAddrBus] pc_o,
    output reg [`InstAddrBus] pc_o_ctrl_branch,

    output reg stall_o
);
    assign ram_request = `True;
    assign ram_pc_o = pc_i;
    assign inst_o   = !ram_ready ? 0 : ram_inst_i;
    assign pc_o     = pc_i;
    assign pc_o_ctrl_branch = pc_i;
    assign stall_o  = !ram_ready;

endmodule