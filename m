Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA06103
	for <pstadt@stud.fh-heilbronn.de>; Sat, 3 Jul 1999 00:54:33 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA4282470; Fri, 2 Jul 1999 15:49:38 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA29553
	for linux-list;
	Fri, 2 Jul 1999 15:43:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA75527;
	Fri, 2 Jul 1999 15:43:05 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04011; Fri, 2 Jul 1999 15:43:02 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA02592;
	Sat, 3 Jul 1999 00:42:53 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA09729;
	Sat, 3 Jul 1999 00:41:25 +0200
Date: Sat, 3 Jul 1999 00:41:25 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: Ulf Carlsson <ulfc@thepuffingroup.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Memory corruption
Message-ID: <19990703004125.A9423@uni-koblenz.de>
References: <19990622033931.A7201@thepuffingroup.com> <199906300101.SAA09334@fir.engr.sgi.com> <19990630044702.A6969@thepuffingroup.com> <199906302201.PAA29334@fir.engr.sgi.com> <19990701022357.D30652@uni-koblenz.de> <199907010053.RAA00061@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <199907010053.RAA00061@fir.engr.sgi.com>; from William J. Earl on Wed, Jun 30, 1999 at 05:53:58PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 30, 1999 at 05:53:58PM -0700, William J. Earl wrote:

>      Suppose physical page X has been used as logical page 100 of executable
> file ABC, and is then freed, but is still partially in the icache at 
> virtual index 0.  Then suppose the page X is reused as logical page 200 of
> executable DEF, at virtual index 0.  The writeback of the data cache is
> good, but there are still cache lines from file ABC in the icache.  If
> nothing flushes the icache (and there is no reason to flush the icache
> when reusing a page for data), the icache will have stale data with respect
> to the new identity of page X as logical page 200 of executable DEF.

Ok, yes that can happen in theory if code has been executed in a page
which was not marked PROT_EXEC but execed though.  Fixing that makes things
quite a bit slower, we'll have to flush the icache on every flush_cache_page.
flush_cache_range() already does this.

Hmm...  Maybe a my-software-behaves-properly-and-I-know-this-is-dangerous-
sysctl() which restablishes the current i-cache flushing behaviour if
VM_EXEC is unset?

I herewith order an execution protection bit for the next generation MIPS
and while we're at it an integer add with carry for faster IP checksums.

> The icache issue applies to all processors.  The dcache issue applies only
> to the R4000PC, R4600, and R5000.

And R41xx, R42xx, R43xx, R4700, Nevada, Kronus, Sony Playstation II CPU ...

>  > Flushing the caches for pages which are being unmapped is done by
>  > flush_cach_page and takes care of the VM_EXEC flag.
>  > 
>  > On exec, fork or exit we flush the entire cache so that problems shouldn't
>  > hit us either.
>
> It is not clear this works as expected if the page is stolen by vmscan.

The thing is that as I already mentioned above a page might be in the
icache even though it isn't marked as VM_EXEC.

>  > Actually we're pretty generous with our cacheflushed, we flush more
>  > than we should.
>
> Yes, but it is not clear that all paths are covered.
>
>  > > Also, the flush_page_to_ram() slows down processing on
>  > > machines which physical cache tags, for cases where the virtual
>  > > index used by the kernel and the virtual index used by the application
>  > > are the same.  It should have an extra argument of the intended user
>  > > virtual address, so that it can decide whether to flush or not on
>  > > architectures such as MIPS.
>  > 
>  > For R3000 and R6000 flush_page_to_ram() is a no-op, see
>  >  arch/mips/mm/r2300.c and arch/mips/mm/r6000.c.
>
> Yes, since those have write-through caches.

The cache write policy doesn't matter in that case.

> The icache invalidation is still an issue, if there are any paths, such
> as try_to_swap_out(), which break a virtual-to-physical mapping without
> flushing the icache.

>  > For virtual indexed CPUs something like change_page_colour(oldvaddr,
>  > newvaddr) would usually do a more efficient job than always flushing the
>  > page to memory especially when combined with an allocator which takes the
>  > vaddr where the page will be mapped as a hint.
>
>       Right.  Also, for IRIX and RISCos, I had mmap prefer an mmap
> address for which color(address) == color(file_offset), so that
> applications not using MAP_FIXED would always map a given file page at
> the same virtual color, and I had the kernel use page_mapin() to make
> a page addressable, so that I could have page_mapin() create a KSEG2
> mapping of the appropriate color if it were different from the KSEG0
> color of the page (for cases where the allocator could not allocate a
> page with KSEG0 color to match the desired virtual color).
> page_mapin() would of course return the KSEG0 address if the KSEG0
> color matched the virtual color.  The color changing code is still
> neaded to deal with MAP_FIXED and so on, but it is much less
> performance-critical.

That will also deal efficiently with the way ld.so loads ELF binaries.

  Ralf
