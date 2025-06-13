module risc(clk,rst);
  input clk,rst;
  wire [31:0]pc_top,w1,rdd,rdr,im,mul,sw,aw,pcin,addw,memw,wrw;
  wire w2,w3,z,b,selw,memtow,memww,memrw;
  wire [1:0]alu_wire;
  wire [3:0]co;
  
  program_counter pc(.clk(clk),.rst(rst),.in(pcin),.out(pc_top));
  
  adder ad(.in(pc_top),.out(aw));
  
  instruction_mem in(.clk(clk),.rst(rst),.read_add(pc_top),.instruction(w1));
  
  mux1 multiplexer(.a(aw),.b(sw),.sel(selw),.out(pcin));
  
  registers regi(.clk(clk),.rst(rst),.rr1(w1[19:15]),.rr2(w1[24:20]),.wr(w1[11:7]),.wd(wrw),.rd1(rdd),.rd2(rdr),.regwrite(w2));
  
  alu unit(.a(rdd),.b(mul),.zero(z),.result(addw),.alu_c(co));
  
  mux2 multip (.c(rdr),.d(im),.sele(w3),.outp(mul));
  
  control_unit controll(.branch(b),.memread(memrw),.memtoreg(memtow),.alu_op(alu_wire),.memwrite(memww),.alu_src(w3),.regwrite(w2),.inst(w1[6:0]));

  data_mem dataa(.clk(clk),.rst(rst),.address(memw),.wd(rdr),.rd(addw),.memwrite(memww),.memread(memrw));
  
  adder2 addition(.r1(pc_top),.r2(im),.r3(sw));
  
  immediate_generator immed(.opcode(w1[6:0]),.instruction(w1),.genout(im));
  
  alu_control ac(.alu_op(alu_wire),.func7(w1[30]),.func3(w1[14:12]),.alu_out(co));
  
  mux3 multiplex(.p(addw),.q(memw),.s(memtow),.outpt(wrw));
  
  andg aand(.branch(b),.zero(z),.a(selw));
 
endmodule

//PC  
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

//Top adder
module adder(in,out);
  input [31:0]in;
  output[31:0]out;
  assign out=in+4;
endmodule

//Instruction memory
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
  
  mem[28]=32'b000000001111_00101_010_01000_0000011;
  
  mem[36]=32'b0000000_01111_00101_010_01101_0100011;    
  
  mem[44]=32'h00948663;
    end
endmodule
        


//Registers
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


//Control unit
module control_unit(branch,memread,memtoreg,alu_op,memwrite,alu_src,regwrite,inst);
  input [6:0] inst;
  output reg [1:0]alu_op;
  output reg branch, memread, memtoreg, memwrite,alu_src,regwrite;
  always@(*)
    begin
      case(inst)
        7'b0110011: {alu_src,memtoreg,regwrite,memread,memwrite,branch,alu_op}<=8'b00100010;
        7'b0000011: {alu_src,memtoreg,regwrite,memread,memwrite,branch,alu_op}<=8'b11110000;
        7'b0100011: {alu_src,memtoreg,regwrite,memread,memwrite,branch,alu_op}<=8'b10001000;
        7'b1100011: {alu_src,memtoreg,regwrite,memread,memwrite,branch,alu_op}<=8'b00000101;
        default: {alu_src,memtoreg,regwrite,memread,memwrite,branch,alu_op}<=8'b00000000;
      endcase
    end
endmodule
  
//Immediate generator
module immediate_generator(opcode,instruction,genout);
  input [6:0]opcode;
  input[31:0]instruction;
  output reg [31:0]genout;
  always@(*)
    begin
      case(opcode)
        7'b0000011: genout<={{20{instruction[31]}},instruction[31:20]};
        7'b0100011: genout<={{20{instruction[31]}},instruction[31:25],instruction[11:7]};
        7'b1100011: genout<={{19{instruction[31]}},instruction[31],instruction[30:25],instruction[11:8],1'b0};
      endcase
    end
endmodule

//ALU
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

//ALU Control
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
  
//Multiplexers
module mux1(a,b,sel,out);
  input [31:0]a,b;
  input sel;
  output reg [31:0]out;
  always@(*)
    begin
      case(sel)
        1'b0: out=a;
        1'b1: out=b;
        default: out<=32'b0;
      endcase
    end
endmodule

module mux2(c,d,sele,outp);
  input [31:0]c,d;
  input sele;
  output reg [31:0]outp;
  assign outp=(sele==1)?d:c;
endmodule

module mux3(p,q,s,outpt);
  input [31:0]p,q;
  input s;
  output reg [31:0]outpt;
  assign outpt=(s==0)?p:q;
endmodule

//AND gate
module andg(branch,zero,a);
  input branch,zero;
  output a;
  assign a=branch & zero;
endmodule

//Data memory
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
            
            
//Adder connected to shift left
module adder2(r1,r2,r3);
  input [31:0]r1,r2;
  output reg [31:0]r3;
  assign r3=r1 + r2;
endmodule
