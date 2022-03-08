//--------------------------------------------------------------------
// Design Name : alu
// File Name   : alu.v
// Function    :  
// Designer    : Chen Xiaowei         - Nanyang technological University 
//                                    - Technische Universität München
// Email       : chen1408@e.ntu.edu.sg
// Blog         : haitianzhishang.github.io
//---------------------------------------------------------------------
module alu #(
  paramater  
)
(
  input     [ 5: 0] func,    
  input     [31: 0] op_0,
  input     [31: 0] op_1,
  output    [31: 0] result
);

wire [31: 0] signed_add_0,signed_add_1,signed_add_result;
wire [31: 0] unsigned_add_0,unsigned_add_1,unsigned_add_result;
wire [31: 0] signed_sub_0,signed_sub_1,signed_sub_result;
wire [31: 0] unsigned_sub_0,unsigned_sub_1,unsigned_sub_result;
wire [31: 0] signed_mul_0,signed_mul_1,signed_mul_result;
wire [31: 0] unsigned_mul_0,unsigned_mul_1,unsigned_mul_result;
wire [31: 0] signed_div_0,signed_div_1,signed_div_result;
wire [31: 0] unsigned_div_0,unsigned_div_1,unsigned_div_result;
wire [31: 0] and_0,and_1,and_result;
wire [31: 0] or_0,or_1,or_result;
wire [31: 0] xor_0,xor_1,xor_result;
wire [31: 0] nor_0,nor_1,nor_result;
wire [31: 0] signed_shiftl_0,signed_shiftl_1,signed_shiftl_result;
wire [31: 0] signed_shiftr_0,signed_shiftr_1,signed_shiftr_result;
wire [31: 0] unsigned_shiftr_0,unsigned_shiftr_1,unsigned_shiftr_result;

//Operand bingding
always @(*) 
begin
  case (func)
    6'h0:
    begin
      signed_add_0    = op_0;
      signed_add_1    = op_1;
      result          = signed_add_result;
    end
    6'h1:
    begin
      unsigned_add_0  = op_0;
      unsigned_add_1  = op_1;
      result          = unsigned_add_result;
    end
    6'h2:
    begin
      signed_sub_0    = op_0;
      signed_sub_1    = op_1;
      result          = signed_sub_result;
    end
    6'h3:
    begin
      unsigned_sub_0  = op_0;
      unsigned_sub_1  = op_1;
      result          = unsigned_sub_result;
    end
    6'h4:
    begin
      signed_mul_0    = op_0;
      signed_mul_1    = op_1;
      result          = signed_mul_result;
    end
    6'h5:
    begin
      unsigned_mul_0  = op_0;
      unsigned_mul_1  = op_1;
      result          = unsigned_mul_result;
    end
    6'h6:
    begin
      signed_div_0    = op_0;
      signed_div_1    = op_1;
      result          = signed_div_result;
    end
    6'h7:
    begin
      unsigned_div_0  = op_0;
      unsigned_div_1  = op_1;
      result          = unsigned_div_result;
    end
    6'h8:
    begin
      and_0           = op_0;
      and_1           = op_1;
      result          = and_result;
    end
    6'h9:
    begin
      or_0            = op_0;
      or_1            = op_1;
      result          = or_result;
    end
    6'h10:
    begin
      xor_0           = op_0;
      xor_1           = op_1;
      result          = xor_result;
    end
    6'h11:
    begin
      nor_0           = op_0;
      nor_1           = op_1;
      result          = nor_result;
    end
    6'h12:
    begin
      signed_shiftl_0   = op_0;
      signed_shiftl_1   = op_1;
      result            = signed_shiftl_result;
    end
    6'h13:
    begin
      signed_shiftr_0   = op_0;
      signed_shiftr_1   = op_1;
      result            = signed_shiftr_result;
    end
    6'h14:
    begin
      unsigned_shiftr_0  = op_0;
      unsigned_shiftr_1  = op_1;
      result             = unsigned_shiftr_result;
    end
    default: 
      signed_add_0    = op_0;
      signed_add_1    = op_1;
      result          = 32'b0;
  endcase

end


//unsigned
always@(*) 
begin

end

endmodule : alu