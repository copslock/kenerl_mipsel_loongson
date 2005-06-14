Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2005 18:21:52 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:58132 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225617AbVFNRVg>; Tue, 14 Jun 2005 18:21:36 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5EHInh1028589;
	Tue, 14 Jun 2005 18:18:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5EHInO8028588;
	Tue, 14 Jun 2005 18:18:49 +0100
Date:	Tue, 14 Jun 2005 18:18:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	madprops@gmx.net
Cc:	linux-mips@linux-mips.org
Subject: Re: tlb magic
Message-ID: <20050614171848.GF5183@linux-mips.org>
References: <17069.62407.584863.185198@mips.com> <18788.1118764826@www21.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18788.1118764826@www21.gmx.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 14, 2005 at 06:00:26PM +0200, madprops@gmx.net wrote:

> yes, I'm reading "See MIPS Run". So thanks for the online support that comes
> with it. Now, if I got it correctly, the exception routing described in
> section 6.7 uses per-process mappings for kseg2, i.e. that e.g. the first
> 2MB of (each) kseg2 are used  as page table of the corresponding process and
> maybe another few kb for process related stuff. Provided the page tables are
> continuously at the same address ( e.g. KSEG2_BASE ) a change of ASID in
> EntryHi would indeed make a change of the kseg2 pointer in Context
> unnecessary ( it always points to KSEG2_BASE ). The mapping of kseg2 would
> automatically change as the global bit is set to zero. 
> 
> Using the standard page table approach I would now need an additional page
> table for each process in order to map those 2+x MB in kseg2 which I could
> put in kseg0/1 or in kseg2 with 'wired' TLB entries.
> 
> If that's the way to go - why is it only used in early BSD ports of like
> 1987 ? Are there any troubles with it or have other mechanisms turned out to
> be better for any reason ?

I don't know the details of how it was used in BSD.  But this is how very
early Linux/MIPS kernels were doing it on R4000 class processors:

 - the entire 4MB of pagetables are mapped into KSEG2 at 0xe4000000
 - Linux likes to think of pagetables as 2-level trees (simplifying
   things a little here).
 - So at 4kB pagesize and 4 byte entries for each page the root of the tree
   will end up at

    root = (base + (base >> (12 - 2))

   where base is 0xe4000000; 12 the log2 of the pagesize and 2 the log2 of 4.
   So root compute to 0xe4390000.

Now let's see how we handle a pagefault in this scheme:

 - we take an exception and go to the reload handler at 0x80000000.
 - The CPU tries to help us [1] by with the value in the context register
   which with a little munging (see [1]) we use to index the 4MB of
   pagetables and load the right pagetable entry, then eret.  That's the
   fast path.

Now for the slow path.  We enter it if indexing the mapped pagetable
array at 0xe4000000 results in a TLB miss exception.  But we're already
in a TLB exception handler running with the EXL flag in the status
register set:

 - we jump to 0x80000180
 - we see it's a TLB exception, so branch to the TLB exception handler
 - The TLB exception handler figures out what kind of work it has to do.
   I only cover the TLB reload case here.
 - By now we know it must have been an access to the pagetable mapping
   that has failed.
 - We start all over by first indexing the 4kB of the root at 0xe439000
   with the upper 10 bits of the virtual address and loading the entry
   found there into the TLB.
   At this point we can guarantee that if we resume execution will take
   an exception again but we'll only use the fast path part of the handlers.

So I guess by this point you're asking why this magic address for the
TLB root.  As mentioned previously Linux consideres pagetables a two
level tree and the root of that tree (the first level) data structure
happens to be suitable as the pagetable to map the 4MB of second level
data.

So on a context switch all that's needed is swapping the content of this
one wired entry holding the root pointer and ASID and voilla, we've
magically changed the mappings for the entire 4MB of pagetables.

I eventually removed that code because it was resulting in cache aliases
and felt that fixing them would eleminate the performance advantage of this
relativly complicated scheme.  It certainly was too funky for an early
stage OS and we may reconsider.

  Ralf

[1] but doesn't really succeed because for 4-byte pagetable entries the
    values in the context and xcontext registers are not formed the way we'd
    prefer them ...
