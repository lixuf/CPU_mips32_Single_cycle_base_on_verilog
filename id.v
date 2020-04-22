module id(rr1,rr2,wr,wd,rd1,rd2,reset,regwrite);
	input [4:0] rr1,rr2,wr;
	input [31:0] wd;
	output [31:0] rd1,rd2;
	reg [31:0] rd1,rd2;
	input reset,regwrite;
	reg [31:0] register [5'b11111:0];
	always@(rr1)
	begin
	 if(reset)
	  begin
	   rd1<=8'h00000000;
	   rd2<=8'h00000000;
	  end
	 else
	  begin
	   rd1<=register[rr1];
	   rd2<=register[rr2];
	  end
	end
	always@(wd)
	begin
	 if(regwrite)
	  register[wr]<=wd;
	end
endmodule