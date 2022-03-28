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
`define R_TYPE 000000
`define I_TYPE 010000
`define J_TYPE 110000

`define BEQ    010000
`define BNE    010001
`define BLEZ   010010
`define BGEZ   010011

`define SB     010100
`define SH     010101
`define SW     010110

`define LB     011000
`define LH     011001
`define LW     011010
`define ULB    011011
`define ULH    011100


