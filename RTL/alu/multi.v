//--------------------------------------------------------------------
// Design Name : multi
// File Name   : multi.v
// Function    :  
// Designer    : Chen Xiaowei         - Nanyang technological University 
//                                    - Technische Universität München
// Email       : chen1408@e.ntu.edu.sg
// Blog        : haitianzhishang.github.io
//---------------------------------------------------------------------
module multi #(
  parameter  IN_DATA_WIDTH  = 32
  parameter  OUT_DATA_WIDTH = 64
)
(
  input    [IN_DATA_WIDTH-1: 0]   a,      
  input    [IN_DATA_WIDTH-1: 0]   b,    
  output   [OUT_DATA_WIDTH-1: 0]  c
  
);

localparam BOOTH_NUM = $ceil((DATA_WIDTH+1)/2);
integer i,j;


reg [DATA_WIDTH-1: 0] m1;
reg [DATA_WIDTH-1: 0] m2;
reg [DATA_WIDTH-1: 0] s;
reg [IN_DATA_WIDTH: 0] ppm_temp [BOOTH_NUM];

//Booth-2 encoding
always@(*) 
begin
  m1[0] = 1'b0^a[0];
  m2[0] = ~(1'b0^a[0]|~(a[0]^a[1]));
  s[0]  = a[1];      
  for(i=1;i<BOOTH_NUM;i=i+1)
  begin
    m1[i] = a[i-1]^a[i];//01,10
    m2[i] = ~(a[i-1]^a[i]|~(a[i]^a[i+1]));//011,100
    s[i]  = a[i+1];
  end
end
//Partial Product
always @(*) 
begin
  for(i=0;i<BOOTH_NUM;i=i+1)
  begin
    //First Bit
    ppm_temp[i][0] = (m1[i]&b[0]+m2[i]&1'b0)^s[i];
    for(j=0;j<DATA_WIDTH;j=j+1)
      ppm_temp[i][j] = (m1[i]&b[j]+m2[i]&b[j-1])^s[i];
    //Last Bit
    ppm_temp[i][IN_DATA_WIDTH] = (m1[i]&1'b0+m2[i]&b[IN_DATA_WIDTH-1])^s[i];
  end
end


endmodule : multi