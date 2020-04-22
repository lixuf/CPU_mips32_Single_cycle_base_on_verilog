module alu(ina,inb,result,zero,aluop,reset);
	input [31:0] ina,inb;
	output [31:0] result;
	output zero;
	input [3:0] aluop;
	input reset;
	reg [31:0] result;
	parameter	ADD=4'b0010,
			SUB=4'b0110,
			AND=4'b0000,
			OR=4'b0001,
			SLL=4'b1000;
	always@(inb)
	begin
	if(!reset)
	begin
	 casex(aluop)
	  ADD:result<=ina+inb;
	  SUB:result<=ina-inb;
	  AND:result<=ina&inb;
	  OR:result<=ina|inb;
	  SLL:result<=(ina<<inb);
	  default:result<=8'hxxxxxxxx;
	 endcase
	end
	end
	assign zero=(result)?1'b0:1'b1;
endmodule