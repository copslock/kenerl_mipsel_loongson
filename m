Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2005 17:42:54 +0000 (GMT)
Received: from mailfe10.tele2.se ([IPv6:::ffff:212.247.155.33]:50912 "EHLO
	swip.net") by linux-mips.org with ESMTP id <S8225266AbVBKRmc>;
	Fri, 11 Feb 2005 17:42:32 +0000
X-T2-Posting-ID: g63wq726D5fsXb2UbU6LU0KOXzHnTHjCzHZ35sC2MDs=
Received: from [213.103.108.136] (HELO [192.168.0.32])
  by mailfe10.swip.net (CommuniGate Pro SMTP 4.2.9)
  with ESMTP id 87498397 for linux-mips@linux-mips.org; Fri, 11 Feb 2005 18:42:23 +0100
Message-ID: <420CEE7F.3080201@astek.fr>
Date:	Fri, 11 Feb 2005 18:42:23 +0100
From:	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.7.3) Gecko/20040910
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: IP32 - issues with last CVS snapshoot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ftemporelli@astek.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ftemporelli@astek.fr
Precedence: bulk
X-list: linux-mips

Hello,

I've been able to compile and launch 2.6.11-rc3 from last CVS snapshoot.

First, there's something wrong with "make ip32_defconfig" which generate 
config file with "Kernel code model = 64-bit kernel" (MIPS64=y) but 
doesn't preselect  "Use 64-bit ELF format for building" (BUILD_ELF64=n)
doing so, "make" quickly generates an error:
---
  CC      init/main.o
Assembler messages:
Error: -mgp64 used with a 32-bit ABI
---
not too difficult to correct (I'm compiling the kernel on the O2, so I 
also need to "make menuconf" for removing cross compilation...)

Then, may be something to explain: arcboot (3.8.5) can't load ELF64 
vmlinuz (I've a segment violation) but is able to load ELF32 
(vmlinuz.32) image... Can you confirm that ELF64 are still running with 
arcboot 3.8.5 ?

At last, there are two (non critical) issues when using the kernel:
- kernel is reporting only 186MBytes of RAM (384 MBytes avail.). Seems 
that last Ilya's patch ("full-memV3") is already integrated in this CVS 
snap...
- segmentation fault when using swap

At the end of this mail, the boot full dump (arcboot + kernel)

Hope this will help.
Best regards.

Frederic TEMPORELLI

PS: now my O2 is booted on serial port... nice for dump

=========================================

arcsboot: ARCS Linux ext2fs loader 0.3.8.5

stack starts at: 0xa13faff8
Free Memory(3) segment found at (0x80002000,0x80d50000).
Adding 8192 bytes at 0x80002000 to the list of available memory
Free Memory(3) segment found at (0x81400000,0x81404000).
Free Memory(3) segment found at (0x81412000,0x8c000000).
Adding 180281344 bytes at 0x81412000 to the list of available memory
mylinux32 is not an envVar
Command line:
0: scsi(0)disk(1)rdisk(0)partition(8)/ext2debu
1: mylinux32
2: ConsoleIn=serial(0)
3: ConsoleOut=serial(0)
4: SystemPartition=scsi(0)disk(1)rdisk(0)partition(8)
5: OSLoader=ext2debu
6: OSLoadPartition=scsi(0)disk(1)rdisk(0)partition(0)
7: OSLoadFilename=linux64
OSLoadPartition: scsi(0)disk(1)rdisk(0)partition(0)
OSLoadFilename: mylinux32
Loading mylinux32 from scsi(0)disk(1)rdisk(0)partition(0)
Allocated 0x20 bytes for segments
Loading 32-bit executable
Loading program segment 1 at 0x80004000, offset=0x4000, size = 0x6d1086
6e4000      (cache: 96.2%)

Zeroing memory at 0x806d5086, size = 0x2df9a
Command line after config file:
0: /boot/myvmlinux32
1: root=/dev/sda1
Kernel entry: 0x0 8065f000

--- Debug: press <spacebar> to boot kernel ---
Starting ELF32 kernel
Linux version 2.6.11-rc3 (root@o2) (gcc version 3.4.4 20041218 
(prerelease) (Deb
ian 3.4.3-6)) #7 Fri Feb 11 16:03:44 UTC 2005
ARCH: SGI-IP32
PROMLIB: ARC firmware Version 1 Revision 10
CRIME id a rev 1 at 0x0000000014000000
CRIME MC: bank 0 base 0x0000000000000000 size 33554432MB
CRIME MC: bank 1 base 0x0000000002000000 size 33554432MB
CRIME MC: bank 2 base 0x0000000004000000 size 33554432MB
CRIME MC: bank 3 base 0x0000000006000000 size 33554432MB
CRIME MC: bank 4 base 0x0000000008000000 size 33554432MB
CRIME MC: bank 5 base 0x000000000a000000 size 33554432MB
CPU revision is: 00002321
FPU revision is: 00002310
Determined physical RAM map:
 memory: 000000000c000000 @ 0000000000000000 (usable)
Built 1 zonelists
Kernel command line: root=/dev/sda1
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
R5000 SCACHE size 1024kB, linesize 32 bytes.
Synthesized TLB refill handler (30 instructions).
Synthesized TLB load handler fastpath (44 instructions).
Synthesized TLB store handler fastpath (44 instructions).
Synthesized TLB modify handler fastpath (43 instructions).
PID hash table entries: 1024 (order: 10, 32768 bytes)
Calibrating system timer... 200 MHz CPU detected
Using 100.247 MHz high precision timer.
Console: colour dummy device 80x25
CRIME memory error at 0x0d3fffe0 ST 0x0c00a828<INV,RE,REID=0x28,NONFATAL>
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Memory: 186048k/196608k available (2627k kernel code, 10304k reserved, 
3877k dat
a, 476k init, 0k highmem)
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  available.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
NET: Registered protocol family 16
Can't analyze prologue code at ffffffff8028fff0
MACE PCI rev 1
SCSI subsystem initialized
MACEPCI: Master abort at 0x00004000 (C)
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 53) is a 16550A
ttyS1 at MMIO 0x0 (irq = 59) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
eth0: SGI MACE Ethernet rev. 1
PCI: Enabling device 0000:00:01.0 (0046 -> 0047)
ahc_pci:0:1:0: Using left over BIOS settings
PCI: Enabling device 0000:00:02.0 (0046 -> 0047)
ahc_pci:0:2:0: Using left over BIOS settings
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Wide Channel A, SCSI Id=0, 16/253 SCBs

  Vendor: SGI       Model: IBM DCAS-32160W   Rev: S68A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 8
  Vendor: SGI       Model: IBM DORS-32160W   Rev: WA6A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:2:0: Tagged Queuing enabled.  Depth 8
  Vendor: TOSHIBA   Model: CD-ROM XM-5701TA  Rev: 0167
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Wide Channel A, SCSI Id=0, 16/253 SCBs

st: Version 20041025, fixed bufsize 32768, s/g segs 256
osst :I: Tape driver with OnStream support version 0.99.3
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
SCSI device sda: 4197405 512-byte hdwr sectors (2149 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 4197405 512-byte hdwr sectors (2149 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda9 sda11
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
SCSI device sdb: 4197405 512-byte hdwr sectors (2149 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 4197405 512-byte hdwr sectors (2149 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb9 sdb11
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 2, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 4, lun 0,  type 5
aoe: aoe_init: AoE v2.6-5 initialised.
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem 
as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 476k freed
INIT: version 2.84 booting
Loading /etc/console/boottime.kmap.gz
Activating swap.
CPU 0 Unable to handle kernel paging request at virtual address 
0000000000000000
, epc == ffffffff80080d20, ra == ffffffff80080c2c
Oops in arch/mips/mm/fault.c::do_page_fault, line 166[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffff806fe000 0000000000000000 0000000040000000
$ 4   : 0000000000000000 0000000000000040 0000000000000001 0000000000000000
$ 8   : 0000000000008000 0000000000000000 000000000000acba ffffffff802e2800
$12   : 0000000000000028 ffffffff80122898 0000000000000000 ffffffff802d4000
$16   : c000000000036000 0000000000037000 0000000000036000 0000000000036000
$20   : 0000000000000000 ffffffffffffffbf 0000000000036000 0000000000036000
$24   : 0000000000000000 ffffffff80021280
$28   : 980000000ba1c000 980000000ba1fcd0 0000000000000040 ffffffff80080c2c
Hi    : 0000000000023184
Lo    : 000000000000bb2c
epc   : ffffffff80080d20 $L27+0x0/0x4     Not tainted
ra    : ffffffff80080c2c $LCFI10+0x4c/0x74
Status: 9001fce3    KX SX UX KERNEL EXL IE
Cause : 00000008
BadVA : 0000000000000000
PrId  : 00002321
Process swapon (pid: 26, threadinfo=980000000ba1c000, task=980000000bfcc698)
Stack : 980000000bdebf58 c000000000036000 c000000000036000 ffffffff80702000
        0000000000000400 ffffffff80702000 0000000000036000 c000000000035fff
        980000000bdebf58 ffffffff806e37f8 0000000000000001 0000000000000035
        00000000000000d2 0000000000000040 ffffffff802e2e60 00000000000007df
        000000000001a7ea ffffffff80081754 c000000000000000 980000000be32848
        ffffffff80081838 0000000000000040 980000000be32848 980000000be32848
        980000000bdebf58 ffffffff80081be4 980000000be328d0 0000000000000000
        0000000000034fd4 ffffffff806e3848 980000000bae2000 ffffffffffffffea
        980000000be35000 980000000b970dd8 980000000132d690 980000000128e170
        ffffffff800872c0 ffffffff800868dc 980000000132d5e0 0000000000000000
        ...
Call Trace:
 [<ffffffff80081754>] $L225+0x8/0x2c
 [<ffffffff80081838>] $L239+0x8/0x18
 [<ffffffff80081be4>] $L324+0x8/0x14
 [<ffffffff800872c0>] $L1135+0x50/0x88
 [<ffffffff800868dc>] $LBE478+0x2c/0x30
 [<ffffffff8009d7b8>] $L37+0x8/0x18
 [<ffffffff8001d95c>] handle_sys+0x11c/0x13c
 [<ffffffff8001fcf3>] $L14+0x8b/0xb8


Code: 0064b00b  00e2a02d  00000000 <de870000> 3c040000  3c018070  
64840000  6421
2000  0004203c
/etc/init.d/rcS: line 99:    26 Segmentation fault      swapon -a 
2>/dev/null
Checking root file system...
fsck 1.27 (8-Mar-2002)
/dev/sda1: clean, 21432/261120 files, 178974/521846 blocks
ioctl32(hwclock:37): Unknown cmd fd(3) cmd(00004b50){00} arg(7fff7d10) 
on /dev/t
ty1
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of ouioctl32(hwclock:40): 
Unknown cmd
fd(3) cmd(00004b50){00} arg(7fff7d00) on /dev/tty1
r search for an access method.
System tioctl32(hwclock:41): Unknown cmd fd(3) cmd(00004b50){00} 
arg(7fff7d10) o
n /dev/tty1
ime was Fri Feb 11 16:35:09 UTC 2005.
Setting the System Clock using the Hardware Clock as reference...
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access 
method.
System Clock set. System local time is now Fri Feb 11 16:35:09 UTC 2005.
Cleaning up ifupdown...done.
Checking all file systems...
fsck 1.27 (8-Mar-2002)
Setting kernel variables ...
... done.
Mounting local filesystems...
none on /dev/pts type devpts (rw,mode=0620)
Running 0dns-down to make sure resolv.conf is ok...done.
Initializing: /etc/network/ifstate.
Aborting iptables load: unknown ruleset, "active".
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...done.
Starting portmap daemon: portmap.
Loading the saved-state of the serial devices...
/dev/ttyS0 at 0x0000 (irq = 53) is a 16550A
/dev/ttyS1 at 0x0000 (irq = 59) is a 16550A

Setting the System Clock ioctl32(hwclock:117): Unknown cmd fd(3) 
cmd(00004b50){0
0} arg(7fff7d10) on /dev/tty1
using the Hardware Clock as reference...
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access 
method.
System Clock set. Local time: Fri Feb 11 16:35:14 UTC 2005

Running ntpdate to synchronize clockError : Name or service not known
.
Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
Recovering nvi editor sessions... done.
Setting up X server socket directory /tmp/.X11-unix...done.
Setting up ICE socket directory /tmp/.ICE-unix...done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...ifup: interface lo already configured
ifup: interface eth0 already configured
done.
Running ntpdate to synchronize clockError : Name or service not known
.
Starting portmap daemon: portmap.
Starting process accounting: done.
Starting internet superserver: inetd.
Starting OpenBSD Secure Shell server: sshd.
Starting NTP server: ntpd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.

Debian GNU/Linux 3.1 o2 ttyS0
=========================================
