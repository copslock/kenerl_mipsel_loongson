Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA2588027 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Apr 1998 08:05:22 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id IAA6466165
	for linux-list;
	Wed, 1 Apr 1998 08:04:21 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA6452220
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Apr 1998 08:04:19 -0800 (PST)
Received: from ballyhoo.ml.org ([194.236.80.80]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA21185
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 08:04:17 -0800 (PST)
	mail_from (grimsy@zigzegv.ml.org)
Received: from calypso.saturn ([130.244.90.67]) by ballyhoo.ml.org
	 with smtp (ident grimsy using rfc1413) id m0yKPxI-000xjYC
	(Debian Smail-3.2 1996-Jul-4 #2); Wed, 1 Apr 1998 18:01:36 +0200 (CEST)
Date: Wed, 1 Apr 1998 19:06:46 +0200 (CEST)
From: Ulf Carlsson <grimsy@zigzegv.ml.org>
X-Sender: grimsy@calypso.saturn
To: linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
In-Reply-To: <Pine.LNX.3.96.980401000602.10731A-100000@web.aec.at>
Message-ID: <Pine.LNX.3.96.980401184505.217B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

2.1.90 doesn't work on my Indy :-(

Here's the output (maybe something for Ralf to look at):

PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 33284672 bytes (31528K, 30MB)
ARCH: SGI-IP22
CPU: MIPS-R4000 FPU<MIPS-R4000FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines.
Primary instruction cache 8kb, linesize 16 bytes)
Primary data cache 8kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 128
Linux version 2.1.90 (oliver@ball.aec.at) (gcc version 2.7.2) ...
MC: SGI memory controller Revision 3
R4600/R5000 SCACHE size 0k linesize 128 bytes
calculating r4koff... 000a1e0(500192)
GFX INIT: SHMIQ setup
usemaclone misc device registered (minor: 151)
Video screen size is 00004c88 at 88318db0
Console: 16 point font, 992 scans
Console: colour NEWPORT 158x62, 1 virtual console (max 63)
Calibrating delay loop... 49.97 BogoMIPS
Memory: 28300k/163372k available (1036 kernel code, 2188k data)
Swansea University Computer Society NET3.039 for Linux 2.1
NET3: Unix domain sockets 0.16 for Linux NET3.038.
Swansea University Computer Society TCP/IP for NET3.037
IP Protocols: ICMP, UDP, TCP
Checking for 'wait' instruction... unavailable
POSIX conformance testing by UNIFIX
Starting kswapd v 1.5
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
WD93: Driver version 1.25 compiled on Mar 31 1998 at 22:26:48
 debug_flags=0x00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0scsi0 : GVP SeriesII SCSI
scsi : 1 host
 sending SDTR 0103013f0csync_xfer=2cpagefault from irq handler: 0000
$0 : 00000000 1004fc00 89f5ac80 ffffff80
$4 : 00000000 89f5acd0 1004fc00 1004fc00
$8 : 1004fc00 1000001f 4003f004 8802c10c
$12: 00000100 880ee84e 88009fa0 ffffffe0
$16: c0000044 00001000 a9f58000 89f59c00
$20: 89f59e70 bfbc0003 00000060 bfb90000
$24: a8747310 8810e5cc
$28: 88008000 88009c90 89f59e70 880d9204
epc   : 880224e8
Status: 1000fc02
Cause : 30008008
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing

So, that's all! Puh.. my fingers are burning, those hex numbers drove me
crazy..

I've still a R4000SC with 1mb cache. Tell me if I can dome something else
to help you debugging it. I don't think I have the knowledge needed to fix
the problem on my own right now, sorry... 

- Ulf
