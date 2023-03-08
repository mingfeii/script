onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/clk
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/arst
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/valid_i
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/dat_i
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/last_o
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/ready_i
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/valid_o
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/dat_o
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/ready_o
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/fail
add wave -noupdate -expand -label sim:/ready_skid_tb/Group1 -group {Region: sim:/ready_skid_tb} /ready_skid_tb/next_last_o
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/clk
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/arst
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/valid_i
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/dat_i
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/ready_i
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/valid_o
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/dat_o
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/ready_o
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/backup_storage
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/backup_valid
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/internal_valid_o
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/internal_ready_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {998091 ns} 0}
quietly wave cursor active 1
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
configure wave -timelineunits ns
update
WaveRestoreZoom {997663 ns} {1000124 ns}
