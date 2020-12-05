`define ZERO            32'h00000000
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

`define StallBus        5:0