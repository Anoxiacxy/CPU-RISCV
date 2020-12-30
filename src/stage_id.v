`include "config.v" 

module stage_id (
    input wire [`InstAddrBus]   pc_i,
    input wire [`InstBus]       inst_i,
    output reg [`InstAddrBus]  pc_o,

    output reg read_request1, //
    output reg [`RegAddrBus] read_addr1, //
    input wire [`RegBus] read_data1,

    output reg read_request2, //
    output reg [`RegAddrBus]    read_addr2, //
    input wire [`RegBus]        read_data2,

    output reg [`RegBus]        rs1_data, //
    output reg [`RegBus]        imm1, //
    output reg imm_rs1_sel, //

    output reg [`RegBus]        rs2_data, //
    output reg [`RegBus]        imm2, //
    output reg imm_rs2_sel, //

    output reg [`RegAddrBus]    rd_addr,  //
    output reg                  rd_write, //
    output reg                  rd_load,  //

    output reg [`OpBus]         op, //
    output reg [`CatagoryBus]   catagory, //

    output reg branch, //
    output reg jump, //
    output reg [`InstAddrBus] branch_addr, //
    output reg [`InstAddrBus] branch_offset, //   

    input reg ex_load,
    input reg ex_write,
    input reg [`RegAddrBus] ex_rd_addr,
    input reg [`RegBus]     ex_rd_data,
    input reg mem_write,
    input reg [`RegAddrBus] mem_rd_addr,
    input reg [`RegBus]     mem_rd_data,

    input wire predict_i,
    output reg predict_o, //

    output wire stall_o //
);
    wire [6 : 0] func7  = inst_i[31 : 25];
    wire [2 : 0] func3  = inst_i[14 : 12];
    wire [6 : 0] opcode = inst_i[6  : 0 ];
    wire [4 : 0] shamt  = inst_i[24 : 20];

    wire [`RegBus] imm_I_type = $signed(inst_i[31:20]);
    wire [`RegBus] imm_S_type = $signed({inst_i[31:25], inst_i[11:7]});
    wire [`RegBus] imm_B_type = $signed({inst_i[31], inst_i[7], inst_i[30:25], inst_i[11:8]});
    wire [`RegBus] imm_U_type = {inst_i[31:12], 12'b000000000000};
    wire [`RegBus] imm_J_type = $signed(inst_i[31], inst_i[19:12], inst_i[20], inst_i[30:21]);

    wire [`RegBus] imm, imm1, imm2;
    // for imm
    always @ (*) begin
        case (opcode) begin
            `OpcodeLui:     imm <= imm_U_type;  rd_write <= `True;  rd_load <= `False; // lui
            `OpcodeAuipc:   imm <= imm_U_type;  rd_write <= `True;  rd_load <= `False; // auipc
            `OpcodeJal:     imm <= imm_J_type;  rd_write <= `True;  rd_load <= `False; // jal
            `OpcodeJalr:    imm <= imm_I_type;  rd_write <= `True;  rd_load <= `False; // jalr
            `OpcodeBranch:  imm <= imm_B_type;  rd_write <= `False; rd_load <= `False; // branch
            `OpcodeLui:     imm <= imm_I_type;  rd_write <= `True;  rd_load <= `True;  // load
            `OpcodeStore:   imm <= imm_S_type;  rd_write <= `False; rd_load <= `False; // store
            `OpcodeOpi:     imm <= imm_I_type;  rd_write <= `True;  rd_load <= `False; // opi
            `OpcodeOp:      imm <= 0;           rd_write <= `True;  rd_load <= `False; // op
            default:        imm <= 0;           rd_write <= `False; rd_load <= `False; // default
        end
    end

    // for branch_addr, branch_offset, branch, jump
    always @ (*) begin
        if (opcode == `OpcodeJal) begin
            branch_addr <= pc_i;
            branch_offset <= imm;
            jump <= `True;
            branch <= `False;
        end else if (opcode == `OpcodeJalr) begin
            branch_addr <= rs1_data;
            branch_offset <= imm;
            jump <= `True;
            branch <= `True;
        end else if (opcode == `OpcodeBranch) begin
            branch_addr <= pc_i;
            branch_offset <= imm;
            jump <= `False;
            branch <= `True;
        end else begin
            branch_addr <= 0;
            branch_offset <= 0;
            jump <= `False;
            branch <= `False;
        end
    end

    assign pc_o = pc_i;

    assign rd_addr = inst_i[11 : 7];
    wire [`RegAddrBus] rs1_addr = inst_i[19 : 15];
    wire [`RegAddrBus] rs2_addr = inst_i[24 : 20];

    assign read_addr1 = rs1_addr;
    assign read_addr2 = rs2_addr;

    wire stall_o1;
    wire stall_o2;
    assign stall_o = stall_o1 || stall_o2;

    // for rs1_data, stall_o1
    always @ (*) begin
        if (!read_request1 || !rs1_addr) begin
            stall_o1 <= `False;
            rs1_data <= 0;
        end            
        else if (ex_load && (rs1_addr == ex_rd_addr)) begin
            stall_o1 <= `True;
            rs1_data <= 0;
        end
        else if (ex_write && (rs1_addr == ex_rd_addr)) begin
            stall_o1 <= `False;
            rs1_data <= ex_rd_data;
        end
        else if (mem_write && (rs1_addr == mem_rd_addr)) begin
            stall_o1 <= `False;
            rs1_data <= mem_rd_data;
        end
        else begin
            stall_o1 <= `False;
            rs1_data <= read_data1;
        end
    end

    // for rs2_data, stall_o2
    always @ (*) begin
        if (!read_request2 || !rs2_addr) begin
            stall_o2 <= `False; rs2_data <= 0;
        end            
        else if (ex_load && (rs2_addr == ex_rd_addr)) begin
            stall_o2 <= `True;
            rs2_data <= 0;
        end
        else if (ex_write && (rs2_addr == ex_rd_addr)) begin
            stall_o2 <= `False;
            rs2_data <= ex_rd_data;
        end
        else if (mem_write && (rs2_addr == mem_rd_addr)) begin
            stall_o2 <= `False;
            rs2_data <= mem_rd_data;
        end
        else begin
            stall_o2 <= `False;
            rs2_data <= read_data2;
        end
    end

    // for read_request1, read_reequest2
    always @ (*) begin
        if (opcode == 7'b0110111 || opcode == 7'b0010111 || opcode == 7'b1101111) begin
            read_request1 <= `False;
            read_request2 <= `False;
        end else if (opcode == 7'b1100111 || opcode == 7'b0000011 || opcode == 7b'0010011) begin
            read_request1 <= `True;
            read_request2 <= `False;
        end else begin
            read_request1 <= `True;
            read_request2 <= `True;
        end     
    end


    // for catagory, op
    always @ (*) begin
        case (opcode) begin
            7'b0110111: begin catagory <= `CatagoryArith;   op <= `OpAdd;   end // lui
            7'b0010111: begin catagory <= `CatagoryArith;   op <= `OpAdd;   end // auipc
            7'b1101111: begin catagory <= `CatagoryArith;   op <= `OpAdd;   end // jal
            7'b1100111: begin catagory <= `CatagoryArith;   op <= `OpAdd;   end // jalr
            7'b1100011: begin
                catagory <= `CatagoryBranch;
                case (func3) begin
                    3'b000: op <= `OpEq; // beq
                    3'b001: op <= `OpNe; // bne
                    3'b100: op <= `OpLt; // blt
                    3'b101: op <= `OpGe; // bge
                    3'b110: op <= `OpLtu; // bltu
                    3'b111: op <= `OpGeu; // bgeu
                    default: op <= `OpEq; // default
                end
            end // branch
            7'b0000011: begin catagory <= `CatagoryLoad;    op <= func3;    end // load
            7'b0100011: begin catagory <= `CatagoryStore;   op <= func3;    end // store
            7'b0010011: begin
                case (func3) begin
                    3'b000: begin catagory <= `CatagoryArith;   op <= `OpAdd;   end // add
                    3'b010: begin catagory <= `CatagoryComp;    op <= `OpSlt;   end // slt
                    3'b011: begin catagory <= `CatagoryComp;    op <= `OpSltu;  end // sltu
                    3'b100: begin catagory <= `CatagoryLogic;   op <= `OpXor;   end // xor
                    3'b110: begin catagory <= `CatagoryLogic;   op <= `OpOr;    end // or
                    3'b111: begin catagory <= `CatagoryLogic;   op <= `OpAnd;   end // and
                    3'b001: begin catagory <= `CatagoryShift;   op <= `OpSll;   end // sll
                    3'b101: begin catagory <= `CatagoryShift;
                        if (!func7) op <= `OpSrl; // srl  
                        else        op <= `OpSra; // sra
                    end
                    default: begin catagory <= `CatagoryArith; op <= `OpAdd; end // default
                end
            end // opi
            7'b0110011: begin
                case (func3) begin
                    3'b000: begin catagory <= `CatagoryArith;
                        if (!inst_i[30])    op <= `OpAdd; // add
                        else                op <= `OpSub; // sub
                    end 
                    3'b010: begin catagory <= `CatagoryComp;    op <= `OpSlt;   end // slt
                    3'b011: begin catagory <= `CatagoryComp;    op <= `OpSltu;  end // sltu
                    3'b100: begin catagory <= `CatagoryLogic;   op <= `OpXor;   end // xor
                    3'b110: begin catagory <= `CatagoryLogic;   op <= `OpOr;    end // or
                    3'b111: begin catagory <= `CatagoryLogic;   op <= `OpAnd;   end // and
                    3'b001: begin catagory <= `CatagoryShift;   op <= `OpSll;   end // sll
                    3'b101: begin catagory <= `CatagoryShift;
                        if (!func7) op <= `OpSrl; // srl  
                        else        op <= `OpSra; // sra
                    end 
                    default: begin catagory <= `CatagoryArith; op <= `OpAdd; end // default
                end
            end // op
            default: begin catagory <= `CatagoryArith; op <= `OpAdd; end // default
        end
        
    end

    // for imm1, imm2, imm_rs1_sel, imm_rs2_sel
    always @ (*) begin
        case (opcode) begin
            7'b0110111: begin imm1 <= imm;      imm2 <= 0;  
                        imm_rs1_sel <= `False;  imm_rs2_sel <= `False;  end // lui
            7'b0010111: begin imm1 <= pc_i;     imm2 <= imm;  
                        imm_rs1_sel <= `False;  imm_rs2_sel <= `False;  end // auipc
            7'b1101111: begin imm1 <= pc_i;     imm2 <= 4 
                        imm_rs1_sel <= `False;  imm_rs2_sel <= `False;  end // jal
            7'b1100111: begin imm1 <= pc_i;     imm2 <= 4 
                        imm_rs1_sel <= `False;  imm_rs2_sel <= `False;  end // jalr 
            7'b1100011: begin imm1 <= 0;        imm2 <= 0;
                        imm_rs1_sel <= `True;   imm_rs2_sel <= `True;   end // branch
            7'b0000011: begin imm1 <= 0;        imm2 <= imm;
                        imm_rs1_sel <= `True;   imm_rs2_sel <= `False;  end // load
            7'b0100011: begin imm1 <= 0;        imm2 <= imm;
                        imm_rs1_sel <= `True;   imm_rs2_sel <= `False;  end // store
            7'b0010011: begin
                imm_rs1_sel <= `True;   imm_rs2_sel <= `False;  imm1 <= 0;
                if (func3 == 3'b001 || func3 == 3'b101) 
                        imm2 <= shamt;
                else    
                        imm2 <= imm;    
            end // opi
            7'b0110011: begin imm1 <= 0;        imm2 <= 0;
                        imm_rs1_sel <= `True;   imm_rs2_sel <= `True;   end // op
            default: imm1 <= 0; imm2 <= 0; imm_rs1_sel <= 0; imm_rs2_sel <= 0; end // default
        end
    end

endmodule