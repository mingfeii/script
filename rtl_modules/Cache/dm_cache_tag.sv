/*cache: tag memory, single port, 1024 blocks*/
timeunit 1ns; 
timeprecision 1ps;
import cache_def::*;

module dm_cache_tag(
    input clk, //write clock
    input cache_req_type tag_req,//tag request/command, e.g. RW, valid
    input cache_tag_type tag_write,//write port
    output cache_tag_type tag_read
);//read port
cache_tag_type tag_mem[0:1023];

assign tag_read = tag_mem[tag_req.index];

always_ff @(posedge(clk)) begin
    if (tag_req.we)
        tag_mem[tag_req.index] <= tag_write;
end
endmodule