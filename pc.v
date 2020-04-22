module pc(clk,reset,pcin,pcout,pcenable);
	input clk,reset,pcenable;
	input [31:0] pcin;
	output [31:0] pcout;
	reg [31:0] pcout;
	always@(posedge clk or posedge reset)
	begin
	 if(reset)
	  pcout<=8'h00000000;
	 else if(pcenable)
	  pcout<=pcin;
	end
endmodule