Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id LAA275868 for <linux-archive@neteng.engr.sgi.com>; Thu, 23 Oct 1997 11:27:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA03565 for linux-list; Thu, 23 Oct 1997 11:25:30 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA03509; Thu, 23 Oct 1997 11:25:20 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA13635; Thu, 23 Oct 1997 11:25:18 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from ozzy.uni-koblenz.de (946@ozzy.uni-koblenz.de [141.26.5.8]) by informatik.uni-koblenz.de (8.8.7/8.6.9) with ESMTP id UAA26628; Thu, 23 Oct 1997 20:25:16 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199710231825.UAA26628@informatik.uni-koblenz.de>
Received: by ozzy.uni-koblenz.de (8.8.5/KO-2.0)
	id UAA03797; Thu, 23 Oct 1997 20:23:38 +0200
Subject: Re: Magnum 4000 caches
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Thu, 23 Oct 1997 20:23:38 +0200 (MEST)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-Reply-To: <199710231808.LAA11992@fir.engr.sgi.com> from "William J. Earl" at Oct 23, 97 11:08:31 am
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>      Yes, I think you should leave the linesize alone, at least on
> the MCT version 2.  You could try alternate linesize values on the MCT
> version 3.  The cache control code should use the linesize values from
> $config.  By the way, I have found that it is generally faster on the R4000 (and
> especially on later processors) to compute such values from $config each
> time than to load them from variables in memory.  The amortized cost
> of the extra cache misses can easily outweigh the extra instructions needed
> to recompute the value (since the latter are really very few, if you
> code the sequence cleverly in assembly language).  Similarly, if you need
> to test for processor type, it is usually faster to fetch and decode
> $prid than to use a variable in memory.

Indeed, Linux could need a little polish in that respect ...

>        The R6000 is a real challenge.  It is substantially different
> from the R3000 and R4000.  In particular, it uses part of the cache
> as a sort of second level TLB.  ES/IX is the CDC version of MP RISC/os.
> (MIPS worked on MP RISC/os, but never shipped it to customers; CDC took
> it over as a product.)  The I/O is fairly straightforward, being mostly
> VME devices, but it does include I/O address mapping hardware which must
> be configured.

Is the information in newer releases of Kane's MIPS bible sufficient to
do the R6000 part of the job?  I guess the company (BIT ???) that made the
R6000 is no longer around, so it would make sense if Roman'd ask them
for a manual ...

  Ralf
