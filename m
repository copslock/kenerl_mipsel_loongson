Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id VAA368855 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Sep 1997 21:11:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA04823 for linux-list; Wed, 10 Sep 1997 21:10:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA04815 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Sep 1997 21:10:34 -0700
Received: from jenolan.rutgers.edu (jenolan.rutgers.edu [128.6.111.5]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA08742
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Sep 1997 21:10:33 -0700
	env-from (davem@jenolan.rutgers.edu)
Received: (from davem@localhost)
	by jenolan.rutgers.edu (8.8.5/8.8.5) id AAA14641;
	Thu, 11 Sep 1997 00:09:23 -0400
Date: Thu, 11 Sep 1997 00:09:23 -0400
Message-Id: <199709110409.AAA14641@jenolan.rutgers.edu>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ralf@mailhost.uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199709110351.FAA08065@informatik.uni-koblenz.de> (message from
	Ralf Baechle on Thu, 11 Sep 1997 05:51:07 +0200 (MET DST))
Subject: Re: R5000 caches
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
   Date: Thu, 11 Sep 1997 05:51:07 +0200 (MET DST)

   Can anybody give me a pointer to where the R5000 caches, especially
   the cache instruction, are documented?  My two IDT R5000 manuals
   don't contain the least bit of information regarding the cache
   instruction.  I'm primarily interested in how the indexed
   operations select the cache set of the primary caches to operate
   on.  On the R4600 which has 16kb per cache bit 13 selects the set.
   So I assume it's bit 14 on the R5000 with it's 32kb per cache?  The
   code from David handles the R5000 like a R4000 CPU but this doesn't
   look very credible to me as this is a QED CPU and the other members
   of the R5k family like the Nevada (which run Linux now also!) have
   two way primary caches.

In SGI boxes, if my memory serves, the R5k's were the chips which
needed the special:

	cli();
	jump_into_64_bit_mode();
	{peek,poke}_magic_physaddr();
	leave_64_bit_mode();
	sti();

sequence, both to enable/disable the cache and to perform flush
operations.  Although this could have been for the R4600.  I do
remember that IRIX had special code to work the R5k caches, but this
might have been for the L2 cache operations only, not L1.

All of this was very SGI specific and was mostly for the L2 cache
operations.  I think the R5k had a special "flush command" which would
just pull a pin going to the cache and invalidate all the lines in one
cycle (earle told me this, he may be able to elaborate).

The R5k, by design at least in the SGI boxes, lacks a L2 cache, it was
added externally on the SGI motherboard's, and thus all the funcy
methods to access/enable/disable/flush it...  Again, I could be
confusing r4600 and r5k here, so who knows.

Later,
David "Sparc" Miller
davem@caip.rutgers.edu
