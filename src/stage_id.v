module stage_id (
    input wire clk,
    input wire rst,

    input wire [`InstAddrBus] pc_i,
    input wire [`InstBus] inst_i,

    output reg read_request1,
    output reg [`RegAddrBus] read_addr1,
    input wire [`RegBus] read_data1,

    output reg read_request2,
    output reg [`RegAddrBus] read_addr2,
    input wire [`RegBus] read_data2,

    output reg [`RegBus] op_data1,
    output reg [`RegBus] op_data2,
    output reg [`AluOp]  op,
    output reg [2:0]     catagory,




    output wire stall_o
);

    wire [`RegAddrBus] rd  <= inst_i[11 : 7];
    wire [`RegAddrBus] rs1 <= inst_i[19 : 15];
    wire [`RegAddrBus] rs2 <= inst_i[24 : 20];
    
    wire [6 : 0] func7  <= inst_i[31 : 25];
    wire [2 : 0] func3  <= inst_i[14 : 12];
    wire [6 : 0] opcode <= inst_i[6  : 0 ];
    wire [4 : 0] shamt  <= inst_i[24 : 20];

    wire [`RegBus] imm_I_type <= $signed(inst_i[31:20]);
    wire [`RegBus] imm_S_type <= $signed({inst_i[31:25], inst_i[11:7]});
    wire [`RegBus] imm_B_type <= $signed({inst_i[31], inst_i[7], inst_i[30:25], inst_i[11:8]});
    wire [`RegBus] imm_U_type <= {inst_i[31:12], 12'b000000000000};
    wire [`RegBus] imm_J_type <= $signed(inst_i[31], inst_i[19:12], inst_i[20], inst_i[30:21]);

    always @ (*) begin
        if (!rst) begin 
            case (opcode) begin
                7'b0110111: // lui
                7'b0010111: // auipc
                7'b1101111: // jal
                7'b1100111: // jalr
                7'b1100011: begin
                    
                end // B
                7'b0000011: // load
                7'b0100011: // store
                7'b0010011: // opi
                7'b0110011: // op

            end
        end
    end
endmodule