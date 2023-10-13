# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "custom_component_demo"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY custom_component_demo
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 4] import pin assigment from file
set_global_assignment -name QSF_FILE ../../src/HW/DE1_SoC.qsf

#execute_flow -compile
project_close


