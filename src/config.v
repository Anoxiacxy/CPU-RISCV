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
`define InstLui    0
`define InstAuipc  1
`define InstJal    2
`define InstJalr   3
`define InstBeq    4
`define InstBne    5
`define InstBlt    6
`define InstBge    7
`define InstBltu   8
`define InstBgeu   9  
`define InstLb     10
`define InstLh     11
`define InstLw     12
`define InstLbu    13
`define InstLhu    14
`define InstSb     15
`define InstSh     16
`define InstSw     17
`define InstAddi   18
`define InstSlti   19
`define InstSltiu  20
`define InstXori   21
`define InstOri    22
`define InstAddi   23
`define InstSlli   24
`define InstSrli   25
`define InstSrai   26
`define InstAdd    27
`define InstSub    28
`define InstSll    29
`define InstSlt    30
`define InstSltu   31
`define InstXor    32
`define InstSrl    33
`define InstSra    34
`define InstOr     35
`define InstAnd    36
// catagory
`define CatagoryBus     2:0
`define CatagoryShift  0
`define OpSll  0
`define OpSrl  1
`define OpSra  2

`define CatagoryArith  1
`define OpAdd  0 
`define OpSub  1

`define CatagoryLogic  2
`define OpXor  0
`define OpOr   1
`define OpAnd  2

`define CatagoryComp   3
`define OpSlt  0
`define OpSltu 1

`define CatagoryBranch 4
`define OpEq   0
`define OpNe   1
`define OpLt   2
`define OpGe   3
`define OpLtu  4
`define OpGeu  5

`define CatagoryJump   5
`define CatagoryLoad   6
`define CatagoryStore  7

// op
`define OpBus  2:0


`define OpcodeLui       7'b0110111
`define OpcodeAuipc     7'b0010111
`define OpcodeJal       7'b1101111
`define OpcodeJalr      7'b1100111
`define OpcodeBranch    7'b1100011
`define OpcodeLoad      7'b0000011
`define OpcodeStore     7'b0100011
`define OpcodeOpi       7'b0010011
`define OpcodeOp        7'b0110011

`define BhtNum      2048
`define LogBhtNum   11
`define BhtIndex    `LogBhtNum + 1 : 2

`define BtbNum      32
`define LogBtbNum   5
`define BtbIndex    `LogBtbNum + 1 : 2
`define BtbTag      31 : `LogBtbNum + 2

`define RamAval     2'b00
`define RamInst     2'b01
`define RamMemr     2'b10
`define RamMemw     2'b11




`define 
