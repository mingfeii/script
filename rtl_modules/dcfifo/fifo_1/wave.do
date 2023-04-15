onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/wr_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/rd_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/rst
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/wr
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/wr_data
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/rd
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/rd_data
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/wr_used_words
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/rd_used_words
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/wr_full
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/wr_empty
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/rd_full
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/rd_empty
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/ref_word
add wave -noupdate -expand -label sim:/tb_dc_fifo/Group1 -group {Region: sim:/tb_dc_fifo} /tb_dc_fifo/rd_word
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_clk_i
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_data_i
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_i
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_used_words_o
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_full_o
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_empty_o
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_clk_i
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_data_o
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_i
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_used_words_o
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_full_o
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_empty_o
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rst_i
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_req
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_used_words
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_full
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_empty
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_ptr_wr_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_ptr_gray_wr_clk_comb
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_ptr_gray_wr_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_ptr_gray_rd_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_ptr_gray_rd_clk_mtstb
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_ptr_rd_clk_comb
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_ptr_rd_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wr_addr
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_req
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_used_words
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_full
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_empty
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_ptr_rd_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_ptr_gray_rd_clk_comb
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_ptr_gray_rd_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_ptr_gray_wr_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_ptr_gray_wr_clk_mtstb
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_ptr_wr_clk_comb
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_ptr_wr_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_addr
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rd_en
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/data_in_ram
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/data_in_o_reg
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rst_rd_clk_d1
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rst_rd_clk_d2
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rst_rd_clk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rst_wr_clk_d1
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rst_wr_clk_d2
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rst_wr_clk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {9304834050 ps} {9304838802 ps}
