onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/dut/clkSelect
add wave -noupdate /DE1_SoC_testbench/dut/rst
add wave -noupdate {/DE1_SoC_testbench/dut/KEY[0]}
add wave -noupdate -expand /DE1_SoC_testbench/dut/RedPixels
add wave -noupdate -expand /DE1_SoC_testbench/dut/GrnPixels
add wave -noupdate /DE1_SoC_testbench/dut/position
add wave -noupdate /DE1_SoC_testbench/dut/gameover
add wave -noupdate /DE1_SoC_testbench/dut/HEX1
add wave -noupdate /DE1_SoC_testbench/dut/HEX0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1521848 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1575263 ps}
