`include "config.v"

module stage_ex (
    input wire [`InstAddrBus]   pc_i,

    input wire [`RegBus]        rs1_data,
    input wire [`RegAddrBus]    rs1_addr,
    input wire [`RegBus]        imm1,
    input wire imm_rs1_sel,

    input wire [`RegBus]        rs2_data,
    input wire [`RegAddrBus]    rs2_addr,
    input wire [`RegBus]        imm2,
    input wire imm_rs2_sel,

    input wire [`RegAddrBus]    rd_addr_i,
    input wire                  rd_write_i,
    input wire                  rd_load_i,
    output wire [`RegAddrBus]    rd_addr_o, //
    output wire                  rd_write_o, //
    output wire                  rd_load_o, //
    output reg [`RegBus]        rd_data, //

    input wire [`OpBus]         op_i,
    input wire [`CatagoryBus]   catagory_i,
    output wire [`OpBus]         op_o, //
    output wire [`CatagoryBus]   catagory_o, //

    output wire [`MemAddrBus]    mem_addr, // 
    output wire [`MemDataBus]    mem_data, //

    input wire branch,
    input wire jump,
    input wire [`InstAddrBus]   branch_addr,
    input wire                  branch_addr_change,
    input wire [`InstAddrBus]   branch_offset,

    input wire [`InstAddrBus]    npc,
    input wire                   predict_result, 
    output wire                  predict_error, //
    output wire                  predict_update, //
    output wire                  actual_result, //
    output wire [`InstAddrBus]   branch_npc1, //
    output wire [`InstAddrBus]   branch_npc2, //
    output wire [`InstAddrBus]   branch_pc, //
    output wire                  stall_o
);
    assign branch_pc = pc_i;
    assign op_o = op_i;
    assign catagory_o = catagory_i;

    assign rd_addr_o    = rd_addr_i;
    assign rd_write_o   = rd_write_i;
    assign rd_load_o    = rd_load_i;

    assign stall_o = `False;

    reg [`RegBus] rs1;
    reg [`RegBus] rs2;

    wire [`RegBus] op1 = imm_rs1_sel ? rs1_data : imm1;
    wire [`RegBus] op2 = imm_rs2_sel ? rs2_data : imm2;

    wire [`InstAddrBus]  branch_if_taken = branch_addr + branch_offset;
    wire [`InstAddrBus]  branch_if_not_taken = pc_i + 4;

    assign mem_addr = op1 + op2;
    assign mem_data = rs2;

    reg [`RegBus]   result_shift;
    reg [`RegBus]   result_arith;
    reg [`RegBus]   result_logic;
    reg [`RegBus]   result_comp;
    reg             result_branch;

    assign actual_result    = result_branch || jump;
    assign branch_npc1      = actual_result ? branch_if_taken : branch_if_not_taken;
    assign branch_npc2      = branch_npc1;
    assign predict_error    = ((branch || jump) && (
            predict_result != actual_result ||
            npc != branch_npc1)) 
        || (branch && jump);
    assign predict_update   = (branch ^ jump);

    always @ (*) begin
        case (op_i) 
            `OpSll: result_shift <= (op1 << op2);
            `OpSrl: result_shift <= (op1 >> op2);
            `OpSra: result_shift <= ($signed(op1) >>> op2);
            default: result_shift <= 0;
        endcase
    end

    always @ (*) begin
        case (op_i) 
            `OpAdd: result_arith <= (op1 + op2);
            `OpSub: result_arith <= (op1 - op2);
            default: result_arith <= 0;
        endcase
    end
    
    always @ (*) begin
        case (op_i) 
            `OpXor: result_logic <= (op1 ^ op2);
            `OpOr:  result_logic <= (op1 | op2);
            `OpAnd: result_logic <= (op1 & op2);
            default: result_logic <= 0;
        endcase
    end

    always @ (*) begin
        case (op_i) 
            `OpSlt: result_comp <= ($signed(op1) < $signed(op2));
            `OpSltu: result_comp <= (op1 < op2);
            default: result_comp <= 0;
        endcase
    end
    
    always @ (*) begin
        case (op_i) 
            `OpEq: result_branch <= (op1 == op2);
            `OpNe: result_branch <= (op1 != op2);
            `OpLt: result_branch <= ($signed(op1) < $signed(op2));
            `OpGe: result_branch <= !($signed(op1) < $signed(op2));
            `OpLtu: result_branch <= (op1 < op2);
            `OpGeu: result_branch <= !(op1 < op2);
            default: result_branch <= `False;
        endcase
    end

    always @ (*) begin
        case (catagory_i) 
            `CatagoryShift: rd_data <= result_shift;
            `CatagoryArith: rd_data <= result_arith;
            `CatagoryLogic: rd_data <= result_logic;
            `CatagoryComp:  rd_data <= result_comp;
            default:        rd_data <= 0;
        endcase
    end

endmodule