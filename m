Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA536140 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Sep 1997 18:58:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA29040 for linux-list; Thu, 11 Sep 1997 18:57:54 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA29018; Thu, 11 Sep 1997 18:57:51 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA11453; Thu, 11 Sep 1997 18:57:32 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from dahn (ralf@dahn.uni-koblenz.de [141.26.4.39]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id DAA16937; Fri, 12 Sep 1997 03:57:24 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199709120157.DAA16937@informatik.uni-koblenz.de>
Received: by dahn (SMI-8.6/KO-2.0)
	id DAA11230; Fri, 12 Sep 1997 03:57:21 +0200
Subject: Re: R5000 caches
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Fri, 12 Sep 1997 03:57:20 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, davem@jenolan.rutgers.edu,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <199709120134.SAA10912@fir.engr.sgi.com> from "William J. Earl" at Sep 11, 97 06:34:54 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>       By the way, in case you are not familiar with the problem, watch
> out for the R4600 errata in regard to index invalidate.  Basically,
> you need to disable interrupts while using the index invalidate
> and index writeback invalidate instructions on R4600 Rev. 1.7, so that
> invalidating a given line in one set is atomic with invalidating
> the corresponding line in the second set.  You can turn on interrupts
> periodically, but it is important to do both sets for a given index
> at the same time, without the possibility of an interrupt or exception.
> The errata can result in the same line winding up in both sets,
> leading to stale data.  The bug is not present in the R4600 Rev. 2.0
> or the R5000.

There is a more elegant solution for this bug.  Just leave the interrupts
as they are and invalidate set b before set a.  Anyway, Linux currently
still handles this erratum by disabling interrupts.

  Ralf
