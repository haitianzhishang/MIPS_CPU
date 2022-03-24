module multi_tb;

  reg[31: 0] a, b;
  reg[63: 0] c;
  reg clk;

  always #5 clk = ~clk;
  
  initial
  begin
    $dumpfile("wave.vcd");        
    $dumpvars(0, multi_tb);  
    clk = 0;
    #10 a = 32'd10;
    $display("asdasdasd");
    #15 b = 32'd15;
    $finish;
  end

  multi #(
          .IN_DATA_WIDTH (32),
          .OUT_DATA_WIDTH(64)

    ) multi_inst(
                  .a(a),
                  .b(b),
                  .c(c)
    );

endmodule : multi_tb