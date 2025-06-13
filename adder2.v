module adder2(r1,r2,r3);
  input [31:0]r1,r2;
  output reg [31:0]r3;
  assign r3=r1 + r2;
endmodule
