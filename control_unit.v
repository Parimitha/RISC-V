module control_unit(branch,memread,memtoreg,alu_op,memwrite,alu_src,regwrite,inst);
  input [6:0] inst;
  output reg [2:0]alu_op;
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
  
  
