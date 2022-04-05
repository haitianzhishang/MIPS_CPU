//--------------------------------------------------------------------
// Design Name : dp_sram
// File Name   : dp_sram.v
// Function    : Dual Port SRAM
// Designer    : Chen Xiaowei         - Nanyang technological University 
//                                    - Technische Universität München
// Email       : chen1408@e.ntu.edu.sg
// Blog        : haitianzhishang.github.io
//---------------------------------------------------------------------
module dp_sram #(
  parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 8
)
(
  input                      i_clk,    
  input                      i_rst_n, 
  input                      i_we,
  input  [ADDR_WIDTH-1 : 0]  i_addr,
  input  [DATA_WIDTH-1 : 0]  i_wdata,
  output [DATA_WIDTH-1 : 0]  o_rdata
);
  
  localparam DEPTH = 2**ADDR_WIDTH;
  integer i;

  reg [DATA_WIDTH-1: 0] mem [DEPTH-1: 0];
  reg [DATA_WIDTH-1: 0] rdata;

  always@(posedge i_clk or negedge i_rst_n) 
  begin
    if(!i_rst_n) 
    begin
      for(i=0;i<DEPTH;i=i+1)
        mem[i] <= 'b0;
    end
    else
    begin
      if(i_we)
        mem[i_addr] <= i_wdata;
      else
        rdata       <= mem[i_addr];
    end
  end

  assign o_rdata = rdata;

endmodule