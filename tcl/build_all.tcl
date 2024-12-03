# Step 0: set up path to this file
variable tcl_path [ file dirname [ file normalize [ info script ] ] ] 
variable build_path ./

# Step 1: Create a new project
create_project my_project ./my_project -part xc7z020clg400-2 -force

set_property target_language VHDL [current_project]
set_param general.maxThreads 16

proc program_ram {bitfile} {
    open_hw_manager
    connect_hw_server -allow_non_jtag
    open_hw_target
    set_property PROBES.FILE {} [get_hw_devices xc7z020_1]
    set_property FULL_PROBES.FILE {} [get_hw_devices xc7z020_1]
    set_property PROGRAM.FILE $bitfile [get_hw_devices xc7z020_1]
    program_hw_devices [get_hw_devices xc7z020_1]
    disconnect_hw_server
}

source $tcl_path/block_designs/lwip_test/zynq_bd.tcl

generate_target all [get_files  $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd]

export_ip_user_files -of_objects [get_files $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] $build_path/my_project/my_project.srcs/sources_1/bd/zynq_bd/zynq_bd.bd]

launch_runs zynq_bd_axi_bram_ctrl_0_0_synth_1 zynq_bd_axi_gpio_0_0_synth_1 zynq_bd_eka_timeri_0_synth_1 zynq_bd_proc_sys_reset_0_0_synth_1 zynq_bd_processing_system7_0_0_synth_1 zynq_bd_smartconnect_0_0_synth_1 -jobs 32
wait_on_runs zynq_bd_axi_bram_ctrl_0_0_synth_1 zynq_bd_axi_gpio_0_0_synth_1 zynq_bd_eka_timeri_0_synth_1 zynq_bd_proc_sys_reset_0_0_synth_1 zynq_bd_processing_system7_0_0_synth_1 zynq_bd_smartconnect_0_0_synth_1

add_files -norecurse $tcl_path/block_designs/zynq_bd_wrapper.vhd
add_files -norecurse $tcl_path/../vhdl_sources/top.vhd
set_property top top [current_fileset]

write_hw_platform -fixed -force -file $build_path/zynq_hw_export.xsa

synth_design -rtl -rtl_skip_mlo -name rtl_1

set_property IOSTANDARD LVCMOS33 [get_ports [list led_blinker]]
place_ports led_blinker T12

close [ open $build_path/placed_design.xdc w ]
add_files -fileset constrs_1 $build_path/placed_design.xdc
set_property target_constrs_file $build_path/placed_design.xdc [current_fileset -constrset]
save_constraints -force

launch_runs synth_1 -jobs 32
wait_on_run synth_1

launch_runs impl_1 -jobs 32
wait_on_run impl_1

launch_runs impl_1 -to_step write_bitstream -jobs 32

open_run impl_1 -name impl_1

## run sw build here
#
write_bitstream -force jihuu.bit
