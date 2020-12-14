`define ZeroWord        32'h00000000
`define WordBus         31:0
`define True            1'b1
`define False           1'b0

`define InstAddrBus     31:0
`define InstBus         31:0

`define ResetEnable     1'b1
`define ChipEnable      1'b1
`define ReadEnable      1'b1
`define WriteEnable     1'b1

`define ResetDisable    1'b0
`define ChipDisable     1'b0
`define ReadDisable     1'b0
`define WriteDisable    1'b0

// regfile.v
`define RegAddrBus      4:0
`define RegAddrWidth    5
`define RegBus          31:0
`define RegWidth        32
`define RegNum          32

`define Hold            2'b01
`define Pass            2'b00
`define Bubb            2'b11

// inst 
`define inst_lui    0
`define inst_auipc  1
`define inst_jal    2
`define inst_jalr   3
`define inst_beq    4
`define inst_bne    5
`define inst_blt    6
`define inst_bge    7
`define inst_bltu   8
`define inst_bgeu   9  
`define inst_lb     10
`define inst_lh     11
`define inst_lw     12
`define inst_lbu    13
`define inst_lhu    14
`define inst_sb     15
`define inst_sh     16
`define inst_sw     17
`define inst_addi   18
`define inst_slti   19
`define inst_sltiu  20
`define inst_xori   21
`define inst_ori    22
`define inst_addi   23
`define inst_slli   24
`define inst_srli   25
`define inst_srai   26
`define inst_add    27
`define inst_sub    28
`define inst_sll    29
`define inst_slt    30
`define inst_sltu   31
`define inst_xor    32
`define inst_srl    33
`define inst_sra    34
`define inst_or     35
`define inst_and    36
// catagory
`define catagory_shifts     0
`define catagory_arithmetic 1
`define catagory_ 1
// op
`define op_add  0
`define op_sub  1

`define op_sll  0
`define op_srl  1
`define 

`define op_slt  3
`define op_sltu 4
`define op_xor  5
`define op_sra  6
`define op_srl  7
`define op_or   8
`define op_and  9
`define op_eq   10



