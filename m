Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA23207
	for <pstadt@stud.fh-heilbronn.de>; Thu, 1 Jul 1999 02:57:43 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA4004419; Wed, 30 Jun 1999 17:56:32 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA44961
	for linux-list;
	Wed, 30 Jun 1999 17:54:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id RAA93669;
	Wed, 30 Jun 1999 17:53:59 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA00061; Wed, 30 Jun 1999 17:53:58 -0700
Date: Wed, 30 Jun 1999 17:53:58 -0700
Message-Id: <199907010053.RAA00061@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: "William J. Earl" <wje@fir.engr.sgi.com>,
        Ulf Carlsson <ulfc@thepuffingroup.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Memory corruption
In-Reply-To: <19990701022357.D30652@uni-koblenz.de>
References: <19990622033931.A7201@thepuffingroup.com>
	<199906300101.SAA09334@fir.engr.sgi.com>
	<19990630044702.A6969@thepuffingroup.com>
	<199906302201.PAA29334@fir.engr.sgi.com>
	<19990701022357.D30652@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
...
 > >      In particular, if process A mmaps a file page at virtual index
 > > 0 and process B happens to mmap the same file page at virtual index
 > > 1, they will in general corrupt each other's view of the data.
 > 
 > Oh, the common case is either shared r/o mappings or SysV SHM which per
 > ABI is 64kb aligned, so the hairy case doesn't hit us.  Usually ...
 > 
 > Especially I don't see why anything should corrupt executable pages
 > which are r/o mapped.

     Suppose physical page X has been used as logical page 100 of executable
file ABC, and is then freed, but is still partially in the icache at 
virtual index 0.  Then suppose the page X is reused as logical page 200 of
executable DEF, at virtual index 0.  The writeback of the data cache is
good, but there are still cache lines from file ABC in the icache.  If
nothing flushes the icache (and there is no reason to flush the icache
when reusing a page for data), the icache will have stale data with respect
to the new identity of page X as logical page 200 of executable DEF.

     Also, if there are incompatible aliases for a page, and there are
dirty lines left in the cache when the mapping for, say, virtual index
1 is released, and then the mapping for virtual index 0 is also released,
and the page, which has KSEG0 virtual index 0 is used for I/O, the normal
flushing will flush only virtual index 0.  A later victim writeback of
the dirty lines for virtual index 1 will overwrite the new data with
stale data, even if the new data is instructions.  This case can apply
even if the one alias is a kernel KSEG0 alias and the other is a 
user alias.  For regular file I/O, this is not a problem, but it is a problem
with mmap(), particularly since Linux mmap() makes no attempt to keep multiple
mappings of the same page of a file color-congruent.  (mmap() addresses
are essentially arbitrary.)  

     The icache issue applies to all processors.  The dcache issue applies only
to the R4000PC, R4600, and R5000.

 > >      There is a comment in memory.c that a non-present page shouldn't
 > > be cached, but it is not yet clear to me that this is guaranteed for
 > > the icache.
 > 
 > Flushing the caches for pages which are being unmapped is done by
 > flush_cach_page and takes care of the VM_EXEC flag.
 > 
 > On exec, fork or exit we flush the entire cache so that problems shouldn't
 > hit us either.

      It is not clear this works as expected if the page is stolen by
vmscan.

 > Actually we're pretty generous with our cacheflushed, we flush more than we
 > should.

     Yes, but it is not clear that all paths are covered.

 > > Also, the flush_page_to_ram() slows down processing on
 > > machines which physical cache tags, for cases where the virtual
 > > index used by the kernel and the virtual index used by the application
 > > are the same.  It should have an extra argument of the intended user virtual
 > > address, so that it can decide whether to flush or not on architectures
 > > such as MIPS.
 > 
 > For R3000 and R6000 flush_page_to_ram() is a no-op, see arch/mips/mm/r2300.c
 > and arch/mips/mm/r6000.c.

    Yes, since those have write-through caches.  The icache
invalidation is still an issue, if there are any paths, such as
try_to_swap_out(), which break a virtual-to-physical mapping without
flushing the icache.

 > For virtual indexed CPUs something like change_page_colour(oldvaddr, newvaddr)
 > would usually do a more efficient job than always flushing the page to
 > memory especially when combined with an allocator which takes the vaddr where
 > the page will be mapped as a hint.

      Right.  Also, for IRIX and RISCos, I had mmap prefer an mmap
address for which color(address) == color(file_offset), so that
applications not using MAP_FIXED would always map a given file page at
the same virtual color, and I had the kernel use page_mapin() to make
a page addressable, so that I could have page_mapin() create a KSEG2
mapping of the appropriate color if it were different from the KSEG0
color of the page (for cases where the allocator could not allocate a
page with KSEG0 color to match the desired virtual color).
page_mapin() would of course return the KSEG0 address if the KSEG0
color matched the virtual color.  The color changing code is still
neaded to deal with MAP_FIXED and so on, but it is much less
performance-critical.
