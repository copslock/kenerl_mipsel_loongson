Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA773151 for <linux-archive@neteng.engr.sgi.com>; Mon, 18 May 1998 09:29:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA35613
	for linux-list;
	Mon, 18 May 1998 09:27:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA39332;
	Mon, 18 May 1998 09:27:21 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA20630; Mon, 18 May 1998 09:26:25 -0700
Date: Mon, 18 May 1998 09:26:25 -0700
Message-Id: <199805181626.JAA20630@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr
Subject: Re: VCE question
In-Reply-To: <19980518133553.34099@uni-koblenz.de>
References: <19980518133553.34099@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > I don't have a machine with a SC CPU, so I hopbe somebody of you can
 > help me -- the manuals of the R4000 / R4400 documents that the L2 cache
 > is tagged with bits 12-14 of the virtual address.  This is somewhat
 > strange because only cache-size / 4kb bits are required to avoid virtual
 > aliases.  That would be 1 bit for the R4000SC and 2 bits for the R4400SC.
 > 
 > Question: will the R4000SC/R4400SC actually verify 3 bits or only the
 > one rsp. two bits which need to be checked?

     Yes, they verify all 3 bits.  You can have a VCE handler, even for
kernel stacks, if you are very careful in the general exception handler.
(The VCE handler does writeback invalidate on the primary data cache and
an invalidate on the primary instruction cache for the offending address,
and then does a hit-set-virtual on the secondary cache; alternately, somewhat
more slowly, but more simply, the handler does a writeback invalidate on the
secondary cache.)  Of course, you still have to arrange to have only
one virtual color valid at a time for a given physical page to make
the R4000PC, R4600, and R5000 work correctly.  On the other hand, if you
can arrange that, including flushing the cache appropriately when changing
the current virtual color of a physical page, you will never get a VCE
(assuming you treat the R4000SC and R4400SC has having 8 colors, not 2 or
4).  

     On the other processors, where VCE is not detected, you can
further optimize the code by allowing for multiple virtual colors for
read-only pages, invalidating all conflicting mappings when a
read-write mapping is required.  IRIX does this in 6.3 and 6.5.  We
don't break the mappings; we just turn off pg_vr in the PTEs.  When we
get a fault on one of the software-valid, hardware-invalid mappings,
we do an ownership switch, turning off the mappings for the current
color and changing the current color to the desired one.  This of
course requires appropriate cache cleaning for the whole page.
By comparison, the R4000SC/R4400SC VCE handler works just one cache
line at a time.
