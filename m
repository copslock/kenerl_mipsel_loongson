Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA26660 for <linux-archive@neteng.engr.sgi.com>; Tue, 29 Sep 1998 17:07:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA31767
	for linux-list;
	Tue, 29 Sep 1998 17:07:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA36694
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 29 Sep 1998 17:06:59 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA09048
	for <linux@cthulhu.engr.sgi.com>; Tue, 29 Sep 1998 17:06:57 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-01.uni-koblenz.de [141.26.249.1])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA18377
	for <linux@cthulhu.engr.sgi.com>; Wed, 30 Sep 1998 02:07:01 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA04081;
	Wed, 30 Sep 1998 01:58:21 +0200
Message-ID: <19980930015819.D3920@uni-koblenz.de>
Date: Wed, 30 Sep 1998 01:58:19 +0200
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: VCEI/VCED handling
References: <19980929011414.43485@alpha.franken.de> <19980929015003.E2215@uni-koblenz.de> <19980929232455.30571@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980929232455.30571@alpha.franken.de>; from Thomas Bogendoerfer on Tue, Sep 29, 1998 at 11:24:55PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 29, 1998 at 11:24:55PM +0200, Thomas Bogendoerfer wrote:

> On Tue, Sep 29, 1998 at 01:50:03AM +0200, ralf@uni-koblenz.de wrote:
> > We've got code of which we're shure that it is correct.  Nevertheless
> > Linux ist still fragile on SC machines.  I've been tracking this in
> > private emails with Ulf but so far only with limited success.  Aside of
> > the missing VCED / VCEI handlers there must be something else that is
> > broken.
> 
> As I understand the problem now, I wrote the little test program below.
> If I'll try it on a R4600PC Indy or a R4000PC Olivetti with Linux, I don't
> get what I would expect. On IRIX, Linux/Alpha (I have to change the offset
> between the two mapping to 0x2000, because of the bigger page size on Alphas)
> and Linux/x86 the program works. IMHO this is a showstopper as we don't handle 
> cache aliases right.  

It's a known problem - and a nasty one.  Basically a good solution requires
a way to map a page's physical address to virtual addresses.  And Linux 2.2's
mm will not provide this feature.  Reverse mappings are under planning for
2.3 for other improvments.  It was my plan to ignore this bug for now and
deal with virtual coherency when reverse mappings are implemented in 2.3.

Oh, I've already implemented the solution for the special case of ZERO_PAGE.
On CPUs which know about the virtual coherency exception have eight colours
for zero page.  The change is basically to pass in the virtual address to
ZERO_PAGE such that we always do ``colourly correct'' allocation.  That was
the simple case.

> How does IRIX solve this problem ? Does it disable caching for shared 
> writeable pages ?

Mapping shared writeable pages uncached is not the solution.  The virtual
coherency problem in Linux/MIPS may happen between multiple userspace
mappings or userspace and kernelspace, that is KSEG0, mappings.  While
we could disable caching for certain pages in the hope that we'll only
end up with a few uncached pages making KSEG0 uncached is completly
unacceptable performancewise.  However, if we don't, then we might end up
with aliases between userspace pages and KSEG0 pages.

Here two postings from Wje recovered from my neverending mail archives:

> Date: Thu, 2 Apr 1998 15:15:03 -0800
> Message-Id: <199804022315.PAA01986@fir.engr.sgi.com>
> From: "William J. Earl" <wje@fir.engr.sgi.com>
> To: ralf@uni-koblenz.de
> Cc: "William J. Earl" <wje@fir.engr.sgi.com>, linux@cthulhu.engr.sgi.com
> Subject: Re: VCE exceptions
> 
> ralf@uni-koblenz.de writes:
>  > On Thu, Apr 02, 1998 at 01:41:02PM -0800, William J. Earl wrote:
>  > 
>  > >  > Another way to finally eleminate the virtual coherency problem from
>  > >  > KSEG0's landscape would be to actually use 8 pages as an array of
>  > >  > empty_zero_pages[], so we would be able to map one wherever we want
>  > >  > such that we never run into virtual coherency trouble.
>  > > 
>  > >       For an always-zero page, this is the best solution.  At a small
>  > > cost in memory, you get far less overhead.
>  > 
>  > Indeed, 16ns on a 250Mhz machine for every exception that goes via the
>  > general exception vector _plus_ the actual vce / vci handling, that sucks.
>  > I just wonder why those exceptions have been implemented at all?
>  > 
>  > They may help somewhat in debugging operating systems, but in our situation
>  > they're nervragging by their mere existance.
> 
> In the R10000, the hardware does the VCE correction.  On the R4000PC, R4600,
> and R5000, we have to avoid the problem in software, since the hardware
> does not detect conflicts.   The motivation, and the reason that IRIX
> depends on VCEs on the R4000 and R4400, was to make it easier to port
> R3000 operating systems to the R4000.  If you don't have infrastructure
> to control virtual aliasing (where a single page is mapped read-write at
> two distinct virtual addresses with differing primary cache virtual indexes),
> you get wrong answers with VCE (whether handled in software or hardware).
> At MIPS, with the Magnum 4000PC under RISC/os, and at SGI, with the
> Indy R4000PC (and later R4600 and R5000), I modified RISC/os and IRIX to
> control virtual aliasing, but only for those platforms without hardware
> VCE detection (in order to minimize time to market).  
> 
>     Note that taking a K0SEG address for a physical page which is also mapped
> to user space can easily cause a VCE, since there is a good chance that
> the K0SEG virtual index differs from the user space virtual index, unless
> you match physical page color to virtual page color when allocating pages.
> Note that you have to do that for any pages which must be accessible in
> the general exception handler, since you cannot handle a VCE in the
> exception handler.

> Date: Fri, 3 Apr 1998 11:11:15 -0800
> Message-Id: <199804031911.LAA21028@fir.engr.sgi.com>
> From: "William J. Earl" <wje@fir.engr.sgi.com>
> To: ralf@uni-koblenz.de
> Cc: linux@cthulhu.engr.sgi.com
> Subject: Re: VCE exceptions

[...]

>      Remember that there are two parts to the problem.  For the R4000SC and
> R4400SC, you can attack it by having the general exception handler avoid
> referencing any page which could get a VCE (probably by not using data in
> memory until after determining that the exception is a VCE exception) 
> and having the VCE exception handler, running in assembly code at SR_EXL
> level, fixup the cache (typically by doing hit-writeback-invalidate on
> the D cache, hit-invalidate on the I cache, and hit-set-virtual on
> the S cache, or else by doing hit-writeback-invalidate on the S-cache,
> which is simpler but slower, accounting for the multiple I and
> D cache entries per S cache entry).    For the other processors, the software
> has to avoid creating D cache aliases (mappings with different virtual
> indexes in the D cache) for writeable pages, to avoid data corruption
> via stale copies in the D cache.  Since there is no hardware detection
> of the aliases, the data corruption is silent.

[...]

>  > A small test program for the mmap/write problem attached.  If may be
>  > necessary to start it several times in order to make it print the ``Big
>  > trouble, man ...'' message.
> 
>      As soon as I get a chance, I will look at the relevant linux
> code.  Note that physical color allocation can also make a big
> performance difference on direct mapped secondary caches, as on all of
> the Indy processors with secondary caches.  That is, you want to
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

  Ralf
