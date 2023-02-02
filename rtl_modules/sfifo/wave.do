onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/clk
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/rst
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/wr
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/wr_data
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/rd
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/rd_data
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/used_words
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/full
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/empty
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/ref_word
add wave -noupdate -expand -label sim:/tb_sc_fifo/Group1 -group {Region: sim:/tb_sc_fifo} /tb_sc_fifo/rd_word
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/clk_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/rst_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/wr_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/wr_data_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/used_words_o
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/rd_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/rd_data_o
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/full_o
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/empty_o
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/wr_addr
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/wr_req
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/full
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/rd_addr
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} -color Gold /tb_sc_fifo/dut/rd_req
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} -color Gold /tb_sc_fifo/dut/rd_en
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/empty
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/used_words
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/data_in_ram
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/data_in_o_reg
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/svrl_w_in_mem
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/first_word
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/wr_clk_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/wr_addr_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/wr_data_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/wr_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/rd_clk_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/rd_addr_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/rd_data_o
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/rd_i
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/ram_lut
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/ram/Group1 -group {Region: sim:/tb_sc_fifo/dut/ram} /tb_sc_fifo/dut/ram/rd_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {68305 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 276
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
WaveRestoreZoom {0 ps} {158512 ps}
