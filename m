Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA2832111 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Apr 1998 11:12:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id LAA5933027
	for linux-list;
	Fri, 3 Apr 1998 11:11:22 -0800 (PST)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA7467004
	for <linux@engr.sgi.com>;
	Fri, 3 Apr 1998 11:11:20 -0800 (PST)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id LAA21028; Fri, 3 Apr 1998 11:11:15 -0800
Date: Fri, 3 Apr 1998 11:11:15 -0800
Message-Id: <199804031911.LAA21028@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: VCE exceptions
In-Reply-To: <19980403135245.23593@uni-koblenz.de>
References: <19980402225314.63238@uni-koblenz.de>
	<199804022141.NAA01565@fir.engr.sgi.com>
	<19980403003623.50122@uni-koblenz.de>
	<199804022315.PAA01986@fir.engr.sgi.com>
	<19980403135245.23593@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > 
 > --PXFtsOsTdHNUZQcU
 > Content-Type: text/plain; charset=us-ascii
 > 
 > On Thu, Apr 02, 1998 at 03:15:03PM -0800, William J. Earl wrote:
 > 
 > > At MIPS, with the Magnum 4000PC under RISC/os, and at SGI, with the
 > > Indy R4000PC (and later R4600 and R5000), I modified RISC/os and IRIX to
 > > control virtual aliasing, but only for those platforms without hardware
 > > VCE detection (in order to minimize time to market).  
 > 
 > VCE's don't look too difficult to tackle under Linux.

     Remember that there are two parts to the problem.  For the R4000SC and
R4400SC, you can attack it by having the general exception handler avoid
referencing any page which could get a VCE (probably by not using data in
memory until after determining that the exception is a VCE exception) 
and having the VCE exception handler, running in assembly code at SR_EXL
level, fixup the cache (typically by doing hit-writeback-invalidate on
the D cache, hit-invalidate on the I cache, and hit-set-virtual on
the S cache, or else by doing hit-writeback-invalidate on the S-cache,
which is simpler but slower, accounting for the multiple I and
D cache entries per S cache entry).    For the other processors, the software
has to avoid creating D cache aliases (mappings with different virtual
indexes in the D cache) for writeable pages, to avoid data corruption
via stale copies in the D cache.  Since there is no hardware detection
of the aliases, the data corruption is silent.

 > >     Note that taking a K0SEG address for a physical page which is also mapped
 > > to user space can easily cause a VCE, since there is a good chance that
 > > the K0SEG virtual index differs from the user space virtual index, unless
 > > you match physical page color to virtual page color when allocating pages.
 > > Note that you have to do that for any pages which must be accessible in
 > > the general exception handler, since you cannot handle a VCE in the
 > > exception handler.
 > 
 > The VCE bug is actually worse than I thought before.  I was in the assumption
 > that we'd handle all cases were VC might hit us because the MIPS ABI takes
 > care of by it's restrictions of the virtual addresses for mmaping.  Well,
 > I was wrong.  Writing via write(2) to a file that is also mmap(2)ed may
 > result in virtual coherency problems.
 > 
 > Another problem is that under Linux one cannot simply allocate a page of
 > a desired colour - which would of course be the prefered solution.  Luckily
 > a vce exceptionhandler will not run into the problem under Linux.
 >
 > A small test program for the mmap/write problem attached.  If may be
 > necessary to start it several times in order to make it print the ``Big
 > trouble, man ...'' message.

     As soon as I get a chance, I will look at the relevant linux
code.  Note that physical color allocation can also make a big
performance difference on direct mapped secondary caches, as on all of
the Indy processors with secondary caches.  That is, you want to
maximize the likelihood that the secondary cache indexes of the
physical pages in a given application will be uniformly distributed
across the secondary cache.  Excessive hot spots will lead to
dramatically lower performance.  Allocation of a page where physical
color matches intented virtual color matters only if you need
to use a K0SEG address for the page to avoid TLB misses (as in 
the general exception handler, unless the K2SEG address is wired).

     For the mmap/write problem, what I did in IRIX was to first try
to assign mmap() virtual colors and buffer cache virtual colors
(colors of the K2SEG address for the page, not necessarily physical
color of the page, although having the physical color match means that
a cheaper K0SEG reference can be used) congruent to the virtual color
of the file offset for that page.  Then write() will see the same
virtual color when accessing the page as will the user program when
accessing the page using an address created using mmap().  When
MAP_FIXED and MAP_SHARED are set, however, and the specified virtual
color for the mapping is not congruent to the specified file offset,
an extra mechanism is required, namely software ownership switching of
the "current" virtual color.  For the page frame, we remember the
current virtual color, and arrange that the pg_vr bit is set only for
mappings which match that virtual color.  If we get a fault on a
mapping of a different color, we writeback-invalidate the primary
caches for the "current" color, invalidate the "current" mappings (by
turning off pg_vr), record the new "current" color, and then validate
the new "current" mappings (by turning on pg_vr).  In IRIX 6.3 and
later versions, I also allow the possibility of a "shared read
multiple color" state, where all mappings were allowed to be valid,
but with pg_m off.  That is, the "current" color became a
multiple-reader/single-writer lock on access to the page (where the
"single-writer" was a color equivalence class, not a single mapping).
In this case, the transition from "multiple-reader" mode to
"single-writer" mode requires invalidating all colors of the primary
cache for the given page.  Note that for MAP_FIXED with MAP_PRIVATE,
we can simply copy the page, even when it has not yet been modified,
if the mapped virtual color is not congruent to the file offset
virtual color.

    In IRIX, we handle the instruction cache specially, and do not
attempt to keep it coherent on the processors without hardware VCE
detection, so the above description is a little more restrictive than
what actually happens.  This approach is based on updates to instruction
pages being relatively rare, compared to updates to other pages,
so we wind up doing fewer I cache invalidates overall.
