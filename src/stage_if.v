module stage_if (
    input wire clk,
    input wire rst,

    input wire [`InstAddrBus] pc_i,

    output reg ram_request,
    output reg [`InstAddrBus] ram_pc_o,
    input wire [`InstBus] ram_inst_i,
    input wire ram_ready,

    output reg [`InstBus] inst_o,
    output reg [`InstAddrBus] pc_o,

    output wire stall_o
);
    assign ram_request = !rst;
    assign ram_pc_o = rst ? `ZeroWord : pc_i;
    assign inst_o   = rst || !ram_ready ? `ZeroWord : ram_inst_i;
    assign pc_o     = rst ? `ZeroWord : pc_i;
    assign stall_o  = rst ? `False : !ram_ready;

endmodule