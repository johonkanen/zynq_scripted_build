# Step 0: set up path to this file
variable tcl_path [ file dirname [ file normalize [ info script ] ] ] 
variable build_path ./

# Step 1: Create a new project
create_project my_project ./my_project -part xc7z020clg400-1 -force

set_property target_language VHDL [current_project]

proc program_ram {bitfile} {
    open_hw_manager
    connect_hw_server -allow_non_jtag
    open_hw_target
    set_property PROGRAM.FILE {$bitfile} [get_hw_devices xc7z020_1]
    current_hw_device [get_hw_devices xc7z020_1]
    set_property PROBES.FILE {} [get_hw_devices xc7z020_1]
    set_property FULL_PROBES.FILE {} [get_hw_devices xc7z020_1]
    program_hw_devices [get_hw_devices xc7z020_1]
    refresh_hw_device [lindex [get_hw_devices xc7z020_1] 0]
    refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7z020_1] 0]
}


# Create and configure the block design
create_bd_design "zynq_bd"

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup

set_property -dict [list \
  CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {ARM PLL} \
  CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {166.666} \
  CONFIG.PCW_USE_M_AXI_GP0 {0} \
] [get_bd_cells processing_system7_0]

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
startgroup
    make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_CLK0]
    make_bd_pins_external  [get_bd_pins processing_system7_0/FCLK_RESET0_N]
endgroup
    
assign_bd_address
regenerate_bd_layout
#
save_bd_design

generate_target all [get_files  $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd]

export_ip_user_files -of_objects [get_files $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd]
launch_runs zynq_bd_processing_system7_0_0_synth_1 -jobs 32
export_simulation -of_objects [get_files $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd] -directory $build_path/my_project/my_project.ip_user_files/sim_scripts -ip_user_files_dir $build_path/my_project/my_project.ip_user_files -ipstatic_source_dir $build_path/my_project/my_project.ip_user_files/ipstatic -lib_map_path [list {modelsim=$build_path/my_project/my_project.cache/compile_simlib/modelsim} {questa=$build_path/my_project/my_project.cache/compile_simlib/questa} {riviera=$build_path/my_project/my_project.cache/compile_simlib/riviera} {activehdl=$build_path/my_project/my_project.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
wait_on_run zynq_bd_processing_system7_0_0_synth_1

add_files -norecurse $tcl_path/../vhdl_sources/generated_top.vhd
add_files -norecurse $tcl_path/../vhdl_sources/top.vhd

write_hw_platform -fixed -force -file $build_path/zynq_hw_export.xsa

launch_runs synth_1 -jobs 32
wait_on_run synth_1
open_run synth_1 -name synth_1
set_property IOSTANDARD LVCMOS33 [get_ports [list led_blinker]]
place_ports led_blinker T12

launch_runs impl_1 -jobs 32
wait_on_run impl_1

launch_runs impl_1 -to_step write_bitstream -jobs 32
wait_on_run impl_1
