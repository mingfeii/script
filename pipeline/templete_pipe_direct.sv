module templete_pipe_direct #(
    parameter FBIT = 8,
    parameter PASS_DW = 8,
    parameter PHASE_DW = 15
)(
    input clk,
    input rst_n,

    input [PHASE_DW-1:0] phase1,
    input [PHASE_DW-1:0] phase2,
    input [FBIT-1:0]     phase_frac,
    input [PASS_DW-1:0]  phase_pass_data, //不参与计算，但是需要传递的信号
    input phase_valid,
    output logic phase_ready,

    output logic [PHASE_DW-1:0] interp_phase,
    output logic interp_valid,
    output logic [PASS_DW-1:0] interp_pass_data,
    input  logic interp_ready

);


localparam PI2 = 2**PHASE_DW - 1;
localparam PI = PI2 >> 1;
wire compare_flag = phase1 > phase2;
reg [PHASE_DW-1:0] phase_diff;
reg [PHASE_DW:0] a,b,a1,b1;
reg compare_flag_1d;
reg [FBIT-1:0] phase_frac_1d,phase_frac_2d;

localparam NUMS = 4;

bit  [NUMS:0] valid ;
bit  [NUMS:0] ready ;
reg [NUMS:0] [PASS_DW-1:0] pass_data;

assign phase_ready = ready[0];
assign interp_valid = valid[NUMS];
assign interp_pass_data = pass_data[NUMS];

always_comb begin

    ready[NUMS] = interp_ready;
    for (int i = NUMS; i >= 1; i--) begin
        ready[i - 1] = ~valid[i] | ready[i];
        
    end
end

always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        valid <= '0;
        pass_data <= '0;
    end
    else begin
        for (int i = 1; i <= NUMS; i++) begin
        
           if (i == 1) begin  
                if (phase_ready) begin 
                    valid[i] <= phase_valid & phase_ready;
                    if (phase_valid) pass_data[i] <= phase_pass_data;
                end 
           end else if (ready[i - 1]) begin
                valid[i] <= valid[i - 1] & ready[i - 1];
                if (valid[i - 1]) pass_data[i] <= pass_data[i - 1];
            end
        end
    end
end

//state 0
always_ff@(posedge clk or negedge rst_n)
    if (!rst_n) begin 
        phase_diff <= '0;
        compare_flag_1d <= 1'b0;
        phase_frac_1d <= '0;
        a <= 0;
        b <= 0;
    end else if (phase_valid && phase_ready) begin 
        phase_diff <= compare_flag ? phase1 - phase2 : phase2 - phase1;
        compare_flag_1d <= compare_flag;
        phase_frac_1d <= phase_frac;
        a <= phase1;
        b <= phase2;
    end 

//stage 1
always_ff@(posedge clk or negedge rst_n)
    if (!rst_n) begin 
        a1 <= '0;
        b1 <= '0;
        phase_frac_2d <= '0;
    end else if (valid[1] && ready[1]) begin 
        phase_frac_2d <= phase_frac_1d;
        a1 <= a;
        b1 <= b;
        if (phase_diff > PI) begin 
            if (compare_flag_1d) begin 
                b1 <= b + PI2;
                a1 <= a;
            end else  begin 
                a1 <= a + PI2;
                b1 <= b;
            end 
        end 
    end 

wire [PHASE_DW+FBIT:0] mult_a,mult_b;

assign mult_a = a1 * (2**FBIT - phase_frac_2d);
assign mult_b = b1 * phase_frac_2d;

//stage 2
reg [PHASE_DW+FBIT+1:0] res_pre;

always_ff@(posedge clk or negedge rst_n)
    if (!rst_n)
        res_pre <= '0;
    else if (valid[2] && ready[2])
        res_pre <= mult_a + mult_b;

//state 3
wire [PHASE_DW+1:0] res_truncate;
reg [PHASE_DW+1:0] res;

assign res_truncate = res_pre >> FBIT;

always_ff@(posedge clk or negedge rst_n)
    if (!rst_n)
        res <= '0;
    else if (valid[3] && ready[3]) begin 
        if (res_truncate > PI2)
            res <= res_truncate - PI2;
        else 
            res <= res_truncate;
    end 

assign interp_phase = res[0+:PHASE_DW];



endmodule 