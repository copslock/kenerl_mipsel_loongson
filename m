Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA1967149 for <linux-archive@neteng.engr.sgi.com>; Thu, 26 Mar 1998 15:07:43 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id PAA4249180
	for linux-list;
	Thu, 26 Mar 1998 15:06:54 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA4287093
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 26 Mar 1998 15:06:52 -0800 (PST)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA16539
	for <linux@cthulhu.engr.sgi.com>; Thu, 26 Mar 1998 15:06:49 -0800 (PST)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yILj5-0027mNC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Fri, 27 Mar 1998 00:06:23 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yILiy-002OoxC; Fri, 27 Mar 98 00:06 MET
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02028;
	Fri, 27 Mar 1998 00:04:26 +0100
Message-ID: <19980327000426.03461@alpha.franken.de>
Date: Fri, 27 Mar 1998 00:04:26 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com, David A Willmore <willmore@cig.mot.com>
Subject: Re: MIPS 2.1.89 now in CVS
References: <19980317234843.10411@uni-koblenz.de> <9803242106.ZM28226@whelk> <19980325042742.20917@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980325042742.20917@uni-koblenz.de>; from ralf@uni-koblenz.de on Wed, Mar 25, 1998 at 04:27:42AM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Mar 25, 1998 at 04:27:42AM +0100, ralf@uni-koblenz.de wrote:
> On Tue, Mar 24, 1998 at 09:06:06PM -0600, David A Willmore wrote:
> > Hey! :)  I've got a 53c90 card for the ISA bus that I would like to use on a
> > x86 machine.  Any idea how easy it would be to modify this driver to work with
> > a very generic card like that?  Funny that I didn't find any of this code in
> > the normal 2.1.90.  I take it your code isn't merged in?
> 
> Actually adding the necessary changes shouldn't be difficult.  Check out
> the files drivers/scsi/{sparc,jazz}esp.[ch] in one of the snapshots on
> ftp.linux.sgi.com.  You'll have to provide a similar machine / bus specific
> backend like for these two architectures.  Actually an ISA specific backend
> should be easier to implement than these two.

depends on the DMA engine used on the board. When the card uses the normal
PC DMA controller it will be dead slow and a horror to implement (welcome
to world of 64K segments). If the board has it's own DMA engine, you need
documentation for it. And without DMA you will need a new driver.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
