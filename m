Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA531127 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Sep 1997 18:23:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA19776 for linux-list; Thu, 11 Sep 1997 18:22:32 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA19764; Thu, 11 Sep 1997 18:22:30 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA02566; Thu, 11 Sep 1997 18:22:24 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from dahn (ralf@dahn.uni-koblenz.de [141.26.4.39]) by informatik.uni-koblenz.de (8.8.6/8.6.9) with SMTP id DAA12959; Fri, 12 Sep 1997 03:22:19 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199709120122.DAA12959@informatik.uni-koblenz.de>
Received: by dahn (SMI-8.6/KO-2.0)
	id DAA08782; Fri, 12 Sep 1997 03:22:15 +0200
Subject: Re: R5000 caches
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Fri, 12 Sep 1997 03:22:15 +0200 (MET DST)
Cc: ralf@mailhost.uni-koblenz.de, davem@jenolan.rutgers.edu,
        linux@cthulhu.engr.sgi.com
In-Reply-To: <199709120102.SAA10756@fir.engr.sgi.com> from "William J. Earl" at Sep 11, 97 06:02:20 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

>      For primary caches, the set is selected by the high order bit of
> the cache index (virtual address bit 13 on the R4600, virtual
> address bit 14 on the R5000).  (Note that the R10000 is different: it
> uses the low order address bit to select the set.)  

Indeed, but currently our only R10k problem is that we don't support
that thing at all ...

>        Yes, that is correct for hte Indy, but the O2 R5000SC does
> use the real R5000 secondary cache.  The L2 enable bit is set on O2
> R5000SC and is not set on the Indy.

>       If you were using the index bits incorrectly, that would cause
> disk corruption, and, as noted above, the set selection bit differs,
> due to the size of the cache.  Basically, if the size of the cache is
> X, then (X >> 1) is the set selection bit.  The R4600SC secondary
> cache code should apply equally to the Indy R5000SC, without change.

Ok, thanks for the information.  It's what I was expecting.  In that
case the version which I'm just about to check in is still not R5000
safe.  I'm going to fix that rsn.

Quickfix for R5000 hackers: change the #define for waybit in
arch/mips/mm/r4xx0.c from 0x2000 to (dcache_size >> 1).

  Ralf
