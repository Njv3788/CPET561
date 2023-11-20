onerror {resume}

quietly WaveActivateNextPane {} 0
add wave -noupdate                    /Lab8_tb/uut/filter/clk
add wave -noupdate                    /Lab8_tb/uut/filter/reset
add wave -noupdate                    /Lab8_tb/uut/filter/filter_en
add wave -noupdate                    /Lab8_tb/uut/filter/data_in
add wave -noupdate                    /Lab8_tb/uut/filter/data_out
add wave -noupdate                    /Lab8_tb/uut/filter/register_q
add wave -noupdate                    /Lab8_tb/uut/filter/add_q
add wave -noupdate                    /Lab8_tb/uut/filter/multiplier_q
add wave -noupdate                    /Lab8_tb/audioSampleArray

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {887 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {12000 ns}

