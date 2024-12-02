# 2024-11-30T07:31:59.744094
import vitis

client = vitis.create_client()
client.set_workspace(path="ws")

platform = client.create_platform_component(name = "platform"
                                            ,hw_design = "zynq_hw_export.xsa"
                                            ,os = "standalone"
                                            ,cpu = "ps7_cortexa9_0"
                                            ,domain_name = "standalone_ps7_cortexa9_0")

platform = client.get_component(name="platform")
domain = platform.get_domain(name="standalone_ps7_cortexa9_0")
status = domain.set_lib(lib_name="lwip220"
                        , path="D:\Xilinx\Vitis\2024.2\data\embeddedsw\ThirdParty\sw_services\lwip220_v1_1")

status = platform.build()

# platform with library needs to be built before aplication component can be added
comp = client.create_app_component(name="lwip_echo_server"
                                   ,platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm"
                                   ,domain = "standalone_ps7_cortexa9_0"
                                   ,template = "lwip_echo_server")

comp = client.get_component(name="lwip_echo_server")
comp.build()
client.close()
