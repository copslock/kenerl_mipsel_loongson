Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 13:06:06 +0000 (GMT)
Received: from p508B6CC5.dip.t-dialin.net ([IPv6:::ffff:80.139.108.197]:41707
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225309AbTLMNGF>; Sat, 13 Dec 2003 13:06:05 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBDD63oK011433;
	Sat, 13 Dec 2003 14:06:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBDD625S011432;
	Sat, 13 Dec 2003 14:06:02 +0100
Date: Sat, 13 Dec 2003 14:06:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Cc: nick@snowman.net
Subject: Recently, on a uniprocessor Origin 200 ...
Message-ID: <20031213130602.GA10478@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

[...]
Walking SCSI Adapter 0 (/hw/module/1/slot/MotherBoard), (pci id 0)
1+ 2- 3- 4- 5- 6- 7- 8- 9- 10- 11- 12- 13- 14- 15- = 1 device(s)

Walking SCSI Adapter 1 (/hw/module/1/slot/MotherBoard), (pci id 1)
1- 2- 3- 4- 5- 6+ 7- = 1 device(s)
Initializing PROM Device drivers ..........             DONE
Checking hardware inventory ...............              DONE

**** System Configuration and Diagnostics Summary ****
CONFIG:
         No. of NODEs enabled    = 1
         No. of NODEs disabled   = 0
         No. of CPUs enabled     = 1
         No. of CPUs disabled    = 0
         Mem enabled             = 128 MB
         Mem disabled            = 0 MB
         No. of RTRs enabled     = 0
         No. of RTRs disabled    = 0

DIAG RESULTS:
         NO DIAGS WERE RUN!
**** End System Configuration and Diagnostics Summary ****


System Maintenance Menu

1) Start System
2) Install System Software
3) Run Diagnostics
4) Recover System
5) Enter Command Monitor

Option? 5
Command Monitor.  Type "exit" to return to the menu.
>> boot():
Setting $netaddr to 172.16.1.31 (from server 172.16.1.1)
Obtaining  from server 172.16.1.1
2094496+422528+331877+132363 entry: 0xa800000000284020
Linux version 2.6.0-test11 (ralf@dea.linux-mips.net) (gcc version 2.95.4 20010319 (prerelease)) #22 Thu Dec 11 19:34:54 CET 2003
ARCH: SGI-IP27
PROMLIB: ARC firmware Version 64 Revision 0
Discovered 1 cpus on 1 nodes
node_distance: router_a NULL
************** Topology ********************
    00 
00  -1 
Total memory probed : 0x8000 pages
CPU revision is: 00000926
FPU revision is: 00000900
IP27: Running on node 0.
Node 0 has a primary CPU, CPU is running.
Node 0 has no secondary CPU.
Machine is in M mode.
Cpu 0, Nasid 0x0, pcibr_setup(): found partnum= 0xc002...is bridge
CPU 0 clock is 65535MHz.

[ ... am I the champion of overclocking or not :-) ]

Determined physical RAM map:
On node 0 totalpages: 32768
  DMA zone: 32768 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=dksc(0,1,0)
Primary instruction cache 32kB, physically tagged, 2-way, linesize 64 bytes.
Primary data cache 32kB 2-way, linesize 32 bytes.
Unified secondary cache 1024kB 2-way, linesize 128 bytes.
PID hash table entries: 16 (order 4: 256 bytes)
Memory: 125280k/0k available (1779k kernel code, 0k reserved, 681k data, 328k init, 0k highmem)
Calibrating delay loop... 130.81 BogoMIPS
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  unavailable.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
Can't analyze prologue code at ffffffff80052c80
SCSI subsystem initialized
PCI: Fixing isp1020 in bus:slot.fn 0000:00:00.0
PCI: Fixing isp1020 in bus:slot.fn 0000:00:01.0
PCI: Fixing base addresses for IOC3 device 0000:00:02.0
PCI: Fixing base addresses for IOC3 device 0000:00:05.0
ikconfig 0.7 with /proc/config*
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09b
Serial: 8250/16550 driver $Revision: 1.90 $ 16 ports, IRQ sharing enabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
ttyS12 at MMIO 0x0 (irq = 0) is a 16550A
Found DS1981U NIC registration number c7:0f:03:00:70:5e, CRC de.
Ethernet address is 04:00:69:05:7e:68.
eth0: Using PHY 31, vendor 0x20005c0, model 0, rev 1.
eth0: IOC3 SSRAM has 128 kbyte.
Found DS1981U NIC registration number 58:cf:01:00:70:5e, CRC 6e.
Ethernet address is 08:00:69:05:48:1e.
eth1: Using PHY 31, vendor 0x20005c0, model 0, rev 1.
eth1: IOC3 SSRAM has 128 kbyte.
qlogicisp : new isp1020 revision ID (5)
qlogicisp : new isp1020 revision ID (5)
scsi0 : QLogic ISP1020 SCSI on PCI bus 00 device 00 irq 4 I/O base 0x8200000
Using anticipatory io scheduler
  Vendor: IBM       Model: DNES-318350Y      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
eth0: Link is up at 100Mb/s, Full Duplex.
scsi1 : QLogic ISP1020 SCSI on PCI bus 00 device 08 irq 5 I/O base 0x8400000
eth1: Link is up at 100Mb/s, Full Duplex.
  Vendor: TOSHIBA   Model: CD-ROM XM-5701TA  Rev: 0167
  Type:   CD-ROM                             ANSI SCSI revision: 02
st: Version 20030811, fixed bufsize 32768, s/g segs 256
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 8Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "dksc(0,1,0)" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)

(And there really is nothing on the disk, so that is 100% success ...)

  Ralf 
