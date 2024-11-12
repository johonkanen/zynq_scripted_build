# Step 0: set up path to this file
variable tcl_path [ file dirname [ file normalize [ info script ] ] ] 
variable build_path ./

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
source 

# here starts the vhdl design
add_files -norecurse d:/dev/zynq_scripted_build/vhdl_sources/top.vhd

launch_runs zynq_bd_processing_system7_0_0_synth_1 -jobs 32

write_hw_platform -fixed -force -file $hc_project_path/zynq_bd_wrapper.xsa

launch_runs synth_1 -jobs 32
wait_on_run synth_1
set_property IOSTANDARD LVCMOS33 [get_ports [list led_blinker]]
place_ports led_blinker P15
launch_runs impl_1 -to_step write_bitstream -jobs 32
wait_on_run impl_1

