Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA27456; Mon, 1 Apr 1996 04:44:20 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id EAA27470; Mon, 1 Apr 1996 04:43:00 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id EAA27464; Mon, 1 Apr 1996 04:42:45 -0800
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA26890 for <lmlinux@neteng.engr.sgi.com>; Mon, 1 Apr 1996 04:42:26 -0800
Received: from caipfs.rutgers.edu by deliverator.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/951211.SGI.AUTO)
	 id EAA20331; Mon, 1 Apr 1996 04:42:23 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id HAA07688; Mon, 1 Apr 1996 07:42:15 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id HAA00427; Mon, 1 Apr 1996 07:42:15 -0500
Date: Mon, 1 Apr 1996 07:42:15 -0500
Message-Id: <199604011242.HAA00427@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: sparclinux@vger.rutgers.edu
CC: linux-kernel@vger.rutgers.edu, linux-smp@vger.rutgers.edu,
        lmlinux@neteng.engr.sgi.com, user@host.rutgers.edu
Subject: SYMMMMETRRRRIC MULTI PENGUINNNNNNN!!!!!!
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


(yeah, it runs shell and basic programs, I can telnet out etc.
but it hard-locks now and then, working on it...)

Any questions?  And remember kids, Linux is just a "toy operating
system."

PROMLIB: Sun Boot Prom Version 3 Revision 2
ARCH: SUN4M
TYPE: Sun4m SparcStation10
Ethernet address: 8:0:20:12:53:32
Found 4 CPU prom device tree node(s).
IOMMU: impl 0 vers 1 page table at f03c0000 of size 65536 bytes
sbus0: Clock 20.0 MHz
dma0: Revision 2 
dma1: Revision 2 
cgsix0 at 0x20000000
Console: 16 point font, 864 scans
Console: colour SUN 128x54, 1 virtual console (max 63)
Calibrating delay loop.. ok - 115.51 BogoMIPS
Memory: 175720k available (948k kernel code, 2988k data)
Swansea University Computer Society NET3.033 for Linux 1.3.50
NET3: Unix domain sockets 0.12 for Linux NET3.033.
Swansea University Computer Society TCP/IP for NET3.033
IP Protocols: ICMP, UDP, TCP
Linux version 1.3.77 (davem@huahaga.rutgers.edu) (gcc version 2.6.3) #15 Mon Apr 1 07:02:51 EST 1996
Entering SparclinuxMultiPenguin(SMP) Mode...
Starting CPU 1 at f002a9b8
Calibrating delay loop.. ok - 115.92 BogoMIPS
Starting CPU 2 at f002a9d0
Calibrating delay loop.. ok - 104.86 BogoMIPS
Starting CPU 3 at f002a9e8
Calibrating delay loop.. ok - 104.86 BogoMIPS
Total of 4 Penguins activated (441.14 PenguinMIPS).
Sparc Zilog8530 serial driver version 1.00
tty00 at 0xffede004 (irq = 44) is a Zilog8530
tty01 at 0xffede000 (irq = 44) is a Zilog8530
tty02 at 0xffedb004 (irq = 44) is a Zilog8530
tty03 at 0xffedb000 (irq = 44) is a Zilog8530
Sun TYPE 4 keyboard detected without keyclick
Sun Mouse-Systems mouse driver version 1.00
esp0: IRQ 36 SCSI ID 7  Clock 20 MHz Period 99 NCR53C9x(esp236) detected
scsi0 : Sparc ESP236
scsi : 1 host.
Started kswapd v 1.5 
  Vendor: SEAGATE   Model: ST32430N SUN2.1G  Rev: 0444
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 3, lun 0
scsi : detected 1 SCSI disk total.
SCSI Hardware sector size is 512 bytes on device sda
sunlance.c:v1.5 21/Mar/96 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 08:00:20:12:53:32 
Partition check:
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
Sending BOOTP and RARP requests.....OK
Root-NFS: Got RARP answer from 128.6.155.101, my address is 128.6.155.53
Root-NFS: Got file handle for /caip/u119/davem/SparcLinux/machines/jenolan via RPC
VFS: Mounted root (nfs filesystem).
# mount -n -t proc none /proc
# cat /proc/cpuinfo
cpu		: ROSS HyperSparc RT625
fpu		: ROSS HyperSparc combined IU/FPU
promlib		: Version 3 Revision 2
type		: sun4m
Elf Support	: yes
Cpu0Bogo	: 115.50
Cpu1Bogo	: 115.91
Cpu2Bogo	: 104.85
Cpu3Bogo	: 104.85
MMU type	: ROSS HyperSparc
invall		: 4020
invmm		: 0
invrnge		: 0
invpg		: 0
contexts	: 4096
big_chunks	: 0
little_chunks	: 0
        CPU0		CPU1		CPU2		CPU3
State: online		online		online		akp
Lock:  2		2		2		2

klock: ff
block: 0
alock: 0
