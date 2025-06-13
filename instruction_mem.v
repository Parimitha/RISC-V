module instruction_mem(clk,rst,read_add,instruction);
  input clk,rst;
  input [31:0]read_add;
  output reg[31:0]instruction;
  reg [31:0] mem[63:0];
  assign instruction=mem[read_add];
  always@(posedge clk or posedge rst)
    begin
      if(rst)
        begin
          for(int i=0;i<64;i=i+1)
            begin
              mem[i]=32'b0;
            end
        end
      else
        mem[0]=32'b0;
        mem[4]=32'b0000000_11001_10000_000_01101_0110011; //add
        mem[8]=32'b0100000_00011_01000_000_00101_0110011; //sub
        mem[12]=32'b0000000_00011_00010_111_00001_0110011; //and
  
      mem[28]=32'b000000001111_00101_010_01000_0000011;  //load instruction
  
      mem[36]=32'b0000000_01111_00101_010_01101_0100011;    //store instruction
  
      mem[44]=32'h00948663;                   //branch instruction
    end
endmodule
        
