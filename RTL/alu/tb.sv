module tb;

  reg clk;

  always #5 clk = !clk;

  initial
  begin
    
    clk = 0;
    $dumpfile("wave.vcd");        
    $dumpvars(0, tb);  
    #100;
    $finish;
  end

endmodule : tb