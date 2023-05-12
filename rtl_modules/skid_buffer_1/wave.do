onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/clk
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/arst
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/valid_i
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/ready_i
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} -radix unsigned /ready_skid_tb/dut/dat_i
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/valid_o
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} -radix unsigned /ready_skid_tb/dut/dat_o
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/ready_o
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} /ready_skid_tb/dut/buf_valid
add wave -noupdate -expand -label sim:/ready_skid_tb/dut/Group1 -group {Region: sim:/ready_skid_tb/dut} -radix unsigned /ready_skid_tb/dut/buf_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {51 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 303
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
WaveRestoreZoom {19 ns} {157 ns}
