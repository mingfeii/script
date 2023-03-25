if ![file isdirectory ./work] { vlib ./work }
vmap work ./work
vlog  ./\*.*v
vlog  ./\*.*sv
 vsim work.test_main -voptargs=+acc
#  do wave.do
 run -all