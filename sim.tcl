if ![file isdirectory ./work] { vlib ./work }
vmap work ./work
vlog  ./\*.*v
vlog  ./\*.*sv
 vsim work.ready_skid_tb -voptargs=+acc
 do wave.do
 run -all