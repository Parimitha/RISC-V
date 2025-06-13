module program_counter(clk,rst,in,out);
  input clk,rst;
  input [31:0]in;
  output reg[31:0]out;
  always@(posedge clk or posedge rst)
    begin
      if(rst)
        out<=32'b0;
      else
        out<=in;
    end
endmodule

