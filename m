Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA535243 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Sep 1997 18:35:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA23588 for linux-list; Thu, 11 Sep 1997 18:34:59 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA23573; Thu, 11 Sep 1997 18:34:56 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA10912; Thu, 11 Sep 1997 18:34:54 -0700
Date: Thu, 11 Sep 1997 18:34:54 -0700
Message-Id: <199709120134.SAA10912@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Cc: davem@jenolan.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: Re: R5000 caches
In-Reply-To: <199709120122.DAA12959@informatik.uni-koblenz.de>
References: <199709120102.SAA10756@fir.engr.sgi.com>
	<199709120122.DAA12959@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
...
 > >       If you were using the index bits incorrectly, that would cause
 > > disk corruption, and, as noted above, the set selection bit differs,
 > > due to the size of the cache.  Basically, if the size of the cache is
 > > X, then (X >> 1) is the set selection bit.  The R4600SC secondary
 > > cache code should apply equally to the Indy R5000SC, without change.
 > 
 > Ok, thanks for the information.  It's what I was expecting.  In that
 > case the version which I'm just about to check in is still not R5000
 > safe.  I'm going to fix that rsn.
 > 
 > Quickfix for R5000 hackers: change the #define for waybit in
 > arch/mips/mm/r4xx0.c from 0x2000 to (dcache_size >> 1).

      By the way, in case you are not familiar with the problem, watch
out for the R4600 errata in regard to index invalidate.  Basically,
you need to disable interrupts while using the index invalidate
and index writeback invalidate instructions on R4600 Rev. 1.7, so that
invalidating a given line in one set is atomic with invalidating
the corresponding line in the second set.  You can turn on interrupts
periodically, but it is important to do both sets for a given index
at the same time, without the possibility of an interrupt or exception.
The errata can result in the same line winding up in both sets,
leading to stale data.  The bug is not present in the R4600 Rev. 2.0
or the R5000.
