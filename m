Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id BAA1174708 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Dec 1997 01:31:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA28697 for linux-list; Fri, 12 Dec 1997 01:30:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA28680 for <linux@engr.sgi.com>; Fri, 12 Dec 1997 01:29:55 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id BAA28549
	for <linux@engr.sgi.com>; Fri, 12 Dec 1997 01:29:54 -0800
	env-from (root@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-22.uni-koblenz.de [141.26.249.22])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id KAA07116
	for <linux@engr.sgi.com>; Fri, 12 Dec 1997 10:29:23 +0100 (MET)
Received: (from root@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id KAA04215;
	Fri, 12 Dec 1997 10:26:07 +0100
Message-ID: <19971212102607.64599@lappi.waldorf-gmbh.de>
Date: Fri, 12 Dec 1997 10:26:07 +0100
From: root <root@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: R4000SC/R4400SC crashes ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I think I found the bug causing the reported R4000SC/R4400SC crashes.
In r4kcache.h some of the functions for handling the second level caches
were using the wrong cacheops.

I'm rewriting the thing; the file was producing a huge object file and
not able to handle primary instruction and data caches with different
linesize.  This was a problem with the Vr4300 and some Magnum 4000 and
the Olivetti M700 where reconfiguring the linesize of the primary cache
isn't advisable.

What I won't fix for now is the handling of split instruction and data
second level caches a la R4000SC.  I don't know of any system using
something like this.

  Ralf
