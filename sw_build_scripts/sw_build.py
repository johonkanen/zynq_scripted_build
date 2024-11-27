#-----------------------------------------------------------------
# Vitis v2024.2 (64-bit)
# Start of session at: Wed Nov 27 15:20:44 2024
# Current directory: D:\dev\zynq_scripted_build\build
# Command line: vitis -i
# Journal file: vitis_journal.py
# Batch mode: $XILINX_VITIS/bin/vitis -new -s D:\dev\zynq_scripted_build\build\vitis_journal.py
#-----------------------------------------------------------------

#!/usr/bin/env python3
import vitis
import os

client = vitis.create_client()
pwd = os.getcwd()
client.set_workspace(pwd + '/pyws')

platform = client.create_platform_component(name = "base_platform",hw_design = "zynq_hw_export.xsa",os = "standalone",cpu = "ps7_cortexa9_0")
