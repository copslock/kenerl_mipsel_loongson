Received:  by oss.sgi.com id <S553753AbRAICNa>;
	Mon, 8 Jan 2001 18:13:30 -0800
Received: from dorian.blic.net ([217.23.192.5]:43794 "EHLO dorian.blic.net") convert rfc822-to-8bit
	by oss.sgi.com with ESMTP id <S553751AbRAICNG>;
	Mon, 8 Jan 2001 18:13:06 -0800
Received: from quake.blic.net (pmalic@quake.blic.net [217.23.192.7])
	by dorian.blic.net (8.9.3/8.9.3) with ESMTP id CAA00705
	for <linux-mips@oss.sgi.com>; Tue, 9 Jan 2001 02:57:20 +0100
Date:   Tue, 9 Jan 2001 03:16:20 +0100 (CET)
From:   Predrag Malicevic <pmalic@blic.net>
To:     <linux-mips@oss.sgi.com>
Subject: O200 problem...
Message-ID: <Pine.LNX.4.30.0101090210460.10752-100000@quake.blic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,

I'm trying to install Linux on an Origin 200 and I'm having problems with
booting the kernel (CVS tree linux from oss.sgi.com).  I've included below
a console session of my tries to boot the kernel.  In two cases below I
used the default kernel configuration but without the SCSI driver.  In the
first case I used parameters root=/dev/nfs and nfsroot=.... It reached
'Calibrating delay loop' and then 'Got dbe at 0xffffffff8013e970'.  After
that, I guess, some kind of register dump followed (I'm working with MIPS
architecture for the first time).  In the second case it reached "TCP:
Hash tables configured". Besides these two tries, I've tried using
different kernel configuration options in the machine selection category
and besides the obvious ones (IP27, IP27 N-Mode and Multi-Processing), I'm
clueless about the meaning of other options.

I would really appreciate some guidance on making the kernel boot...
Thanks in advance and sorry for such a long email.


**** The recorded console session from minicom ****

IP27 PROM SGI Version 5.28  built 11:17:13 AM Sep 24, 1998
Master testing hub interrupts
Testing/Initializing memory
CPU A testing secondary cache (1 MB)
Discovering local IO ...
Using console at /hw/module/1/MotherBoard
Running serial_dma diag (Bridge base = 0x9200000008000000  PCI dev = 2)
Local IO discover DONE.
Running Hub Chip BTE test.
BTE0 completed.
BTE1 completed.
Checking Local Link Connection.
Discovering CrayLink connectivity
Local hub CrayLink is down.
*** Local network link down
Discovered 1 objects (1 hubs, 0 routers)
Waiting for peers to complete discovery.
No other nodes present; becoming global master
Global master is /hw/module/1/slot/MotherBoard
Loading BASEIO prom
Uncompressing segment BASEIO prom
Jumping to entry point 0xa800000001c00140

Numbering nodes...
1 CPUs on 1 nodes found.
Clocks synchronized.
Modules numbered.
Updating module serial numbers.
BASEIO PROM Monitor SGI Version 5.28  built 11:16:22 AM Sep 24, 1998 (BE64)
Sizing caches...
Initializing environment
Initializing software and devices.
Installing Devices...
Running enet_all diag (Bridge base = 0x9200000008000000  PCI dev = 2  Mode = 0)
Running scsi_ram diag (Bridge base = 0x9200000008000000  PCI dev = 0)
Running scsi_dma diag (Bridge base = 0x9200000008000000  PCI dev = 0)
Running scsi_controller diag (Bridge base = 0x9200000008000000  PCI dev = 0)

Walking SCSI Adapter 0 (/hw/module/1/slot/MotherBoard), (pci id 0)
1+ 2- 3- 4- 5- 6- 7- 8- 9- 10- 11- 12- 13- 14- 15- = 1 device(s)
Running scsi_ram diag (Bridge base = 0x9200000008000000  PCI dev = 1)
Running scsi_dma diag (Bridge base = 0x9200000008000000  PCI dev = 1)
Running scsi_controller diag (Bridge base = 0x9200000008000000  PCI dev = 1)

Walking SCSI Adapter 1 (/hw/module/1/slot/MotherBoard), (pci id 1)
1- 2- 3- 4- 5+ 6+ 7- = 2 device(s)
Initializing devices...
Checking hardware inventory...

**** System Configuration and Diagnostics Summary ****
CONFIG:
         No. of NODEs enabled    = 1
         No. of NODEs disabled   = 0
         No. of CPUs enabled     = 1
         No. of CPUs disabled    = 0
         Mem enabled             = 64 MB
         Mem disabled            = 0 MB
         No. of RTRs enabled     = 0
         No. of RTRs disabled    = 0

DIAG RESULTS:
         ALL DIAGS PASSED!
**** End System Configuration and Diagnostics Summary ****


System Maintenance Menu

1) Start System
2) Install System Software
3) Run Diagnostics
4) Recover System
5) Enter Command Monitor

Option? 5
Command Monitor.  Type "exit" to return to the menu.
>> hinv -v
IP27 Node Board, Module 1, Slot MotherBoard
    ASIC HUB Rev 3, 90 MHz, (nasid 0)
    Processor A: 180 MHz R10000, Rev 2.6, 1M secondary cache, (cpu 0)
      R10000FPC  Rev 0
    Memory on board, 64 MBytes (Standard)
      Bank 0, 64 MBytes <-- (Physical Bank 0)
BASEIO IO Board, Module 1, Slot MotherBoard
    ASIC BRIDGE Rev 4, (widget 8)
    adapter PCI-SCSI Rev 5, (pci id 0)
        peripheral SCSI DISK, ID 1, SGI IBM  DCHS04Y
    adapter PCI-SCSI Rev 5, (pci id 1)
        peripheral SCSI TAPE, ID 5, ARCHIVE Python 02779-XXX
        peripheral SCSI CDROM, ID 6, TOSHIBA CD-ROM XM-5701TA
    adapter IOC3 Rev 1, (pci id 2)
        controller multi function SuperIO
        controller Ethernet Rev 1
>> hinv -mvvv
location: /hw/module/1/slot/MotherBoard
Part:013-1895-001;Name:PIMM_1XT5_1MB;Serial:GCK618;Revision:F;Group:ff;Capability:ffffffff;Variety:ff;Laser:000000178518;

location: /hw/module/1/slot/MotherBoard
Part:030-1244-001;Name:IP29;Serial:GCH576;Revision:H;Group:ff;Capability:ffffffff;Variety:ff;Laser:00000017a582;

>> version
BASEIO PROM Monitor SGI Version 5.28  built 11:16:22 AM Sep 24, 1998 (BE64)
>> printenv
AutoLoad=No
dbgtty=/dev/tty/ioc30
root=dks0d1s0
nonstop=0
rbaud=19200
SystemPartition=dksc(0,1,8)
OSLoadPartition=dksc(0,1,0)
OSLoader=sash
OSLoadFilename=unix
TimeZone=PST8PDT
console=d
oldConsolePath=/hw/module/1/slot/MotherBoard
gConsoleIn=default
gConsoleOut=default
diskless=0
scsihostid=0
ProbeAllScsi=n
dbaud=9600
volume=80
sgilogo=y
netaddr=192.168.21.231
ConsoleOut=/dev/tty/ioc30
ConsoleIn=/dev/tty/ioc30
cpufreq=180
ConsolePath=/hw/module/1/slot/MotherBoard
>> opts
SGI Version 5.28  built 11:16:22 AM Sep 24, 1998
Libkl was built as follows: -xansi -fullwarn    -D_STANDALONE -DMP -DDISCONTIG_PHYSMEM -DNUMA_BASE -DNUMA_PM  -DNUMA_TBORROW -DNUMA_MIGR_CONTROL  -DNUMA_REPLICATION -DNUMA_REPL_CONTROL -DNUMA_SCHED  -DLARGE_CPU_COUNT -DHUB2_NACK_WAR  -DBRIDGE_ERROR_INTR_WAR -DMAPPED_KERNEL -DBHV_SYNCH  -DHUB_ERR_STS_WAR -DHUB_MIGR_WAR -DNCR16C550 -DTL16PIR552  -DSN0_INTR_BROKEN -DFRU  -DSN0_USE_BTE -DBTE_BZERO_WAR -DREV1_BRIDGE_SUPPORTED  -DHUB_II_IFDR_WAR -DRTINT_WAR -DPCOUNT_WAR -DBRIDGE_B_DATACORR_WAR -D_KERNEL -DR10000   -D_PAGESZ=16384 -DIP27 -DPROM -U__INLINE_INTRINSICS -DSN0 -I../../../include -I../../../IP27prom -non_shared -elf -64 -G 0 -mips4 -OPT:space=ON -OPT:quad_align_branch_targets=FALSE -OPT:quad_align_with_memops=FALSE -TENV:misalignment=1 -OPT:unroll_times_max=0 -OPT:unroll_size=0 -TENV:kernel  -IPA:inline=off:cprop=off:cgi=off:autognum=off -ipa -Wl,-tt1:1    -nostdinc -I/u1/people/ayoung/6.4-patch3292/root/usr/include  -O2  -MDupdate Makedepend.SN0 -woff 1685,515,608,658,799,803,852,1048,1233,1499,1068,1185,1209,1505,1506,1692,1174

Libsk was built as follows: -xansi -fullwarn    -D_STANDALONE -DMP -DDISCONTIG_PHYSMEM -DNUMA_BASE -DNUMA_PM  -DNUMA_TBORROW -DNUMA_MIGR_CONTROL  -DNUMA_REPLICATION -DNUMA_REPL_CONTROL -DNUMA_SCHED  -DLARGE_CPU_COUNT -DHUB2_NACK_WAR  -DBRIDGE_ERROR_INTR_WAR -DMAPPED_KERNEL -DBHV_SYNCH  -DHUB_ERR_STS_WAR -DHUB_MIGR_WAR -DNCR16C550 -DTL16PIR552  -DSN0_INTR_BROKEN -DFRU  -DSN0_USE_BTE -DBTE_BZERO_WAR -DREV1_BRIDGE_SUPPORTED  -DHUB_II_IFDR_WAR -DRTINT_WAR -DPCOUNT_WAR -DBRIDGE_B_DATACORR_WAR -D_KERNEL -DR10000   -D_PAGESZ=16384 -DIP27 -DSN0 -I../../../include  -non_shared -elf -64 -G 0 -mips4 -OPT:space=ON -OPT:quad_align_branch_targets=FALSE -OPT:quad_align_with_memops=FALSE -TENV:misalignment=1 -OPT:unroll_times_max=0 -OPT:unroll_size=0 -TENV:kernel  -IPA:inline=off:cprop=off:cgi=off:autognum=off -ipa -Wl,-tt1:1    -nostdinc -I/u1/people/ayoung/6.4-patch3292/root/usr/include  -O2  -MDupdate Makedepend.SN0 -woff 1685,515,608,658,799,803,852,1048,1233,1499,1068,1185,1209,1505,1506,1692,1174

The IO6prom was built as follows: -xansi -fullwarn    -D_STANDALONE -DMP -DDISCONTIG_PHYSMEM -DNUMA_BASE -DNUMA_PM  -DNUMA_TBORROW -DNUMA_MIGR_CONTROL  -DNUMA_REPLICATION -DNUMA_REPL_CONTROL -DNUMA_SCHED  -DLARGE_CPU_COUNT -DHUB2_NACK_WAR  -DBRIDGE_ERROR_INTR_WAR -DMAPPED_KERNEL -DBHV_SYNCH  -DHUB_ERR_STS_WAR -DHUB_MIGR_WAR -DNCR16C550 -DTL16PIR552  -DSN0_INTR_BROKEN -DFRU  -DSN0_USE_BTE -DBTE_BZERO_WAR -DREV1_BRIDGE_SUPPORTED  -DHUB_II_IFDR_WAR -DRTINT_WAR -DPCOUNT_WAR -DBRIDGE_B_DATACORR_WAR -D_KERNEL -DR10000   -D_PAGESZ=16384 -DIP27  -DPROM -DNO_tpsc -DSN0 -I../include -I../IP27prom -non_shared -elf -64 -G 0 -mips4 -OPT:space=ON -OPT:quad_align_branch_targets=FALSE -OPT:quad_align_with_memops=FALSE -TENV:misalignment=1 -OPT:unroll_times_max=0 -OPT:unroll_size=0 -TENV:kernel  -IPA:inline=off:cprop=off:cgi=off:autognum=off -ipa -Wl,-tt1:1    -nostdinc -I/u1/people/ayoung/6.4-patch3292/root/usr/include  -O2  -MDupdate Makedepend.SN0 -woff 1685,515,608,658,799,803,852,1048,1233,1499,1068,1185,1209,1505,1506,1692,1174


>> bootp():vmlinux root=/dev/nfs nfsroot=/ 192.168.21.220:/MIPS
Obtaining vmlinux from server itlab4
         1160272   |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-+374720   |/-\|/-\|/-\|/-\|/-\|/-\+228460 entry: 0xa80000000013c000
ARCH: SGI-IP27
PROMLIB: ARC firmware Version 64 Revision 0
Discovered 1 cpus on 1 nodes
Total memory probed : 0x4000 pages
Linux version 2.4.0-test11 (pmalic@itlab4) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #1 Thu Dec 28 13:36:59 CET 2000
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
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs nfsroot=192.168.21.220:/MIPS
Entering 64-bit mode.
Calibrating delay loop... 179.81 BogoMIPS
Got dbe at 0xffffffff8013e970
Cpu 0
$0      : 0000000000000000 ffffffff94201ce0 a8000000001cf680 0000000000000000
$4      : 00000000000000d0 0000000000000039 0000000000000000 a8000000001cf000
$8      : 0000000000004000 0000000000000000 ffffffff80196039 ffffffff801c8828
$12     : 0000000000000010 0000000000000000 000000000000000a ffffffff8012f330
$16     : a8000000011bbe58 0000000000003439 0000000000003048 ffffffff801ca4a8
$20     : 0000000000004000 0000000000000001 0000000000000001 0000000000000000
$24     : 0000000000000000 0000000000000030
$28     : ffffffff80138000 ffffffff8013bdc0 a80000000013c000 ffffffff8013e9ac
Hi      : 0000000000000000
Lo      : 0000000000003438
epc     : ffffffff8013e970
badvaddr: ffffffff801c8828
badvaddr: ffffffff801c8828
Status  : 94201ce3
Cause   : 0000901c
Cause   : 0000901c
Index:  0 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  1 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  2 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  3 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  4 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  5 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  6 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  7 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  8 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index:  9 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 10 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 11 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 12 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 13 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 14 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 15 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 16 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 17 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 18 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 19 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 20 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 21 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 22 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 23 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 24 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 25 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 26 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 27 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 28 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 29 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 30 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 31 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 32 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 33 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 34 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 35 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 36 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 37 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 38 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 39 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 40 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 41 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 42 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 43 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 44 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 45 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 46 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 47 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 48 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 49 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 50 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 51 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 52 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 53 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 54 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 55 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 56 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 57 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 58 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 59 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 60 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 61 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 62 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]
Index: 63 pgmask=00000000 va=c0000fff80000000 asid=00  [pa=000000 c=0 d=0 v=0 g=0]  [pa=000000 c=0 d=0 v=0 g=0]

[ Here the machine hangs and I restart it. For brevity, I've removed the lines that are written to the screen while booting. ]
[ Now I'm tring to boot another kernel: ]


>> bootp():vmlinux
Obtaining vmlinux from server itlab4
         1160272   |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-+374704   |/-\|/-\|/-\|/-\|/-\|/-\+228460 entry: 0xa80000000013c000
ARCH: SGI-IP27
PROMLIB: ARC firmware Version 64 Revision 0
Discovered 1 cpus on 1 nodes
Total memory probed : 0x4000 pages
Linux version 2.4.0-test11 (pmalic@itlab4) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #2 Thu Dec 28 13:46:29 CET 2000
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
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
Entering 64-bit mode.
Calibrating delay loop... 179.81 BogoMIPS
Memory: 61496k/65536k available (1133k kernel code, 4040k reserved, 129k data, 216k init)
Dentry-cache hash table entries: 8192 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 3, 32768 bytes)
Page-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 4096 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware on host bus  0.
PCI: Fixing isp1020 in [bus:slot.fn] 00:00.0
PCI: Fixing isp1020 in [bus:slot.fn] 00:01.0
PCI: Fixing base addresses for IOC3 device 00:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabledttyS00 at iomem 0x9200000008620178 (irq = 0) is a 16550A
Using PHY 31, vendor 0x20005c0, model 0, rev 1.
eth0:  MII transceiver found at MDIO address 31, config 3100 status 786f.
IOC3 SSRAM has 128 kbyte.
Found DS1981U NIC registration number 39:e6:02:00:70:5e, CRC 19.
Ethernet address is 08:00:69:05:73:0e.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 256 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)

[ Here the machines hangs again. I've tried many more times with different kernel configurations, but it's the same thing. It either "gets a dbe" or just stops after "TCP: Hash tables ..." ]


--pm
