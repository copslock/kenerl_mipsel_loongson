Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA02697 for <linux-archive@neteng.engr.sgi.com>; Thu, 29 Oct 1998 02:11:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA87971
	for linux-list;
	Thu, 29 Oct 1998 02:10:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA67585
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 29 Oct 1998 02:10:39 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn ([194.236.80.24]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06071
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Oct 1998 02:10:37 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m0zYp3r-000w6uC@calypso.saturn> (Debian Smail3.2.0.101)
	for linux@cthulhu.engr.sgi.com; Thu, 29 Oct 1998 11:12:11 +0100 (CET) 
Message-ID: <19981029111211.B28553@zigzegv.ml.org>
Date: Thu, 29 Oct 1998 11:12:11 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: HAL2 interrupt
References: <19981028005901.C23849@zigzegv.ml.org> <19981028232652.A2587@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19981028232652.A2587@alpha.franken.de>; from Thomas Bogendoerfer on Wed, Oct 28, 1998 at 11:26:52PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Oct 28, 1998 at 11:26:52PM +0100, Thomas Bogendoerfer wrote:
> On Wed, Oct 28, 1998 at 12:59:01AM +0100, Ulf Carlsson wrote:
> > Now I'm asking again, do you know which interrupt number I should request for
> > the PBUS DMA:s. I can't handle the interrupts correctly without the knowledge of
> 
> for me it looks like SGINT_HPCDMA should be the first PBUS DMA interrupt.
> But looking further into the indyIRQ.S and indy_int.c indicates, that these
> interrupts aren't implemented, yet.

The problem is that the sgiseeq and the sgiwd93 use HPC DMA as well, but they're
sharing local interrupt 0 (MIPS IRQ 2), and using some status register to
differentiate them. If I were writing a sgiwd93 driver or a sgiseeq driver, my
first guess would have been that they were using the SGINT_HPCDMA interrupts.

Well, looks like I'm out of luck, I'll do some trial & error.

Ralf?

- Ulf
