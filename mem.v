module mem(memread,memwrite,address,wd,rd,reset);
	input memread,memwrite,reset;
	input [31:0] address;
	input [31:0] wd;
	output [31:0] rd;
	reg [31:0] rd;
	reg[31:0] memory[10'b1111111111:0];
	always@(address)
	begin
	 if(!reset)
	   begin
	    if(memread)
	     rd<=memory[address[9:0]];
	    else if(memwrite)
	     memory[address[9:0]]<=wd;
	   end
	end
endmodule