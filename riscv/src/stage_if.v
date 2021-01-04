module stage_if (
    input wire rst,

    input wire [`InstAddrBus] pc_i,

    output wire ram_request,
    input wire ram_done,

    input wire [`RegBus]        inst_i,
    output wire [`InstBus]       inst_o,
    output wire [`InstAddrBus]   pc_o1,
    output wire [`InstAddrBus]   pc_o2,
    output wire [`InstAddrBus]   pc_o3,

    output wire stall_o
);

    assign pc_o1 = rst ? 0 : pc_i; // next stage
    assign pc_o2 = pc_o1; // if
    assign pc_o3 = pc_o1; // next pc
    assign ram_request = rst ? `False : `True;
    assign stall_o = !ram_done; // done if inst match pc
    assign inst_o = (!rst && ram_done) ? inst_i : 0;

endmodule