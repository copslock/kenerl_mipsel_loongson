Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2005 14:02:00 +0100 (BST)
Received: from mail.void.at ([IPv6:::ffff:212.88.181.19]:32444 "EHLO
	mail.void.at") by linux-mips.org with ESMTP id <S8225327AbVHBNBl>;
	Tue, 2 Aug 2005 14:01:41 +0100
Received: from bademeister.void.at ([212.88.172.176] helo=[172.16.0.150])
	by mail.void.at with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.52)
	id 1DzwRE-0005b7-HZ
	for linux-mips@linux-mips.org; Tue, 02 Aug 2005 15:04:09 +0200
Message-ID: <42EF6E86.9040302@strodl.org>
Date:	Tue, 02 Aug 2005 15:00:54 +0200
From:	Andreas Strodl <andreas@strodl.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: IDE problem
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-mail.void.at-MailScanner: Found to be clean
X-MailScanner-From: andreas@strodl.org
Return-Path: <andreas@strodl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas@strodl.org
Precedence: bulk
X-list: linux-mips

Hi,

I'm using the kernel version 2.4.31 (-r2_4_31) from the CVS.

The plattform is a MIPS Toshiba JMR3927CF with an IDE PCI chipset CMD649.

The problem is that the IDE chipset CMD649 is detected but the hardisk
that is connected
via this IDE channel is not detected. The system boots direct from a
flash so I can paste
/proc entries too.

Note:
#define PCIBIOS_MIN_IO          0x8000  /* reserve regacy I/O space */
#define PCIBIOS_MIN_MEM     0x0000
This settings are used for this board.

dmesg Output:
CPU revision is: 00002242
Primary instruction cache 8kB, linesize 16 bytes
Primary data cache 4kB, linesize 16 bytes
Linux version 2.4.31 (andi@diesel) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2 release)) #16 Die Aug 2 14:28:16 CEST 2005
TX3927 -- CRIR:39270040 CCFG:0006b039 PCFG:007c1000
TX3927 PCIC -- DID:000a VID:102f RID:07 Arbiter:Internal
TX39XX D-Cache WriteBack (CWF) .
Determined physical RAM map:
 memory: 01ffff00 @ 00000000 (usable)
On node 0 totalpages: 8191
zone(0): 4096 pages.
zone(1): 4095 pages.
zone(2): 0 pages.
Kernel command line: rw root=/dev/ramdisk console=ttyS0,115200
S3511A: 05 08 02 02 0d 15 31
Calibrating delay loop... 132.30 BogoMIPS
Memory: 25596k/32764k available (1965k kernel code, 7168k reserved, 247k
data, 108k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: IO 0x00000000-0x00ffffff MEM 0x08000000-0x0fffffff
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
URL log initialization
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis
Communications AB.
Squashfs 2.1 (released 2004/12/10) (C) 2002-2004 Phillip Lougher
Power: function of power button was initialised
pty: 256 Unix98 ptys configured
TXx927 Serial driver version 0.21
ttyS00 at 0xfffef300 (irq = 22) is a TXx927 SIO
ttyS01 at 0xfffef400 (irq = 23) is a TXx927 SIO
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0x8000, 00:e3:d8:ec:ea:d8, IRQ 16
eth1: RealTek RTL8139 at 0x8400, 00:b7:a2:01:be:a2, IRQ 17
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD649: IDE controller at PCI slot 00:0e.0
CMD649: chipset revision 2
CMD649: 100% native mode on irq 18
    ide0: BM-DMA at 0x8800-0x8807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x8808-0x880f, BIOS settings: hdc:pio, hdd:pio
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 108k freed


# cat /proc/ioports
00008000-000080ff : PCI device 10ec:8139
  00008000-000080ff : 8139too
00008400-000084ff : PCI device 10ec:8139
  00008400-000084ff : 8139too
00008800-0000880f : PCI device 1095:0649
  00008800-00008807 : ide0
  00008808-0000880f : ide1
00008c00-00008c07 : PCI device 1095:0649
00009000-00009007 : PCI device 1095:0649
00009400-00009403 : PCI device 1095:0649
00009800-00009803 : PCI device 1095:0649

# cat /proc/interrupts
           CPU0
 16:          0      tx3927_irq  eth0
 17:          9      tx3927_irq  eth1
 21:          0      tx3927_irq  power
 22:        534      tx3927_irq  serial_txx927
 29:     102227      tx3927_irq  timer

ERR:          0

# cat /proc/ide/drivers
ide-disk version 1.17
ide-default version 0.9.newide

# cat /proc/ide/cmd64x


Controller: 0
CMD649 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    no               no              no                no
DMA Mode:        PIO(?)           PIO(?)          PIO(?)            PIO(?)
PIO Mode:       ?                ?               ?                 ?
                polling                          polling
                clear                            clear
                enabled                          enabled

# cat /proc/pci
PCI devices found:
  Bus  0, device  12, function  0:
    Class 0200: PCI device 10ec:8139 (rev 16).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0x8000 [0x80ff].
      Non-prefetchable 32 bit memory at 0x8082000 [0x80820ff].
  Bus  0, device  13, function  0:
    Class 0200: PCI device 10ec:8139 (rev 16).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0x8400 [0x84ff].
      Non-prefetchable 32 bit memory at 0x8082400 [0x80824ff].
  Bus  0, device  14, function  0:
    Class 0101: PCI device 1095:0649 (rev 2).
      IRQ 18.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      I/O at 0x8c00 [0x8c07].
      I/O at 0x9400 [0x9403].
      I/O at 0x9000 [0x9007].
      I/O at 0x9800 [0x9803].
      I/O at 0x8800 [0x880f].
  Bus  0, device  15, function  0:
    Class 0c03: PCI device 1131:1561 (rev 48).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0x8080000 [0x8080fff].
  Bus  0, device  15, function  1:
    Class 0c03: PCI device 1131:1561 (rev 48).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0x8081000 [0x8081fff].
  Bus  0, device  15, function  2:
    Class 0c03: PCI device 1131:1562 (rev 48).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=16.
      Non-prefetchable 32 bit memory at 0x8082800 [0x80828ff].
#


I also found out, that drive->present in do_probe in
drivers/ide/ide-probe.c is 0
so I will not be detected, right?

Any Ideas

Best regards

Andrew
