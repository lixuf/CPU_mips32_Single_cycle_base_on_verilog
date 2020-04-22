`include "alu.v"
`include "alucontrol.v"
`include "control_unit.v"
`include "id.v"
`include "ifr.v"
`include "mem.v"
`include "pc.v"
`include "pc_add.v"
`include "pc_mux1.v"
`include "pc_mux2.v"
`include "pc_nadd.v"
`include "pc_shift.v"
`include "sign_extend.v"
module cpu(clk,reset,pcin,pcout,pcenable,pc_addout,zero,ifrout,ifrenable,jump,branch,memtoreg,memwrite,memread,aluop,alusrc,regwrite,regdst,signout,signout2,pc_naddout,pc_mux1out,jout,regdstout,rd1,rd2,alusrcout,aluopration,result,rd,memtoregout);
	input clk,reset,pcenable,ifrenable;
	output [31:0] pcin, pcout,pc_addout,ifrout,signout,signout2,pc_naddout,pc_mux1out,jout,regdstout,rd1,rd2,alusrcout,result,rd,memtoregout;
	output jump,branch,memtoreg,memwrite,memread,alusrc,regwrite,regdst,zero;
	output [1:0] aluop;
	output [3:0]aluopration;
	wire [31:0] pcin, pcout,pc_addout,ifrout,signout,signout2,pc_naddout,pc_mux1out,jout,regdstout,rd1,rd2,alusrcout,result,rd,memtoregout;
	wire clk,reset,pcenable,ifrenable,jump,branch,memtoreg,memwrite,memread,alusrc,regwrite,regdst,zero;
	wire [1:0] aluop;
	wire [3:0] aluopration;
	pc m_pc(.clk(clk),.reset(reset),.pcenable(pcenable),.pcin(pcin),.pcout(pcout));
	pc_add m_pc_add(.pc_addin(pcout),.pc_addout(pc_addout));
	ifr m_ifr(.ifrin(pcout),.ifrout(ifrout),.ifrenable(ifrenable));
	control_unit m_control_unit(.jump(jump),.branch(branch),.memtoreg(memtoreg),.memwrite(memwrite),.memread(memread),.aluop(aluop),.alusrc(alusrc),.regwrite(regwrite),.regdst(regdst),.op(ifrout[31:26]));
	sign_extend m_sign_extend(.signin(ifrout[15:0]),.signout(signout),.signout2(signout2));
	pc_nadd m_pc_nadd(.pc_naddin1(pc_addout),.pc_naddin2(signout2),.pc_naddout(pc_naddout));
	pc_mux1 m_pc_mux1(.in0(pc_addout),.in1(pc_naddout),.branch(branch),.zero(zero),.pc_mux1out(pc_mux1out));
	pc_shift m_pc_shift(.jin(ifrout[25:0]),.jout(jout),.pc_addout(pc_addout[31:28]));
	pc_mux2 m_pc_mux2(.in0(jout),.in1(pc_mux1out),.jump(jump),.pc_mux2out(pcin));
	pc_mux2 m_regdst(.in0(ifrout[20:16]),.in1(ifrout[15:11]),.jump(regdst),.pc_mux2out(regdstout));
	id m_id(.rr1(ifrout[25:21]),.rr2(ifrout[20:16]),.wr(regdstout),.wd(memtoregout),.rd1(rd1),.rd2(rd2),.reset(reset),.regwrite(regwrite));
	pc_mux2 m_alusrc(.in0(rd2),.in1(signout),.jump(alusrc),.pc_mux2out(alusrcout));
	alucontrol m_alucontrol(.aluop(aluop),.func(ifrout[10:6]),.aluopration(aluopration));
	alu m_alu(.ina(rd1),.inb(alusrcout),.zero(zero),.result(result),.aluop(aluopration),.reset(reset));
	mem m_mem(.memread(memread),.memwrite(memwrite),.address(result),.wd(rd2),.rd(rd),.reset(reset));
	pc_mux2 m_memtoreg(.in0(result),.in1(rd),.jump(memtoreg),.pc_mux2out(memtoregout));
endmodule