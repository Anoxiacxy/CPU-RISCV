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

    wire clk;
    always @ (*) begin
        if (rdy_in) 
            clk <= clk_in;
        else
            clk <= clk; 
    end

    wire if_stall_o;
    wire id_stall_o;
    wire ex_stall_o;
    wire mem_stall_o;

    wire [`StallBus] stall_reg_pc_i;
    wire [`StallBus] stall_if_id_i;
    wire [`StallBus] stall_ex_mem_i;
    wire [`StallBus] stall_id_ex_i;
    wire [`StallBus] stall_mem_wb_i;

    wire [`InstAddrBus] pc_reg_pc_stage_if;


    ctrl_stall ctrl_stall_(
        .clk(clk), .rst(rst_in),
        .stall_if(if_stall_o), 
        .stall_id(id_stall_o),
        .stall_ex(ex_stall_o),
        .stall_mem(mem_stall_o),
        .stall_reg_pc(stall_reg_pc_i),
        .stall_if_id(stall_if_id_i),
        .stall_id_ex(stall_id_ex_i),
        .stall_ex_mem(stall_ex_mem_i),
        .stall_mem_wb(stall_mem_wb_i),
    );

    ctrl_branch ctrl_branch_(
        
    );

    ctrl_ram ctrl_ram_(

    );

    reg_pc reg_pc_(
        .clk(clk), .rst(rst_in), .stall(stall_reg_pc_i),
        .branch(),
        .target(),
        .pc_i(),
        .pc_o(pc_reg_pc_stage_if)
    );

    stage_if stage_if_(
        .pc_i(pc_reg_pc_stage_if),
        .
    );

    stage_id stage_id_(

    );

    reg_if_id reg_if_id_(

    );

    

    


endmodule