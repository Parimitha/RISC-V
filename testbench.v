module risc_tb;
  reg clk,rst;
  risc uut(.clk(clk),.rst(rst));
  initial begin
    clk=0; rst=1;
    #10 rst=0;
    #500;
    $finish;
  end
  always begin #5 clk=~clk;
  end 
  initial begin
    $dumpfile("wave.vcd");   
    $dumpvars(0,risc_tb);
  end
endmodule
