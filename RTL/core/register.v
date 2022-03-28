//--------------------------------------------------------------------
// Design Name : register
// File Name   : register.v
// Function    : General Registers 
// Designer    : Chen Xiaowei         - Nanyang technological University 
//                                    - Technische Universität München
// Email       : chen1408@e.ntu.edu.sg
// Blog        : haitianzhishang.github.io
//---------------------------------------------------------------------
module register (
  input                         i_clk,    
  input                         i_rst_n, 
  input  [`RS_WIDTH-1      : 0] i_rs,
  input  [`RT_WIDTH-1      : 0] i_rt,
  input  [`RD_WIDTH-1      : 0] i_rd,
  input  [`REGISTER_WIDTH-1: 0] i_rd_data,
  output [`REGISTER_WIDTH-1: 0] o_rs_data,
  output [`REGISTER_WIDTH-1: 0] o_rt_data
);

  integer i;
  reg [`REGISTER_WIDTH-1: 0] general_reg[`REGISTER_NUM-1:0];

  always@(posedge i_clk or negedge i_rst_n) 
  begin
    if(!i_rst_n) 
    begin
      for(i=0;i<`REGISTER_NUM;i=i+1)
        general_reg[i] <= 'b0;
    end
    else
      general_reg[i_rd] <= i_rd_data;
  end

  assign o_rs_data = general_reg[i_rs];
  assign o_rt_data = general_reg[i_rt];

endmodule