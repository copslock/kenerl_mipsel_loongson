Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id LAA278056 for <linux-archive@neteng.engr.sgi.com>; Thu, 23 Oct 1997 11:49:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA13182 for linux-list; Thu, 23 Oct 1997 11:47:53 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA13144; Thu, 23 Oct 1997 11:47:44 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA12820; Thu, 23 Oct 1997 11:47:43 -0700
Date: Thu, 23 Oct 1997 11:47:43 -0700
Message-Id: <199710231847.LAA12820@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Magnum 4000 caches
In-Reply-To: <199710231825.UAA26628@informatik.uni-koblenz.de>
References: <199710231808.LAA11992@fir.engr.sgi.com>
	<199710231825.UAA26628@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
...
 > >        The R6000 is a real challenge.  It is substantially different
 > > from the R3000 and R4000.  In particular, it uses part of the cache
 > > as a sort of second level TLB.  ES/IX is the CDC version of MP RISC/os.
 > > (MIPS worked on MP RISC/os, but never shipped it to customers; CDC took
 > > it over as a product.)  The I/O is fairly straightforward, being mostly
 > > VME devices, but it does include I/O address mapping hardware which must
 > > be configured.
 > 
 > Is the information in newer releases of Kane's MIPS bible sufficient to
 > do the R6000 part of the job?  I guess the company (BIT ???) that made the
 > R6000 is no longer around, so it would make sense if Roman'd ask them
 > for a manual ...

     BIT made the parts originally, but we later got the parts from NEC.
The latter were faster, more reliable, and much cheaper.  CDC might still
provide the manuals.  As far as I know, the R6000 is not well documented
in the regular MIPS documentation.  I might, however, be able to get you
some information about processor issues.
