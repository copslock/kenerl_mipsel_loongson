Received:  by oss.sgi.com id <S553971AbRAYQf2>;
	Thu, 25 Jan 2001 08:35:28 -0800
Received: from ns.snowman.net ([63.80.4.34]:49674 "EHLO ns.snowman.net")
	by oss.sgi.com with ESMTP id <S553957AbRAYQfD>;
	Thu, 25 Jan 2001 08:35:03 -0800
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id LAA31307
	for <linux-mips@oss.sgi.com>; Thu, 25 Jan 2001 11:34:59 -0500
Date:   Thu, 25 Jan 2001 11:34:59 -0500 (EST)
From:   <nick@snowman.net>
X-Sender: nick@ns
To:     linux-mips@oss.sgi.com
Subject: Origin 200 crash
In-Reply-To: <20010125165530.B12576@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.21.0101251132350.30763-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

When booting any of three different kernels I have found, including a
working one from Bacchus I get this:
>> bootp():
Setting $netaddr to 10.1.1.2 (from server 10.1.1.1)
Obtaining  from server 10.1.1.1
1464880+388016+339100 entry: 0xa800000000188000
ARCH: SGI-IP27
PROMLIB: ARC firmware Version 64 Revision 0
Discovered 1 cpus on 1 nodes
Total memory probed : 0x14000 pages
Linux version 2.4.0-test11 (ralf@dbear.engr.sgi.com) (gcc version
egcs-2.91.66 19990314 (egcs-1.1.2 release)) #3 SMP Tue Dec 26 11:0
Loading R10000 MMU routines.
CPU revision is: 00000926
Primary instruction cache 32kb, linesize 64 bytes
Primary data cache 32kb, linesize 32 bytes
Secondary cache sized at 1024K, linesize 128
IP27: Running on node 0.
Node 0 has a primary CPU, CPU is running.
Node 0 has no secondary CPU.
Machine is in M mode.
Cpu 0, Nasid 0x0, pcibr_setup(): found partnum= 0xc002...is bridge
CPU 0 clock is 65535MHz.
On node 0 totalpages: 294912
zone(0): 294912 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: OSLoadOptions=INST
Entering 64-bit mode.
Calibrating delay loop... 179.81 BogoMIPS
Memory: 286120k/327680k available (1430k kernel code, 41560k reserved,
150k data, 208k init)
Dentry-cache hash table entries: 65536 (order: 8, 1048576 bytes)
Buffer-cache hash table entries: 32768 (order: 6, 262144 bytes)
Page-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 32768 (order: 7, 524288 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
REPLICATION: ON nasid 0, ktext from nasid 0, kdata from nasid 0
PCI: Probing PCI hardware on host bus  0.
PCI: Fixing isp1020 in [bus:slot.fn] 00:00.0
PCI: Fixing isp1020 in [bus:slot.fn] 00:01.0
PCI: Fixing base addresses for IOC3 device 00:02.0
PCI: Fixing base addresses for IOC3 device 00:05.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
ttyS00 at iomem 0x9200000008620178 (irq = 0) is a 16550ASHARE_IRQ
SERIAL_PCI enabled
ttyS01 at iomem 0x9200000008920178 (irq = 0) is a 16550A
Using PHY 31, vendor 0x20005c0, model 0, rev 1.
eth0:  MII transceiver found at MDIO address 31, config 3100 status 786f.
IOC3 SSRAM has 128 kbyte.
Found DS1981U NIC registration number 2a:e8:02:00:70:5e, CRC b9.
Ethernet address is 08:00:69:05:77:36.
Using PHY 31, vendor 0x20005c0, model 0, rev 1.
eth1:  MII transceiver found at MDIO address 31, config 3100 status 7849.
IOC3 SSRAM has 128 kbyte.
Found DS1981U NIC registration number 49:d1:01:00:70:5e, CRC dc.
Ethernet address is 08:00:69:05:45:f1.
SCSI subsystem driver Revision: 1.00
qlogicisp : new isp1020 revision ID (5)
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 00 device 00 irq 4 I/O base
0x8200000
scsi1 : QLogic ISP1020 SCSI on PCI bus 00 device 08 irq 5 I/O base
0x8400000
Got dbe at 0xffffffff8013f43c
Cpu 0
$0      : 0000000000000000 0000000014201ce0 a80000000028d040
a80000000028d000
$4      : a80000000028d080 0000000000000000 0000000000000040
ffffffff801ccc80
$8      : 0000000014201ce1 0000000000000000 0000000000000004
0000000000000000
$12     : 0000000000000000 a80000000028d080 ffffffffffffffff
a80000000028d014
$16     : 0000000000000040 0000000014201ce1 a80000000028d040
0000000000000002
$20     : a800000047ffcc00 a8000000002e8800 0000000000000000
a8000000002e88b8
$24     : 0000000000000040 a8000000002e8800
$28     : a800000003678000 a80000000367bb20 a800000003667c30
ffffffff800ddacc
Hi      : 0000000000000000
Lo      : 0000000000000040
epc     : ffffffff8013f43c
badvaddr: a800000047ffde60
badvaddr: a800000047ffde60
Status  : 14201ce2
Cause   : 0000901c
Cause   : 0000901c
Index:  0 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  1 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  2 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  3 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  4 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  5 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  6 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  7 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  8 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  9 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 10 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 11 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 12 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 13 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 14 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 15 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 16 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 17 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 18 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 19 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 20 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 21 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 22 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 23 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 24 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 25 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 26 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 27 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 28 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 29 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 30 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 31 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 32 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 33 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 34 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 35 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 36 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 37 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 38 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 39 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 40 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 41 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 42 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 43 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 44 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 45 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 46 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 47 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 48 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 49 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 50 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 51 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 52 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 53 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 54 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 55 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 56 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 57 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 58 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 59 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 60 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 61 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 62 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 63 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0
v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]

Any suggestions/ideas?
	Thanks
		Nick
