Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA2574043 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Apr 1998 09:28:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id JAA5514193
	for linux-list;
	Wed, 1 Apr 1998 09:26:23 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA6495965
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Apr 1998 09:26:16 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id JAA24096
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 09:26:14 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id TAA06971
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 19:26:13 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id TAA05783;
	Wed, 1 Apr 1998 19:26:03 +0200
Message-ID: <19980401192600.33372@uni-koblenz.de>
Date: Wed, 1 Apr 1998 19:26:00 +0200
To: Ulf Carlsson <grimsy@zigzegv.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
References: <Pine.LNX.3.96.980401000602.10731A-100000@web.aec.at> <Pine.LNX.3.96.980401184505.217B-100000@calypso.saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.96.980401184505.217B-100000@calypso.saturn>; from Ulf Carlsson on Wed, Apr 01, 1998 at 07:06:46PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 01, 1998 at 07:06:46PM +0200, Ulf Carlsson wrote:

> 2.1.90 doesn't work on my Indy :-(
> 
> Here's the output (maybe something for Ralf to look at):

> PROMLIB: SGI ARCS firmware Version 1 Revision 10
> PROMLIB: Total free ram 33284672 bytes (31528K, 30MB)
> ARCH: SGI-IP22
> CPU: MIPS-R4000 FPU<MIPS-R4000FPC> ICACHE DCACHE SCACHE
> Loading R4000 MMU routines.
> Primary instruction cache 8kb, linesize 16 bytes)
> Primary data cache 8kb, linesize 16 bytes)
> Secondary cache sized at 1024K linesize 128
> Linux version 2.1.90 (oliver@ball.aec.at) (gcc version 2.7.2) ...
> MC: SGI memory controller Revision 3
> R4600/R5000 SCACHE size 0k linesize 128 bytes

Ouch?  That routine should never be called.  Bug #1.

> wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0scsi0 : GVP SeriesII SCSI
                                                           ^^^^^^^^^^^^^^^^^
Ouch.  Guess I got caught cuting'n'pasting from the Amiga code ...
Anyway, purely cosmetic.

> scsi : 1 host
>  sending SDTR 0103013f0csync_xfer=2cpagefault from irq handler: 0000
> $0 : 00000000 1004fc00 89f5ac80 ffffff80
> $4 : 00000000 89f5acd0 1004fc00 1004fc00
       ^^^^^^^^
Hmm...  That one looks like you sliped a line or something _really_
strange happend.  The value should actually be 0x00000080.  Which on
our horribly small screen font looks almost like 0x00000000.

It this assumption is right, then the fix will be easy.

> $8 : 1004fc00 1000001f 4003f004 8802c10c
> $12: 00000100 880ee84e 88009fa0 ffffffe0
> $16: c0000044 00001000 a9f58000 89f59c00
> $20: 89f59e70 bfbc0003 00000060 bfb90000
> $24: a8747310 8810e5cc
> $28: 88008000 88009c90 89f59e70 880d9204
> epc   : 880224e8
> Status: 1000fc02
> Cause : 30008008
> Aiee, killing interrupt handler
> Kernel panic: Attempted to kill the idle task!
> In swapper task - not syncing
> 
> So, that's all! Puh.. my fingers are burning, those hex numbers drove me
> crazy..

That's why god sent men the serial console :-)

> I've still a R4000SC with 1mb cache. Tell me if I can dome something else
> to help you debugging it. I don't think I have the knowledge needed to fix
> the problem on my own right now, sorry... 

Let's fry that bug anyway.  What you provided in combination with the
kernel binary is actually useful information.

There is just one thing which I request when people are spreading kernels -
please don't strip them.  It makes disassembling quite a bit harder.

  Ralf
