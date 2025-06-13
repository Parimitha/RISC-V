module mux2(c,d,sele,outp);
  input [31:0]c,d;
  input sele;
  output reg [31:0]outp;
  assign outp=(sele==1)?d:c;
endmodule
