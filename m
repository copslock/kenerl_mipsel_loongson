Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA34045 for <linux-archive@neteng.engr.sgi.com>; Sun, 22 Mar 1998 21:02:29 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id VAA2585681
	for linux-list;
	Sun, 22 Mar 1998 21:01:58 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA2530338
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 22 Mar 1998 21:01:56 -0800 (PST)
Received: from MajorD.xtra.co.nz (terminator.xtra.co.nz [202.27.184.5]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id VAA19551
	for <linux@cthulhu.engr.sgi.com>; Sun, 22 Mar 1998 21:01:54 -0800 (PST)
	mail_from (ratfink@xtra.co.nz)
Received: from xtra.co.nz (xtra185187.xtra.co.nz [202.27.185.187])
	by MajorD.xtra.co.nz (8.8.8/8.8.6) with ESMTP id RAA27079
	for <linux@cthulhu.engr.sgi.com>; Mon, 23 Mar 1998 17:01:52 +1200 (NZST)
Message-ID: <3515ECBF.B46B0714@xtra.co.nz>
Date: Mon, 23 Mar 1998 17:01:51 +1200
From: Brendan Black <ratfink@xtra.co.nz>
Organization: Acess Denied...
X-Mailer: Mozilla 4.04 [en] (X11; U; Linux 2.0.33 i586)
MIME-Version: 1.0
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: experiences...
Content-Type: text/plain; charset=x-UNICODE-2-0-UTF-7
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've been watching the list for a while now, originally with the
intention of trying out LinuxSGI on a Challenge S, well there ain't one
spare anymore, but there is this indy :)

to cut a long story short, I grabbed the installer from linus, went
through the instructions, and tried various different kernels with the
following results:
(you'll have to excuse any typing mistakes, I handwrote the boot
messages)

2.1.55 (vmlinux-970916-efs.gz)

PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 64622592 bytes (63108K, 61MB)
ARCH: SGI-IP22
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines
CPU revision is: 00000450
Primary ICACHE 16K (linesize 16 bytes)
Primary DCACHE 16K (linesize 16 bytes)
Secondary cache sized at 1024K linesize 128
MC: SGI memory controller Revision 3
calculating r4koff... 000bcf0c(773900)
GFX INIT: SHMIQ setup
usemaclone misc device registered (minor: 151)
usema device registered (major 86)
Video screen size is 00004c88 at 883a5b90
Console: 16 point font, 992 scans
Console: colour NEWPORT 158x62, 1 virtual console (max 63)
Calibrating delay loop.. ok - 77.21 BogoMIPS
Memory: 60544k/196180k available (1020k kernel code, 2768k data)
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix Domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: IGMP, ICMP, UDP, TCP
Checking for 'wait' instruction.. unavailable
Linux version 2.1.55 (shaver@neon.ingenia.ca) (gcc version 2.7.2) #121
Tue Sep 16 16:30:52 EDT 1997
POSIX conformance testing by UNIFIX
starting kswapd v 1.23
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9838 (irq=21) is a Zilog8530
tty01 at 0xbfbd9830 (irq=21) is a Zilog8530
WD93: Driver version 1.25 complied on Sep 13 1997 at 19:13:34
debug_flags=0x00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0scsi0 : SGI WD93
scsi : 1 host
   sending SDTR

it stops at this point and this happens no matter what options I give
the kernel (root=/dev/sd??)

2.1.67 (from linus) stops at same point (has a few different devices,
but essentially the same)
2.1.72 (from linus) gives me a blank screen (no messages whatsoever :()

aside from the hardware messages above, heres an hinv:

penguin 3% hinv
Iris Audio Processor: version A2 revision 4.1.0
1 150 MHZ IP22 Processor
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
CPU: MIPS R4400 Processor Chip Revision: 5.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Secondary unified instruction/data cache size: 1 Mbyte
Main memory size: 64 Mbytes
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Integral Ethernet: ec0, version 1
Integral SCSI controller 0: Version WD33C93B, revision D
Disk drive: unit 2 on SCSI controller 0
Graphics board: Indy 8-bit
Vino video: unit 0, revision 0, IndyCam not connected

I had to install Irix 5.3 myself on the machine, as someone had
completely screwed the volume header.

The disk is id=2, so irix sits on an efs partition on /dev/dsk/s0d2s0,
swap on /dev/dsk/s0d2s1, with my e2fs partition on /dev/dsk/s0d2s2,
which all installed without a hitch, once I had learned the vagaries of
fx first and the installer second. I may have a hardware problem though,
on first turning the machine on, it tries accessing scsi device (0,1,0)
on the diagnostics, which as far as I can tell doesn't exist, and then
fails diagnostics, then if you hit start system, it boots off (0,2,0)
>:-|

I am intending on documenting everything I have to do to get this
machine working, hopefully with a full install, and submit this to the
project, so - any ideas on the above lockup/errors ??

cheers
-- 
Brendan Black - Network Engineer, Telecom Internet Services
email:	ratfink@xtra.co.nz (personal)	phone: +-649 3555238
	                                mob:   +-6425 2752667
"Waving away a cloud of smoke, I look up, and am blinded by a bright,
white
light. It's God. No, not Richard Stallman, or Linus Torvalds, but God.
In
a booming voice, He says: "THIS IS A SIGN. USE LINUX, THE FREE UNIX
SYSTEM
FOR THE 386." -- Matt Welsh
