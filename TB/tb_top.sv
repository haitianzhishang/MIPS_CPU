`include "instr_def.v"

module tb_top;

  reg clk, rst_n;


  wire                          core_inst_o_instr_bus_we;
  wire [`INSTR_WIDTH-1     : 0] core_inst_i_instr_bus_data;
  wire [`INSTR_WIDTH-1     : 0] core_inst_o_instr_bus_data;
  wire [`INSTR_ADDR_WIDTH-1: 0] core_inst_o_instr_bus_addr;
  wire                          core_inst_o_data_bus_we;
  wire [`DATA_WIDTH-1      : 0] core_inst_i_data_bus_data;
  wire [`DATA_WIDTH-1      : 0] core_inst_o_data_bus_data;
  wire [`DATA_ADDR_WIDTH-1 : 0] core_inst_o_data_bus_addr;

  reg                      instr_mem_inst_i_we;
  wire [8-1 : 0]           instr_mem_inst_i_addr;
  wire [`DATA_WIDTH-1 : 0] instr_mem_inst_i_wdata;
  wire [`DATA_WIDTH-1 : 0] instr_mem_inst_o_rdata;

  reg                      data_mem_inst_i_we;
  wire [8-1 : 0]           data_mem_inst_i_addr;
  wire [`DATA_WIDTH-1 : 0] data_mem_inst_i_wdata;
  wire [`DATA_WIDTH-1 : 0] data_mem_inst_o_rdata;

  logic [`DATA_WIDTH-1  : 0] data_mem[256];
  logic [`INSTR_WIDTH-1 : 0] instr_mem[256];

  always #5 clk = ~clk;

  initial
  begin
      $dumpfile("tb_top.vcd");
      $dumpvars(0,tb_top);
      for(int i=0;i<32;i++)
        $dumpvars(1,core_inst.register_inst.general_reg[i]);
      for(int i=0;i<256;i++)
      begin
        $dumpvars(1,tb_top.instr_mem_inst.mem[i]);
        $dumpvars(1,tb_top.data_mem_inst.mem[i]);
      end
  end

  initial
  begin
    clk   = 0;
    rst_n = 1;
    #5    rst_n = 0;
    #10   rst_n = 1;
    #1000 $finish;
  end

// Data memory initialization
  initial
  begin
    @(posedge rst_n);
    for(int i=0;i<256;i++) 
      data_mem_inst.mem[i] = i;
  end

// Instruction memory initialization
  initial
  begin
    @(posedge rst_n)
    instr_mem_inst.mem[0]=lw(5'b0,5'b0,16'b0);
  end

  core core_inst(
                  .i_clk       (clk),
                  .i_rst_n     (rst_n),
                  .o_instr_bus_we  (core_inst_o_instr_bus_we),
                  .i_instr_bus_data(core_inst_i_instr_bus_data),
                  .o_instr_bus_data(core_inst_o_instr_bus_data),
                  .o_instr_bus_addr(core_inst_o_instr_bus_addr),
                  .o_data_bus_we   (core_inst_o_data_bus_we),
                  .i_data_bus_data (core_inst_i_data_bus_data),
                  .o_data_bus_data (core_inst_o_data_bus_data),
                  .o_data_bus_addr (core_inst_o_data_bus_addr)
    );

  dp_sram #(
            .DATA_WIDTH(32),
            .ADDR_WIDTH(8)
  )
  instr_mem_inst(
                          .i_clk  (clk),
                          .i_rst_n(rst_n),
                          .i_we   (instr_mem_inst_i_we),
                          .i_addr (instr_mem_inst_i_addr),
                          .i_wdata(instr_mem_inst_i_wdata),
                          .o_rdata(instr_mem_inst_o_rdata)
    );

  dp_sram #(
            .DATA_WIDTH(32),
            .ADDR_WIDTH(8)
  ) 
  data_mem_inst(
                        .i_clk  (clk),
                        .i_rst_n(rst_n),
                        .i_we   (data_mem_inst_i_we),
                        .i_addr (data_mem_inst_i_addr),
                        .i_wdata(data_mem_inst_i_wdata),
                        .o_rdata(data_mem_inst_o_rdata)
    );

  assign instr_mem_inst_i_we        = core_inst_o_instr_bus_we;
  assign core_inst_i_instr_bus_data = instr_mem_inst_o_rdata;
  assign instr_mem_inst_i_wdata     = core_inst_o_instr_bus_data;
  assign instr_mem_inst_i_addr      = core_inst_o_instr_bus_addr;

  assign data_mem_inst_i_we         = core_inst_o_data_bus_we;
  assign core_inst_i_data_bus_data  = data_mem_inst_o_rdata;
  assign data_mem_inst_i_wdata      = core_inst_o_data_bus_data;
  assign data_mem_inst_i_addr       = core_inst_o_data_bus_addr;

  function bit[31: 0] lw(bit[4:0] rs, bit[4:0] rt, bit[15:0] imm);
    lw = {6'b011010,rs,rt,imm};
    return lw;
  endfunction

endmodule