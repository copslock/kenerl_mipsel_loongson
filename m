Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA22994 for <linux-archive@neteng.engr.sgi.com>; Sat, 9 Jan 1999 11:22:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA16720
	for linux-list;
	Sat, 9 Jan 1999 11:22:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA18822
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 9 Jan 1999 11:22:12 -0800 (PST)
	mail_from (chad@sgidal.dallas.sgi.com)
Received: from dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	 id NAA02460; Sat, 9 Jan 1999 13:22:09 -0600
Message-ID: <3697AC60.90A11C2E@dallas.sgi.com>
Date: Sat, 09 Jan 1999 13:22:08 -0600
From: Chad Carlin <chad@sgidal.dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Robin Humble <rjh@pixel.maths.monash.edu.au>, linux@cthulhu.engr.sgi.com
Subject: Still boot vmlinux trouble
References: <199901090724.SAA15752@pixel.maths.monash.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thanks Robin,

You were right about the device files by the way. They were all josed.
Here's what they look like now:

marvin2:chad 200 # ls -l /dist/linux/mipseb/dev
total 0
crw-------    1 root     sys        4,  0 Jan  9 12:31 console
crw-rw-rw-    1 root     sys        1,  3 Jan  9 12:31 null
brw-r-----    1 root     6          1,  1 Jan  9 12:32 ram
crw-------    1 root     sys        4,  0 Jan  9 12:33 systty
crw-------    1 root     sys        4,  1 Jan  9 12:33 tty1
crw-------    1 root     sys        4,  2 Jan  9 12:33 tty2
crw-------    1 root     sys        4,  3 Jan  9 12:33 tty3
crw-------    1 root     sys        4,  4 Jan  9 12:34 tty4
crw-------    1 root     sys        4,  5 Jan  9 12:34 tty5


*(When you said /dev/ in you email I assumed you meant on my linux
distribution and not the actual /dev being used by my nfs server. 

Now to the problem. I believe the problem is the "Warning: unable to
open an initial console." error message. Any ideas?

>> boot bootp()169.238.83.43:vmlinux nfsroot=169.238.83.43:/dist/linux/mipseb nfsaddrs=::8.0.69.a.d5.44:0xffffff80:marvin2::

130768+22320+3184+341792+48560d+4604+6816 entry: 0x8bfa60d0
Obtaining vmlinux from server 169.238.83.43
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 65814528 bytes (64272K,62MB)
ARCH: SGI-IP22
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE 
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes)
Primary data cache 16kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 128
Linux version 2.1.100 (root@alex3.med.iacnet.com) (gcc version 2.7.2)
#29 Thu Jul 9 22:19:39 EDT 1998
MC: SGI memory controller Revision 3
calculating r4koff... 000f436e(1000302)
zs0: console input
zs0: console I/O
Calibrating delay loop... 99.94 BogoMIPS
Memory: 60364k/196116k available (1216k kernel code, 2684k data)
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: ICMP, UDP, TCP
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Starting kswapd v 1.5 
Adv: about to run setup()
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
Ramdisk driver initialized : 16 ramdisks of 4096K size
loop: registered device at major 7
WD93: Driver version 1.25 compiled on Jul  7 1998 at 16:59:57
 debug_flags=0x00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0scsi0 : SGI WD93
scsi : 1 host.
 sending SDTR 0103013f0csync_xfer=2c  Vendor: IBM       Model:
DCAS-32160        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE
ST31200N  Rev: 9278
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 3, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4226725 [2063 MB] [2.1
GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2077833 [1014 MB] [1.0
GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:07:9b:35 
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 169.238.83.43, my address is
169.238.83.19
IP-Config: Gateway not on directly connected network.
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4
Looking up port of RPC 100003/2 on 169.238.83.43
Looking up port of RPC 100005/1 on 169.238.83.43
VFS: Mounted root (nfs filesystem).
Adv: done running setup()
Freeing unused kernel memory: 44k freed
Warning: unable to open an initial console.
page fault from irq handler: 0000
$0 : 00000000 88180000 0000062d 00000000
$4 : 00000000 1004fc00 00000000 00000000
$8 : 00000000 00000000 00000000 00000cc9
$12: 367e8b11 8bf30864 8bf30800 00000000
$16: 8bf41000 8bf2c0e0 0000062d 881523c8
$20: abf41040 bfb94000 00000000 bfbd4000
$24: 00000000 8bf5fb58
$28: 88008000 88009d90 0000000e 880e3f38
epc   : 880e3e74
Status: 1004fc02
Cause : 00000008
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

Thanks again
