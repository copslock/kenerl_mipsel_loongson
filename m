Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA22926
	for <pstadt@stud.fh-heilbronn.de>; Thu, 1 Jul 1999 00:08:37 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA4018869; Wed, 30 Jun 1999 15:06:28 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA83583
	for linux-list;
	Wed, 30 Jun 1999 15:01:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id PAA38895;
	Wed, 30 Jun 1999 15:01:27 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA29334; Wed, 30 Jun 1999 15:01:27 -0700
Date: Wed, 30 Jun 1999 15:01:27 -0700
Message-Id: <199906302201.PAA29334@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ulf Carlsson <ulfc@thepuffingroup.com>
Cc: linux@cthulhu.engr.sgi.com, ralf@uni-koblenz.de
Subject: Re: Memory corruption
In-Reply-To: <19990630044702.A6969@thepuffingroup.com>
References: <19990622033931.A7201@thepuffingroup.com>
	<199906300101.SAA09334@fir.engr.sgi.com>
	<19990630044702.A6969@thepuffingroup.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson writes:
...
 > Sometimes when this happens I think I only get a SIGSEGV or a SIGBUS, otherwise
 > I get internal compiler errors.  It's hard to say since these problems are very
 > hard to reproduce, and I forget what happens from time to time.  I have
 > unfortunately not written down the results.  It sounds like this may be the
 > cause of the type of file corruption I have when only a little part of the file
 > is damaged (sounds like the problem covers both icache and dcache).  That type
 > of file corruption goes away after reboot.  I haven't had a chance to try this
 > with my discard-disk-cache program since this happens very seldom..
 > 
 > >       What model of CPU do you have in your machine?
 > 
 > I have a 133 MHz R4600 with 512kb board cache, 16kb dcache and 16kb icache.

     I have been looking at the fault handling and the cache flushing routines
for the R4600.  In do_no_page() in mm/memory.c, we have:

	flush_page_to_ram(page);

I don't see where any code invalidates the icache, which might have
cached lines from a previous incarnation of the page.
flush_page_to_ram(), for the R4600, essentially does a writeback of
the dcache, if I understand the code correctly.  I believe that an
icache invalidate is also needed, at least for executable pages
(including any page for which mprotect() with PROT_EXEC has been
called, not just for text pages from an executable file).  Also,
unless something has changed, my understanding is that conflicting
virtual aliases (in the dcache) are still possible, which will also
lead to data corruption when it happens.

     In particular, if process A mmaps a file page at virtual index
0 and process B happens to mmap the same file page at virtual index
1, they will in general corrupt each other's view of the data.

     There is a comment in memory.c that a non-present page shouldn't
be cached, but it is not yet clear to me that this is guaranteed for
the icache.  Also, the flush_page_to_ram() slows down processing on
machines which physical cache tags, for cases where the virtual
index used by the kernel and the virtual index used by the application
are the same.  It should have an extra argument of the intended user virtual
address, so that it can decide whether to flush or not on architectures
such as MIPS.

    Handling the virtual index conflicts requires dynamic ownership
switching (including cache flushing), which means that we have to record
those hardware-valid PTEs currently referencing the page, so that we can
invalidate the PTEs and flush the cache when a fault happens for a mapping
of a different color.  We could take a brute-force approach, and record
just one mapping, forcing a fault on each use of a different message,
which would allow us to keep the reverse map in an array parallel to mem_map,
or we could use some more complex structure to record mappings.  Also,
to reduce the frequency of conflicts, address assignment in do_mmap()
should take cache color into account on machines with virtually indexed
caches which lack hardware cache coherency (such as the R4000PC, R4600,
and R5000).

    
