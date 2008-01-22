Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 21:07:31 +0000 (GMT)
Received: from poczta.ibb.waw.pl ([212.87.28.201]:36028 "EHLO ibb.waw.pl")
	by ftp.linux-mips.org with ESMTP id S28590584AbYAVVHW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Jan 2008 21:07:22 +0000
Received: from gigo (helo=localhost)
	by ibb.waw.pl with local-esmtp (Exim 4.63)
	(envelope-from <gigo@poczta.ibb.waw.pl>)
	id 1JHQOD-0000oM-8Q
	for linux-mips@linux-mips.org; Tue, 22 Jan 2008 22:10:37 +0100
Date:	Tue, 22 Jan 2008 22:10:37 +0100 (CET)
From:	gigo@poczta.ibb.waw.pl
To:	linux-mips@linux-mips.org
Subject: Old Indy, 64-bit setup
Message-ID: <Pine.LNX.4.64.0801222106460.31014@poczta.ibb.waw.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <gigo@poczta.ibb.waw.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gigo@poczta.ibb.waw.pl
Precedence: bulk
X-list: linux-mips

  Hello,
Just a silly question. Is there any working 64-bit kernel configuration 
for my r4k 100MHz Indy? From time to time i compile another new kernel for 
64-bit... and see the thing dying. Recently it looked pretty well like 
Indy r4k 100MHz (BROTHER!?!?!) crash shown in 
http://www.linux-mips.org/archives/linux-mips/2007-11/msg00186.html
Everything but the kernel is debian stable: binutils 2.17
gcc 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)...

I would be very happy to give you any more info/do any test, if 
you are interested.

These are taken on 32-bit (usually working) 2.6.23.14 from linux-mips.org.
/proc/cpuinfo:
system type             : SGI Indy
processor               : 0
cpu model               : R4000PC V3.0  FPU V0.0
BogoMIPS                : 45.68
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 48
extra interrupt vector  : no
hardware watchpoint     : yes
ASEs implemented        :
shadow register sets    : 1
VCED exceptions         : 0
VCEI exceptions         : 0

dmesg:
Linux version 2.6.23.14 (root@indyk) (gcc version 4.1.2 20061115 
(prerelease) (Debian 4.1.1-21)) #2 PREEMPT Fri Jan 18 13:00:11 CET 2008
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
console [early0] enabled
CPU revision is: 00000430
FPU revision is: 00000500
MC: SGI memory controller Revision 3
MC: Probing memory configuration:
  bank0:  32M @ 08000000
  bank1:  32M @ 0a000000
Determined physical RAM map:
  memory: 04000000 @ 08000000 (usable)
Wasting 1048576 bytes for tracking 32768 unused pages
On node 0 totalpages: 49152
   Normal zone: 384 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 48768 pages, LIFO batch:15
   Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order.  Total pages: 48768
Kernel command line: root=/dev/sda1 auto
Primary instruction cache 8kB, physically tagged, direct mapped, linesize 16 bytes.
Primary data cache 8kB, direct mapped, linesize 16 bytes.
Synthesized TLB refill handler (21 instructions).
Synthesized TLB load handler fastpath (33 instructions).
Synthesized TLB store handler fastpath (33 instructions).
Synthesized TLB modify handler fastpath (32 instructions).
PID hash table entries: 1024 (order: 10, 4096 bytes)
Calibrating system timer... 48800 [100.0000 MHz CPU]
Using 49.971 MHz high precision timer.
NG1: Revision 3, 8 bitplanes, REX3 revision B, VC2 revision A, xmap9 
revision A, cmap revision C, bt445 revision A
NG1: Screensize 1296x1024
Console: colour SGI Newport 162x64
console handover: boot [early0] -> real [tty0]
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 60896k/65536k available (2158k kernel code, 4484k reserved, 325k 
data, 104k init, 0k highmem)
Calibrating delay loop... 45.68 BogoMIPS (lpj=22272)
(...)
Time: MIPS clocksource has been installed.
(...)
io scheduler cfq registered (default)
DS1286 Real Time Clock Driver v1.0
(...)
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
            setup_args=,,,,,,,,,,
            Version 1.26++ - 10/Feb/2007, Compiled Jan 18 2008 at 06:02:09
scsi0 : SGI WD93
  sending SDTR 010301320c 010301320c sync_xfer=2c
(...)



Regards,

Grzegorz Wieczorek
