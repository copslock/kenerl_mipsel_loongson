Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id LAA271053 for <linux-archive@neteng.engr.sgi.com>; Thu, 23 Oct 1997 11:10:58 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA26322 for linux-list; Thu, 23 Oct 1997 11:08:35 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA26317; Thu, 23 Oct 1997 11:08:33 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA11992; Thu, 23 Oct 1997 11:08:31 -0700
Date: Thu, 23 Oct 1997 11:08:31 -0700
Message-Id: <199710231808.LAA11992@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Magnum 4000 caches
In-Reply-To: <199710231757.TAA25739@informatik.uni-koblenz.de>
References: <199710231721.KAA10794@fir.engr.sgi.com>
	<199710231757.TAA25739@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > >      It turned out that, at least for some workloads, the 4000PC
 > > worked better that way.  (If I remember correctly, a 32-byte linesize
 > > is better for the icache, since a 4-instruction basic block is
 > > unusual.)  However, not all boxes use the same linesize values,
 > > because there were hardware bugs with at least some of the memory
 > > controllers which were affected by the choice of linesize.  I don't
 > > remember the details anymore, although I might find them in my mail
 > > archivies.  I have a 4000PC system (32-byte I, 16-byte D, MCT version 3)
 > > and two 4000SC systems (16-byte I, D, and S, MCT version 2) still online.
 > > I think that MCT version 2 would not support a 32-byte line.
 > 
 > So as the easy solution, as I understand things we should be safe by
 > just leaving the linesize as the firmware chooses them for us Magnums?  
 > I actually intended to experiment with the linesize on R4k but as
 > things look now this isn't a good thing.

     Yes, I think you should leave the linesize alone, at least on
the MCT version 2.  You could try alternate linesize values on the MCT
version 3.  The cache control code should use the linesize values from
$config.  By the way, I have found that it is generally faster on the R4000 (and
especially on later processors) to compute such values from $config each
time than to load them from variables in memory.  The amortized cost
of the extra cache misses can easily outweigh the extra instructions needed
to recompute the value (since the latter are really very few, if you
code the sequence cleverly in assembly language).  Similarly, if you need
to test for processor type, it is usually faster to fetch and decode
$prid than to use a variable in memory.

 > Btw, seems we'll get an interesting new target for Linux.  It's currently
 > ftp.uni-erlangen.de and one of the admins who might do the job, a Linux/68k
 > hacker told me it's a 3 x R6000 box with 256mb of RAM currently running
 > ES/IX something like that ...

       The R6000 is a real challenge.  It is substantially different
from the R3000 and R4000.  In particular, it uses part of the cache
as a sort of second level TLB.  ES/IX is the CDC version of MP RISC/os.
(MIPS worked on MP RISC/os, but never shipped it to customers; CDC took
it over as a product.)  The I/O is fairly straightforward, being mostly
VME devices, but it does include I/O address mapping hardware which must
be configured.
