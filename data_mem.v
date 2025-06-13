module data_mem(clk,rst,address,wd,rd,memwrite,memread);
  input clk,rst,memwrite,memread;
  input [31:0]address,wd;
  output reg[31:0]rd;
  reg [31:0] data[63:0];
  always@(posedge clk or posedge rst)
    begin
      if(rst)
        begin
        for(int i=0;i<64;i=i+1)
            data[i]<=32'b0;
        end
      else if(memwrite)
        begin
        data[address]<=wd;
    end
      assign rd=(memread)?data[address]:32'b0;
    end
endmodule
            
