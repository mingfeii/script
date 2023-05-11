
module template_pipe_state #(parameter
QQ=12, // [U12.0], input width
SS=11, // [U1.10], SENS format: U1.xxxxx
TF=4 // IS,IR fraction bits. IS,IR format: [U(1+QQ).TF]
)(
input clk,
input rst_n,
input ofmd,
input [2:0][12:1] thres,
output irdy,
input ival,
input ieof,
input isol,
input [QQ:1] q,
input ov, // Status2
input bad, // Status3
input [SS:1] sens1, sens2,
input ordy,
output oval,
output reg oeof,
output reg osol,
output oerr,
output reg [16:1] obk,
output [16:1] oir,
output [QQ+SS:1] ois,
output [QQ+SS:1] oit);

// == control ==================
localparam [2:0] 
T0=-1, // idle
T1=T0+1, // Q1*S1->MR
T2=T0+2, // Q3-MR->IS
T3=T0+3, // IS-MR->IT; Q2*S2->MR; 
T4=T0+4, // IT+MR->IT it就是IR，就是除数
TN=T0+5; // output 结果就是 IS/IT

reg [2:0] st;
wire mval = st!=T0; //不在初始阶段
assign oval = st==TN; //只有在最后一个阶段时，oval才使能输出
wire mrdy = ~oval | ordy; //不在最后一个阶段，或者后一级有请求了
wire mack = mval & mrdy; //不在初始阶段并且 不在最后一个阶段，或者后一级有请求
assign irdy = ~mval | oval & ordy; //在初始阶段或者同时输出&同时有请求--》向上一级请求数据
wire iack = ival & irdy;//采集前一级数据

always @(posedge clk or negedge rst_n)
if (~rst_n) st <= T0; else //优先级
if (iack) st <= T1; else //要接受上一级数据了，到第一个阶段T1
if (mack) st <= oval ? T0 : st+1;//中间阶段，要是到了最后一个阶段就重回第0个阶段，count clock

// == datapath =================
reg ovr;
reg obad;
reg [QQ:1] q12, q3;
reg [SS:1] s12;
reg [QQ+SS:1] mr;
reg signed [1+QQ+SS:1] is;
reg signed [2+QQ+SS:1] it;
reg [12:1] bkr;

assign ois = is<0 ? 0 : is;
assign oit = it<0 ? 0 : it>=2**(QQ+SS) ? 2**(QQ+SS)-1 : it;
//wire signed [3+QQ+TF:1] itrnd = it[2+QQ+SS:SS-TF]+it[SS-TF-1];
//assign oit = itrnd<0 ? 0 : itrnd>=2**(1+QQ+TF) ? 2**(1+QQ+TF)-1 : itrnd[1+QQ+TF:1];

wire [1+QQ:1] bkrnd = mr[QQ+SS:SS] + mr[SS-1];
wire [12:1] bkn = bkrnd>12'hfff ? 12'hfff : bkrnd[12:1];
assign obk = bkr;

wire signed [2+QQ:1] irrnd = it[2+QQ+SS:SS+1]+it[SS];
assign oir = irrnd<0 ? 0 : irrnd>12'hfff ? 12'hfff : irrnd[12:1];

wire bkof = obk > thres[0];
wire irof = oir > thres[1];
wire iruf = oir < thres[2];
assign oerr = obad | ofmd & (ovr | bkof | irof | iruf);

reg [SS:1] sens;
always @* case(st)
  T2: sens = sens2;
  T0, TN: sens = sens1;
  default: sens = 'bx;
endcase

reg sub;
reg signed [2+QQ+SS:1] ac;
always @* case(st)
  T2: begin sub=1; ac=q3<<(SS-1); end
  T3: begin sub=1; ac=is; end
  T4: begin sub=0; ac=it; end
  default: begin sub=1'bx; ac='bx; end
endcase

wire [QQ+SS:1] mo = q12 * s12;
wire signed [2+QQ+SS:1] sum = ac + (sub ? -mr : mr);

always @(posedge clk) if (iack | st==T1 | st==T2) oeof <= iack ? ieof : ieof | oeof;
always @(posedge clk) if (iack | st==T1 | st==T2) osol <= iack ? isol : isol | osol;
always @(posedge clk) if (iack | st==T1 | st==T2) ovr <= iack ? ov : ov | ovr;
always @(posedge clk) if (iack | st==T2) obad <= bad;
always @(posedge clk) if (iack | st==T2) s12 <= sens;
always @(posedge clk) if (iack | st==T2) q12 <= q;
always @(posedge clk) if (st==T1) q3 <= q;
always @(posedge clk) if (st==T1 | st==T3) mr <= mo;
always @(posedge clk) if (st==T3 | st==T4) it <= sum;
always @(posedge clk) if (st==T2) is <= sum;
always @(posedge clk) if (st==T2) bkr <= bkn;

endmodule
