if ![file isdirectory ./work] { vlib ./work }
vmap work ./work

vlog nopipeline.sv  +libext+.sv 

vlog tb.sv  +libext+.v +libext+.sv 


vsim work.tb \
    -L altera_mf_ver \
    -L altera_ver \
    -L lpm_ver \
    -L sgate_ver \
    -L altera_lnsim_ver \
    -L cyclonev_ver \
    -L cyclonev_hssi_ver \
    -L cyclonev_pcie_hip_ver \
    -voptargs=+acc
do wave.do
run -all



