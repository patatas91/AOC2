onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_test/MIPS/clk
add wave -noupdate -color Magenta -itemcolor Magenta /mips_test/MIPS/MI_ready
add wave -noupdate -color White -itemcolor White /mips_test/MIPS/load_PC
add wave -noupdate -color Blue -itemcolor Blue /mips_test/MIPS/Branch
add wave -noupdate -radix hexadecimal -radixshowbase 0 /mips_test/MIPS/PC_in
add wave -noupdate -radix hexadecimal -radixshowbase 0 /mips_test/MIPS/PC_out
add wave -noupdate -color Red -itemcolor Red -radix binary -radixshowbase 0 /mips_test/MIPS/Op_code_ID
add wave -noupdate -color Magenta -itemcolor Magenta -radix hexadecimal -radixshowbase 0 /mips_test/MIPS/MI_out
add wave -noupdate -color Gold -itemcolor Gold -radix hexadecimal -radixshowbase 0 /mips_test/MIPS/BusA_EX
add wave -noupdate -color Gold -itemcolor Gold -radix hexadecimal -radixshowbase 0 /mips_test/MIPS/Mux_out
add wave -noupdate -color Gold -itemcolor Gold -radix hexadecimal -radixshowbase 0 /mips_test/MIPS/ALU_out_EX
add wave -noupdate /mips_test/MIPS/MemRead_MEM
add wave -noupdate /mips_test/MIPS/MemWrite_MEM
add wave -noupdate -color Pink -itemcolor Pink -radix hexadecimal -childformat {{/mips_test/MIPS/Mem_D/RAM(0) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(1) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(2) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(3) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(4) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(5) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(6) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(7) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(8) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(9) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(10) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(11) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(12) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(13) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(14) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(15) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(16) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(17) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(18) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(19) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(20) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(21) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(22) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(23) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(24) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(25) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(26) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(27) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(28) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(29) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(30) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(31) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(32) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(33) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(34) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(35) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(36) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(37) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(38) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(39) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(40) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(41) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(42) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(43) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(44) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(45) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(46) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(47) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(48) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(49) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(50) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(51) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(52) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(53) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(54) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(55) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(56) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(57) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(58) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(59) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(60) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(61) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(62) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(63) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(64) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(65) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(66) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(67) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(68) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(69) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(70) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(71) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(72) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(73) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(74) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(75) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(76) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(77) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(78) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(79) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(80) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(81) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(82) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(83) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(84) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(85) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(86) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(87) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(88) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(89) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(90) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(91) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(92) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(93) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(94) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(95) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(96) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(97) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(98) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(99) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(100) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(101) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(102) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(103) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(104) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(105) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(106) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(107) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(108) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(109) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(110) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(111) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(112) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(113) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(114) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(115) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(116) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(117) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(118) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(119) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(120) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(121) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(122) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(123) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(124) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(125) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(126) -radix hexadecimal} {/mips_test/MIPS/Mem_D/RAM(127) -radix hexadecimal}} -radixshowbase 0 -subitemconfig {/mips_test/MIPS/Mem_D/RAM(0) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(1) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(2) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(3) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(4) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(5) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(6) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(7) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(8) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(9) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(10) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(11) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(12) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(13) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(14) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(15) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(16) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(17) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(18) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(19) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(20) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(21) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(22) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(23) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(24) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(25) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(26) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(27) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(28) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(29) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(30) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(31) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(32) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(33) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(34) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(35) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(36) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(37) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(38) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(39) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(40) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(41) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(42) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(43) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(44) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(45) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(46) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(47) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(48) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(49) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(50) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(51) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(52) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(53) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(54) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(55) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(56) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(57) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(58) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(59) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(60) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(61) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(62) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(63) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(64) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(65) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(66) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(67) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(68) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(69) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(70) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(71) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(72) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(73) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(74) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(75) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(76) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(77) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(78) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(79) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(80) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(81) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(82) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(83) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(84) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(85) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(86) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(87) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(88) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(89) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(90) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(91) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(92) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(93) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(94) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(95) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(96) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(97) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(98) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(99) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(100) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(101) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(102) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(103) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(104) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(105) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(106) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(107) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(108) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(109) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(110) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(111) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(112) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(113) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(114) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(115) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(116) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(117) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(118) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(119) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(120) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(121) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(122) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(123) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(124) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(125) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(126) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Mem_D/RAM(127) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0}} /mips_test/MIPS/Mem_D/RAM
add wave -noupdate /mips_test/MIPS/RegWrite_WB
add wave -noupdate -color Pink -itemcolor Pink -radix hexadecimal -childformat {{/mips_test/MIPS/Register_bank/reg_file(0) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(1) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(2) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(3) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(4) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(5) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(6) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(7) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(8) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(9) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(10) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(11) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(12) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(13) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(14) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(15) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(16) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(17) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(18) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(19) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(20) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(21) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(22) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(23) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(24) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(25) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(26) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(27) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(28) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(29) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(30) -radix hexadecimal} {/mips_test/MIPS/Register_bank/reg_file(31) -radix hexadecimal}} -radixshowbase 0 -subitemconfig {/mips_test/MIPS/Register_bank/reg_file(0) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(1) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(2) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(3) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(4) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(5) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(6) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(7) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(8) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(9) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(10) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(11) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(12) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(13) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(14) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(15) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(16) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(17) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(18) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(19) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(20) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(21) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(22) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(23) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(24) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(25) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(26) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(27) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(28) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(29) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(30) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0} /mips_test/MIPS/Register_bank/reg_file(31) {-color Pink -height 15 -itemcolor Pink -radix hexadecimal -radixshowbase 0}} /mips_test/MIPS/Register_bank/reg_file
add wave -noupdate -color Cyan -itemcolor Cyan /mips_test/MIPS/riesgo_rs_d1
add wave -noupdate -color Cyan -itemcolor Cyan /mips_test/MIPS/riesgo_rs_d2
add wave -noupdate -color Cyan -itemcolor Cyan /mips_test/MIPS/riesgo_rt_d1
add wave -noupdate -color Cyan -itemcolor Cyan /mips_test/MIPS/riesgo_rt_d2
add wave -noupdate -color Red -itemcolor Red /mips_test/MIPS/avanzar_F
add wave -noupdate -color {Medium Spring Green} -itemcolor {Medium Spring Green} /mips_test/MIPS/avanzar_ID
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {589 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 210
configure wave -valuecolwidth 68
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {536 ns} {601 ns}