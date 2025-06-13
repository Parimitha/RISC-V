module mux3(p,q,s,outpt);
  input [31:0]p,q;
  input s;
  output reg [31:0]outpt;
  assign outpt=(s==0)?p:q;
endmodule
