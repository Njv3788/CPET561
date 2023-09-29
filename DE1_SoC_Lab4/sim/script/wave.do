onerror {resume}
radix define Display {
    "7'b1000000" "0"     -color "yellow",
    "7'b1111001" "1"     -color "yellow",
    "7'b0100100" "2"     -color "yellow",
    "7'b0110000" "3"     -color "yellow",
    "7'b0011001" "4"     -color "yellow",
    "7'b0010010" "5"     -color "yellow",
    "7'b0000010" "6"     -color "yellow",
    "7'b1111000" "7"     -color "yellow",
    "7'b0000000" "8"     -color "yellow",
    "7'b0011000" "9"     -color "yellow",
    "7'b0001000" "A"     -color "yellow",
    "7'b0000011" "B"     -color "yellow",
    "7'b1000110" "C"     -color "yellow",
    "7'b0100001" "D"     -color "yellow",
    "7'b0000110" "E"     -color "yellow",
    "7'b0001110" "F"     -color "yellow",
    "7'b1111111" "blank" -color "yellow",
    -default default         yellow
}

radix define state  {
    "5'b00001" "IDLE"          -color "orange",
    "5'b00010" "SWEEP_RIGHT"   -color "orange",
    "5'b00100" "INT_RIGHT"     -color "orange",
    "5'b01000" "SWEEP_LEFT"    -color "orange",
    "5'b10000" "INT_LEFT"      -color "orange",
    -default default         orange
}

quietly WaveActivateNextPane {} 0
add wave -noupdate /lab4_top_tb/clk
add wave -noupdate /lab4_top_tb/reset
add wave -noupdate /lab4_top_tb/address
add wave -noupdate /lab4_top_tb/write
add wave -noupdate -radix hexadecimal /lab4_top_tb/writedata
add wave -noupdate -radix hexadecimal /lab4_top_tb/uut/ram/Registers
add wave -noupdate -radix state /lab4_top_tb/uut/fsm/current_states
add wave -noupdate -radix state /lab4_top_tb/uut/fsm/next_states
add wave -noupdate -radix state /lab4_top_tb/uut/fsm/irq
add wave -noupdate -radix state /lab4_top_tb/uut/fsm/direxction
add wave -noupdate -radix state /lab4_top_tb/uut/fsm/idle_out
add wave -noupdate -radix hexadecimal /lab4_top_tb/uut/period_cnt/pulse
add wave -noupdate -radix hexadecimal /lab4_top_tb/uut/period_cnt/pwm
add wave -noupdate -radix hexadecimal /lab4_top_tb/uut/period_cnt/count_sig
add wave -noupdate -radix hexadecimal /lab4_top_tb/uut/period_cnt/next_count
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
WaveRestoreZoom {0 ns} {2100 ns}

