Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA2831405 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Apr 1998 13:28:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id NAA7473937
	for linux-list;
	Fri, 3 Apr 1998 13:28:16 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA7500315;
	Fri, 3 Apr 1998 13:28:12 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA18238; Fri, 3 Apr 1998 13:28:00 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-16.uni-koblenz.de [141.26.249.16])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id XAA29779;
	Fri, 3 Apr 1998 23:27:55 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id XAA05313;
	Fri, 3 Apr 1998 23:27:42 +0200
Message-ID: <19980403232741.05512@uni-koblenz.de>
Date: Fri, 3 Apr 1998 23:27:41 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com, linux-kernel@vger.rutgers.edu
Subject: Re: VCE exceptions
References: <19980402225314.63238@uni-koblenz.de> <199804022141.NAA01565@fir.engr.sgi.com> <19980403003623.50122@uni-koblenz.de> <199804022315.PAA01986@fir.engr.sgi.com> <19980403135245.23593@uni-koblenz.de> <199804031911.LAA21028@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199804031911.LAA21028@fir.engr.sgi.com>; from William J. Earl on Fri, Apr 03, 1998 at 11:11:15AM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Cc this to linux-kernel so this reaches the other Linux-vm people and
porters as well.  Maybe someone of them already has a way of dealing with
virtual aliases in virtual indexed caches.

On Fri, Apr 03, 1998 at 11:11:15AM -0800, William J. Earl wrote:

>  > The VCE bug is actually worse than I thought before.  I was in the assumption
>  > that we'd handle all cases were VC might hit us because the MIPS ABI takes
>  > care of by it's restrictions of the virtual addresses for mmaping.  Well,
>  > I was wrong.  Writing via write(2) to a file that is also mmap(2)ed may
>  > result in virtual coherency problems.
>  > 
>  > Another problem is that under Linux one cannot simply allocate a page of
>  > a desired colour - which would of course be the prefered solution.  Luckily
>  > a vce exceptionhandler will not run into the problem under Linux.

In the meantime I've got a draft of the a handler available.

>  > A small test program for the mmap/write problem attached.  If may be
>  > necessary to start it several times in order to make it print the ``Big
>  > trouble, man ...'' message.
> 
>      As soon as I get a chance, I will look at the relevant linux
> code.  Note that physical color allocation can also make a big
> performance difference on direct mapped secondary caches, as on all of
> the Indy processors with secondary caches.

Mark Hemment and David Miller had a page coloring scheme implemented.  I
think he dumped it again for whatever reasons.  Whatever, given the problems
with cache aliasing as result of not having proper cache coloring the code
needs to be resurrected.

>  That is, you want to
> maximize the likelihood that the secondary cache indexes of the
> physical pages in a given application will be uniformly distributed
> across the secondary cache.  Excessive hot spots will lead to
> dramatically lower performance.  Allocation of a page where physical
> color matches intented virtual color matters only if you need
> to use a K0SEG address for the page to avoid TLB misses (as in 
> the general exception handler, unless the K2SEG address is wired).
> 
>      For the mmap/write problem, what I did in IRIX was to first try
> to assign mmap() virtual colors and buffer cache virtual colors
> (colors of the K2SEG address for the page, not necessarily physical
> color of the page, although having the physical color match means that
> a cheaper K0SEG reference can be used) congruent to the virtual color
> of the file offset for that page.  Then write() will see the same
> virtual color when accessing the page as will the user program when
> accessing the page using an address created using mmap().  When
> MAP_FIXED and MAP_SHARED are set, however, and the specified virtual
> color for the mapping is not congruent to the specified file offset,
> an extra mechanism is required, namely software ownership switching of
> the "current" virtual color.  For the page frame, we remember the
> current virtual color, and arrange that the pg_vr bit is set only for
> mappings which match that virtual color.  If we get a fault on a
> mapping of a different color, we writeback-invalidate the primary
> caches for the "current" color, invalidate the "current" mappings (by
> turning off pg_vr), record the new "current" color, and then validate
> the new "current" mappings (by turning on pg_vr).  In IRIX 6.3 and
> later versions, I also allow the possibility of a "shared read
> multiple color" state, where all mappings were allowed to be valid,
> but with pg_m off.  That is, the "current" color became a
> multiple-reader/single-writer lock on access to the page (where the
> "single-writer" was a color equivalence class, not a single mapping).
> In this case, the transition from "multiple-reader" mode to
> "single-writer" mode requires invalidating all colors of the primary
> cache for the given page.  Note that for MAP_FIXED with MAP_PRIVATE,
> we can simply copy the page, even when it has not yet been modified,
> if the mapped virtual color is not congruent to the file offset
> virtual color.
> 
>     In IRIX, we handle the instruction cache specially, and do not
> attempt to keep it coherent on the processors without hardware VCE
> detection, so the above description is a little more restrictive than
> what actually happens.  This approach is based on updates to instruction
> pages being relatively rare, compared to updates to other pages,
> so we wind up doing fewer I cache invalidates overall.

I *think* the VCEI case never happens under Linux, at least not until an
application does something _really_ stupid.  What an apps would need to
do is something opening a mapping with PROT_EXEC|PROT_WRITE|PROT_READ
and attempt to modify it by write(2) to it.  I don't think this ever
happens in real live.

Anyway, we have to deal with the problem and I'm going to hope the people
that actually have machines with SC/MC CPUs were the hardware detects the
problem for us will help me by running test kernels.

  Ralf
