Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA1194245 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Dec 1997 10:16:30 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA03843 for linux-list; Fri, 12 Dec 1997 10:11:09 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA03725; Fri, 12 Dec 1997 10:10:54 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA21606; Fri, 12 Dec 1997 10:10:49 -0800
Date: Fri, 12 Dec 1997 10:10:49 -0800
Message-Id: <199712121810.KAA21606@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: root <root@uni-koblenz.de>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: R4000SC/R4400SC crashes ...
In-Reply-To: <19971212102607.64599@lappi.waldorf-gmbh.de>
References: <19971212102607.64599@lappi.waldorf-gmbh.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

root@uni-koblenz.de writes:
 > Hi all,
 > 
 > I think I found the bug causing the reported R4000SC/R4400SC crashes.
 > In r4kcache.h some of the functions for handling the second level caches
 > were using the wrong cacheops.
 > 
 > I'm rewriting the thing; the file was producing a huge object file and
 > not able to handle primary instruction and data caches with different
 > linesize.  This was a problem with the Vr4300 and some Magnum 4000 and
 > the Olivetti M700 where reconfiguring the linesize of the primary cache
 > isn't advisable.
 > 
 > What I won't fix for now is the handling of split instruction and data
 > second level caches a la R4000SC.  I don't know of any system using
 > something like this.
...

     I don't know about other vendors, but all MIPS and SGI systems had
unified secondary caches.  It is indeed the case that reconfiguruing
the linesize on the MIPS Magnum systems is not advisable, at least on
the older revisions of the memory controller.  (Various combinations mostly
worked, but only some worked all the time.)  As far as I know, all systems
shipped were correctly configured.
