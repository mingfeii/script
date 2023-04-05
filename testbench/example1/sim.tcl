if ![file isdirectory ./work] { vlib ./work }
vmap work ./work
vlog testbench_header.sv
vlog  ./\*.*sv
 vsim work.tb -voptargs=+acc
#  do wave.do
 run -all