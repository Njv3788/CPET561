# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "Nios_II_Processor"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY Nios_II_Processor
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

project_close


