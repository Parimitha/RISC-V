module alu(a,b,zero,result,alu_c);
  input [31:0]a,b;
  input [3:0]alu_c;
  output reg zero;
  output reg [31:0]result;
  always@(*)
    begin
      case(alu_c)
        4'b0000: result<=a & b;
        4'b0001: result<=a | b;
        4'b0010: result<=a + b;
        4'b0110: result<=a - b;
        default: result<=32'b0;
      endcase
    end 
endmodule
