module tb_top;

reg clk, rst_n;

always #5 clk = ~clk;

initial
begin
    $dumpfile("tb_top.vcd");
    $dumpvars(0,tb_top);
end

initial
begin
  clk   = 0;
  rst_n = 1;
  #5    rst_n = 0;
  #10   rst_n = 1;
  #1000 $finish;
end

core core_inst(
                .i_clk       (clk),
                .i_rst_n     (rst_n),
                .i_instr     (),
                .i_ld_data   (),
                .o_st_data   (),
                .o_instr_addr(),
                .o_data_addr ()
  );

dp_sram instr_mem_inst(
                        .i_clk  (clk),
                        .i_rst_n(rst_n),
                        .i_we   (),
                        .i_addr (),
                        .i_wdata(),
                        .o_rdata()
  );

dp_sram data_mem_inst(
                      .i_clk  (clk),
                      .i_rst_n(rst_n),
                      .i_we   (),
                      .i_addr (),
                      .i_wdata(),
                      .o_rdata()
  );

endmodule