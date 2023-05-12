`timescale 1ns/1ns

module tb();


localparam PI2 = 2**15-1;
localparam PI = PI2 / 2;

logic clk;
logic rst_n;

parameter FBIT = 8;
parameter PHASE_DW = 15;
parameter PASS_DW = 8;

parameter RANDOM = 1'b1;

parameter SMMOTH_RDY = 1'b1;


logic [PHASE_DW-1:0] phase1;
logic [PHASE_DW-1:0] phase2;
logic [FBIT-1:0]     phase_frac,phase_frac_pre;
logic phase_valid;
logic phase_ready;

logic [PHASE_DW-1:0] interp_phase;
logic interp_valid;
logic interp_ready,interp_ready_1;

logic [PASS_DW-1:0]  phase_pass_data; //不参与计算，但是需要传递的信号
logic [PASS_DW-1:0] interp_pass_data;



initial begin
    rst_n=0;
    #100
    rst_n=1;
end

initial begin
    clk=0;
    forever begin
        #5 clk=~clk;
    end

end

event done;

reg [PHASE_DW-1:0] src1_mem [1024];
reg [PHASE_DW-1:0] src2_mem [1024];
reg [7:0] frac_mem [1024];


reg [PHASE_DW-1:0] dst_mem [1024];
reg [PHASE_DW-1:0] ref_mem[1024];



initial begin 
    integer i;
    bit [PHASE_DW*2-1:0] data;
    for(i=0;i<1024;i++) begin 
        data=RANDOM ? $urandom() : data+1'b1;
        src1_mem[i] = data[0+:PHASE_DW];
        src2_mem[i] = data[PHASE_DW*2-1:PHASE_DW];
        frac_mem[i] = $urandom_range(255);
    end 
end 


int o_cnt;
initial begin:GEN_RDY
    interp_ready_1 =1'b0;
    forever @(posedge clk)begin 
        automatic int rdn = $urandom_range(100);
        if(rdn <= 10 && o_cnt < 1024)
            interp_ready_1 <=1'b1;
        else
            interp_ready_1 <=1'b0;
    end 
end 


assign interp_ready = SMMOTH_RDY ? 1'b1 : interp_ready_1;

initial begin:GEN_OUT_MEM
    forever @(posedge clk)begin 
        if (interp_ready && interp_valid)begin 
            o_cnt <= o_cnt+1'b1;
            dst_mem[o_cnt] <= interp_phase;
        end
        if (o_cnt == 1024)
            -> done;
    end
end 

initial begin 
    @done;
    // check_data();
    #1000
    $finish;
end 


always@(posedge clk or negedge rst_n)
    if (!rst_n)
        phase_frac_pre <= 0;
    else if (phase_valid && phase_ready)
        phase_frac_pre <= $urandom_range(255);




int icnt;
always@(posedge clk or negedge rst_n)
    if (!rst_n) begin 
        phase1 <= src1_mem[0];
        phase2 <= src2_mem[0];
        phase_valid <= 0;
        icnt <= 0;
        phase_frac <= frac_mem[0];
        phase_pass_data <= 0;
    end else begin 
        if (icnt > 1025) phase_valid <= 1'b0;
        else if (phase_valid && phase_ready) begin 
            // phase_valid <= $urandom();
            phase_valid <= 1;
            phase1 <= src1_mem[icnt+1];
            phase2 <= src2_mem[icnt+1];
            phase_frac <= frac_mem[icnt+1];
            phase_pass_data <= $urandom();
            ref_mem[icnt] <= interpolate_phase(src1_mem[icnt],src2_mem[icnt],frac_mem[icnt]);
            icnt <= icnt + 1;
        end else begin 
            phase_valid <= 1'b1;
        end 
    end 
    

// xyz_rectify_phase_interp #(
//     .FBIT(FBIT),
//     .PHASE_DW(PHASE_DW)
// )DUT (
// .clk(clk),
// .rst_n(rst_n),
// .phase1       (phase1       ),
// .phase2       (phase2       ),
// .phase_frac   (phase_frac   ),
// .phase_valid  (phase_valid  ),
// .phase_ready  (phase_ready  ),
// .interp_phase (interp_phase ),
// .interp_valid (interp_valid ),
// .phase_pass_data(phase_pass_data),
// .interp_pass_data(interp_pass_data),
// .interp_ready (interp_ready )

// );



nopipeline #(

)pip2_U(
    .clk(clk),
    .rst_n(rst_n),

    .ival(phase_valid),
    .irdy(phase_ready),

    .oval(interp_valid),
    .ordy(interp_ready)

);



function reg [PHASE_DW-1:0] interpolate_phase(input [PHASE_DW-1:0] p1, input [PHASE_DW-1:0] p2,input [FBIT-1:0] f);
    int phase_diff;
    int a,b;
    reg [PHASE_DW+FBIT+1:0] res;
    // 1d linear interpolation
    // a,b is the phase value of two adjacent pixels
    // f is the interpolation factor

    //--------------------------
    //adjust value range before interpolation
    a = p1;
    b = p2;
    phase_diff = a > b ? a - b : b - a;
    if (phase_diff > PI) begin 
        if(a > b)
            b = b + PI2;
        else
            a = a + PI2;
        
    end 
    //--------------------------
    // original interploation calculation here
    res = a*(2**FBIT - f) + b*f;
    res = res >> FBIT;
    //--------------------------
    // post process 
    if(res > PI2)
        res = res - PI2;
    
    interpolate_phase = res[0+:PHASE_DW];


endfunction





endmodule 