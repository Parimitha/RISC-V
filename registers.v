module registers(clk,rst,rr1,rr2,wr,wd,rd1,rd2,regwrite);
  input clk,rst,regwrite;
  input [4:0]rr1,rr2,wr;
  input [31:0]wd;
  output reg [31:0]rd1,rd2;
  reg [31:0] regi[31:0];
  initial begin
    regi[0]=0;
    regi[1]=4;
    regi[2]=2;
    regi[3]=24;
    regi[4]=3;
    regi[5]=20;
    regi[6]=15;
    regi[7]=18;
    regi[8]=6;
    regi[9]=8;
    regi[10]=55;
    regi[11]=30;
    regi[12]=40;
    regi[13]=8;
    regi[14]=10;
    regi[15]=12;
    regi[16]=16;
    regi[17]=18;
    regi[18]=33;
    regi[19]=42;
    regi[20]=12;
    regi[21]=4;
    regi[22]=9;
    regi[23]=7;
    regi[24]=48;
    regi[25]=36;
    regi[26]=23;
    regi[27]=29;
    regi[28]=25;
    regi[29]=34;
    regi[30]=50;
    regi[31]=52;
    regi[32]=27;
  end
  assign rd1=regi[rr1];
  assign rd2=regi[rr2];
  always@(posedge clk)
    begin
      if(rst)
        for(int k=0;k<32;k=k+1)
          regi[k]=32'b0;
      else if(regwrite==1)
        regi[wr]=wd;
    end
endmodule
