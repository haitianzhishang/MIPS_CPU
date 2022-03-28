module tb_top;

core core_inst(
                .i_clk       (i_clk),
                .i_rst_n     (i_rst_n),
                .i_instr     (i_instr),
                .i_ld_data   (i_ld_data),
                .o_st_data   (o_st_data),
                .o_instr_addr(o_instr_addr),
                .o_data_addr (o_data_addr)
  );

dp_sram instr_mem_inst(
                        .i_clk  (i_clk),
                        .i_rst_n(i_rst_n),
                        .i_we   (i_we),
                        .i_addr (i_addr),
                        .i_wdata(i_wdata),
                        .o_rdata(o_rdata)
  );

dp_sram data_mem_inst(
                      .i_clk  (i_clk),
                      .i_rst_n(i_rst_n),
                      .i_we   (i_we),
                      .i_addr (i_addr),
                      .i_wdata(i_wdata),
                      .o_rdata(o_rdata)
  );

endmodule