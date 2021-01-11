`define ZeroWord        32'h00000000
`define WordBus         31:0
`define True            1'b1
`define False           1'b0

`define InstAddrBus     31:0
`define InstBus         31:0
`define MemAddrBus      31:0
`define MemDataBus      31:0
`define ByteBus         7:0
`define StallBus        1:0

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
`define BtbTag      17 : `LogBtbNum + 2

`define RamAval     3'b000
`define RamInst     3'b001
`define RamMemr     3'b010
`define RamMemw     3'b011
`define RamAhad     3'b100

`define ICacheSize  64
`define ICacheBlockSize 4
`define LogICacheSize  6
`define ICacheOffset 1 : 0
`define ICacheIndex  `LogICacheSize + 1 : 2
`define ICacheTag    17 : `LogICacheSize + 2

`define DCacheSize  64
`define DCacheBlockSize  4
`define LogDCacheSize  6
`define DCacheOffset 1 : 0
`define DCacheIndex  `LogDCacheSize + 1 : 2
`define DCacheTag    17 : `LogDCacheSize + 2
