module nopipeline #(

)(
    input clk,
    input rst_n,


    input ival,
    output logic irdy,

    output logic oval,
    input  logic ordy

);



localparam [2:0] T0=-1, 
T1=T0+1, 
T2=T0+2, 
T3=T0+3,  
T4=T0+4, 
TN=T0+5; 


reg [2:0] st;
wire mval = st!=T0; 
assign oval = st==TN;
wire mrdy = ~oval | ordy;
wire mack = mval & mrdy;
assign irdy = ~mval | oval & ordy; //这里其实阻塞了输入：mval有效，但是oval无效时
wire iack = ival & irdy;



always @(posedge clk or negedge rst_n)
if (~rst_n) st <= T0; else
if (iack) st <= T1; else 
if (mack) st <= oval ? T0 : st+1;





endmodule 