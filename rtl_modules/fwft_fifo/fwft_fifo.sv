module fwft_fifo #(
    parameter FIFO_DEPTH = 64,
    parameter FIFO_ADDR = $clog2(FIFO_DEPTH),
    parameter USE_LUTS = 1'b0,
    parameter FIFO_WIDTH = 8
)(
    input clk,
    input rst,

    input wr_en,
    input [FIFO_WIDTH-1:0] din,

    input rd_en,
    output [FIFO_WIDTH] dout,

    output reg full,
    output reg empty
);


logic [FIFO_ADDR:0] next_words_in_ram;
logic [FIFO_ADDR:0] words_in_ram;
logic [FIFO_ADDR-1:0] rd_addr;
logic [FIFO_ADDR-1:0] wr_addr;
logic fetch_data,commit_data;
logic has_more_words;

// assign fetch_data = rd_en && !empty;
assign fetch_data = (rd_en || empty) && has_more_words;

assign commit_data = wr_en && !full;

always_comb begin 
    if (commit_data && !fetch_data)
        next_words_in_ram = words_in_ram + 1;
    else if (!commit_data && fetch_data)
        next_words_in_ram = words_in_ram - 1;
    else 
        next_words_in_ram = words_in_ram;
end 

always_ff@(posedge clk) begin 
    words_in_ram <= next_words_in_ram;
    full <= (next_words_in_ram == FIFO_DEPTH);
    // empty <= (next_words_in_ram == 0);
    has_more_words <= (next_words_in_ram != 0);

    if (fetch_data)
        rd_addr <= rd_addr + 1'b1;

    if (fetch_data)
        empty <= 1'b0;
    else if (rd_en)
        empty <= 1'b1;

    if (commit_data) 
        wr_addr <= wr_addr + 1'b1;
    
    if (rst) begin 
        empty <= 1'b1;
        full <= 1'b1;
        words_in_ram <= 0;
        rd_addr <= 0;
        wr_addr <= 0;
        has_more_words <= 0;
    end 
end 
        
dual_port_ram #(
  .DATA_WIDTH ( FIFO_WIDTH ),
  .ADDR_WIDTH ( FIFO_ADDR ),
  .USE_LUTS   ( USE_LUTS   )
) ram (
  .wr_clk_i   ( clk       ),
  .wr_addr_i  ( wr_addr   ),
  .wr_data_i  ( din       ),
  .wr_i       ( commit_data),
  .rd_clk_i   ( clk       ),
  .rd_addr_i  ( rd_addr   ),
  .rd_data_o  ( dout      ),
  .rd_i       ( fetch_data)
);





endmodule 