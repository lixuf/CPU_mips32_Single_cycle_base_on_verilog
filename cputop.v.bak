`include "cpu.v"
`timescale 10ns/1ns
`define PE 100
module cputop;
	reg clk,reset,pcenable,ifrenable;
	integer test;
	cpu t_cpu(.clk(clk),.reset(reset),.pcenable(pcenable),.ifrenable(ifrenable));
	initial
	 begin
	  reset=0;
	  clk=1;
	  test1;
	 end
	task test1;
	 begin
	  $readmemb("mem.txt",t_cpu.m_mem.memory);
	  $readmemb("reg.txt",t_cpu.m_id.register);
	  $readmemb("code.txt",t_cpu.m_ifr.memory);
	  test=1;
	 end
	endtask
	always@(test)
	begin
	 reset<=1'b1;
	 {pcenable,ifrenable}<=2'b11;
	end
	always@(posedge reset)
	begin
	 reset<=1'b0;
	end
	always#(`PE/2)clk=~clk;
	endmodule;