Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id VAA368585 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Sep 1997 21:29:21 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id VAA06982 for linux-list; Wed, 10 Sep 1997 21:28:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id VAA06973 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Sep 1997 21:28:34 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id VAA11604
	for <linux@cthulhu.engr.sgi.com>; Wed, 10 Sep 1997 21:28:28 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from grass (ralf@grass.uni-koblenz.de [141.26.4.65]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id GAA12438; Thu, 11 Sep 1997 06:28:22 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199709110428.GAA12438@informatik.uni-koblenz.de>
Received: by grass (SMI-8.6/KO-2.0)
	id GAA11544; Thu, 11 Sep 1997 06:28:17 +0200
Subject: Re: R5000 caches
To: davem@jenolan.rutgers.edu (David S. Miller)
Date: Thu, 11 Sep 1997 06:28:17 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199709110409.AAA14641@jenolan.rutgers.edu> from "David S. Miller" at Sep 11, 97 00:09:23 am
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> In SGI boxes, if my memory serves, the R5k's were the chips which
> needed the special:
> 
> 	cli();
> 	jump_into_64_bit_mode();
> 	{peek,poke}_magic_physaddr();
> 	leave_64_bit_mode();
> 	sti();
> 
> sequence, both to enable/disable the cache and to perform flush
> operations.  Although this could have been for the R4600.  I do

Afaik it's for both CPUs.

> remember that IRIX had special code to work the R5k caches, but this
> might have been for the L2 cache operations only, not L1.
> 
> All of this was very SGI specific and was mostly for the L2 cache
> operations.  I think the R5k had a special "flush command" which would
> just pull a pin going to the cache and invalidate all the lines in one
> cycle (earle told me this, he may be able to elaborate).

It's the L2 enable bit for the "true", means CPU controlled L2 cache
of the R5000.  The fact that we're dealing with two different types
of L2 caches for the R5000 complicates things slightly.  By design
the R5000 supports an external cache.  What SGI did was more or less
just ignoring that feature and using the R5000 as a R4600 replacement.
That's why they're using an external cache which is controlled by
the chipset.

> The R5k, by design at least in the SGI boxes, lacks a L2 cache, it was
> added externally on the SGI motherboard's, and thus all the funcy
> methods to access/enable/disable/flush it...  Again, I could be
> confusing r4600 and r5k here, so who knows.

Well, your memory serves right.  However my problem are especially
the primary caches (I've got not box with a "true" R5000 L2 cache), so
that doesn't solve my problem.  As far as I can tell your R4600 code seems
to work for the R5000 Indy with the "fake" cache.  I suspect that the
problem handling the L1 caches was causing the disk corruption I observed
on my Indy while on this Nevada box I'm using here SCSI works as realiable
as it is supposed to be.

Anyway, there is still enough fun to have.  I'm planning a little
lmbenchmania followed by a cycle-massacre and I'm just hacking
microsecond timers for that ...

  Ralf
