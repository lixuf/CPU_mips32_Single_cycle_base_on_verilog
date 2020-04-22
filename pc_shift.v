module pc_shift(jin,jout,pc_addout);
	input [27:0]jin;
	input [3:0]pc_addout;
	output [31:0] jout;
	reg [31:0]jout;
	always@(jin)
	begin
	 jout[31:28]<=pc_addout;
	 jout[27:0]<=jin<<2;
	end
endmodule