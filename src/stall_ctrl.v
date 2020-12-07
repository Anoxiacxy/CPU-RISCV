module stall_ctrl (
    input wire clk,
    input wire rst,

    input wire stall_if,
    input wire stall_id,
    input wire stall_ex,
    input wire stall_mem,

    output wire [1:0] stall_pcreg,
    output wire [1:0] stall_if_id,
    output wire stall_id_ex,
    output wire stall_ex_mem,
    output wire stall_mem_wb
);
    wire [9:0] stall;
    always @(*) begin
        if (rst) 
            stall = {Pass, Pass, Pass, Pass, Pass};
        else if (stall_mem) 
            stall = {Hold, Hold, Hold, Hold, };
        else if (stall_ex)
            stall = 5'b11110;
        else if (stall_id)
            stall = 5'b11100;
        else if (stall_if)
            stall = 5'b11000;
        else 
            stall = 5'b00000;
    end

    assign stall_pcreg = stall[9:8];
    assign stall_if_id = stall[7:6];
    assign stall_id_ex = stall[5:4];
    assign stall_ex_mem = stall[3:2];
    assign stall_mem_wb = stall[1:0];

endmodule