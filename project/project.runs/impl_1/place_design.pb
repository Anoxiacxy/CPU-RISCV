
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
22default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0052default:default2
1865.4492default:default2
0.0002default:defaultZ17-268h px� 
Z
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: f56d89bd
*commonh px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.010 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0042default:default2
1865.4492default:default2
0.0002default:defaultZ17-268h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
h
SPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 175f915ce
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:02 ; elapsed = 00:00:02 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 17941779e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:08 ; elapsed = 00:00:06 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 17941779e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:08 ; elapsed = 00:00:06 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
I
4Phase 1 Placer Initialization | Checksum: 17941779e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:08 ; elapsed = 00:00:06 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
2.1 2default:default2!
Floorplanning2default:defaultZ18-101h px� 
C
.Phase 2.1 Floorplanning | Checksum: 26e0c9898
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:10 ; elapsed = 00:00:07 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
x

Phase %s%s
101*constraints2
2.2 2default:default2)
Global Placement Core2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
2.2.1 2default:default20
Physical Synthesis In Placer2default:defaultZ18-101h px� 
�
FFound %s LUTNM shape to break, %s LUT instances to create LUTNM shape
553*physynth2
6212default:default2
702default:defaultZ32-1035h px� 
�
YBreak lutnm for timing: one critical %s, two critical %s, total %s, new lutff created %s
561*physynth2
1092default:default2
5122default:default2
6212default:default2
22default:defaultZ32-1044h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
6492default:default2!
nets or cells2default:default2
6212default:default2
cells2default:default2
282default:default2
cells2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
=Pass %s. Identified %s candidate %s for fanout optimization.
76*physynth2
12default:default2
62default:default2
nets2default:defaultZ32-76h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2@
cpu0/reg_id_ex_/Q[1]cpu0/reg_id_ex_/Q[1]2default:default2
222default:default8Z32-81h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2@
cpu0/reg_id_ex_/Q[0]cpu0/reg_id_ex_/Q[0]2default:default2
222default:default8Z32-81h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2@
cpu0/reg_id_ex_/Q[2]cpu0/reg_id_ex_/Q[2]2default:default2
152default:default8Z32-81h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2@
cpu0/reg_id_ex_/Q[3]cpu0/reg_id_ex_/Q[3]2default:default2
112default:default8Z32-81h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2@
cpu0/reg_id_ex_/Q[4]cpu0/reg_id_ex_/Q[4]2default:default2
102default:default8Z32-81h px� 
�
'Processed net %s. Replicated %s times.
81*physynth2@
cpu0/reg_id_ex_/Q[6]cpu0/reg_id_ex_/Q[6]2default:default2
62default:default8Z32-81h px� 
�
$Optimized %s %s. Created %s new %s.
216*physynth2
62default:default2
nets2default:default2
862default:default2
	instances2default:defaultZ32-232h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
62default:default2!
nets or cells2default:default2
862default:default2
cells2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.1242default:default2
1865.4492default:default2
0.0002default:defaultZ17-268h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[0]hci0/ADDRARDADDR[0]2default:default2B
hci0/ram_reg_0_0_i_17	hci0/ram_reg_0_0_i_172default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[2]hci0/ADDRARDADDR[2]2default:default2B
hci0/ram_reg_0_0_i_15	hci0/ram_reg_0_0_i_152default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[1]hci0/ADDRARDADDR[1]2default:default2B
hci0/ram_reg_0_0_i_16	hci0/ram_reg_0_0_i_162default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2t
.hci0/uart_blk/uart_rx_fifo/q_addr_reg[16]_3[0].hci0/uart_blk/uart_rx_fifo/q_addr_reg[16]_3[0]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_0_3_i_2	*hci0/uart_blk/uart_rx_fifo/ram_reg_0_3_i_22default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2`
$hci0/FSM_sequential_q_state_reg[1]_0$hci0/FSM_sequential_q_state_reg[1]_02default:default2@
hci0/ram_reg_0_0_i_1	hci0/ram_reg_0_0_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth24
hci0/p_0_in[0]hci0/p_0_in[0]2default:default2F
hci0/ram_mux_sel__6_i_1	hci0/ram_mux_sel__6_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[6]hci0/ADDRARDADDR[6]2default:default2B
hci0/ram_reg_0_0_i_11	hci0/ram_reg_0_0_i_112default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[9]hci0/ADDRARDADDR[9]2default:default2@
hci0/ram_reg_0_0_i_8	hci0/ram_reg_0_0_i_82default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2p
,hci0/uart_blk/uart_rx_fifo/q_addr_reg[16][0],hci0/uart_blk/uart_rx_fifo/q_addr_reg[16][0]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_3_2_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_3_2_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2Z
!hci0/uart_blk/uart_rx_fifo/WEA[0]!hci0/uart_blk/uart_rx_fifo/WEA[0]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_2_0_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_2_0_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[3]hci0/ADDRARDADDR[3]2default:default2B
hci0/ram_reg_0_0_i_14	hci0/ram_reg_0_0_i_142default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2@
hci0/ADDRARDADDR[12]hci0/ADDRARDADDR[12]2default:default2@
hci0/ram_reg_0_0_i_5	hci0/ram_reg_0_0_i_52default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2Z
!hci0/uart_blk/uart_rx_fifo/WEA[1]!hci0/uart_blk/uart_rx_fifo/WEA[1]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_2_1_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_2_1_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2@
hci0/ADDRARDADDR[13]hci0/ADDRARDADDR[13]2default:default2@
hci0/ram_reg_0_0_i_4	hci0/ram_reg_0_0_i_42default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2@
hci0/ADDRARDADDR[14]hci0/ADDRARDADDR[14]2default:default2@
hci0/ram_reg_0_0_i_3	hci0/ram_reg_0_0_i_32default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[8]hci0/ADDRARDADDR[8]2default:default2@
hci0/ram_reg_0_0_i_9	hci0/ram_reg_0_0_i_92default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2@
hci0/ADDRARDADDR[11]hci0/ADDRARDADDR[11]2default:default2@
hci0/ram_reg_0_0_i_6	hci0/ram_reg_0_0_i_62default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2H
hci0/q_addr_reg[15]_0[2]hci0/q_addr_reg[15]_0[2]2default:default2B
hci0/ram_reg_0_6_i_14	hci0/ram_reg_0_6_i_142default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[4]hci0/ADDRARDADDR[4]2default:default2B
hci0/ram_reg_0_0_i_13	hci0/ram_reg_0_0_i_132default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[7]hci0/ADDRARDADDR[7]2default:default2B
hci0/ram_reg_0_0_i_10	hci0/ram_reg_0_0_i_102default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2t
.hci0/uart_blk/uart_rx_fifo/q_addr_reg[16]_2[0].hci0/uart_blk/uart_rx_fifo/q_addr_reg[16]_2[0]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_1_5_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_1_5_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2H
hci0/q_addr_reg[15]_0[0]hci0/q_addr_reg[15]_0[0]2default:default2B
hci0/ram_reg_0_6_i_16	hci0/ram_reg_0_6_i_162default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2@
hci0/ADDRARDADDR[10]hci0/ADDRARDADDR[10]2default:default2@
hci0/ram_reg_0_0_i_7	hci0/ram_reg_0_0_i_72default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2@
hci0/ADDRARDADDR[15]hci0/ADDRARDADDR[15]2default:default2@
hci0/ram_reg_0_0_i_2	hci0/ram_reg_0_0_i_22default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2h
(hci0/uart_blk/uart_rx_fifo/hci_io_din[3](hci0/uart_blk/uart_rx_fifo/hci_io_din[3]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_0_3_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_0_3_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2>
hci0/ADDRARDADDR[5]hci0/ADDRARDADDR[5]2default:default2B
hci0/ram_reg_0_0_i_12	hci0/ram_reg_0_0_i_122default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2H
hci0/q_addr_reg[15]_0[1]hci0/q_addr_reg[15]_0[1]2default:default2B
hci0/ram_reg_0_6_i_15	hci0/ram_reg_0_6_i_152default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2t
.hci0/uart_blk/uart_rx_fifo/q_addr_reg[16]_0[1].hci0/uart_blk/uart_rx_fifo/q_addr_reg[16]_0[1]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_2_6_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_2_6_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2h
(hci0/uart_blk/uart_rx_fifo/hci_io_din[5](hci0/uart_blk/uart_rx_fifo/hci_io_din[5]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_0_5_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_0_5_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2H
hci0/q_addr_reg[15]_0[6]hci0/q_addr_reg[15]_0[6]2default:default2B
hci0/ram_reg_0_6_i_10	hci0/ram_reg_0_6_i_102default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2H
hci0/q_addr_reg[15]_0[3]hci0/q_addr_reg[15]_0[3]2default:default2B
hci0/ram_reg_0_6_i_13	hci0/ram_reg_0_6_i_132default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2h
(hci0/uart_blk/uart_rx_fifo/hci_io_din[4](hci0/uart_blk/uart_rx_fifo/hci_io_din[4]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_0_4_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_0_4_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2J
hci0/q_addr_reg[15]_0[12]hci0/q_addr_reg[15]_0[12]2default:default2@
hci0/ram_reg_0_6_i_4	hci0/ram_reg_0_6_i_42default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2H
hci0/q_addr_reg[15]_0[7]hci0/q_addr_reg[15]_0[7]2default:default2@
hci0/ram_reg_0_6_i_9	hci0/ram_reg_0_6_i_92default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2H
hci0/q_addr_reg[15]_0[4]hci0/q_addr_reg[15]_0[4]2default:default2B
hci0/ram_reg_0_6_i_12	hci0/ram_reg_0_6_i_122default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2H
hci0/q_addr_reg[15]_0[9]hci0/q_addr_reg[15]_0[9]2default:default2@
hci0/ram_reg_0_6_i_7	hci0/ram_reg_0_6_i_72default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2H
hci0/q_addr_reg[15]_0[8]hci0/q_addr_reg[15]_0[8]2default:default2@
hci0/ram_reg_0_6_i_8	hci0/ram_reg_0_6_i_82default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2t
.hci0/uart_blk/uart_rx_fifo/q_addr_reg[16]_3[1].hci0/uart_blk/uart_rx_fifo/q_addr_reg[16]_3[1]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_0_4_i_2	*hci0/uart_blk/uart_rx_fifo/ram_reg_0_4_i_22default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2J
hci0/q_addr_reg[15]_0[15]hci0/q_addr_reg[15]_0[15]2default:default2@
hci0/ram_reg_0_6_i_1	hci0/ram_reg_0_6_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2h
(hci0/uart_blk/uart_rx_fifo/hci_io_din[6](hci0/uart_blk/uart_rx_fifo/hci_io_din[6]2default:default2n
+hci0/uart_blk/uart_rx_fifo/ram_reg_0_6_i_17	+hci0/uart_blk/uart_rx_fifo/ram_reg_0_6_i_172default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2J
hci0/q_addr_reg[15]_0[13]hci0/q_addr_reg[15]_0[13]2default:default2@
hci0/ram_reg_0_6_i_3	hci0/ram_reg_0_6_i_32default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2h
(hci0/uart_blk/uart_rx_fifo/hci_io_din[7](hci0/uart_blk/uart_rx_fifo/hci_io_din[7]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_0_7_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_0_7_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2J
hci0/q_addr_reg[15]_0[14]hci0/q_addr_reg[15]_0[14]2default:default2@
hci0/ram_reg_0_6_i_2	hci0/ram_reg_0_6_i_22default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2h
(hci0/uart_blk/uart_rx_fifo/hci_io_din[2](hci0/uart_blk/uart_rx_fifo/hci_io_din[2]2default:default2l
*hci0/uart_blk/uart_rx_fifo/ram_reg_0_2_i_1	*hci0/uart_blk/uart_rx_fifo/ram_reg_0_2_i_12default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2J
hci0/q_addr_reg[15]_0[11]hci0/q_addr_reg[15]_0[11]2default:default2@
hci0/ram_reg_0_6_i_5	hci0/ram_reg_0_6_i_52default:default8Z32-117h px� 
�
DNet %s could not be optimized because driver %s could not be cloned
117*physynth2J
hci0/q_addr_reg[15]_0[10]hci0/q_addr_reg[15]_0[10]2default:default2@
hci0/ram_reg_0_6_i_6	hci0/ram_reg_0_6_i_62default:default8Z32-117h px� 
P
.No nets found for critical-cell optimization.
68*physynthZ32-68h px� 
�
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
j
FNo candidate cells for DSP register optimization found in the design.
274*physynthZ32-456h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
i
DNo candidate cells found for Shift Register to Pipeline optimization564*physynthZ32-1123h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
h
DNo candidate cells for SRL register optimization found in the design349*physynthZ32-677h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
i
ENo candidate cells for BRAM register optimization found in the design297*physynthZ32-526h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
j
FNo candidate cells for URAM register optimization found in the design
437*physynthZ32-846h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
R
.No candidate nets found for HD net replication521*physynthZ32-949h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0052default:default2
1865.4492default:default2
0.0002default:defaultZ17-268h px� 
B
-
Summary of Physical Synthesis Optimizations
*commonh px� 
B
-============================================
*commonh px� 


*commonh px� 


*commonh px� 
�
�-----------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Optimization                                     |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
-----------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  LUT Combining                                    |          621  |             28  |                   649  |           0  |           1  |  00:00:02  |
|  Very High Fanout                                 |           86  |              0  |                     6  |           0  |           1  |  00:00:07  |
|  Critical Cell                                    |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  DSP Register                                     |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Shift Register to Pipeline                       |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Shift Register                                   |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  BRAM Register                                    |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  URAM Register                                    |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Dynamic/Static Region Interface Net Replication  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total                                            |          707  |             28  |                   655  |           0  |           9  |  00:00:08  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 


*commonh px� 


*commonh px� 
T
?Phase 2.2.1 Physical Synthesis In Placer | Checksum: 25c5f97ab
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:15 ; elapsed = 00:00:46 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
K
6Phase 2.2 Global Placement Core | Checksum: 10e87d514
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:16 ; elapsed = 00:00:47 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
D
/Phase 2 Global Placement | Checksum: 10e87d514
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:16 ; elapsed = 00:00:47 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 15b918cb8
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:20 ; elapsed = 00:00:49 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 2329cc7c7
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:27 ; elapsed = 00:00:53 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 2668885da
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:28 ; elapsed = 00:00:53 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 200a331ed
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:28 ; elapsed = 00:00:53 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
t

Phase %s%s
101*constraints2
3.5 2default:default2%
Fast Optimization2default:defaultZ18-101h px� 
G
2Phase 3.5 Fast Optimization | Checksum: 20bbde73a
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:21 ; elapsed = 00:01:44 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 


Phase %s%s
101*constraints2
3.6 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.6 Small Shape Detail Placement | Checksum: 1bf255686
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:48 ; elapsed = 00:02:13 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
u

Phase %s%s
101*constraints2
3.7 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.7 Re-assign LUT pins | Checksum: 222f5301e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:50 ; elapsed = 00:02:14 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
3.8 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.8 Pipeline Register Optimization | Checksum: 183e6af7d
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:50 ; elapsed = 00:02:15 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
t

Phase %s%s
101*constraints2
3.9 2default:default2%
Fast Optimization2default:defaultZ18-101h px� 
G
2Phase 3.9 Fast Optimization | Checksum: 2571258b0
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:03:10 ; elapsed = 00:02:31 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 2571258b0
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:03:10 ; elapsed = 00:02:31 . Memory (MB): peak = 1865.449 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
V
APost Placement Optimization Initialization | Checksum: 13d7c4d7b
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
a

Starting %s Task
103*constraints2&
Physical Synthesis2default:defaultZ18-103h px� 
�

Phase %s%s
101*constraints2
1 2default:default25
!Physical Synthesis Initialization2default:defaultZ18-101h px� 
�
EMultithreading enabled for phys_opt_design using a maximum of %s CPUs380*physynth2
22default:defaultZ32-721h px� 
�
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2default:default2
 2default:default2
-9.7852default:default2

-37722.9922default:defaultZ32-619h px� 
U
@Phase 1 Physical Synthesis Initialization | Checksum: 139b7a64f
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 1910.277 ; gain = 0.0002default:defaulth px� 
�
PProcessed net %s, BUFG insertion was skipped due to placement/routing conflicts.32*	placeflow2*
cpu0/ctrl_ram_/rst_reg2default:defaultZ46-33h px� 
�
PProcessed net %s, BUFG insertion was skipped due to placement/routing conflicts.32*	placeflow23
cpu0/reg_id_ex_/jump_o_reg_0[0]2default:defaultZ46-33h px� 
�
�BUFG insertion identified %s candidate nets. Inserted BUFG: %s, Replicated BUFG Driver: %s, Skipped due to Placement/Routing Conflicts: %s, Skipped due to Timing Degradation: %s, Skipped due to Illegal Netlist: %s.43*	placeflow2
22default:default2
02default:default2
02default:default2
22default:default2
02default:default2
02default:defaultZ46-56h px� 
J
5Ending Physical Synthesis Task | Checksum: 1c78f57cc
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:03 ; elapsed = 00:00:02 . Memory (MB): peak = 1910.277 ; gain = 0.0002default:defaulth px� 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 13d7c4d7b
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:03:21 ; elapsed = 00:02:38 . Memory (MB): peak = 1910.277 ; gain = 44.8282default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
-8.5032default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 1cc006787
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:05:51 ; elapsed = 00:04:36 . Memory (MB): peak = 1910.277 ; gain = 44.8282default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 1cc006787
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:05:51 ; elapsed = 00:04:36 . Memory (MB): peak = 1910.277 ; gain = 44.8282default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 1cc006787
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:05:52 ; elapsed = 00:04:37 . Memory (MB): peak = 1910.277 ; gain = 44.8282default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 1cc006787
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:05:52 ; elapsed = 00:04:37 . Memory (MB): peak = 1910.277 ; gain = 44.8282default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0132default:default2
1910.2772default:default2
0.0002default:defaultZ17-268h px� 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 1dd145020
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:05:52 ; elapsed = 00:04:37 . Memory (MB): peak = 1910.277 ; gain = 44.8282default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 1dd145020
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:05:52 ; elapsed = 00:04:37 . Memory (MB): peak = 1910.277 ; gain = 44.8282default:defaulth px� 
>
)Ending Placer Task | Checksum: 13b754f49
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:05:52 ; elapsed = 00:04:37 . Memory (MB): peak = 1910.277 ; gain = 44.8282default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1302default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
place_design: 2default:default2
00:05:542default:default2
00:04:382default:default2
1910.2772default:default2
44.8282default:defaultZ17-268h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:042default:default2
00:00:012default:default2
1910.2772default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2r
^C:/Users/Anoxiacxy/Documents/Github/CPU-RISCV/project/project.runs/impl_1/riscv_top_placed.dcp2default:defaultZ17-1381h px� 
d
%s4*runtcl2H
4Executing : report_io -file riscv_top_io_placed.rpt
2default:defaulth px� 
�
kreport_io: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.024 . Memory (MB): peak = 1910.277 ; gain = 0.000
*commonh px� 
�
%s4*runtcl2~
jExecuting : report_utilization -file riscv_top_utilization_placed.rpt -pb riscv_top_utilization_placed.pb
2default:defaulth px� 
�
%s4*runtcl2e
QExecuting : report_control_sets -verbose -file riscv_top_control_sets_placed.rpt
2default:defaulth px� 
�
ureport_control_sets: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.037 . Memory (MB): peak = 1910.277 ; gain = 0.000
*commonh px� 


End Record