Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA07214 for <linux-archive@neteng.engr.sgi.com>; Sun, 12 Jul 1998 14:57:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA84819
	for linux-list;
	Sun, 12 Jul 1998 14:56:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA37151
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Jul 1998 14:56:52 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02962
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Jul 1998 14:56:50 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yvU6w-0027qfC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 12 Jul 1998 23:56:46 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yvU6o-002OpLC; Sun, 12 Jul 98 23:56 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA07125;
	Sun, 12 Jul 1998 23:53:20 +0200
Message-ID: <19980712235319.65470@alpha.franken.de>
Date: Sun, 12 Jul 1998 23:53:19 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: One good and some bad news
References: <19980712112949.25350@alpha.franken.de> <19980712190135.R10756@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980712190135.R10756@uni-koblenz.de>; from ralf@uni-koblenz.de on Sun, Jul 12, 1998 at 07:01:35PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 12, 1998 at 07:01:35PM +0200, ralf@uni-koblenz.de wrote:
> On Sun, Jul 12, 1998 at 11:29:49AM +0200, Thomas Bogendoerfer wrote:
> 
> > first the good news: 
> > 
> > Yesterday XF68_FBDev showed the first ugly gray X11 screen on my 
> > Olivetti M700. Yeah !
> 
> Does this mean the X Server which I've built is running without
> changes?

no, that's the one I've built:-) But it's made with your XFree patch
and an updated .spec file for the latest RH5.1 package (XFree86-3.3.2-13).
A couple of hours ago, I had X with window manager and application running
(PS/2 mouse works, too). There is only one small problem left, when scrolling
the X screen down. Looks like my "hardware" scrolling has some problems
with graphics.

> DBE has a nasty property, it can be delayed until some write access
> is written back from cache to memory.  The EPC then often points to
> completly useless addresses.

good to know, as the address was really bogus. Is there a chance to
print out the faulting physical address for a bus error ? This would
give us some chances to find the real culprit. But it still hasn't happen
again.

> Some places in the kernel also pass uncached addresses to MAP_NR().  In
> order to make that work right I decieded back in '94 to mask out everything
> but the bits that might be set in the physical address corrosponding to a
> KSEG0 address.

hmm, I've checked the MAP_NR() in the kernel, and couldn't find such
cases. In fact my changed kernel works perfect.

> The Olli case is somewhat special because the designers had the gorgeuous
> idea of placing some peripherals outside the lowest 4gb therefore more
> fun with EISA mappings for example ahead ...

I know. 

> These type of warning messae often indicate serious trouble.

hmm, the produced binaries are working without problem.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
