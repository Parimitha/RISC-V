module alu_control(alu_op,func7,func3,alu_out);
  input func7;
  input [1:0]alu_op;
  input [2:0]func3;
  output reg [3:0]alu_out;
  always@(*)
    begin
      case({alu_op,func7,func3})
        6'b000000: alu_out <=4'b0010;
        6'b010000: alu_out<=4'b0110;
        6'b100000: alu_out<=4'b0010;
        6'b101000: alu_out<=4'b0110;
        6'b100111: alu_out<=4'b0000;
        6'b100110: alu_out<=4'b0001;
        default: alu_out<=4'b0;
      endcase
    end
endmodule
  
  
  
