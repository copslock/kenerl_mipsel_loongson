Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2009 21:49:28 +0000 (GMT)
Received: from kuber.nabble.com ([216.139.236.158]:3213 "EHLO kuber.nabble.com")
	by ftp.linux-mips.org with ESMTP id S21365811AbZBPVtY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Feb 2009 21:49:24 +0000
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1LZBL7-0001OH-Kw
	for linux-mips@linux-mips.org; Mon, 16 Feb 2009 13:49:21 -0800
Message-ID: <22046664.post@talk.nabble.com>
Date:	Mon, 16 Feb 2009 13:49:21 -0800 (PST)
From:	fabry83 <distributor@hotmail.it>
To:	linux-mips@linux-mips.org
Subject: Kernel 2.4.17_mvl21-malta-mips: error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Nabble-From: distributor@hotmail.it
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: distributor@hotmail.it
Precedence: bulk
X-list: linux-mips


Hello world

I have a router d'link g624t with 32mb of ram,TI ar7,bootloader adam2.
I have installed Routertech 2.8 and when i try to use the wireless access
point i have a kernel error...
With the help of Thechief i have try a new release deactivating the mips 16
code,but the problem is unsolved.
I post the serial debug with the error:

[CODE]

Copyright (C) 2006 Merlion-ACORP Russia Software Company.
Launching kernel LZMA decompressor.
Kernel decompressor was successful ... launching kernel.

LINUX started...
Config serial console: ttyS0,38400
Auto Detection SANGAM chip
This SOC has MDIX cababilities on chip.
CPU revision is: 00018448
Primary instruction cache 16kb, linesize 16 bytes (4 ways)
Primary data cache 16kb, linesize 16 bytes (4 ways)
Number of TLB entries 16.
Linux version 2.4.17_mvl21-malta-mips_fp_le (router@Ubuntu) () #1 Sun Nov 23
01:41:54 GMT 2008
Determined physical RAM map:
 memory: 14000000 @ 00000000 (reserved)
 memory: 00020000 @ 14000000 (ROM data)
 memory: 01fe0000 @ 14020000 (usable)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: 
calculating r4koff... 000b71b0(750000)
CPU frequency 150.00 MHz
Calibrating delay loop... 149.91 BogoMIPS
Freeing Adam2 reserved memory [0x14001000,0x0001f000]
Memory: 30156k/32768k available (1802k kernel code, 2612k reserved, 131k
data, 60k init)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
TI Optimizations: Allocating TI-Cached Memory Pool.
Using 120 Buffers for TI-Cached Memory Pool.
DEBUG: Using Hybrid Mode.
NSP Optimizations: Succesfully allocated TI-Cached Memory Pool.
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
squashfs: version 3.1 (2006/08/19) Phillip Lougher, lzma support by McMCC
Adam2 environment variables API installed.
pty: 32 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xa8610e00 (irq = 15) is a 16550A
ttyS01 at 0xa8610f00 (irq = 16) is a 16550A
Vlynq CONFIG_MIPS_AVALANCHE_VLYNQ_PORTS=2
Vlynq Device vlynq0 registered with minor no 63 as misc device. Result=0
Vlynq instance:0 Link UP
Vlynq Device vlynq1 registered with minor no 62 as misc device. Result=0
VLYNQ 1 : init failed
cpu_freq = 150000000
block: 64 slots per queue, batch=16
DEBUG: Initializing the voice port management module. 
DEBUG: Initialization of the voice port management module successful..
Cpmac driver is allocating buffer memory at init time.
Cpmac driver Enable TX complete interrupt
Default Asymmetric MTU for eth0 1500
Default Asymmetric MTU for eth1 1500
Default Asymmetric MTU for eth2 1500
Default Asymmetric MTU for eth3 1500
PPP generic driver version 2.4.1
avalanche flash device: 0x400000 at 0x10000000.
 Amd/Fujitsu Extended Query Table v1.1 at 0x0040
Flash type: AMD; Manufacturer=AMD.
Manufacturer_ID=0x0001; Chip_ID=0x00F9; Chip_Size=0x400000;
Erase_Regions=0x0002
The Chief's FLASH extensions (www.RouterTech.Org): code loaded.
number of CFI chips: 1
Looking for mtd device :mtd0:
Found a mtd0 image (0x94000), with size (0x35c000).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x00094000-0x003f0000 : "mtd0"
mtd: partition "mtd0" doesn't start on an erase block boundary -- force
read-only
Looking for mtd device :mtd1:
Found a mtd1 image (0x10090), with size (0x83f70).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x00010090-0x00094000 : "mtd1"
mtd: partition "mtd1" doesn't start on an erase block boundary -- force
read-only
Looking for mtd device :mtd2:
Found a mtd2 image (0x0), with size (0x10000).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x00000000-0x00010000 : "mtd2"
Looking for mtd device :mtd3:
Found a mtd3 image (0x3f0000), with size (0x10000).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x003f0000-0x00400000 : "mtd3"
Looking for mtd device :mtd4:
Found a mtd4 image (0x10000), with size (0x3e0000).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x00010000-0x003f0000 : "mtd4"
Looking for mtd device :mtd5:
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack version 2.1 (256 buckets, 2048 max) - 384 bytes per conntrack
ip_conntrack_pptp version 1.9 loaded
ip_nat_pptp version 1.5 loaded
ip_tables: (C) 2000-2002 Netfilter core team
ipt_account 0.1.6 : Piotr Gasid³o <quaker@barbara.eu.org>,
http://www.barbara.eu.org/~quaker/ipt_account/
netfilter PSD loaded - (c) astaro AG
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
Initializing the WAN Bridge.
Please set the MAC Address for the WAN Bridge.
Set the Environment variable 'HWA_3' or 'macc' or 'wan_br_mac'. 
MAC Address should be in the following format: xx:xx:xx:xx:xx:xx
VFS: Mounted root (squashfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 60k freed
Algorithmics/MIPS FPU Emulator v1.5
Sun Nov 23 01:46:00 UTC 2008
 Reading Standard Configuration File /etc/led.conf

 Configured 19 states 
registered device TI Avalanche SAR
Sangam detected
DSP binary filesize = 362422 bytes
tn7dsl_set_modulation : Setting mode to 0xff
Texas Instruments ATM driver: version:[7.03.09.00]
ifconfig: SIOCGIFFLAGS: No such device
ifconfig: SIOCGIFFLAGS: No such device
ifconfig: SIOCGIFFLAGS: No such device

Please press Enter to activate this console. PVC dB
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
Nov 23 01:46:12 cfgmgr(pppoa-108): Nov 23 01:46:12 | Valid Configuration
Tree
Doing BRCTL ...
addbr br0 
Doing BRCTL ...
addbr br1 
Doing BRCTL ...
addbr br2 
Nov 23 01:4tn7dsl_set_modulation : Setting mode to 0xff
6:12 cfgmgr(sntp): Nov 23 01:46:12 | NTP Polling Timer for DHCP Started
succesfully.
Nov 23 01:46:12 cfgmgr(sar): Nov 23 01:46:12 | DSL Polling Timer Started
succesfully.
Nov 23 01:46:12 cfgmgr(sar): Nov 23 01:46:12 | PSP Boot environment  Modem
Modulation Change: 0xff
Nov 23 01:46:13 cfgmgr(fdb): Nov 23 01:46:13 | Firewall NAT service started
Default Asymmetric MTU for br0 1500
Nov 23 01:46:13 cfgmgr(lanbridge0): Nov 23 01:46:13 | Bridge Created: br0
Default Asymmetric MTU for br1 1500
Default Asymmetric MTU for br2 1500
Doing BRCTL ...
setfilter br0 0 
Nov 23 01:46:15 cfgmgr(lanbridge0): Nov 23 01:46:15 | Bridge VLAN0 add eth0
Nov 23 01:46:15 cfgmgr(lanbridge0): Nov 23 01:46:15 | Bridge VLAN AUTO OFF.
Doing BRCTL ...
vlan trailer disable 
Doing BRCTL ...
addif br0 eth0 
Nov 23 01:46:15 cfgmgr(lanbridge1): Nov 23 01:46:15 | Bridge Created: br1
device eth0 entered promiscuous mode
br0: port 1(eth0) entering learning state
Doing BRCTL ...
setfilter br1 0 
Nov 23 01:46:16 cfgmgr(lanbridge2): Nov 23 01:46:16 | Bridge Created: br2
Doing BRCTL ...
setfilter br2 0 
Doing BRCTL ...
stp br0 off 
Doing BRCTL ...
setigmpsnoop br0 off 
Doing BRCTL ...
stp br1 off 
Doing BRCTL ...
setigmpsnoop br1 off 
Nov 23 01:46:18 cfgmgr(lanbridge0): Nov 23 01:46:18 | Bridge Interface
Added: eth0
set bridge igmp snooping Off
Default Asymmetric MTU for wlan0 1500
set bridge igmp snooping Off
br0: port 1(eth0) entering forwarding state
br0: topology change detected, propagating
296: 
802.11d is 296: disabled.
296: 802.11h is 296: disabled.
296: Configuration succeeded !!!
296: WLAN driver database is up
Resetting the remote device.
Doing BRCTL ...
setfilter br0 0 
Doing BRCTL ...
stp br2 off 
Doing BRCTL ...
setigmpsnoop br2 off 
Nov 23 01:46:20 cfgmgr(ap): Nov 23 01:46:20 | AP Driver configuration
successful
Un-resetting the remote device.
About to re-init the VLYNQ.
Re-initialized the VLYNQ.
298: AcxRegAddr = 0xA4040000, AcxMemAddr = 0xA4000000
298: whal_acxProcInitiate: found DEVICE_VENDOR ID = 0x9066104c
299: whal_acxProcInitiate: Cpu halt -> download code
299: whal_acxProcLoadFwImage: 0xa4000000, 0x0
299: whal_acxProcLoadFwImage() -- Loading FW image299: Compiled for RADIA
(bg) radio
299: whal_acxProcLoadFwImage: 1, pBuf=0xc00a4000, len=0x15564. Extra
pBuf=0x0, len=0x3
299: whal_acxProcLoadFwImage: 2, pBuf=0xc00a4000, len=0x15564. Extra
pBuf=0x0, len=0x3
300: whal_acxProcLoadFwImage: 3, pBuf=0xc00a4000, len=0x15564,
DataLen=0x1555c
300: whal_acxProcLoadFwImage: 4, pBuf=0xc00a4000, len=0x15564
300: whal_acxProcLoadFwImage: Checksum, calc=0x71e76f, file=0x71e76f
304: whal_acxProcInitiate: run
304: whal_acxProcWaitInitComplete:
309: whal_acxMboxInit: pCmdMbox=0xa401dd00, pInfoMbox=0xa401de88
309: ----------------------------------------------------------------
309:             ACX Firmaware Version = Rev 1.6.0.24
309: ----------------------------------------------------------------
309: whal_acxProcConfigure: templates (beacon, probe response, tim) for [0]
Network
310: whal_acxProcConfigure: Host Queue is in 0x95ACE020
310:  TxQueue[0] NumDesc  = 32
310:  TxQueue[0] Priority = 0
310:  TxQueue[1] NumDesc  = 32
310:  TxQueue[1] Priority = 129
310: 
whal_acxConfigMemory() --
HostRxDescriptorsAddr = 15ace020
310:  RxQueue NumDesc  = 32
310:  RxQueue Priority = 0
310:  RxQueue type     = 7
311:  311: whal_acxProcConfigure: WEP cache
311: whal_acxProcConfigure: read queue heads
311: whal_acxConfigRead_QueueHead() -
311:  RxMemBlkQ   - 00015920
311:  RxQueueHead - 00012f14
312:  TxMemBlkQ   - 0001b320
312:  TxMemBlkQ[0]- 00013594
312:  TxMemBlkQ[1]- 00013c14
312:  312: whal_acxProcConfigure: configure RxQueue/TxQueue objects
312: whal_txQueue_Init: [Qid=0] HwBaseAddr=0xa4013594, NumDesc=32
312: whal_txQueue_Init: [Qid=1] HwBaseAddr=0xa4013c14, NumDesc=32
313: whal_ParamsPrintMemMap:
313: 	Code  (0x00000000, 0x0001250c)
	Wep   (0x000127e4, 0x000128f4)
	Sta   (0x000128f4, 0x00012efc)
	Tmpl  (0x00012524, 0x000125c1)
	Queue (0x00012f14, 0x00014294)
	Pool  (0x00015920, 0x0001c720)
315: whal_apiConfig: beaconInterval = 200
	WATCH_DOG_TIMER_VAL = 520
	wd_beacon_limiter = 1
315: WLAN HAL layer is up
315: BssBridge is up
315: Mgmt is up
315: Rx is up
315: Tx is up
315: MemMngr is up
315: main state machine is up
336: WDRV_MAINSM: WLAN Driver initialized successfully

336: WDRV_4X: 4x Disabled
336: WDRV_4X: Concatenation Disabled
336: WDRV_4X: Ack Emulation Disabled
336: whal_apiStartBss: Enable Tx, Rx and Start the Bss
336: ----------------------------------------------------------------
336: ----------------------------------------------------------------
336:   START BSS, SSID=RouterTech.Org, BSSID=00-E0-A0-A6-66-70
337: ----------------------------------------------------------------
337: ----------------------------------------------------------------
337:  AP Power Level = 1
337:  Regulatory Domain = ETSI
337:           Net[0] : Channel=11
337: ----------------------------------------------------------------
338: FW Watchdog is Enabled
dda: wlan0 in initializing Succeeded wireless extensions: ret = 0
set bridge igmp snooping Off
Nov 23 01:46:24 cfgmgr(ap): Nov 23 01:46:24 | AP IS UP
wlan0 device is activated
Nov 23 01:46:24 cfgmgr(static-105): Nov 23 01:46:24 | ifconfig failed with
message: (null)
Doing BRCTL ...
addif br0 wlan0 
device wlan0 entered promiscuous mode
br0: port 2(wlan0) entering learning state
Nov 23 01:46:24 cfgmgr(lanbridge0): Nov 23 01:46:24 | Bridge Interface
Added: wlan0
Doing BRCTL ...
setfilter br0 0 
Nov 23 01:46:26 cfgmgr(sar): Nov 23 01:46:26 | DSL Carrier is down
br0: port 2(wlan0) entering forwarding state
br0: topology change detected, propagating
Restarting system.

ADAM2 Revision 0.22.13
(C) Copyright 1996-2003 Texas Instruments Inc. All Rights Reserved.
(C) Copyright 2003 Telogy Networks, Inc.
Usage: setmfreq [-d] [-s sys_freq, in MHz] [cpu_freq, in MHz]
Memory optimization Complete!

mac_init(): Find mac [(ë(É¨Cšû¬Õ§ ÐP5T(”T(”] in location 7
	Illegal mac [(ë(É¨Cšû¬Õ§ ÐP5T(”T(”], skip
mac_value:00:e0:a0:a6:66:70

Adam2_4MMod > 
Press any key to abort OS load, or wait 5 seconds for OS to boot...
Copyright (C) 2006 Merlion-ACORP Russia Software Company.
Launching kernel LZMA decompressor.
Kernel decompressor was successful ... launching kernel.

LINUX started...
Config serial console: ttyS0,38400
Auto Detection SANGAM chip
This SOC has MDIX cababilities on chip.
CPU revision is: 00018448
Primary instruction cache 16kb, linesize 16 bytes (4 ways)
Primary data cache 16kb, linesize 16 bytes (4 ways)
Number of TLB entries 16.
Linux version 2.4.17_mvl21-malta-mips_fp_le (router@Ubuntu) () #1 Sun Nov 23
01:41:54 GMT 2008
Determined physical RAM map:
 memory: 14000000 @ 00000000 (reserved)
 memory: 00020000 @ 14000000 (ROM data)
 memory: 01fe0000 @ 14020000 (usable)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: 
calculating r4koff... 000b71b0(750000)
CPU frequency 150.00 MHz
Calibrating delay loop... 149.91 BogoMIPS
Freeing Adam2 reserved memory [0x14001000,0x0001f000]
Memory: 30156k/32768k available (1802k kernel code, 2612k reserved, 131k
data, 60k init)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
TI Optimizations: Allocating TI-Cached Memory Pool.
Using 120 Buffers for TI-Cached Memory Pool.
DEBUG: Using Hybrid Mode.
NSP Optimizations: Succesfully allocated TI-Cached Memory Pool.
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
squashfs: version 3.1 (2006/08/19) Phillip Lougher, lzma support by McMCC
Adam2 environment variables API installed.
pty: 32 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0xa8610e00 (irq = 15) is a 16550A
ttyS01 at 0xa8610f00 (irq = 16) is a 16550A
Vlynq CONFIG_MIPS_AVALANCHE_VLYNQ_PORTS=2
Vlynq Device vlynq0 registered with minor no 63 as misc device. Result=0
Vlynq instance:0 Link UP
Vlynq Device vlynq1 registered with minor no 62 as misc device. Result=0
VLYNQ 1 : init failed
cpu_freq = 150000000
block: 64 slots per queue, batch=16
DEBUG: Initializing the voice port management module. 
DEBUG: Initialization of the voice port management module successful..
Cpmac driver is allocating buffer memory at init time.
Cpmac driver Enable TX complete interrupt
Default Asymmetric MTU for eth0 1500
Default Asymmetric MTU for eth1 1500
Default Asymmetric MTU for eth2 1500
Default Asymmetric MTU for eth3 1500
PPP generic driver version 2.4.1
avalanche flash device: 0x400000 at 0x10000000.
 Amd/Fujitsu Extended Query Table v1.1 at 0x0040
Flash type: AMD; Manufacturer=AMD.
Manufacturer_ID=0x0001; Chip_ID=0x00F9; Chip_Size=0x400000;
Erase_Regions=0x0002
The Chief's FLASH extensions (www.RouterTech.Org): code loaded.
number of CFI chips: 1
Looking for mtd device :mtd0:
Found a mtd0 image (0x94000), with size (0x35c000).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x00094000-0x003f0000 : "mtd0"
mtd: partition "mtd0" doesn't start on an erase block boundary -- force
read-only
Looking for mtd device :mtd1:
Found a mtd1 image (0x10090), with size (0x83f70).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x00010090-0x00094000 : "mtd1"
mtd: partition "mtd1" doesn't start on an erase block boundary -- force
read-only
Looking for mtd device :mtd2:
Found a mtd2 image (0x0), with size (0x10000).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x00000000-0x00010000 : "mtd2"
Looking for mtd device :mtd3:
Found a mtd3 image (0x3f0000), with size (0x10000).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x003f0000-0x00400000 : "mtd3"
Looking for mtd device :mtd4:
Found a mtd4 image (0x10000), with size (0x3e0000).
Creating 1 MTD partitions on "Physically mapped flash:0":
0x00010000-0x003f0000 : "mtd4"
Looking for mtd device :mtd5:
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack version 2.1 (256 buckets, 2048 max) - 384 bytes per conntrack
ip_conntrack_pptp version 1.9 loaded
ip_nat_pptp version 1.5 loaded
ip_tables: (C) 2000-2002 Netfilter core team
ipt_account 0.1.6 : Piotr Gasid³o <quaker@barbara.eu.org>,
http://www.barbara.eu.org/~quaker/ipt_account/
netfilter PSD loaded - (c) astaro AG
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Ethernet Bridge 008 for NET4.0
Initializing the WAN Bridge.
Please set the MAC Address for the WAN Bridge.
Set the Environment variable 'HWA_3' or 'macc' or 'wan_br_mac'. 
MAC Address should be in the following format: xx:xx:xx:xx:xx:xx
VFS: Mounted root (squashfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 60k freed
Algorithmics/MIPS FPU Emulator v1.5
Sun Nov 23 01:46:00 UTC 2008
 Reading Standard Configuration File /etc/led.conf

 Configured 19 states 
registered device TI Avalanche SAR
Sangam detected
DSP binary filesize = 362422 bytes
tn7dsl_set_modulation : Setting mode to 0xff
Texas Instruments ATM driver: version:[7.03.09.00]
ifconfig: SIOCGIFFLAGS: No such device
ifconfig: SIOCGIFFLAGS: No such device
ifconfig: SIOCGIFFLAGS: No such device

Please press Enter to activate this console. PVC dB
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
vpi = -1 vci = -1 in_use = 0
Nov 23 01:46:12 cfgmgr(pppoa-108): Nov 23 01:46:12 | Valid Configuration
Tree
Doing BRCTL ...
addbr br0 
Doing BRCTL ...
addbr br1 
Doing BRCTL ...
addbr br2 
Nov 23 01:46:12 cfgmgr(sntp): Nov 23 01:46:12 | NTP Polling Timer for DHCP
Started succesfully.tn7dsl_set_modulation : Setting mode to 0xff

Nov 23 01:46:12 cfgmgr(sar): Nov 23 01:46:12 | DSL Polling Timer Started
succesfully.
Nov 23 01:46:13 cfgmgr(sar): Nov 23 01:46:13 | PSP Boot environment  Modem
Modulation Change: 0xff
Nov 23 01:46:13 cfgmgr(fdb): Nov 23 01:46:13 | Firewall NAT service started
Default Asymmetric MTU for br0 1500
Default Asymmetric MTU for br1 1500
Nov 23 01:46:13 cfgmgr(lanbridge0): Nov 23 01:46:13 | Bridge Created: br0
Default Asymmetric MTU for br2 1500
Doing BRCTL ...
setfilter br0 0 
Nov 23 01:46:15 cfgmgr(lanbridge0): Nov 23 01:46:15 | Bridge VLAN0 add eth0
Nov 23 01:46:15 cfgmgr(lanbridge0): Nov 23 01:46:15 | Bridge VLAN AUTO OFF.
Doing BRCTL ...
vlan trailer disable 
Doing BRCTL ...
addif br0 eth0 
Nov 23 01:46:15 cfgmgr(lanbridge1): Nov 23 01:46:15 | Bridge Created: br1
device eth0 entered promiscuous mode
br0: port 1(eth0) entering learning state
Doing BRCTL ...
setfilter br1 0 
Nov 23 01:46:18 cfgmgr(ap): Nov 23 01:46:18 | WPA Authenticator Started
Nov 23 01:46:18 cfgmgr(lanbridge2): Nov 23 01:46:18 | Bridge Created: br2
br0: port 1(eth0) entering forwarding state
br0: topology change detected, propagating
Doing BRCTL ...
setfilter br2 0 
Doing BRCTL ...
stp br0 off 
Doing BRCTL ...
setigmpsnoop br0 off 
Nov 23 01:46:20 cfgmgr(lanbridge0): Nov 23 01:46:20 | Bridge Interface
Added: eth0
set bridge igmp snooping Off
Doing BRCTL ...
setfilter br0 0 
Doing BRCTL ...
stp br1 off 
Doing BRCTL ...
setigmpsnoop br1 off 
Doing BRCTL ...
stp br2 off 
Doing BRCTL ...
setigmpsnoop br2 off 
Nov 23 01:46:22 cfgmgr(sar): Nov 23 01:46:22 | DSL Carrier is down
set bridge igmp snooping Off
set bridge igmp snooping Off
Default Asymmetric MTU for wlan0 1500
Nov 23 01:46:23 cfgmgr(ap): Nov 23 01:46:23 | AP Driver configuration
successful
343: 
802.11d is 343: disabled.
343: 802.11h is 343: disabled.
343: Configuration succeeded !!!
343: WLAN driver database is up
Resetting the remote device.
Un-resetting the remote device.
About to re-init the VLYNQ.
Re-initialized the VLYNQ.
344: AcxRegAddr = 0xA4040000, AcxMemAddr = 0xA4000000
344: whal_acxProcInitiate: found DEVICE_VENDOR ID = 0x9066104c
344: whal_acxProcInitiate: Cpu halt -> download code
344: whal_acxProcLoadFwImage: 0xa4000000, 0x0
345: whal_acxProcLoadFwImage() -- Loading FW image345: Compiled for RADIA
(bg) radio
345: whal_acxProcLoadFwImage: 1, pBuf=0xc00a4000, len=0x15564. Extra
pBuf=0x0, len=0x3
345: whal_acxProcLoadFwImage: 2, pBuf=0xc00a4000, len=0x15564. Extra
pBuf=0x0, len=0x3
345: whal_acxProcLoadFwImage: 3, pBuf=0xc00a4000, len=0x15564,
DataLen=0x1555c
346: whal_acxProcLoadFwImage: 4, pBuf=0xc00a4000, len=0x15564
346: whal_acxProcLoadFwImage: Checksum, calc=0x71e76f, file=0x71e76f
349: whal_acxProcInitiate: run
349: whal_acxProcWaitInitComplete:
354: whal_acxMboxInit: pCmdMbox=0xa401dd00, pInfoMbox=0xa401de88
355: ----------------------------------------------------------------
355:             ACX Firmaware Version = Rev 1.6.0.24
355: ----------------------------------------------------------------
355: whal_acxProcConfigure: templates (beacon, probe response, tim) for [0]
Network
355: whal_acxProcConfigure: Host Queue is in 0x95DD0020
356:  TxQueue[0] NumDesc  = 32
356:  TxQueue[0] Priority = 0
356:  TxQueue[1] NumDesc  = 32
356:  TxQueue[1] Priority = 129
356: 
whal_acxConfigMemory() --
HostRxDescriptorsAddr = 15dd0020
356:  RxQueue NumDesc  = 32
356:  RxQueue Priority = 0
356:  RxQueue type     = 7
356:  356: whal_acxProcConfigure: WEP cache
357: whal_acxProcConfigure: read queue heads
357: whal_acxConfigRead_QueueHead() -
357:  RxMemBlkQ   - 00016900
357:  RxQueueHead - 00013ef4
357:  TxMemBlkQ   - 0001b400
357:  TxMemBlkQ[0]- 00014574
357:  TxMemBlkQ[1]- 00014bf4
357:  357: whal_acxProcConfigure: configure RxQueue/TxQueue objects
357: whal_txQueue_Init: [Qid=0] HwBaseAddr=0xa4014574, NumDesc=32
358: whal_txQueue_Init: [Qid=1] HwBaseAddr=0xa4014bf4, NumDesc=32
358: whal_ParamsPrintMemMap:
358: 	Code  (0x00000000, 0x0001250c)
	Wep   (0x000127e4, 0x000128f4)
	Sta   (0x000128f4, 0x00013edc)
	Tmpl  (0x00012524, 0x000125c1)
	Queue (0x00013ef4, 0x00015274)
	Pool  (0x00016900, 0x0001c800)
360: whal_apiConfig: beaconInterval = 200
	WATCH_DOG_TIMER_VAL = 520
	wd_beacon_limiter = 1
360: WLAN HAL layer is up
361: BssBridge is up
361: Mgmt is up
361: Rx is up
361: Tx is up
361: MemMngr is up
361: main state machine is up
381: WDRV_MAINSM: WLAN Driver initialized successfully

381: WDRV_4X: 4x Disabled
381: WDRV_4X: Concatenation Disabled
381: WDRV_4X: Ack Emulation Disabled
381: whal_apiStartBss: Enable Tx, Rx and Start the Bss
382: ----------------------------------------------------------------
382: ----------------------------------------------------------------
382:   START BSS, SSID=RouterTech.Org, BSSID=00-E0-A0-A6-66-70
382: ----------------------------------------------------------------
382: ----------------------------------------------------------------
383:  AP Power Level = 1
383:  Regulatory Domain = ETSI
383:           Net[0] : Channel=11
383: ----------------------------------------------------------------
384: FW Watchdog is Enabled
dda: wlan0 in initializing Succeeded wireless extensions: ret = 0
Nov 23 01:46:29 cfgmgr(ap): Nov 23 01:46:29 | AP IS UP
wlan0 device is activated
Doing BRCTL ...
addif br0 wlan0 
device wlan0 entered promiscuous mode
br0: port 2(wlan0) entering learning state
Nov 23 01:46:29 cfgmgr(lanbridge0): Nov 23 01:46:29 | Bridge Interface
Added: wlan0
Doing BRCTL ...
setfilter br0 0 
br0: port 2(wlan0) entering forwarding state
br0: topology change detected, propagating
Kernel unaligned instruction access in unaligned.c:do_ade, line 408:
$0 : 00000000 1000fc00 00000000 00030001 00000022 00000000 00000000 c0043000
$8 : 1000fc01 1000001f 941f3040 40000000 95c19ee1 fffffffb 00000008 7fff6ae0
$16: 00000022 9435eb40 95f1e000 00000000 00000006 95f1ffe8 00000000 00000400
$24: 00000001 2acbed80                   95f1e000 95f1ff08 7fff7db8 9402e810
Hi : 00000032
Lo : 3d70a403
epc  : 9418c1d4    Not tainted
Status: 1000fc03
Cause : 10800010
Process  (pid: 27, stackpage=95f1e000)
Stack: dd6d8803 64968a2f 69056570 74e502fe 4e9513bb af8ddcd0 21882d17
a128fce3
       00000022 9435eb40 9402e810 042be70e 970fb07d 74d74d68 8f517ecb
15de7efb
       3efc2784 00030001 82bd1d07 44a34b32 e1fc0257 de42e953 394fce67
36aa613f
       53fda4f3 88b62868 8fbfdbeb cf4c1179 ee4f3d4c a7ed4a44 b5d0c4ae
765f43a3
       195a1db0 91e0d6bd 083783f6 42314d1f cad648c8 58657618 f4ebdb79
728a7a05
       8ad2187d ...
Call Trace: [<9402e810>] [<940302b8>]

Code: afbf0028  afb10024  afb00020 <8c850000> 04a00007  24820008  8c830008 
14620005  03808021 
Kernel unaligned instruction access in unaligned.c:do_ade, line 408:
$0 : 00000000 1000fc00 383e6e6f 0000001a 95be83f8 736e6172 95be8000 00000000
$8 : 0da8d7fc 1000001f 95f1fcd3 00000000 94214529 fffffffe 95f1fc8e ffffffff
$16: 95be83f0 941fc6a4 00000001 95be83f0 0000001b 95be93d0 00000000 00000400
$24: 00000010 00000006                   95be8000 95be90a8 7fff7db8 94040b58
Hi : 0da8d7fc
Lo : 86d504ab
epc  : 94040ad0    Not tainted
Status: 1000fc02
Cause : 10808010
Process  (pid: 718007680, stackpage=95be8000)
Stack: 8ea20008 8f878020 00000000 24e77084 95be8000 00000001 95be8000
1000fc00
       00000000 94040b58 8ea40000 8f858020 00000000 24a570b0 94040d44
00000000
       0320f809 00000000 8fbc0020 144000a2 00000009 94041058 02c02021
8f998798
       00000000 0320f809 006d46bf 95be8000 00000000 95be91c0 ab710d06
94041558
       8e8400a8 8f858020 00000000 24a56c7c 9403f848 00000000 0320f809
00000000
       8fbc0020 ...
Call Trace: [<94040b58>] [<94040d44>] [<94041058>] [<94041558>] [<9403f848>]
[<9403f8ec>]
 [<9403fec4>] [<94191c04>] [<94191880>] [<9402df94>] [<c0043000>]
[<9402e9bc>]
 [<940302ac>] [<9402df94>] [<c0043000>] [<9402e9bc>] [<9402df94>]
[<940302b8>]
 [<9402df94>] [<c0043000>] [<9402e9bc>] [<9402df94>] [<940302b8>]
[<9402df94>]
 [<c0043000>] [<9402e9bc>] [<9402df94>] [<940302b8>] [<9402df94>]
[<c0043000>]
 [<9402e9bc>] [<9402df94>] [<940302b8>] [<9402df94>] [<c0043000>]
[<9402e9bc>]
 [<9402df94>] [<940302b8>] [<9402df94>] [<c0043000>] [<9402e9bc>] ...

Code: 24120001  3c119420  2631c6a4 <8ca20004> 54540010  00a08021  8ca20000 
14400002  ae020000 
Kernel unaligned instruction access in unaligned.c:do_ade, line 408:
$0 : 00000000 1000fc00 69746361 00000001 00000084 959f2124 00000002 959f2124
$8 : 1000fc00 1000001f 95be8e7a 00000000 94214529 fffffffe 95be8e2f ffffffff
$16: 00000001 941fc6a4 00000009 95be83f0 00000000 95be93d0 00000000 00000400
$24: 00000010 00000007                   95be8000 95be8de8 7fff7db8 94040dc8
Hi : 00000000
Lo : 00000084
epc  : 94040df0    Not tainted
Status: 1000fc02
Cause : 10808014
Process  (pid: 718007680, stackpage=95be8000)
Stack: 95be8000 00000001 95be8000 1000fc00 95be8000 00000009 95be8000
1000fc00
       94040f68 00000000 94040d50 39343032 38303130 31303830 00000009
00000001
       95be8000 94041118 00000000 00000000 00000000 00000000 006d46bf
95be8000
       00000000 95be8ef0 0000001b 94041558 33323130 37363534 00000005
66656463
       9403f848 00003135 33323130 37363534 00000005 66656463 95be8000
00000001
       00000000 ...
Call Trace: [<94040f68>] [<94040d50>] [<94041118>] [<94041558>] [<9403f848>]
[<9403f8ec>]
 [<9403fec4>] [<94191c04>] [<9403469c>] [<94034730>] [<94191880>]
[<940348a0>]
 [<94193ea0>] [<9402b588>] [<9402b59c>] [<94192cd0>] [<9402b5c8>]
[<9402d974>]
 [<9402d6b8>]

Code: 00000000  ace00000  8e620004 <ac470000> 12000005  ae670004  5203000b 
acf20004  09010391 
Kernel unaligned instruction access in unaligned.c:do_ade, line 408:
$0 : 00000000 1000fc00 69746361 00000001 00000108 959f21a8 00000003 959f21a8
$8 : 1000fc00 1000001f 95be8bb9 00000000 94214529 fffffffe 95be8b6e ffffffff
$16: 00000001 941fc6a4 00000009 95be83f0 00000000 95be93d0 00000000 00000400
$24: 00000010 00000006                   95be8000 95be8b28 7fff7db8 94040dc8
Hi : 00000000
Lo : 00000108
epc  : 94040df0    Not tainted
Status: 1000fc02
Cause : 00808414
Process  (pid: 718007680, stackpage=95be8000)
Stack: 95be8000 00000001 95be8000 1000fc00 95be8000 00000009 95be8000
1000fc00
       94040f68 00000000 94040d50 39343032 38303134 31303830 00000009
00000001
       95be8000 94041118 00000000 00000000 00000000 00000000 006d46bf
95be8000
       00000000 95be8c30 00000000 94041558 33323130 37363534 00000005
66656463
       9403f848 00003684 33323130 37363534 00000005 66656463 95be8000
00000001
       00000000 ...
Call Trace: [<94040f68>] [<94040d50>] [<94041118>] [<94041558>] [<9403f848>]
[<9403f8ec>]
 [<9403fec4>] [<94191c04>] [<9403469c>] [<94034730>] [<94191880>]
[<940348a0>]
 [<94193ea0>] [<9402b588>] [<9402b59c>] [<94192cd0>] [<9402b5c8>]
[<9402d974>]
 [<9402d6b8>] [<94040dc8>] [<94040df0>] [<94040f68>] [<94040d50>]
[<94041118>]
 [<94041558>] [<9403f848>] [<9403f8ec>] [<9403fec4>] [<94191c04>]
[<9403469c>]
 [<94034730>] [<94191880>] [<940348a0>] [<94193ea0>] [<9402b588>]
[<9402b59c>]
 [<94192cd0>] [<9402b5c8>] [<9402d974>] [<9402d6b8>]

Code: 00000000  ace00000  8e620004 <ac470000> 12000005  ae670004  5203000b 
acf20004  09010391 
Kernel unaligned instruction access in unaligned.c:do_ade, line 408:
$0 : 00000000 1000fc00 69746361 00000001 0000018c 959f222c 00000004 959f222c
$8 : 1000fc00 1000001f 95be88f9 00000000 94214529 fffffffe 95be88ae ffffffff
$16: 00000001 941fc6a4 00000009 95be83f0 00000000 95be93d0 00000000 00000400
$24: 00000010 00000006                   95be8000 95be8868 7fff7db8 94040dc8
Hi : 00000000
Lo : 0000018c
epc  : 94040df0    Not tainted
Status: 1000fc02
Cause : 00808414
Process  (pid: 718007680, stackpage=95be8000)
Stack: 95be8000 00000001 95be8000 1000fc00 95be8000 00000009 95be8000
1000fc00
       94040f68 00000000 94040d50 39343032 38343134 31303830 00000009
00000001
       95be8000 94041118 00000000 00000000 00000000 00000000 006d46bf
95be8000
       00000000 95be8970 00000000 94041558 33323130 37363534 00000005
66656463
       9403f848 00003cf0 33323130 37363534 00000005 66656463 95be8000
00000001
       00000000 ...
Call Trace: [<94040f68>] [<94040d50>] [<94041118>] [<94041558>] [<9403f848>]
[<9403f8ec>]
 [<9403fec4>] [<94191c04>] [<9403469c>] [<94034730>] [<94191880>]
[<940348a0>]
 [<94193ea0>] [<9402b588>] [<9402b59c>] [<94192cd0>] [<9402b5c8>]
[<9402d974>]
 [<9402d6b8>] [<94040dc8>] [<94040df0>] [<94040f68>] [<94040d50>]
[<94041118>]
 [<94041558>] [<9403f848>] [<9403f8ec>] [<9403fec4>] [<94191c04>]
[<9403469c>]
 [<94034730>] [<94191880>] [<940348a0>] [<94193ea0>] [<9402b588>]
[<9402b59c>]
 [<94192cd0>] [<9402b5c8>] [<9402d974>] [<9402d6b8>] [<94040dc8>] ...

Code: 00000000  ace00000  8e620004 <ac470000> 12000005  ae670004  5203000b 
acf20004  09010391 
Kernel unaligned instruction access in unaligned.c:do_ade, line 408:
$0 : 00000000 1000fc00 69746361 00000001 00000210 959f22b0 00000005 959f22b0
$8 : 1000fc00 1000001f 95be8639 00000000 94214529 fffffffe 95be85ee ffffffff
$16: 00000001 941fc6a4 00000009 95be83f0 00000000 95be93d0 00000000 00000400
$24: 00000010 00000006                   95be8000 95be85a8 7fff7db8 94040dc8
Hi : 00000000
Lo : 00000210
epc  : 94040df0    Not tainted
Status: 1000fc02
Cause : 00808414
Process  (pid: 718007680, stackpage=95be8000)
Stack: 95be8000 00000001 95be8000 1000fc00 95be8000 00000009 95be8000
1000fc00
       94040f68 00000000 94040d50 39343034 38343134 31303830 00000009
00000001
       95be8000 94041118 00000000 00000000 00000000 00000000 006d46bf
95be8000
       00000000 95be86b0 00000000 94041558 33323130 37363534 00000005
66656463
       9403f848 0000436d 33323130 37363534 00000005 66656463 95be8000
00000001
       00000000 ...
Call Trace: [<94040f68>] [<94040d50>] [<94041118>] [<94041558>] [<9403f848>]
[<9403f8ec>]
 [<9403fec4>] [<94191c04>] [<9403469c>] [<94034730>] [<94191880>]
[<940348a0>]
 [<94193ea0>] [<9402b588>] [<9402b59c>] [<94192cd0>] [<9402b5c8>]
[<9402d974>]
 [<9402d6b8>] [<94040dc8>] [<94040df0>] [<94040f68>] [<94040d50>]
[<94041118>]
 [<94041558>] [<9403f848>] [<9403f8ec>] [<9403fec4>] [<94191c04>]
[<9403469c>]
 [<94034730>] [<94191880>] [<940348a0>] [<94193ea0>] [<9402b588>]
[<9402b59c>]
 [<94192cd0>] [<9402b5c8>] [<9402d974>] [<9402d6b8>] [<94040dc8>] ...

Code: 00000000  ace00000  8e620004 <ac470000> 12000005  ae670004  5203000b 
acf20004  09010391 
Kernel unaligned instruction access in unaligned.c:do_ade, line 408:
$0 : 00000000 1000fc00 00000001 00000001 00000294 959f2334 00000006 959f2334
$8 : 1000fc00 1000001f 95be8379 00000000 94214529 fffffffe 95be832e ffffffff
$16: 00000001 941fc6a4 00000009 95be83f0 00000000 95be93d0 00000000 00000400
$24: 00000010 00000006                   95be8000 95be82e8 7fff7db8 94040dc8
Hi : 00000000
Lo : 00000294
epc  : 94040df0    Not tainted
Status: 1000fc02
Cause : 00808414
Process  (pid: 718007680, stackpage=95be8000)
Stack: 95be8000 00000001 95be8000 1000fc00 95be8000 00000009 95be8000
1000fc00
       94040f68 743c3e65 94040d50 39343034 38343134 31303830 00000009
00000001
       95be8000 94041118 79656b3c 79656b3e 6e656c5f 6b2f3c34 006d46bf
95be8000
       00000000 95be83f0 00000000 94041558 33323130 37363534 00000005
66656463
       9403f848 000049ea 33323130 37363534 00000005 66656463 95be8000
00000001
       00000000 ...
Call Trace: [<94040f68>] [<94040d50>] [<94041118>] [<94041558>] [<9403f848>]
[<9403f8ec>]
 [<9403fec4>] [<94191c04>] [<9403469c>] [<94034730>] [<94191880>]
[<940348a0>]
 [<94193ea0>] [<9402b588>] [<9402b59c>] [<94192cd0>] [<9402b5c8>]
[<9402d974>]
 [<9402d6b8>] [<94040dc8>] [<94040df0>] [<94040f68>] [<94040d50>]
[<94041118>]
 [<94041558>] [<9403f848>] [<9403f8ec>] [<9403fec4>] [<94191c04>]
[<9403469c>]
 [<94034730>] [<94191880>] [<940348a0>] [<94193ea0>] [<9402b588>]
[<9402b59c>]
 [<94192cd0>] [<9402b5c8>] [<9402d974>] [<9402d6b8>] [<94040dc8>] ...

Code: 00000000  ace00000  8e620004 <ac470000> 12000005  ae670004  5203000b 
acf20004  09010391 
Kernel unaligned instruction access in unaligned.c:do_ade, line 408:
$0 : 00000000 1000fc00 00000001 00000001 00000318 959f23b8 00000007 959f23b8
$8 : 1000fc00 1000001f 95be80b9 00000000 94214529 fffffffe 95be806e ffffffff
$16: 00000001 941fc6a4 0000001d 95be83f0 00000000 95be93d0 00000000 00000400
$24: 00000010 00000006                   95be8000 95be8028 7fff7db8 94040dc8
Hi : 00000000
Lo : 00000318
epc  : 94040df0    Not tainted
Status: 1000fc02
Cause : 00800414
Process  (pid: 0, stackpage=95be6000)
Stack: afb010b1 ab710d06 a6322bdf a2f33668 95be8000 0000001d 95be8000
1000fc00
       94040f68 00000000 30646338 39343034 38343134 31303830 0000001d
00000001
       95be8000 94041118 2aafe000 2aaee000 2aaee000 2acbcbcc 7ffffffe
95be8000
       00000000 95be8130 00000000 94041558 33323130 37363534 00000005
66656463
       9403f89c 00005067 33323130 37363534 00000005 66656463 95be8000
00000001
       00000000 ...
Call Trace: [<94040f68>] [<94041118>] [<94041558>] [<9403f89c>] [<9403f8ec>]
[<9403fec4>]
 [<94191c04>] [<9403469c>] [<9403476e>] [<94191880>] [<940348a0>]
[<94193ea0>]
 [<9402b588>] [<9402b59c>] [<94192cd0>] [<9402b5c8>] [<9402d974>]
[<9402d6b8>]
 [<94040dc8>] [<94040df0>] [<94040f68>] [<94040d50>] [<94041118>]
[<94041558>]
 [<9403f848>] [<9403f8ec>] [<9403fec4>] [<94191c04>] [<9403469c>]
[<94034730>]
 [<94191880>] [<940348a0>] [<94193ea0>] [<9402b588>] [<9402b59c>]
[<94192cd0>]
 [<9402b5c8>] [<9402d974>] [<9402d6b8>] [<94040dc8>] [<94040df0>] ...

Code: 00000000  ace00000  8e620004 <ac470000> 12000005  ae670004  5203000b 
acf20004  09010391 
[CODE]

Please cam help me to understand this error and solve it?

Kindest regards

Fabrizio
-- 
View this message in context: http://www.nabble.com/Kernel-2.4.17_mvl21-malta-mips%3A-error-tp22046664p22046664.html
Sent from the linux-mips main mailing list archive at Nabble.com.
