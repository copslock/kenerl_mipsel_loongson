Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id DAA161575 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Dec 1997 03:35:38 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA19697 for linux-list; Tue, 16 Dec 1997 03:34:37 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA19688 for <linux@engr.sgi.com>; Tue, 16 Dec 1997 03:34:35 -0800
Received: from Tandem.com (suntan.tandem.com [192.216.221.8]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA25711
	for <linux@engr.sgi.com>; Tue, 16 Dec 1997 03:34:34 -0800
	env-from (jojo@unixpc.germany.tandem.com)
Received: from unixpc.germany.tandem.com (jojo@unixpc.germany.tandem.com [168.87.29.119])
	by Tandem.com (8.8.8/2.0.1) with ESMTP id DAA15249
	for <linux@engr.sgi.com>; Tue, 16 Dec 1997 03:34:07 -0800 (PST)
Received: (from jojo@localhost)
	by unixpc.germany.tandem.com (8.8.7/8.8.7) id LAA07650
	for linux@engr.sgi.com; Tue, 16 Dec 1997 11:36:11 +0100
From: Joachim Schmitz <jojo@unixpc.dus.Tandem.COM>
Message-Id: <199712161036.LAA07650@unixpc.germany.tandem.com>
Subject: bus error IRQ
To: linux@cthulhu.engr.sgi.com
Date: Tue, 16 Dec 1997 11:36:08 +0100 (CET)
Organization: Tandem Computers GmbH
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi list

I'm new to this list and currently trying to setup my Indy for Linux.
For a start I tried just to boot vmlinux-970916-efs and vmlinux-2.1.67
... without success. Both boots ends up with:

boot vmlinux-2.1.67
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 64376832 bytes (62868k,61MB)
ARCH: SGI-IP22
CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE
Loading R4000 MMU routines.
CPU revision is: 00002020
Primary ICACHE 16k (linesize 32 bytes)
Primary DCACHE 16k (linesize 32 bytes)
R4600/R5000 SCACHE size 0K linesize 32 bytes
MC: SGI memory controller Revision 3
calculating r4coff... 000a8fe8(692200)
GFX INIT: SHMIQ setup
usemaclone misc device registered (minor: 151)
Video screen size is 00004c88 at 883e5d48
Console: 16 point font, 992 scans
Console: color NEWPORT 158x62, 1 virtual console (max 63)
Calibrating delay loop.. ok - 138.04 BogoMIPS
Memory: 60304k/196196k available (1164k kernel code, 2880k data)
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: IGMP, ICMP, UDP, TCP
Checking for 'wait' instruction... available.
Linux version 2.1.67 (ralf@indy) (gcc version 2.7.2) #1 Sat Dec 6 12:48:52 PST 1997
POSIX conformance testing by UNIFIX
Starting kswapd v 1.23
SGI Zilog8530  serial driver version 1.00
tty00 at 0xbfdb9838 (irq=21) is a Zilog8530
tty01 at 0xbfdb9830 (irq=21) is a Zilog8530
loop: registered device at major 7
Got a bus error IRQ, shouldn't happen yet
$0 : 00000000 1000fc01 88130000 00000000
$4 : 88174274 8812cb10 883fdcb8 00000001
$8 : 1000fc03 00000201 0000bf81 8813de68
$12: 00000001 00000001 00000001 fffffffc
$16: 0000c000 8bf81000 00000000 00000000
$20: a87ffc20 a8746d10 9fc55064 00000000
$24: 1000fc01 0000000f
$28: 881da370 883fdcb8 00000001 8800b0e8
epc   : 880359f8
Status: 1000fc03
Cause : 00004000
Spinning...


boot vmlinux-970916-efs
...
calculating r4coff... 000a6cc0(683200)
...
usema device registered (major 86)
Video screensize is 00004c88 at 883a5c60
...
Calibrating delay loop.. ok - 136.40 BogoMIPS
Memory: 60560k/196196k available (1020 kernel code, 2768k data)
...
Linux version 2.1.55 (shaver@neon.ingenia.ca) (gcc version 2.7.2) #121 Tue Sep 16 16:30:52 EDT 1997
...
$0 : 00000000 00000000 00030000 80004000
$4 : 00000080 8bf84000 1000fc01 80003fe0
$8 : 00000000 00000000 0000bf83 881194d8
$12: 00000001 00000001 00000001 fffffffc
$16: 0bf83000 8bf8r300 00000000 00000000
$20: a87ffc20 a8746d10 9fc55064 00000000
$24: 1000fc01 0000000f
$28: 881da370 883bfda8 00000001 880d5910
epc   : 880261bc
Status: 1000fc03
Cause : 00004000
Spinning...

(I hope I didn't make to much mistakes keying in the above)
At this point it hangs. Only pulling the power cord helps.
I have no linux-root filesystem (yet), but I don't think
this is the reason for this behavoir, right?

-- 
Bye,	Jojo

email:
work SCHMITZ_JOACHIM@Tandem.COM
home Joachim_Schmitz@D.maus.de
