onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rdata
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wfull
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rempty
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wdata
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/winc
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wclk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wrst_n
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rinc
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rclk
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rrst_n
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/waddr
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/raddr
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wptr
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rptr
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/wq2_rptr
add wave -noupdate -expand -label sim:/tb_dc_fifo/dut/Group1 -group {Region: sim:/tb_dc_fifo/dut} /tb_dc_fifo/dut/rq2_wptr
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
WaveRestoreZoom {0 ps} {4098 ps}
