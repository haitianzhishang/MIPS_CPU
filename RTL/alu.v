//--------------------------------------------------------------------
// Design Name : alu
// File Name   : alu.v
// function    :  
// Designer    : Chen Xiaowei         - Nanyang technological University 
//                                    - Technische Universität München
// Email       : chen1408@e.ntu.edu.sg
// Blog        : haitianzhishang.github.io
//---------------------------------------------------------------------
`include "alu_def.v"
module alu(
  input  [`DATA_WIDTH-1 : 0] i_op_0,
  input  [`DATA_WIDTH-1 : 0] i_op_1,
  input  [`FUNCT_WIDTH-1: 0] i_operation,
  output [`DATA_WIDTH-1 : 0] o_result
);
  
  reg [`DATA_WIDTH-1: 0] result_temp;

  //Operand binding
  always @(*) 
  begin
    case (i_operation)
      `SIGNED_ADD:   result_temp = $signed(i_op_0)+$signed(i_op_1);

      `UNSIGNED_ADD: result_temp = i_op_0+i_op_1;

      `SIGNED_SUB:   result_temp = $signed(i_op_0)+$signed(i_op_1);

      `UNSIGNED_SUB: result_temp = i_op_0-i_op_1;

      `SIGNED_MUL:   result_temp = $signed(i_op_0)*$signed(i_op_1);

      `UNSIGNED_MUL: result_temp = i_op_0*i_op_1;

      `SIGNED_DIV:   result_temp = $signed(i_op_0)/$signed(i_op_1);

      `UNSIGNED_DIV: result_temp = i_op_0/i_op_1;

      `AND:          result_temp = i_op_0&i_op_1;

      `OR:           result_temp = i_op_0|i_op_1;

      `XOR:          result_temp = i_op_0^i_op_1;

      `NOR:          result_temp = ~(i_op_0^i_op_1);

      `SIGNED_SHIFTL:    result_temp = i_op_0<<<i_op_1;

      `SIGNED_SHIFTR:    result_temp = i_op_0>>>i_op_1;

      `UNSIGNED_SHIFTR:  result_temp = i_op_0>>i_op_1;

    endcase // operation
     
  end

  assign o_result = result_temp;

endmodule