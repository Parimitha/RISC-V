module andg(branch,zero,a);
  input branch,zero;
  output a;
  assign a=branch & zero;
endmodule
