Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA524064 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Sep 1997 18:03:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA13549 for linux-list; Thu, 11 Sep 1997 18:02:44 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA13489; Thu, 11 Sep 1997 18:02:33 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA10756; Thu, 11 Sep 1997 18:02:20 -0700
Date: Thu, 11 Sep 1997 18:02:20 -0700
Message-Id: <199709120102.SAA10756@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Cc: davem@jenolan.rutgers.edu (David S. Miller), linux@cthulhu.engr.sgi.com
Subject: Re: R5000 caches
In-Reply-To: <199709110428.GAA12438@informatik.uni-koblenz.de>
References: <199709110409.AAA14641@jenolan.rutgers.edu>
	<199709110428.GAA12438@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > > In SGI boxes, if my memory serves, the R5k's were the chips which
 > > needed the special:
 > > 
 > > 	cli();
 > > 	jump_into_64_bit_mode();
 > > 	{peek,poke}_magic_physaddr();
 > > 	leave_64_bit_mode();
 > > 	sti();
 > > 
 > > sequence, both to enable/disable the cache and to perform flush
 > > operations.  Although this could have been for the R4600.  I do
 > 
 > Afaik it's for both CPUs.

     It applies to the secondary cache on the Indy R4600SC and R5000SC
and the Indigo2 R4600SC, but not to any other systems or processors.

     For primary caches, the set is selected by the high order bit of
the cache index (virtual address bit 13 on the R4600, virtual
address bit 14 on the R5000).  (Note that the R10000 is different: it
uses the low order address bit to select the set.)  

 > > remember that IRIX had special code to work the R5k caches, but this
 > > might have been for the L2 cache operations only, not L1.
 > > 
 > > All of this was very SGI specific and was mostly for the L2 cache
 > > operations.  I think the R5k had a special "flush command" which would
 > > just pull a pin going to the cache and invalidate all the lines in one
 > > cycle (earle told me this, he may be able to elaborate).
 >
 > It's the L2 enable bit for the "true", means CPU controlled L2 cache
 > of the R5000.  The fact that we're dealing with two different types
 > of L2 caches for the R5000 complicates things slightly.  By design
 > the R5000 supports an external cache.  What SGI did was more or less
 > just ignoring that feature and using the R5000 as a R4600 replacement.
 > That's why they're using an external cache which is controlled by
 > the chipset.

       Yes, that is correct for hte Indy, but the O2 R5000SC does
use the real R5000 secondary cache.  The L2 enable bit is set on O2
R5000SC and is not set on the Indy.

 > > The R5k, by design at least in the SGI boxes, lacks a L2 cache, it was
 > > added externally on the SGI motherboard's, and thus all the funcy
 > > methods to access/enable/disable/flush it...  Again, I could be
 > > confusing r4600 and r5k here, so who knows.
 >
 > Well, your memory serves right.  However my problem are especially
 > the primary caches (I've got not box with a "true" R5000 L2 cache), so
 > that doesn't solve my problem.  As far as I can tell your R4600 code seems
 > to work for the R5000 Indy with the "fake" cache.  I suspect that the
 > problem handling the L1 caches was causing the disk corruption I observed
 > on my Indy while on this Nevada box I'm using here SCSI works as realiable
 > as it is supposed to be.
...

      If you were using the index bits incorrectly, that would cause
disk corruption, and, as noted above, the set selection bit differs,
due to the size of the cache.  Basically, if the size of the cache is
X, then (X >> 1) is the set selection bit.  The R4600SC secondary
cache code should apply equally to the Indy R5000SC, without change.
