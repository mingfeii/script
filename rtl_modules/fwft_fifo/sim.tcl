if ![file isdirectory ./work] { vlib ./work }
vmap work ./work
vlog  ./\*.*v
vlog  ./\*.*sv
 vsim work.tb_sc_fifo -voptargs=+acc
 do wave.do
 run -all