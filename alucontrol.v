module alucontrol(aluop,func,aluopration);
	input [1:0]aluop;
	input [5:0]func;
	output [3:0]aluopration;
	reg [3:0]aluopration;
	always@(aluop)
	begin
	 casex(aluop)
	  2'b00:aluopration<=4'b0010;
	  2'b01:aluopration<=4'b0110;
	  2'b11:aluopration<=4'b1000;
	  2'b10:begin
		casex(func)
		6'b100000:aluopration<=4'b0010;
		6'b100010:aluopration<=4'b0110;
		6'b100100:aluopration<=4'b0000;
		6'b100101:aluopration<=4'b0001;
		default:aluopration<=4'bxxxx;
		endcase
		end
	  default:aluopration<=4'bxxxx;
	 endcase
	end
endmodule