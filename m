Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA70851 for <linux-archive@neteng.engr.sgi.com>; Mon, 13 Jul 1998 15:40:21 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA23058
	for linux-list;
	Mon, 13 Jul 1998 15:38:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA47087
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Jul 1998 15:38:41 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA05956
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Jul 1998 15:38:34 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yvrEg-0027pJC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 14 Jul 1998 00:38:18 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yvrEW-002OzrC; Tue, 14 Jul 98 00:38 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id AAA02784;
	Tue, 14 Jul 1998 00:08:26 +0200
Message-ID: <19980714000825.24064@alpha.franken.de>
Date: Tue, 14 Jul 1998 00:08:25 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: One good and some bad news
References: <19980712112949.25350@alpha.franken.de> <19980712190135.R10756@uni-koblenz.de> <19980712235319.65470@alpha.franken.de> <19980713023606.U10756@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980713023606.U10756@uni-koblenz.de>; from ralf@uni-koblenz.de on Mon, Jul 13, 1998 at 02:36:06AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jul 13, 1998 at 02:36:06AM +0200, ralf@uni-koblenz.de wrote:
> On Sun, Jul 12, 1998 at 11:53:19PM +0200, Thomas Bogendoerfer wrote:
> > good to know, as the address was really bogus. Is there a chance to
> > print out the faulting physical address for a bus error ? This would
> > give us some chances to find the real culprit. But it still hasn't happen
> > again.
> 
> Basically what to do would be to modify the kernel such that it will work
> with caches disabled.  Then you get (almost) precise exceptions again.
> Alternative and with less impact on the performance you could try to
> writeback the caches in strategic positions for debugging.  That makes a
> kind of a barrier for DBE exceptions.

ugly. I hope, that I won't need it.

> You patch looks good, could you commit it?  Thanks.

I do, when I've merged my stuff with the latest CVS commits. 

Thomas

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
