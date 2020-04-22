module pc_add(pc_addin,pc_addout);
	input [31:0] pc_addin;
	output [31:0] pc_addout;
	reg [31:0] pc_addout;
	always@(pc_addin)
	begin
	 pc_addout<=pc_addin+4;
	end
endmodule