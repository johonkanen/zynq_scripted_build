# zynq_scripted_build
Build scripts for testing zynq fpga scripted build

oneliner to build both software and hw

> vivado -mode batch -source <path_to_zynq_scripted_build>/tcl/build_all.tcl ; vitis -s <path_to_zynq_scripted_build>/sw_build_scripts/build_lwip.py
