
module ready_skid #(
	parameter WIDTH = 16
)
(
	input clk,arst,
	
	input valid_i,
	input [WIDTH-1:0] dat_i,
	output reg ready_i,
	
	output reg valid_o,
	output reg [WIDTH-1:0] dat_o,
	input ready_o	
);



reg buf_valid;
reg [WIDTH-1:0] buf_data;

always_ff@(posedge clk or posedge arst)
	if (arst)
		ready_i <= 1'b1;//有个buf放在那，因此复位后至少可以收一个数据。
	else if (ready_o)
		ready_i <= 1'b1;//ready_i打拍子，阻断组合逻辑
	else if (valid_i) //在ready_o拉低后的那一个周期，如果没有数据过来，表明buf为空，可以进数据，ready_i保持为1
		ready_i <= 1'b0; //如果有数据过来，buf被占，则不允许再进数据了，ready_i拉低。


always_ff@(posedge clk or posedge arst)
	if (arst)
		buf_data <= 0;
	else if (!ready_o && ready_i && valid_i)
		buf_data <= dat_i;
	
always_ff@(posedge clk or posedge arst)
	if (arst)
		buf_valid <= 1'b0;
	else if (ready_o)//当ready_o拉高，优先读走buf中的数据。
		buf_valid <= 1'b0;
	else if (!ready_o && valid_i && ready_i)
		buf_valid <= 1'b1;
	

assign dat_o = ready_i ? dat_i : buf_data;
assign valid_o = ready_i ? valid_i : buf_valid;



endmodule
