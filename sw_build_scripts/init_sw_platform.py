#!/usr/bin/env python3
import vitis
import os
import time
import shutil
from datetime import datetime
import platform as os_platform

print ("\n-----------------------------------------------------")
print ("Platform flow use case 4: Creation of zynq platform, baremetal domain creation, generation and app component creation\n")

# Create a client object -
client = vitis.create_client()

# Set workspace
date = datetime.now().strftime("%Y%m%d%I%M%S")
if(os_platform.system() == "Windows"):
   workspace = '.\\tmp\\workspace_'+date+'\\'
else:
    workspace = './tmp/workspace_'+date+'/'

platform_name = "platform_test"

#Delete the workspace if already exists.
if (os.path.isdir(workspace)):
    shutil.rmtree(workspace)
    print(f"Deleted workspace {workspace}")

client.set_workspace(workspace)

platform = client.create_platform_component(name = platform_name, hw_design='d:\\dev\\zynq_scripted_build\\build\\my_project\\zynq_bd_wrapper.xsa')
platform.report()

# Add another domain
# standalone_a9_0 = platform.add_domain(name = "standalone_a9_0", cpu = "ps7_cortexa9_0", os = "standalone")
# platform.list_domains()

# Build the platform
# platform.build()
#
# # Create an application component with generated platform using template
# platform_xpfm = client.find_platform_in_repos(platform_name)
# app_component = client.create_app_component(name = 'app_component1', platform = platform_xpfm, domain = 'standalone_a9_0', template = 'hello_world')
#
# # Build app component
# app_component.build()
