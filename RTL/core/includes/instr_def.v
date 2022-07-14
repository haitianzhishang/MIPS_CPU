// Instruction Filed
`define OP_WIDTH    6
`define RS_WIDTH    5
`define RT_WIDTH    5
`define RD_WIDTH    5
`define SHAMT_WIDTH 5
`define FUNCT_WIDTH 6
`define IMMED_WIDTH 16
// Common Width
`define INSTR_WIDTH      32
`define INSTR_ADDR_WIDTH 32
`define DATA_WIDTH       32
`define DATA_ADDR_WIDTH  32
`define REGISTER_WIDTH   32
// Size
`define REGISTER_NUM 32
// Instruction Define
`define R_TYPE 2'b00
`define I_TYPE 2'b01
`define J_TYPE 2'b10

`define R_LOGIC  2'b0000
`define I_LOGIC  2'b1111

`define BEQ    6'b010000
`define BNE    6'b010001
`define BLEZ   6'b010010
`define BGEZ   6'b010011

`define SB     6'b010100
`define SH     6'b010101
`define SW     6'b010110

`define LB     6'b011000
`define LH     6'b011001
`define LW     6'b011010
`define ULB    6'b011011
`define ULH    6'b011100


