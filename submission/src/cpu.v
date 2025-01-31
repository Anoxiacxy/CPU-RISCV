// RISCV32I CPU top module
// port modification allowed for debugging purposes

module cpu(
    input  wire                 clk_in,			// system clock signal
    input  wire                 rst_in,			// reset signal
	input  wire					rdy_in,			// ready signal, pause cpu when low

    input  wire [ 7:0]          mem_din,		// data input bus
    output wire [ 7:0]          mem_dout,		// data output bus
    output wire [31:0]          mem_a,			// address bus (only 17:0 is used)
    output wire                 mem_wr,			// write/read signal (1 for write)
	
	input  wire                 io_buffer_full, // 1 if uart buffer is full
	
	output wire [31:0]			dbgreg_dout		// cpu register output (debugging demo)
);

// implementation goes here

// Specifications:
// - Pause cpu(freeze pc, registers, etc.) when rdy_in is low
// - Memory read result will be returned in the next cycle. Write takes 1 cycle(no need to wait)
// - Memory is of size 128KB, with valid address ranging from 0x0 to 0x20000
// - I/O port is mapped to address higher than 0x30000 (mem_a[17:16]==2'b11)
// - 0x30000 read: read a byte from input
// - 0x30000 write: write a byte to output (write 0x00 is ignored)
// - 0x30004 read: read clocks passed since cpu starts (in dword, 4 bytes)
// - 0x30004 write: indicates program stop (will output '\0' through uart tx)

    wire clk = clk_in & rdy_in;

    // ctrl_stall
    wire stall__stage_if__ctrl_stall;
    wire stall__stage_id__ctrl_stall;
    wire stall__stage_ex__ctrl_stall;
    wire stall__stage_mem__ctrl_stall;
    wire [`StallBus] stall__ctrl_stall__reg_pc;
    wire [`StallBus] stall__ctrl_stall__reg_if_id;
    wire [`StallBus] stall__ctrl_stall__reg_id_ex;
    wire [`StallBus] stall__ctrl_stall__reg_ex_mem;
    wire [`StallBus] stall__ctrl_stall__reg_mem_wb;
    // ctrl_branch
    wire [`InstAddrBus] branch_npc__stage_ex_o;
    wire [`InstAddrBus] pc__ctrl_branch__reg_pc;
    wire [`InstAddrBus] npc__ctrl_branch__reg_if_id;
    wire predict_result__ctrl_branch__reg_if_id;
    wire [`InstAddrBus] branch_pc__stage_ex__ctrl_branch;
    wire [`InstAddrBus] branch_npc__stage_ex__ctrl_branch = branch_npc__stage_ex_o;
    wire actual_result__stage_ex__ctrl_branch;
    wire predict_update__stage_ex__ctrl_branch;
    // ctrl_ram
    wire inst_read__cache_i__ctrl_ram;
    wire [`InstAddrBus] inst_addr__cache_i__ctrl_ram;
    wire [`RegBus]     inst_data__ctrl_ram__cache_i;
    wire inst_done__ctrl_ram__cache_i;
    wire inst_wait__ctrl_ram__cache_i;
    wire mem_read__cache_d__ctrl_ram;
    wire mem_write__cache_d__ctrl_ram;
    wire [`InstAddrBus] mem_addr__cache_d__ctrl_ram;
    wire [`RegBus]      mem_r_data__ctrl_ram__cache_d;
    wire [`ByteBus]     mem_w_data__cache_d__ctrl_ram;
    wire mem_done__ctrl_ram__cache_d;
    // cache_i
    wire request__stage_if__cache_i;
    wire [`InstBus]     inst__cache_i__stage_if;
    wire done__cache_i__stage_if;
    // cache_d
    wire write__stage_mem__cache_d;
    wire read__stage_mem__cache_d;
    wire sign__stage_mem__cache_d;
    wire [1 : 0]        len__stage_mem__cache_d;
    wire [`MemDataBus]  addr__stage_mem__cache_d;
    wire [`RegBus]      r_data__cache_d__stage_mem;
    wire [`RegBus]      w_data__stage_mem__cache_d;
    wire done__cache_d__stage_mem;
    // reg_file
    wire [`RegAddrBus]  write_addr__stage_wb__reg_file;
    wire write_request__stage_wb__reg_file;
    wire [`RegBus]      write_data__stage_wb__reg_file;
    
    wire [`RegAddrBus]  read_addr1__stage_id__reg_file;
    wire read_request1__stage_id__reg_file;
    wire [`RegBus]      read_data1__stage_id__reg_file;
    
    wire [`RegAddrBus]  read_addr2__stage_id__reg_file;
    wire read_request2__stage_id__reg_file;
    wire [`RegBus]      read_data2__stage_id__reg_file;
    // reg_pc
    wire [`InstAddrBus] branch_npc__stage_ex__reg_pc = branch_npc__stage_ex_o;
    wire [`InstAddrBus] pc__reg_pc_stage_if;
    // stage_if
    wire [`InstBus]     inst__stage_if__reg_if_id;
    wire [`InstAddrBus] pc__stage_if__reg_if_id;
    // reg_if_id
    wire [`InstAddrBus] pc__reg_if_id__stage_id;
    wire [`InstBus]     inst__reg_if_id__stage_id;
    wire predict_result__reg_if_id__stage_id;
    wire [`InstAddrBus] npc__reg_if_id__stage_id;
    // stage_id
    wire [`InstAddrBus] pc__stage_id__reg_id_ex;
    wire [`RegBus]      rs1_data__stage_id__reg_id_ex;
    wire rs1_request__stage_id__reg_id_ex;
    wire [`RegAddrBus]  rs1_addr__stage_id__reg_id_ex;
    wire [`RegBus]      imm1__stage_id__reg_id_ex;
    wire imm_rs1_sel__stage_id__reg_id_ex;
    wire [`RegBus]      rs2_data__stage_id__reg_id_ex;
    wire rs2_request__stage_id__reg_id_ex;
    wire [`RegAddrBus]  rs2_addr__stage_id__reg_id_ex;
    wire [`RegBus]      imm2__stage_id__reg_id_ex;
    wire imm_rs2_sel__stage_id__reg_id_ex;
    wire [`RegAddrBus]  rd_addr__stage_id__reg_id_ex;
    wire rd_write__stage_id__reg_id_ex;
    wire rd_load__stage_id__reg_id_ex;
    wire [`OpBus]       op__stage_id__reg_id_ex;
    wire [`CatagoryBus] catagory__stage_id__reg_id_ex;
    wire branch__stage_id__reg_id_ex;
    wire jump__stage_id__reg_id_ex;
    wire [`InstAddrBus] branch_addr__stage_id__reg_id_ex;
    wire branch_addr_change__stage_id__reg_id_ex;
    wire [`InstAddrBus] branch_offset__stage_id__reg_id_ex;
    wire predict_result__stage_id__reg_id_ex;
    wire [`InstAddrBus] npc__stage_id__reg_id_ex;
    // reg_id_ex
    wire [`InstAddrBus] pc__reg_id_ex__stage_ex;
    wire [`RegBus]      rs1_data__reg_id_ex__stage_ex;
    wire rs1_request__reg_id_ex__stage_ex;
    wire [`RegAddrBus]  rs1_addr__reg_id_ex__stage_ex;
    wire [`RegBus]      imm1__reg_id_ex__stage_ex;
    wire imm_rs1_sel__reg_id_ex__stage_ex;
    wire [`RegBus]      rs2_data__reg_id_ex__stage_ex;
    wire rs2_request__reg_id_ex__stage_ex;
    wire [`RegAddrBus]  rs2_addr__reg_id_ex__stage_ex;
    wire [`RegBus]      imm2__reg_id_ex__stage_ex;
    wire imm_rs2_sel__reg_id_ex__stage_ex;
    wire [`RegAddrBus]  rd_addr__reg_id_ex__stage_ex;
    wire rd_write__reg_id_ex__stage_ex;
    wire rd_load__reg_id_ex__stage_ex;
    wire [`OpBus]       op__reg_id_ex__stage_ex;
    wire [`CatagoryBus] catagory__reg_id_ex__stage_ex;
    wire branch__reg_id_ex__stage_ex;
    wire jump__reg_id_ex__stage_ex;
    wire [`InstAddrBus] branch_addr__reg_id_ex__stage_ex;
    wire branch_addr_change__reg_id_ex__stage_ex;
    wire [`InstAddrBus] branch_offset__reg_id_ex__stage_ex;
    wire predict_result__reg_id_ex__stage_ex;
    wire [`InstAddrBus] npc__reg_id_ex__stage_ex;
    // stage_ex
    wire load__reg_ex_mem__stage_ex;
    wire write__reg_ex_mem__stage_ex;
    wire [`RegAddrBus]  addr__reg_ex_mem__stage_ex;
    wire [`RegBus]      data__reg_ex_mem__stage_ex;
    wire write__reg_mem_wb__stage_ex;
    wire [`RegAddrBus]  addr__reg_mem_wb__stage_ex;
    wire [`RegBus]      data__reg_mem_wb__stage_ex;
    wire [`RegAddrBus]  rd_addr__stage_ex__reg_ex_mem;
    wire rd_write__stage_ex__reg_ex_mem;
    wire rd_load__stage_ex__reg_ex_mem;
    wire [`RegBus]      rd_data__stage_ex__reg_ex_mem;
    wire [`MemAddrBus]  mem_addr__stage_ex__reg_ex_mem;
    wire [`RegBus]      mem_data__stage_ex__reg_ex_mem;
    wire [`OpBus]       op__stage_ex__reg_ex_mem;
    wire [`CatagoryBus] catagory__stage_ex__reg_ex_mem;
    // reg_ex_mem
    wire [`RegAddrBus]  rd_addr__reg_ex_mem__stage_mem;
    wire rd_write__reg_ex_mem__stage_mem;
    wire [`RegBus]      rd_data__reg_ex_mem__stage_mem;
    wire [`MemAddrBus]  mem_addr__reg_ex_mem__stage_mem;
    wire [`RegBus]      mem_data__reg_ex_mem__stage_mem;
    wire [`OpBus]       op__reg_ex_mem__stage_mem;
    wire [`CatagoryBus] catagory__reg_ex_mem__stage_mem;
    // stage_mem
    wire [`RegAddrBus]  rd_addr__stage_mem__reg_mem_wb;
    wire rd_write__stage_mem__reg_mem_wb;
    wire [`RegBus]      rd_data__stage_mem__reg_mem_wb;
    // reg_mem_wb
    wire [`RegAddrBus]  rd_addr__reg_mem_wb__stage_wb;
    wire rd_write__reg_mem_wb__stage_wb;
    wire [`RegBus]      rd_data__reg_mem_wb__stage_wb;
    // stage_wb
    
    wire branch_error;
    wire error__stage_ex__reg_pc = branch_error;
    wire error__stage_ex__reg_if_id = branch_error;
    wire error__stage_ex__reg_id_ex = branch_error;
    wire error__stage_ex__ctrl_ram = branch_error;
    wire error__stage_ex__cache_i = branch_error;
    
    ctrl_stall ctrl_stall_(
        .clk(clk), .rst(rst_in),
        .stall_if(stall__stage_if__ctrl_stall), 
        .stall_id(stall__stage_id__ctrl_stall),
        .stall_ex(stall__stage_ex__ctrl_stall),
        .stall_mem(stall__stage_mem__ctrl_stall),
        .stall_reg_pc(stall__ctrl_stall__reg_pc),
        .stall_if_id(stall__ctrl_stall__reg_if_id),
        .stall_id_ex(stall__ctrl_stall__reg_id_ex),
        .stall_ex_mem(stall__ctrl_stall__reg_ex_mem),
        .stall_mem_wb(stall__ctrl_stall__reg_mem_wb)
    );

    wire [`InstAddrBus] pc__stage_if__ctrl_branch = pc__stage_if__reg_if_id;
    
    ctrl_branch ctrl_branch_(
        .clk(clk), .rst(rst_in),
        .pc_i(pc__stage_if__ctrl_branch),
        .pc_o1(pc__ctrl_branch__reg_pc),
        .pc_o2(npc__ctrl_branch__reg_if_id),
        .predict_result(predict_result__ctrl_branch__reg_if_id),
        .branch_pc(branch_pc__stage_ex__ctrl_branch),
        .branch_npc(branch_npc__stage_ex__ctrl_branch),
        .actual_result(actual_result__stage_ex__ctrl_branch),
        .predict_update(predict_update__stage_ex__ctrl_branch)
    );

    wire [2 : 0] mem_len__cache_d__ctrl_ram;
    wire mem_sign__cache_d__ctrl_ram;
    wire [`RegBus] mem_r_addr__cache_d__ctrl_ram;
    wire mem_r_done__ctrl_ram__cache_d;
    wire mem_r_wait__ctrl_ram__cache_d;
    wire [`MemAddrBus] mem_w_addr__cache_d__ctrl_ram;
    wire writting__ctrl_ram__cache_d;
    wire mem_w_wait__ctrl_ram__cache_d;
    
    ctrl_ram ctrl_ram_(
        .clk(clk), .rst(rst_in),    
        .branch_error(error__stage_ex__ctrl_ram),

        .inst_read(inst_read__cache_i__ctrl_ram),
        .inst_addr(inst_addr__cache_i__ctrl_ram),
        .inst_data(inst_data__ctrl_ram__cache_i),
        .inst_done(inst_done__ctrl_ram__cache_i),
        .inst_wait(inst_wait__ctrl_ram__cache_i),

        .mem_sign(mem_sign__cache_d__ctrl_ram),
        .mem_len(mem_len__cache_d__ctrl_ram),
        .mem_read(mem_read__cache_d__ctrl_ram),
        .mem_r_addr(mem_r_addr__cache_d__ctrl_ram),
        .mem_r_data(mem_r_data__ctrl_ram__cache_d),
        .mem_r_done(mem_r_done__ctrl_ram__cache_d),
        .mem_r_wait(mem_r_wait__ctrl_ram__cache_d),

        .mem_write(mem_write__cache_d__ctrl_ram),
        .mem_w_addr(mem_w_addr__cache_d__ctrl_ram),
        .mem_w_data(mem_w_data__cache_d__ctrl_ram),
        .writting(writting__ctrl_ram__cache_d),
        .mem_w_wait(mem_w_wait__ctrl_ram__cache_d),

        .io_buffer_full(io_buffer_full),
        .ram_r_w(mem_wr), .ram_addr(mem_a),
        .ram_w_data(mem_dout), .ram_r_data(mem_din)
    );

    wire [`InstAddrBus] pc__stage_if__cache_i = pc__stage_if__reg_if_id;

    cache_i cache_i_(
        .clk(clk), .rst(rst_in), 
        .branch_error(error__stage_ex__cache_i),
        
        .request_i(request__stage_if__cache_i),
        .addr_i(pc__stage_if__cache_i),
        .data_o(inst__cache_i__stage_if),
        .done_o(done__cache_i__stage_if),

        .request_o(inst_read__cache_i__ctrl_ram),
        .addr_o(inst_addr__cache_i__ctrl_ram),
        .data_i(inst_data__ctrl_ram__cache_i),
        .done_i(inst_done__ctrl_ram__cache_i),
        .wait_i(inst_wait__ctrl_ram__cache_i)
    );

    cache_d cache_d_(
        .clk(clk), .rst(rst_in), 

        .sign_i(sign__stage_mem__cache_d),
        .len_i(len__stage_mem__cache_d),
        .read_i(read__stage_mem__cache_d),
        .write_i(write__stage_mem__cache_d),
        .addr_i(addr__stage_mem__cache_d),
        .data_o(r_data__cache_d__stage_mem),
        .data_i(w_data__stage_mem__cache_d),
        .done_o(done__cache_d__stage_mem),

        .read_o(mem_read__cache_d__ctrl_ram),
        .sign_o(mem_sign__cache_d__ctrl_ram),
        .len_o(mem_len__cache_d__ctrl_ram),
        .r_addr_o(mem_r_addr__cache_d__ctrl_ram),
        .r_data_i(mem_r_data__ctrl_ram__cache_d),
        .r_done_i(mem_r_done__ctrl_ram__cache_d),
        .r_wait_i(mem_r_wait__ctrl_ram__cache_d),

        .write_o(mem_write__cache_d__ctrl_ram),
        .w_addr_o(mem_w_addr__cache_d__ctrl_ram),
        .w_data_o(mem_w_data__cache_d__ctrl_ram),
        .w_wait_i(mem_w_wait__ctrl_ram__cache_d),
        .writting(writting__ctrl_ram__cache_d)
        
    );

    reg_file reg_file_(
        .clk(clk), .rst(rst_in), 
        .w_addr(write_addr__stage_wb__reg_file),
        .write_request(write_request__stage_wb__reg_file),
        .w_data(write_data__stage_wb__reg_file),

        .r_addr1(read_addr1__stage_id__reg_file),
        .read_request1(read_request1__stage_id__reg_file),
        .r_data1(read_data1__stage_id__reg_file),

        .r_addr2(read_addr2__stage_id__reg_file),
        .read_request2(read_request2__stage_id__reg_file),
        .r_data2(read_data2__stage_id__reg_file)
    );

    reg_pc reg_pc_(
        .clk(clk), .rst(rst_in), 
        .stall(stall__ctrl_stall__reg_pc),

        .branch_error(error__stage_ex__reg_pc),
        .branch_npc(branch_npc__stage_ex__reg_pc),
        .pc_i(pc__ctrl_branch__reg_pc),
        .pc_o(pc__reg_pc_stage_if)
    );
        
    stage_if stage_if_(
        .rst(rst_in),
        .pc_i(pc__reg_pc_stage_if),
        .ram_request(request__stage_if__cache_i),
        .ram_done(done__cache_i__stage_if),
        
        .inst_i(inst__cache_i__stage_if),
        .inst_o(inst__stage_if__reg_if_id),
        .pc_o(pc__stage_if__reg_if_id),
        
        .stall_o(stall__stage_if__ctrl_stall)
    );

    reg_if_id reg_if_id_(
        .clk(clk), .rst(rst_in),
        .stall(stall__ctrl_stall__reg_if_id),
        .branch_error(error__stage_ex__reg_if_id),

        .pc_i(pc__stage_if__reg_if_id),
        .inst_i(inst__stage_if__reg_if_id),
        .predict_result_i(predict_result__ctrl_branch__reg_if_id),
        .next_pc_i(npc__ctrl_branch__reg_if_id),

        .pc_o(pc__reg_if_id__stage_id),
        .inst_o(inst__reg_if_id__stage_id),
        .predict_result_o(predict_result__reg_if_id__stage_id),
        .next_pc_o(npc__reg_if_id__stage_id)
    );
    
    wire [`RegAddrBus] addr__stage_ex__stage_id = rd_addr__stage_ex__reg_ex_mem;
    wire write__stage_ex__stage_id = rd_write__stage_ex__reg_ex_mem;
    wire load__stage_ex__stage_id = rd_load__stage_ex__reg_ex_mem;
    wire [`RegBus] data__stage_ex__stage_id = rd_data__stage_ex__reg_ex_mem;
    
    wire [`RegAddrBus] addr__stage_mem__stage_id = rd_addr__stage_mem__reg_mem_wb;
    wire write__stage_mem__stage_id = rd_write__stage_mem__reg_mem_wb;
    wire [`RegBus] data__stage_mem__stage_id = rd_data__stage_mem__reg_mem_wb;
    
    stage_id stage_id_(
        .pc_i(pc__reg_if_id__stage_id),
        .inst_i(inst__reg_if_id__stage_id),
        .pc_o(pc__stage_id__reg_id_ex),

        .read_request1(read_request1__stage_id__reg_file),
        .read_addr1(read_addr1__stage_id__reg_file),
        .read_data1(read_data1__stage_id__reg_file),

        .read_request2(read_request2__stage_id__reg_file),
        .read_addr2(read_addr2__stage_id__reg_file),
        .read_data2(read_data2__stage_id__reg_file),

        .ex_load(load__stage_ex__stage_id),
        .ex_write(write__stage_ex__stage_id),
        .ex_rd_addr(addr__stage_ex__stage_id),
        .ex_rd_data(data__stage_ex__stage_id),
        .mem_write(write__stage_mem__stage_id),
        .mem_rd_addr(addr__stage_mem__stage_id),
        .mem_rd_data(data__stage_mem__stage_id),

        .rs1_data(rs1_data__stage_id__reg_id_ex),
        .imm1(imm1__stage_id__reg_id_ex),
        .imm_rs1_sel(imm_rs1_sel__stage_id__reg_id_ex),

        .rs2_data(rs2_data__stage_id__reg_id_ex),
        .imm2(imm2__stage_id__reg_id_ex),
        .imm_rs2_sel(imm_rs2_sel__stage_id__reg_id_ex),

        .rd_addr(rd_addr__stage_id__reg_id_ex),
        .rd_write(rd_write__stage_id__reg_id_ex),
        .rd_load(rd_load__stage_id__reg_id_ex),

        .op(op__stage_id__reg_id_ex),
        .catagory(catagory__stage_id__reg_id_ex),

        .branch(branch__stage_id__reg_id_ex),
        .jump(jump__stage_id__reg_id_ex),
        .branch_addr(branch_addr__stage_id__reg_id_ex),
        .branch_offset(branch_offset__stage_id__reg_id_ex),

        .predict_result_i(predict_result__reg_if_id__stage_id),
        .npc_i(npc__reg_if_id__stage_id),
        .predict_result_o(predict_result__stage_id__reg_id_ex),
        .npc_o(npc__stage_id__reg_id_ex),

        .stall_o(stall__stage_id__ctrl_stall)
    );

    reg_id_ex reg_id_ex_(
        .clk(clk), .rst(rst_in),    
        .stall(stall__ctrl_stall__reg_id_ex),
        .branch_error(error__stage_ex__reg_id_ex),
        
        .pc_i(pc__stage_id__reg_id_ex),
        .pc_o(pc__reg_id_ex__stage_ex),
        
        .rs1_data_i(rs1_data__stage_id__reg_id_ex),
        .imm1_i(imm1__stage_id__reg_id_ex),
        .imm_rs1_sel_i(imm_rs1_sel__stage_id__reg_id_ex),
        
        .rs2_data_i(rs2_data__stage_id__reg_id_ex),
        .imm2_i(imm2__stage_id__reg_id_ex),
        .imm_rs2_sel_i(imm_rs2_sel__stage_id__reg_id_ex),

        .rs1_data_o(rs1_data__reg_id_ex__stage_ex),
        .imm1_o(imm1__reg_id_ex__stage_ex),
        .imm_rs1_sel_o(imm_rs1_sel__reg_id_ex__stage_ex),
        .rs2_data_o(rs2_data__reg_id_ex__stage_ex),
        .imm2_o(imm2__reg_id_ex__stage_ex),
        .imm_rs2_sel_o(imm_rs2_sel__reg_id_ex__stage_ex),

        .rd_addr_i(rd_addr__stage_id__reg_id_ex),
        .rd_write_i(rd_write__stage_id__reg_id_ex),
        .rd_load_i(rd_load__stage_id__reg_id_ex),

        .rd_addr_o(rd_addr__reg_id_ex__stage_ex),
        .rd_write_o(rd_write__reg_id_ex__stage_ex),
        .rd_load_o(rd_load__reg_id_ex__stage_ex),

        .op_i(op__stage_id__reg_id_ex),
        .catagory_i(catagory__stage_id__reg_id_ex),
        .op_o(op__reg_id_ex__stage_ex),
        .catagory_o(catagory__reg_id_ex__stage_ex),

        .branch_i(branch__stage_id__reg_id_ex),
        .jump_i(jump__stage_id__reg_id_ex),
        .branch_addr_i(branch_addr__stage_id__reg_id_ex),
        .branch_offset_i(branch_offset__stage_id__reg_id_ex),

        .branch_o(branch__reg_id_ex__stage_ex),
        .jump_o(jump__reg_id_ex__stage_ex),
        .branch_addr_o(branch_addr__reg_id_ex__stage_ex),
        .branch_offset_o(branch_offset__reg_id_ex__stage_ex),

        .predict_result_i(predict_result__stage_id__reg_id_ex),
        .npc_i(npc__stage_id__reg_id_ex),
        .predict_result_o(predict_result__reg_id_ex__stage_ex),
        .npc_o(npc__reg_id_ex__stage_ex)
    );

    stage_ex stage_ex_(
        .pc_i(pc__reg_id_ex__stage_ex),
        .rs1_data(rs1_data__reg_id_ex__stage_ex),
        .imm1(imm1__reg_id_ex__stage_ex),
        .imm_rs1_sel(imm_rs1_sel__reg_id_ex__stage_ex),

        .rs2_data(rs2_data__reg_id_ex__stage_ex),
        .imm2(imm2__reg_id_ex__stage_ex),
        .imm_rs2_sel(imm_rs2_sel__reg_id_ex__stage_ex),

        .rd_addr_i(rd_addr__reg_id_ex__stage_ex),
        .rd_write_i(rd_write__reg_id_ex__stage_ex),
        .rd_load_i(rd_load__reg_id_ex__stage_ex),
        
        .rd_addr_o(rd_addr__stage_ex__reg_ex_mem),
        .rd_write_o(rd_write__stage_ex__reg_ex_mem),
        .rd_load_o(rd_load__stage_ex__reg_ex_mem),
        .rd_data(rd_data__stage_ex__reg_ex_mem),

        .op_i(op__reg_id_ex__stage_ex),
        .catagory_i(catagory__reg_id_ex__stage_ex),
        .op_o(op__stage_ex__reg_ex_mem),
        .catagory_o(catagory__stage_ex__reg_ex_mem),
        
        .mem_addr(mem_addr__stage_ex__reg_ex_mem),
        .mem_data(mem_data__stage_ex__reg_ex_mem),

        .branch(branch__reg_id_ex__stage_ex),
        .jump(jump__reg_id_ex__stage_ex),
        .branch_addr(branch_addr__reg_id_ex__stage_ex),
        .branch_offset(branch_offset__reg_id_ex__stage_ex),

        .npc(npc__reg_id_ex__stage_ex),
        .predict_result(predict_result__reg_id_ex__stage_ex),
        .predict_error(branch_error),
        .predict_update(predict_update__stage_ex__ctrl_branch),
        .actual_result(actual_result__stage_ex__ctrl_branch),
        .branch_npc(branch_npc__stage_ex_o),
        .branch_pc(branch_pc__stage_ex__ctrl_branch),

        .stall_o(stall__stage_ex__ctrl_stall)
    
    );

    reg_ex_mem reg_ex_mem_(
        .clk(clk), .rst(rst_in),
        .stall(stall__ctrl_stall__reg_ex_mem),

        .rd_addr_i(rd_addr__stage_ex__reg_ex_mem),
        .rd_write_i(rd_write__stage_ex__reg_ex_mem),
        .rd_load_i(rd_load__stage_ex__reg_ex_mem),
        .rd_data_i(rd_data__stage_ex__reg_ex_mem),

        .rd_load_o(load__reg_ex_mem__stage_ex),
        .rd_addr_o(rd_addr__reg_ex_mem__stage_mem),
        .rd_write_o(rd_write__reg_ex_mem__stage_mem),
        .rd_data_o(rd_data__reg_ex_mem__stage_mem),

        .mem_addr_i(mem_addr__stage_ex__reg_ex_mem),
        .mem_data_i(mem_data__stage_ex__reg_ex_mem),
        .op_i(op__stage_ex__reg_ex_mem),
        .catagory_i(catagory__stage_ex__reg_ex_mem),

        .mem_addr_o(mem_addr__reg_ex_mem__stage_mem),
        .mem_data_o(mem_data__reg_ex_mem__stage_mem),
        .op_o(op__reg_ex_mem__stage_mem),
        .catagory_o(catagory__reg_ex_mem__stage_mem)
    ); 

    stage_mem stage_mem_(
        .rd_addr_i(rd_addr__reg_ex_mem__stage_mem),
        .rd_write_i(rd_write__reg_ex_mem__stage_mem),
        .rd_data_i(rd_data__reg_ex_mem__stage_mem),

        .rd_addr_o(rd_addr__stage_mem__reg_mem_wb),
        .rd_write_o(rd_write__stage_mem__reg_mem_wb),
        .rd_data_o(rd_data__stage_mem__reg_mem_wb),

        .mem_addr_i(mem_addr__reg_ex_mem__stage_mem),
        .mem_data_i(mem_data__reg_ex_mem__stage_mem),
        .op(op__reg_ex_mem__stage_mem),
        .catagory(catagory__reg_ex_mem__stage_mem),

        .mem_read(read__stage_mem__cache_d),
        .mem_write(write__stage_mem__cache_d),
        .mem_signed(sign__stage_mem__cache_d),
        .mem_addr_o(addr__stage_mem__cache_d),
        .mem_len_o(len__stage_mem__cache_d),
        .mem_r_data(r_data__cache_d__stage_mem),
        .mem_w_data(w_data__stage_mem__cache_d),
        .mem_done(done__cache_d__stage_mem),

        .stall_o(stall__stage_mem__ctrl_stall)
    );
    
    reg_mem_wb reg_mem_wb(
        .clk(clk), .rst(rst_in),
        .stall(stall__ctrl_stall__reg_mem_wb),
        .rd_addr_i(rd_addr__stage_mem__reg_mem_wb),
        .rd_write_i(rd_write__stage_mem__reg_mem_wb),
        .rd_data_i(rd_data__stage_mem__reg_mem_wb),

        .rd_addr_o(rd_addr__reg_mem_wb__stage_wb),
        .rd_write_o(rd_write__reg_mem_wb__stage_wb),
        .rd_data_o(rd_data__reg_mem_wb__stage_wb)
    ); 

    stage_wb stage_wb_(
        .rd_addr_i(rd_addr__reg_mem_wb__stage_wb),
        .rd_write_i(rd_write__reg_mem_wb__stage_wb),
        .rd_data_i(rd_data__reg_mem_wb__stage_wb),

        .rd_addr_o(write_addr__stage_wb__reg_file),
        .rd_write_o(write_request__stage_wb__reg_file),
        .rd_data_o(write_data__stage_wb__reg_file)
    );

endmodule