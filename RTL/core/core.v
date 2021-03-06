//--------------------------------------------------------------------
// Design Name : core
// File Name   : core.sv
// Function    :  
// Designer    : Chen Xiaowei         - Nanyang technological University 
//                                    - Technische Universität München
// Email       : chen1408@e.ntu.edu.sg
// Blog        : haitianzhishang.github.io
//---------------------------------------------------------------------
`include "instr_def.v"
module core(
  input                           i_clk,    
  input                           i_rst_n, 

  output                          o_instr_bus_we,
  input  [`INSTR_WIDTH-1     : 0] i_instr_bus_data,
  output [`INSTR_WIDTH-1     : 0] o_instr_bus_data,
  output [`INSTR_ADDR_WIDTH-1: 0] o_instr_bus_addr,
  
  output                          o_data_bus_we,
  input  [`DATA_WIDTH-1      : 0] i_data_bus_data,
  output [`DATA_WIDTH-1      : 0] o_data_bus_data,
  output [`DATA_ADDR_WIDTH-1 : 0] o_data_bus_addr
);

  wire [`INSTR_WIDTH-1     : 0] instr;
  reg  [`DATA_WIDTH-1      : 0] ld_data;
  reg  [`DATA_WIDTH-1      : 0] st_data;
  reg  [`INSTR_WIDTH-1     : 0] if_id_instr_reg;
  reg  [`INSTR_ADDR_WIDTH-1: 0] if_id_pc_reg;

  wire [`OP_WIDTH-1        : 0] op;
  wire [`RS_WIDTH-1        : 0] rs;
  wire [`RT_WIDTH-1        : 0] rt;
  wire [`RD_WIDTH-1        : 0] rd;
  wire [`SHAMT_WIDTH-1     : 0] shamt;
  wire [`FUNCT_WIDTH-1     : 0] funct;
  wire [`IMMED_WIDTH-1     : 0] immed;
  reg  [`INSTR_ADDR_WIDTH-1: 0] id_ex_pc_reg;
  
  reg  [`RT_WIDTH-1        : 0] id_ex_rt_reg;
  reg  [`RD_WIDTH-1        : 0] id_ex_rd_reg;
  reg  [`REGISTER_WIDTH-1  : 0] id_ex_rs_data_reg;
  reg  [`REGISTER_WIDTH-1  : 0] id_ex_rt_data_reg;
  reg  [`FUNCT_WIDTH-1     : 0] id_ex_funct_reg;
  reg  [`IMMED_WIDTH+1     : 0] id_ex_immed_reg;
  reg                           id_ex_rtype_reg;
  reg                           id_ex_itype_reg;
  reg                           id_ex_jtype_reg;
  reg                           id_ex_beq_reg;
  reg                           id_ex_bne_reg;
  reg                           id_ex_blez_reg;
  reg                           id_ex_bgez_reg;
  reg 													id_ex_sb_reg;
  reg 													id_ex_sh_reg;
  reg 													id_ex_sw_reg;
  reg 													id_ex_lb_reg;
  reg 													id_ex_lh_reg;
  reg 													id_ex_lw_reg;
  reg 													id_ex_ulb_reg;
  reg 													id_ex_ulh_reg;

  wire [`INSTR_ADDR_WIDTH-1: 0] instr_addr;
  wire [`DATA_ADDR_WIDTH-1 : 0] data_addr;
  reg  [`RT_WIDTH-1        : 0] ex_mem_rt_reg;
  reg  [`RD_WIDTH-1        : 0] ex_mem_rd_reg;
  reg  [`INSTR_ADDR_WIDTH-1: 0] ex_mem_pc_reg;
  reg  [`DATA_WIDTH-1      : 0] ex_mem_result_reg;
	reg                           ex_mem_beq_reg;
	reg                           ex_mem_bne_reg;
	reg                           ex_mem_blez_reg;
	reg                           ex_mem_bgez_reg;
	reg                           ex_mem_sb_reg;
	reg                           ex_mem_sh_reg;
	reg                           ex_mem_sw_reg;
	reg                           ex_mem_lb_reg;
	reg                           ex_mem_lh_reg;
	reg                           ex_mem_lw_reg;
	reg                           ex_mem_ulb_reg;
	reg                           ex_mem_ulh_reg;

  reg  [`DATA_WIDTH-1     : 0]  mem_wb_mem_data_reg;
  reg  [`REGISTER_WIDTH-1 : 0]  mem_wb_bpc_reg;
  reg                           mem_wb_ld_reg;


  reg  [`RD_WIDTH-1       : 0] wb_id_rd_reg;
  reg  [`REGISTER_WIDTH-1 : 0] wb_id_rd_data_reg;

  wire [`REGISTER_WIDTH-1 : 0] rd_data;
  wire [`REGISTER_WIDTH-1 : 0] rs_data;
  wire [`REGISTER_WIDTH-1 : 0] rt_data;

  wire [`FUNCT_WIDTH-1    : 0] operation;
  wire [`DATA_WIDTH-1     : 0] op_0;
  wire [`DATA_WIDTH-1     : 0] op_1;
  wire [`DATA_WIDTH-1     : 0] result;


//Instruction Fetch Stage
  always@(posedge i_clk or negedge i_rst_n) 
  begin
    if(!i_rst_n) 
    begin
      if_id_instr_reg <= 32'b0;
      if_id_pc_reg    <= 32'b0;
    end
    else
    begin
      if_id_instr_reg <= instr;
      if_id_pc_reg    <= if_id_pc_reg+4;
    end
  end

//Instruction Decode Stage
  assign op    = if_id_instr_reg[31:26];
  assign rs    = if_id_instr_reg[25:21]; 
  assign rt    = if_id_instr_reg[20:16];
  assign rd    = if_id_instr_reg[15:11];
  assign shamt = if_id_instr_reg[10: 6];
  assign funct = if_id_instr_reg[ 5: 0];
  assign immed = if_id_instr_reg[15: 0];
  always @(posedge i_clk or negedge i_rst_n) 
  begin
    if (!i_rst_n) 
    begin
      id_ex_pc_reg      <= 'b0;  //Store PC+4 for an extra cycle
      id_ex_rt_reg      <= 'b0;
      id_ex_rd_reg      <= 'b0;
      id_ex_rs_data_reg <= 'b0;
      id_ex_rt_data_reg <= 'b0;
      id_ex_funct_reg   <= 'b0;
      id_ex_immed_reg   <= 'b0;
      id_ex_rtype_reg   <= 'b0;
      id_ex_itype_reg   <= 'b0;
      id_ex_jtype_reg   <= 'b0;
      id_ex_beq_reg     <= 'b0;
      id_ex_bne_reg     <= 'b0;
      id_ex_blez_reg    <= 'b0;
      id_ex_bgez_reg    <= 'b0;
      id_ex_sb_reg      <= 'b0;
      id_ex_sh_reg      <= 'b0;
      id_ex_sw_reg      <= 'b0;
      id_ex_lb_reg      <= 'b0;
      id_ex_lh_reg      <= 'b0;
      id_ex_lw_reg      <= 'b0;
      id_ex_ulb_reg     <= 'b0;
      id_ex_ulh_reg     <= 'b0;
    end
    else
    begin
      id_ex_pc_reg      <= if_id_pc_reg;  //Store PC+4 for an extra cycle
      id_ex_rt_reg      <= rt;
      id_ex_rd_reg      <= rd;
      id_ex_rs_data_reg <= rs_data;
      id_ex_rt_data_reg <= rt_data;
      id_ex_funct_reg   <= funct;
      id_ex_immed_reg   <= immed<<<2;
      id_ex_rtype_reg   <= (op[`OP_WIDTH-1:`OP_WIDTH-2]==`R_TYPE) ? 1 : 0;
      id_ex_itype_reg   <= (op[`OP_WIDTH-1:`OP_WIDTH-2]==`I_TYPE) ? 1 : 0;
      id_ex_jtype_reg   <= (op[`OP_WIDTH-1:`OP_WIDTH-2]==`J_TYPE) ? 1 : 0;
      id_ex_beq_reg     <= (op==`BEQ)  ? 1 : 0;
      id_ex_bne_reg     <= (op==`BNE)  ? 1 : 0;
      id_ex_blez_reg    <= (op==`BLEZ) ? 1 : 0;
      id_ex_bgez_reg    <= (op==`BGEZ) ? 1 : 0;
      id_ex_sb_reg      <= (op==`SB)   ? 1 : 0;
      id_ex_sh_reg      <= (op==`SH)   ? 1 : 0;
      id_ex_sw_reg      <= (op==`SW)   ? 1 : 0;
      id_ex_lb_reg      <= (op==`LB)   ? 1 : 0;
      id_ex_lh_reg      <= (op==`LH)   ? 1 : 0;
      id_ex_lw_reg      <= (op==`LW)   ? 1 : 0;
      id_ex_ulb_reg     <= (op==`ULB)  ? 1 : 0;
      id_ex_ulh_reg     <= (op==`ULH)  ? 1 : 0;
    end
  end

// ALU Execution Stage
  assign op_0       = (id_ex_beq_reg|id_ex_bne_reg|id_ex_blez_reg|id_ex_bgez_reg) ? id_ex_pc_reg : id_ex_rs_data_reg;
  assign op_1       = id_ex_itype_reg ? id_ex_immed_reg : id_ex_rt_data_reg;
  assign operation  = id_ex_rtype_reg ? id_ex_funct_reg : 6'b1; // Signed addition if no R-type instrcution
  always @(posedge i_clk or negedge i_rst_n) 
  begin
    if (!i_rst_n) 
    begin
      ex_mem_pc_reg     <= 'b0;
      ex_mem_beq_reg    <= 'b0;
      ex_mem_bne_reg    <= 'b0;
      ex_mem_blez_reg   <= 'b0;
      ex_mem_bgez_reg   <= 'b0;
      ex_mem_sb_reg     <= 'b0;
      ex_mem_sb_reg     <= 'b0;
      ex_mem_sh_reg     <= 'b0;
      ex_mem_sw_reg     <= 'b0;
      ex_mem_lb_reg     <= 'b0;
      ex_mem_lh_reg     <= 'b0;
      ex_mem_lw_reg     <= 'b0;
      ex_mem_ulb_reg    <= 'b0;
      ex_mem_ulh_reg    <= 'b0;
      ex_mem_result_reg <= 'b0;
    end
    else
    begin
      ex_mem_rt_reg     <= id_ex_rt_reg;
      ex_mem_rd_reg     <= id_ex_rd_reg;
      ex_mem_pc_reg     <= id_ex_pc_reg;
      ex_mem_beq_reg    <= id_ex_beq_reg;
      ex_mem_bne_reg    <= id_ex_bne_reg;
      ex_mem_blez_reg   <= id_ex_blez_reg;
      ex_mem_bgez_reg   <= id_ex_bgez_reg;
      ex_mem_sb_reg     <= id_ex_sb_reg;
      ex_mem_sh_reg     <= id_ex_sh_reg;
      ex_mem_sw_reg     <= id_ex_sw_reg;
      ex_mem_lb_reg     <= id_ex_lb_reg;
      ex_mem_lh_reg     <= id_ex_lh_reg;
      ex_mem_lw_reg     <= id_ex_lw_reg;
      ex_mem_ulb_reg    <= id_ex_ulb_reg;
      ex_mem_ulh_reg    <= id_ex_ulh_reg;
      ex_mem_result_reg <= result;
    end
  end

// Memory access/Branch Completion Stage
  always @(posedge i_clk or negedge i_rst_n) 
  begin
    if (!i_rst_n) 
    begin
      mem_wb_mem_data_reg <= 'b0;
      mem_wb_ld_reg       <= 'b0;
    end
    else
    begin
      if(ex_mem_lb_reg|ex_mem_lh_reg|ex_mem_lw_reg|ex_mem_ulb_reg|ex_mem_ulh_reg)
      begin
        mem_wb_ld_reg <= 1'b1;
        if(ex_mem_lb_reg)
          mem_wb_mem_data_reg <= ld_data[7] ? {24'b1,ld_data[7:0]} : {24'b0,ld_data[7:0]};
        if(ex_mem_lh_reg)
          mem_wb_mem_data_reg <= ld_data[7] ? {16'b1,ld_data[15:0]} : {16'b0,ld_data[15:0]};
        if(ex_mem_lw_reg)
          mem_wb_mem_data_reg <= ld_data;
        if(ex_mem_ulb_reg)
          mem_wb_mem_data_reg <= {24'b0,ld_data[7:0]};
        if(ex_mem_ulh_reg)
         mem_wb_mem_data_reg <= {24'b0,ld_data[7:0]};
      end
      if(ex_mem_sb_reg)
        st_data <= {24'b0,mem_wb_mem_data_reg};
      if(ex_mem_sh_reg)
        st_data <= {16'b0,mem_wb_mem_data_reg};
      if(ex_mem_sw_reg)
        st_data <= mem_wb_mem_data_reg;  
    end
  end
  assign data_addr    = ex_mem_result_reg;
  assign instr_addr   = ((ex_mem_beq_reg  && (id_ex_rs_data_reg==id_ex_rt_data_reg))|
                         (ex_mem_bne_reg  && (id_ex_rs_data_reg!=id_ex_rt_data_reg))|
                         (ex_mem_blez_reg && (id_ex_rs_data_reg<=0))|
                         (ex_mem_bgez_reg && (id_ex_rs_data_reg>0)))
                         ? ex_mem_result_reg : ex_mem_pc_reg;

// Write Back Stage
  always @(posedge i_clk or negedge i_rst_n) 
  begin
    if (!i_rst_n) 
    begin
      wb_id_rd_reg <= 0;    
    end
    else
    begin
      wb_id_rd_reg        <= rd_data;
      if(mem_wb_ld_reg)
        wb_id_rd_data_reg <= mem_wb_mem_data_reg;
      else
        wb_id_rd_data_reg <= ex_mem_result_reg;
    end
  end

// General Registers
  register register_inst(
                          .i_clk    (i_clk),
                          .i_rst_n  (i_rst_n),
                          .i_rs     (rs),
                          .i_rt     (rt),
                          .i_rd     (rd),
                          .o_rs_data(rs_data),
                          .o_rt_data(rt_data),
                          .i_rd_data(rd_data)
    );
// Arithmetic Logic Unit
  alu alu_inst(
                .i_operation(operation),
                .i_op_0     (op_0),
                .i_op_1     (op_1),
                .o_result   (result)
    );

// Instruction memory interface
  mem_intf  #(
              .BUS_DATA_WIDTH(32),
              .BUS_ADDR_WIDTH(32)
    )
    instr_bus_intf_inst(
                    .i_clk     (i_clk),
                    .i_rst_n   (i_rst_n),
                    .o_bus_we  (o_instr_bus_we),
                    .i_bus_data(i_instr_bus_data),
                    .o_bus_data(o_instr_bus_data),
                    .o_bus_addr(o_instr_bus_addr),
                    .i_we       (1'b0),
                    .o_ld_data  (instr),
                    .i_st_data  (32'b0),
                    .i_data_addr(instr_addr)
    );

// Data memory interface
  mem_intf  #(
              .BUS_DATA_WIDTH(32),
              .BUS_ADDR_WIDTH(32)
    )
    data_bus_intf_inst(
                    .i_clk     (i_clk),
                    .i_rst_n   (i_rst_n),
                    .o_bus_we  (o_data_bus_we),
                    .i_bus_data(i_data_bus_data),
                    .o_bus_data(o_data_bus_data),
                    .o_bus_addr(o_data_bus_addr),
                    .i_we       (data_mem_we),
                    .o_ld_data  (ld_data),
                    .i_st_data  (st_data),
                    .i_data_addr(data_addr)
    );


endmodule
