Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id KAA261582 for <linux-archive@neteng.engr.sgi.com>; Thu, 23 Oct 1997 10:24:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA08604 for linux-list; Thu, 23 Oct 1997 10:21:44 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA08590; Thu, 23 Oct 1997 10:21:42 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA10794; Thu, 23 Oct 1997 10:21:41 -0700
Date: Thu, 23 Oct 1997 10:21:41 -0700
Message-Id: <199710231721.KAA10794@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Magnum 4000 caches
In-Reply-To: <199710231706.TAA24158@informatik.uni-koblenz.de>
References: <199710231706.TAA24158@informatik.uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > Hi,
 > 
 > maybe one of the old Mips people can answer me two questions:
 > 
 >  - why do the Magnum 4000PC instruction and data caches have a different
 >    linesize for the L1 caches, but the Magnum 4000SC not?

     It turned out that, at least for some workloads, the 4000PC
worked better that way.  (If I remember correctly, a 32-byte linesize
is better for the icache, since a 4-instruction basic block is
unusual.)  However, not all boxes use the same linesize values,
because there were hardware bugs with at least some of the memory
controllers which were affected by the choice of linesize.  I don't
remember the details anymore, although I might find them in my mail
archivies.  I have a 4000PC system (32-byte I, 16-byte D, MCT version 3)
and two 4000SC systems (16-byte I, D, and S, MCT version 2) still online.
I think that MCT version 2 would not support a 32-byte line.
 
 >  - does the Magnum 4000SC use a split instruction/data L2 cache?

     No, it has a unified writeback L2 cache.
