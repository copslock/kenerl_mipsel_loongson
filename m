Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 17:01:59 +0000 (GMT)
Received: from ip66-106-155-114.z155-106-66.customer.algx.net ([IPv6:::ffff:66.106.155.114]:22551
	"EHLO atomant.nayna.com") by linux-mips.org with ESMTP
	id <S8225437AbUATRB6>; Tue, 20 Jan 2004 17:01:58 +0000
Received: by atomant.nayna.com with Internet Mail Service (5.5.2653.19)
	id <R91WCXDB>; Tue, 20 Jan 2004 08:59:47 -0800
Message-ID: <DFDD2BC6A4D8D711B8980090279CF95B0176FF@atomant.nayna.com>
From: "Young Chul Park (Patrick)" <pypark@nayna.com>
To: "'jsun@junsun.net'" <jsun@junsun.net>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Linux on Monta-Vista DB88E6318 board carsh
Date: Tue, 20 Jan 2004 08:59:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <pypark@nayna.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pypark@nayna.com
Precedence: bulk
X-list: linux-mips

Hi,
I am Patrick of Nayna networks.
( Board name DB-88E6318 and CPU type MIPS - 5KC )

Now I am trying to boot Linux 2.4.18 ( Marvell-Monta Vista Distribution. )
I am using NFS Root mount  and it normally mounted as I posted it.
after that. problems are happen.
After nfsroot mounted , automatically init procedures in busybox are
executed.
I saw that there was some discussion between  Atifa_Kheel@yahoo.com and
mips-org.
It's similar symtoms but not much help.
In attached screenshot, For debugging purpose, I put this kind of strings
like
==========================================
!!/dev/console!!
!!!! Inside find_next_zero_bit
 !!!
 good /dev/console
!!!! Inside find_next_zero_bit !!!

 next_fd = 2 in fcntl<4>!!!! Inside find_next_zero_bit !!!

 next_fd = 3 in fcntl
 in do_execve /sbin/init
 retval = 1
 in do_execve /etc/init
 retval = 1
 in do_execve /bin/init!!!! Insid
e find_next_zero_bit !!!
Using ELF interpreter /lib/ld.so.1
!!/etc/ld.so.preload!!
==================================================

In busybox main routines, It tries to detect real console and reads the
inittab ( Nothing else just call rc.sysinit )
and inside rc.sysinit, just tries to mount proc ... ( and consecutively
necessary command are listed )
and after that suddenly crashed. 

Anybody who have some tips, I appreciate in advance.

Regards
Patrick

ps] We tried gcc version 2.91.66  and 3.2.2 also. but same as upon.

=====================================================================
MIPSBoot-> go a0400000
## Starting application at 0xa0400000 ...
1
 PRID_IMP_5KC
32MB SDRAM auto-detected (High Decode Address 0x1f)
platformRevision = 2 (Firehawk DB-88E6318 Rev 3.0)
CPU revision is: 0101810a
FPU revision is: 0003810a
Primary instruction cache 16kb, linesize 32 bytes (4 ways)
Primary data cache 8kb, linesize 32 bytes (2 ways)
Linux version 2.4.18-MIPS-01.01 (root@mips-build) (gcc version egcs-2.91.66
1999
0314 (egcs-1.1.2 release)) #69 Mon Jan 19 20:30:06 EST 2004
Determined physical RAM map:
 memory: 01dfffff @ 00000000 (usable)
On node 0 totalpages: 7679
zone(0): 7679 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS1,38400 noinitrd root=/dev/nfs
nfsroot=172.16.1
.210:/home/mips/rootfs
ip=172.16.200.200:172.16.1.210:172.16.0.1:255.255.0.0:rgp
:eth0:
Calibrating delay loop... 255.59 BogoMIPS
calibrating MIPS CPU counter frequency ... 128012730 Hz
Memory: 28468k/30716k available (1397k kernel code, 2248k reserved, 152k
data, 7
6k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Autoconfig PCI channel 0x80199ac8
Scanning bus 00, I/O 0x15000000:0x16000001, Mem 0x16000000:0x18000001
00:08.0 Class 0200: 8086:1229 (rev 08)
        Mem at 0x16000000 [size=0x1000]
        I/O at 0x15000000 [size=0x40]
        Mem at 0x16100000 [size=0x100000]
pcibios_fixup_irqs: slot=8
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
LMNpty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xb400c840x (irq = 23) is a 16550A
ttyS01 at 0xb400c8c0x (irq = 24) is a 16550A
rtc: I/O port 112 is not free.
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.1.1.1 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw
@saw.sw.com.sg> and others
eth0: PCI device 8086:1229, 00:D0:B7:1C:BA:37, IRQ 48.
  Board assembly 721383-008, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
boot_remap register = 0x1fc00000
Probing MTD devices at address 0x1e000000 (0x1000000 in size)
Creating 2 MTD partitions on "MV-88E6318 flash":
0x00000000-0x00200000 : "MV-88E6318 kernel partition"
0x00200000-0x01000000 : "MV-88E6318 file-system partition"
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
IP-Config: Complete:
      device=eth0, addr=172.16.200.200, mask=255.255.0.0, gw=172.16.0.1,
     host=rgp, domain=, nis-domain=(none),
     bootserver=172.16.1.210, rootserver=172.16.1.210, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: Mounting /home/mips/rootfs on server 172.16.1.210 as root
Root-NFS:     rsize = 4096, wsize = 4096, timeo = 7, retrans = 3
Root-NFS:     acreg (min,max) = (3,60), acdir (min,max) = (30,60)
Root-NFS:     nfsd port = -1, mountd port = 0, flags = 00000200
Root-NFS: IPPROTO = UDP <5>Looking up port of RPC 100003/2 on 172.16.1.210
Root-NFS: Portmapper on server returned 2049 as nfsd port
Looking up port of RPC 100005/1 on 172.16.1.210
Root-NFS: mountd port is 32855
NFS:      nfs_mount(ac1001d2:/home/mips/rootfs)
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k freed

!!/dev/console!!
cfo = 801790c4!!!! Inside find_next_zero_bit
 !!!
 good /dev/console
!!!! Inside find_next_zero_bit !!!

 next_fd = 2 in fcntl<4>!!!! Inside find_next_zero_bit !!!

 next_fd = 3 in fcntl
 in do_execve /sbin/init
 retval = 1
 in do_execve /etc/init
 retval = 1
 in do_execve /bin/init!!!! Insid
e find_next_zero_bit !!!
Using ELF interpreter /lib/ld.so.1
!!/etc/ld.so.preload!!
!!!! Inside find_next_zero_bit !!!
out_err /etc/ld.so.preload

 good /etc/ld.so.preload

!!/etc/ld.so.cache!!
!!!! Inside find_next_zero_bit
 !!!
out_err /etc/ld.so.cache

 good /etc/ld.so.cache

!!/lib/libc.so.6!!
!!!! Inside find_next_zero_bit
 !!!
 good /lib/libc.so.6

!!/dev/console!!
!!!! Inside find_next_zero_bit
 !!!
 good /dev/console

!!/etc/localtime!!
!!!! Inside find_next_zero_bit
 !!!
out_err /etc/localtime

 good /etc/localtime
!!!! Inside find_next_zero_bit !!
!
!!/dev/console!!
!!!! Inside find_next_zero_bit
 !!!
 good /dev/console
serial console detected.  Disabling virtual terminals.
!!!! Inside find_next_zero_bit !!
!
!!!! Inside find_next_zero_bit !!!
!!/dev/console!!
!!!! Inside find_next_zero_bit
 !!!
 good /dev/console
init started:  BusyBox v0.60.3 (2002.12.19-11:07+0000) multi-call binary

!!/etc/inittab!!
!!!! Inside find_next_zero_bit
 !!!
 good /etc/inittab

!!/dev/console!!
!!!! Inside find_next_zero_bit
 !!!
 good /dev/console
!!!! Inside find_next_zero_bit !!!

<4>!!!! Inside find_next_zero_bit !!!

!!!! Inside
find_next_zero_bit !!!
 in do_execve /etc/rc.sysinit!!!!
 Inside find_next_zero_bit !!!
Using ELF interpreter /lib/ld.so.1
!!/etc/ld.so.preload!!
!!!! Inside find_next_zero_bit
 !!!
out_err /etc/ld.so.preload
 good /etc/ld.so.preload

!!/etc/ld.so.cache!!
Kernel unaligned instruction access in unaligned.c:do_ade, line 407:
$0 : 00000000 30001000 00000001 00000001 80133ea8 00000001 00000001 00000001
$8 : 8019ad80 00001000 80172000 00000003 00000000 00000000 8019a98e 00000000
$16: 2aac00f4 80172000 00000001 1000001f ffffffe8 00000000 00000000 7fff7278
$24: 00000000 2aabd430                   810a4000 810a5ed0 00403784 80034470
Hi : 00000000
Lo : 00000000
epc  : 80034468    Not tainted
Status: 30001003
Cause : 80808010
Process EUR (pid: 10, stackpage=810a4000)
Stack: 80133ea4 00000001 00000001 00000001 2aac00f4 80172000 00000001
00000000
       80172000 2ab01b78 00000000 7fff7278 80034758 8003477c 80133f2c
00000001
       00000001 00000001 ffffffff ffffffff 00000001 2ab01788 00403784
800068e8
       7fff7b78 7fff7778 7fff7d78 00000000 ffffffff 00000000 00000000
2ab01790
       00000fa5 00000002 2aac00f4 00000000 00000001 00000000 81010100
00000001
       00000000 ...
Call Trace:
Code: 0000a821  3c048013  24843ea8 <0c003fa4> 8e65001c  3c048013  24843eb4
0c00
3fa4  8e65000c
Unable to handle kernel paging request at virtual address 2ab01b80, epc ==
8008e
db0, ra == 8001381c
Oops in fault.c:do_page_fault, line 205:
$0 : 00000000 80180000 00000001 00000002 00000019 00000000 00000200 81d8e000
$8 : 81079d50 30001001 810a5c90 00000000 00000000 00000000 8019a989 fffffffe
$16: 801621c0 2ab01b78 810a4264 ffffffff 80131040 0000000b 00000000 7fff7278
$24: ffffffff 810a5c47                   810a4000 810a5d70 00403784 8001381c
Hi : 00000000
Lo : 00000020
epc  : 8008edb0    Not tainted
Status: 30001003
Cause : 00808008
Process EUR (pid: 10, stackpage=810a4000)
Stack: 8000dee4 810a5d98 00403784 80004a60 801621c0 00000197 810a4000
801310f8
       8001381c 00809000 ffffffe8 00000000 00000000 7fff7278 8012e9e8
00000197
       810a5e20 1000001f ffffffe8 00000000 80004a60 80004a44 8012da60
00000001
       00000001 00000020 2aac00f4 810a5e20 00000001 80004a80 00000005
810a5e10
       8018ac88 00001bcf 80006ea4 8019ad80 00001bd0 0000003e 0000003c
00000001
       2aac00f4 ...
Call Trace:
Code: 8e510000  12200054  2413ffff <8e250008> 10b3004a  00a03021  04a10002
00a0
1021  24a27fff
Unable to handle kernel paging request at virtual address 2ab01b80, epc ==
8008e
db0, ra == 8001381c
Oops in fault.c:do_page_fault, line 205:
$0 : 00000000 30001000 00000001 00000000 00000000 30001001 00000000 0000249e
$8 : ffffffff 0000000a 810a5aaa 00000000 00000000 00000000 8019a989 fffffffe
$16: 00000000 2ab01b78 810a4264 ffffffff 80131040 0000000b 00000000 7fff7278
$24: ffffffff 810a5a67                   810a4000 810a5b90 0
=======================================================================
