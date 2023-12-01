onerror {resume}
quietly virtual function -install /score_counter_testbench/dut -env /score_counter_testbench/dut { &{/score_counter_testbench/dut/count_bcd[7], /score_counter_testbench/dut/count_bcd[6], /score_counter_testbench/dut/count_bcd[5], /score_counter_testbench/dut/count_bcd[4] }} HighBCD
quietly virtual function -install /score_counter_testbench/dut -env /score_counter_testbench/dut { &{/score_counter_testbench/dut/count_bcd[3], /score_counter_testbench/dut/count_bcd[2], /score_counter_testbench/dut/count_bcd[1], /score_counter_testbench/dut/count_bcd[0] }} LowBCD
quietly WaveActivateNextPane {} 0
add wave -noupdate /score_counter_testbench/clk
add wave -noupdate /score_counter_testbench/rst
add wave -noupdate /score_counter_testbench/gameover
add wave -noupdate /score_counter_testbench/green_column
add wave -noupdate /score_counter_testbench/hex0
add wave -noupdate /score_counter_testbench/hex1
add wave -noupdate /score_counter_testbench/dut/previous
add wave -noupdate -radix unsigned -childformat {{(3) -radix decimal} {(2) -radix decimal} {(1) -radix decimal} {(0) -radix decimal}} -subitemconfig {{/score_counter_testbench/dut/count_bcd[7]} {-radix decimal} {/score_counter_testbench/dut/count_bcd[6]} {-radix decimal} {/score_counter_testbench/dut/count_bcd[5]} {-radix decimal} {/score_counter_testbench/dut/count_bcd[4]} {-radix decimal}} /score_counter_testbench/dut/HighBCD
add wave -noupdate -radix unsigned -childformat {{(3) -radix decimal} {(2) -radix decimal} {(1) -radix decimal} {(0) -radix decimal}} -expand -subitemconfig {{/score_counter_testbench/dut/count_bcd[3]} {-radix decimal} {/score_counter_testbench/dut/count_bcd[2]} {-radix decimal} {/score_counter_testbench/dut/count_bcd[1]} {-radix decimal} {/score_counter_testbench/dut/count_bcd[0]} {-radix decimal}} /score_counter_testbench/dut/LowBCD
add wave -noupdate {/score_counter_testbench/dut/count_bcd[7]}
add wave -noupdate {/score_counter_testbench/dut/count_bcd[6]}
add wave -noupdate {/score_counter_testbench/dut/count_bcd[5]}
add wave -noupdate {/score_counter_testbench/dut/count_bcd[4]}
add wave -noupdate {/score_counter_testbench/dut/count_bcd[3]}
add wave -noupdate {/score_counter_testbench/dut/count_bcd[2]}
add wave -noupdate {/score_counter_testbench/dut/count_bcd[1]}
add wave -noupdate {/score_counter_testbench/dut/count_bcd[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2550 ps} 0}
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
WaveRestoreZoom {0 ps} {9293 ps}
