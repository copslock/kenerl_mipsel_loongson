Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA1588340 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Mar 1998 15:50:59 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA4310951
	for linux-list;
	Thu, 26 Mar 1998 15:49:54 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA4271968
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 26 Mar 1998 15:49:52 -0800 (PST)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA03233
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Mar 1998 15:49:50 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yIMOn-0027ZyC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 27 Mar 1998 00:49:29 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yIMOh-002OoOC; Fri, 27 Mar 98 00:49 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA03223;
	Fri, 27 Mar 1998 00:47:57 +0100
Message-ID: <19980327004757.19715@alpha.franken.de>
Date: Fri, 27 Mar 1998 00:47:57 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com, willmore@cig.mot.com
Subject: Re: MIPS 2.1.89 now in CVS
References: <19980327000426.03461@alpha.franken.de> <m0yIMD7-000aNgC@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <m0yIMD7-000aNgC@the-village.bc.nu>; from Alan Cox on Thu, Mar 26, 1998 at 11:37:25PM +0000
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Mar 26, 1998 at 11:37:25PM +0000, Alan Cox wrote:
> > PC DMA controller it will be dead slow and a horror to implement (welcome
> > to world of 64K segments). If the board has it's own DMA engine, you need
> > documentation for it. And without DMA you will need a new driver.
> 
> Can anyone working on generic 53c9x support also talk to the Linux mac folks
> who are also working on this right now. 

the 53c9x mips support is a "port" of the sparc esp driver, which I did
based on work from the m68k people (fastlane, blizzard, etc.). And I also
verified that the changed esp still runs on a Sparc (at least on my SS2).

> Incidentally we'll also be wanting
> to abuse the mips sonic driver soon too 8)

So I should put fixing it higher on my todo list:-) ? It still has problems
with real network traffic. I know the reason, but didn't have time to fix
it, yet.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
