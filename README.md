# zynq_scripted_build
Build scripts for testing zynq fpga scripted build


oneliner to build both software and hw

> vivado -mode batch -source ../tcl/build_all.tcl ; vitis -s ../sw_build_scripts/build_lwip.py

for the oneliner to work the project needs to be build from <path_to>/zynq_scripted_build/build
