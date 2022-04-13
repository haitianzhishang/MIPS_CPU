//--------------------------------------------------------------------
// Design Name : mem_intf
// File Name   : mem_intf.v
// Function    :  
// Designer    : Chen Xiaowei         - Nanyang technological University 
//                                    - Technische Universität München
// Email       : chen1408@e.ntu.edu.sg
// Blog        : haitianzhishang.github.io
//---------------------------------------------------------------------
module mem_intf #(
  parameter  BUS_DATA_WIDTH = 32,
  parameter  BUS_ADDR_WIDTH = 32
)
(
  input                           i_clk,    
  input                           i_rst_n, 
  output                          o_bus_we,
  input  [BUS_DATA_WIDTH-1  : 0]  i_bus_data,
  output [BUS_DATA_WIDTH-1  : 0]  o_bus_data,
  output [BUS_ADDR_WIDTH-1  : 0]  o_bus_addr,

  input                           i_we,
  output [BUS_DATA_WIDTH-1  : 0]  o_ld_data,
  input  [BUS_DATA_WIDTH-1  : 0]  i_st_data,
  input  [BUS_ADDR_WIDTH-1  : 0]  i_data_addr
);

  assign o_ld_data  = i_bus_data;
  assign o_bus_data = i_st_data;
  assign o_bus_we   = i_we;
  assign o_bus_addr = i_data_addr; 

endmodule