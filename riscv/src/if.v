module if (
    input wire rst,

    input wire[`InstAddrBus] pc_i,
    input wire inst_done,
    output wire stall_if, 


    output wire[`InstBus] inst_o,
    output wire[`InstAddrBus] pc_o
);



always @(*) begin
    if (rst == `True) begin
        stall_if    <= `False;
    end if (inst_done == `True) begin
        stall_if    <= `False;
    end else 
        stall_if    <= `True;
end


endmodule 