Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA23490 for <linux-archive@neteng.engr.sgi.com>; Thu, 29 Oct 1998 14:28:31 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA85432
	for linux-list;
	Thu, 29 Oct 1998 14:27:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA51582
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 29 Oct 1998 14:27:45 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn ([194.236.80.22]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05636
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Oct 1998 14:27:42 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m0zZ0ZL-000w5GC@calypso.saturn> (Debian Smail3.2.0.101)
	for linux@cthulhu.engr.sgi.com; Thu, 29 Oct 1998 23:29:27 +0100 (CET) 
Message-ID: <19981029232927.A1325@zigzegv.ml.org>
Date: Thu, 29 Oct 1998 23:29:27 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: HAL2 interrupt
References: <19981028005901.C23849@zigzegv.ml.org> <19981028232652.A2587@alpha.franken.de> <19981029111211.B28553@zigzegv.ml.org> <19981029231009.A3756@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19981029231009.A3756@alpha.franken.de>; from Thomas Bogendoerfer on Thu, Oct 29, 1998 at 11:10:09PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > Well, looks like I'm out of luck, I'll do some trial & error.
> 
> try interrupt 12, which should be the HPC3 interrupt (sgint23.h). After
> getting an HPC3 interrupt you have to look in HPC3 register istat0 and 
> istat1 for the interrupt source. I guess DaveM wanted to map these
> interrupt sources to SGINT_HPCDMA, but never got to implement it.

Thanks, I'll do this tonight or tomorrow.

By the way, I have patched the kernel to support ksymoops (with stack tracing,
call tracing and code dump), and Keith Owens has patched ksymoops to support
MIPS. There was some sort of show_registers() function in traps.c which wasn't
used. I rewrote that function and made it work (yes, the original function
didn't work at all). Sounds interesting, doesn't it? I'll send you the patch
tomorrow...

- Ulf
