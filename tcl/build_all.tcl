# Step 1: Create a new project
create_project my_project ./my_project -part xc7z020clg400-1

set_property target_language VHDL [current_project]

proc program_ram {} {
    open_hw_manager
    connect_hw_server -allow_non_jtag
    open_hw_target
    set_property PROGRAM.FILE {D:/dev/zynq_scripted_build/build/my_project/my_project.runs/impl_1/zynq_bd_wrapper.bit} [get_hw_devices xc7z020_1]
    current_hw_device [get_hw_devices xc7z020_1]
    set_property PROBES.FILE {} [get_hw_devices xc7z020_1]
    set_property FULL_PROBES.FILE {} [get_hw_devices xc7z020_1]
    set_property PROGRAM.FILE {D:/dev/zynq_scripted_build/build/my_project/my_project.runs/impl_1/zynq_bd_wrapper.bit} [get_hw_devices xc7z020_1]
    program_hw_devices [get_hw_devices xc7z020_1]
    refresh_hw_device [lindex [get_hw_devices xc7z020_1] 0]
    refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7z020_1] 0]
}


# Create and configure the block design
create_bd_design "zynq_bd"

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
    
connect_bd_net [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/FCLK_CLK0]

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

startgroup
set_property -dict [list \
  CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} \
  CONFIG.PCW_UART0_UART0_IO {MIO 14 .. 15} \
] [get_bd_cells processing_system7_0]
endgroup

assign_bd_address
regenerate_bd_layout

save_bd_design
# TODO: figure out how to make this use relative paths!
make_wrapper -files [get_files D:/dev/zynq_scripted_build/build/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd] -top
add_files -norecurse d:/dev/zynq_scripted_build/build/my_project/my_project.gen/sources_1/bd/zynq_bd/hdl/zynq_bd_wrapper.vhd

create_ip_run [get_files -of_objects [get_fileset sources_1] D:/dev/zynq_scripted_build/build/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd]
generate_target all [get_files  D:/dev/zynq_scripted_build/build/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd]
export_simulation -of_objects [get_files D:/dev/zynq_scripted_build/build/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd] -directory D:/dev/zynq_scripted_build/build/my_project/my_project.ip_user_files/sim_scripts -ip_user_files_dir D:/dev/zynq_scripted_build/build/my_project/my_project.ip_user_files -ipstatic_source_dir D:/dev/zynq_scripted_build/build/my_project/my_project.ip_user_files/ipstatic -lib_map_path [list {modelsim=D:/dev/zynq_scripted_build/build/my_project/my_project.cache/compile_simlib/modelsim} {questa=D:/dev/zynq_scripted_build/build/my_project/my_project.cache/compile_simlib/questa} {riviera=D:/dev/zynq_scripted_build/build/my_project/my_project.cache/compile_simlib/riviera} {activehdl=D:/dev/zynq_scripted_build/build/my_project/my_project.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet

launch_runs zynq_bd_processing_system7_0_0_synth_1 -jobs 32

write_hw_platform -fixed -force -file D:/dev/zynq_scripted_build/build/my_project/zynq_bd_wrapper.xsa

launch_runs synth_1 -jobs 32
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 32
wait_on_run impl_1

