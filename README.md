# zynq_scripted_build
Build scripts for testing zynq fpga scripted build

oneliner to build both software and hw

> vivado -mode batch -source <path_to_zynq_scripted_build>/tcl/build_all.tcl ; vitis -s <path_to_zynq_scripted_build>/sw_build_scripts/build_lwip.py

boot image can be written like this
> D:/Xilinx\Vitis\2024.2/bin/bootgen.bat -image C:\dev\remove\lwip_freertos.bif -arch zynq -o C:\dev\remove\freertos_lwip.bin -w on

the flash can be written using something like this
> D:\Xilinx\Vitis\2024.2\bin\program_flash -f C:\dev\remove\freertos_lwip.bin -offset 0 -flash_type qspi-x4-single -fsbl C:\dev\remove\ws2\platform\zynq_fsbl\build\fsbl.elf

the bif has following format

```powershell
dingelidong_pingelipong:
{
	[bootloader]C:\dev\remove\ws2\platform\export\platform\sw\boot\fsbl.elf
	C:\dev\remove\jihuu.bit
	C:\dev\remove\ws2\lwip_echo_server\build\lwip_echo_server.elf
}
```
