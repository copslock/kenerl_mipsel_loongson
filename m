Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA290765 for <linux-archive@neteng.engr.sgi.com>; Sun, 8 Mar 1998 04:53:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id EAA1866563 for linux-list; Sun, 8 Mar 1998 04:52:54 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA1577278 for <linux@cthulhu.engr.sgi.com>; Sun, 8 Mar 1998 04:52:52 -0800 (PST)
Received: from ballyhoo.ml.org ([194.236.80.80]) by sgi.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id EAA25113
	for <linux@cthulhu.engr.sgi.com>; Sun, 8 Mar 1998 04:52:51 -0800 (PST)
	mail_from (grimsy@zigzegv.ml.org)
Received: from calypso.saturn ([130.244.187.51]) by ballyhoo.ml.org
	 with smtp (ident grimsy using rfc1413) id m0yBfWQ-000xjYC
	(Debian Smail-3.2 1996-Jul-4 #2); Sun, 8 Mar 1998 13:49:42 +0100 (CET)
Date: Sun, 8 Mar 1998 13:54:50 +0100 (CET)
From: Ulf Carlsson <grimsy@zigzegv.ml.org>
X-Sender: grimsy@calypso.saturn
To: linux@cthulhu.engr.sgi.com
Subject: paging requests again.
In-Reply-To: <Pine.LNX.3.96.980308125517.1691A-100000@web.aec.at>
Message-ID: <Pine.LNX.3.96.980308133524.14385B-100000@calypso.saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I got a compiled kernel from Oliver (greetings to him). I recieve almost
the same error messages as before. 

Obviously worked the kernel with Oliver's Indy:

> PROMLIB: SGI ARCS firmware Version 1 Revision 10
> PROMLIB: Total free ram 64589824 bytes (63076K,61MB)
> ARCH: SGI-IP22
> CPU: MIPS-R5000 FPU<MIPS-R5000FPC> ICACHE DCACHE SCACHE 
> Loading R4000 MMU routines.
> CPU revision is: 00002310
> Primary instruction cache 32768kb, linesize 32 bytes)
> Primary data cache 32768kb, linesize 32 bytes)
> MC: SGI memory controller Revision 3
> R4600/R5000 SCACHE size 512K linesize 128 bytes
> Enabling R4600 SCACHE
> calculating r4koff... 000e3328(930600)

But here's the output I got from my Indy. (reserved for misspellings :)

PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 32284672 bytes (31528K,30MB)
RCH: SGI-IP22
CPU: MIPS-R4000 FPU<MIPS-R400FPC> ICACHE DCACHE SCACHE
Loading R4000 MMU routines
CPU revision is: 00000430
Primary instruction cache 8192kb, linesize 16 bytes)
Primary data cache 8192kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 128
MC: SGI memory controller Revision 3
R4600/R5000 SCACHE size 0K linesize 128 bytes
calculating r4koff... 0003fd7c(261500)
GFX INIT: SHMIQ setup
...
Memory: 28104k/163372k available (1068k kernel code, 2352 data)
...
Checking for 'wait' instruction... unavailable.
...
loop: registered device at major 7
WD93: Driver version 1.25 compiled on ...
 debug_flags=0x00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0scsi0 : SGI WD93
scsi : 1 host.
  sending SDTR 0103013f0csync_xfer=2c<1>Unable to handle kernel paging
request at virtual address c0000068, epc == 88022ec0, ra == 880dccf4
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task
In swapper task - not syncing

Puh..

BTW, isn't this kernel supposed to work on my Indy?

Thank you very much.
- Ulf
