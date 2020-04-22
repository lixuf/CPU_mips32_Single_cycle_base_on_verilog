module control_unit(jump,branch,memtoreg,memwrite,memread,aluop,alusrc,regwrite,regdst,op);
	output jump,branch,memtoreg,memwrite,memread,alusrc,regwrite,regdst;
	output [1:0]aluop;
	reg jump,branch,memtoreg,memwrite,memread,alusrc,regwrite,regdst;
	reg [1:0]aluop;
	input [5:0] op;
	parameter R=6'b000000,
		  lw=6'b100011,
		  sw=6'b101011,
		  beg=6'b000100,
		  sll=6'b110011,
		  j=6'b111011,
		  addi=6'b000001;
	always@(op)
	begin
	 casex(op)
	 R:begin
		{regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch}<=7'b1001000;
		aluop<=2'b10;
		jump<=1'b1;
	  end
	 addi:begin{regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch}<=7'b0101000;aluop<=2'b00;jump<=1'b1;end
	 j:begin{regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch}<=7'bxxx0000;aluop<=2'b00;jump<=1'b0;end
	 lw:begin{regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch}<=7'b0111100;aluop<=2'b00;jump<=1'b1;end
	 sw:begin{regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch}<=7'bx1x0010;aluop<=2'b00;jump<=1'b1;end
	 beg:begin{regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch}<=7'bx0x0001;aluop<=2'b01;jump<=1'b1;end
	 sll:begin{regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch}<=7'b0101000;aluop<=2'b11;jump<=1'b1;end
	 default:begin{regdst,alusrc,memtoreg,regwrite,memread,memwrite,branch}<=7'bxxxxxxx;aluop<=2'bxx;jump<=1'bx;end
	 endcase
	end
endmodule