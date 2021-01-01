module ctrl_stall (
    input wire clk,
    input wire rst,

    input wire stall_if,
    input wire stall_id,
    input wire stall_ex,
    input wire stall_mem,

    output wire [1:0] stall_reg_pc,
    output wire [1:0] stall_if_id,
    output wire [1:0] stall_id_ex,
    output wire [1:0] stall_ex_mem,
    output wire [1:0] stall_mem_wb
);
    reg [9:0] stall;
    always @(*) begin
        if (rst) 
            stall = {`Bubb, `Bubb, `Bubb, `Bubb, `Bubb};
        else if (stall_mem) 
            stall = {`Hold, `Hold, `Hold, `Hold, `Bubb};
        else if (stall_ex)
            stall = {`Hold, `Hold, `Hold, `Bubb, `Pass};
        else if (stall_id)
            stall = {`Hold, `Hold, `Bubb, `Pass, `Pass};
        else if (stall_if)
            stall = {`Hold, `Bubb, `Pass, `Pass, `Pass};
        else 
            stall = {`Pass, `Pass, `Pass, `Pass, `Pass};
    end

    assign stall_reg_pc = stall[9:8];
    assign stall_if_id = stall[7:6];
    assign stall_id_ex = stall[5:4];
    assign stall_ex_mem = stall[3:2];
    assign stall_mem_wb = stall[1:0];

endmodule