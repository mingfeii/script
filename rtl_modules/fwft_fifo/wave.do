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
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/clk
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/rst
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/wr_en
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/din
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/rd_en
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/dout
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/full
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/empty
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/next_words_in_ram
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/words_in_ram
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/rd_addr
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/wr_addr
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/fetch_data
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/commit_data
add wave -noupdate -expand -label sim:/tb_sc_fifo/dut/Group1 -group {Region: sim:/tb_sc_fifo/dut} /tb_sc_fifo/dut/has_more_words
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
WaveRestoreZoom {11278304050 ps} {11278308802 ps}
