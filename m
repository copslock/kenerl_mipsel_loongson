Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2003 08:32:45 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:14208 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225349AbTLOIco>; Mon, 15 Dec 2003 08:32:44 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1AVo9c-0000Ke-00; Mon, 15 Dec 2003 08:32:36 +0000
Date: Mon, 15 Dec 2003 08:32:36 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: Instability / caching problems on Qube 2 - solved ?
Message-ID: <20031215083236.GA1164@skeleton-jack>
References: <20031214162605.GA18357@skeleton-jack> <20031215022717.GA16560@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215022717.GA16560@linux-mips.org>
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 15, 2003 at 03:27:17AM +0100, Ralf Baechle wrote:
> On Sun, Dec 14, 2003 at 04:26:05PM +0000, Peter Horton wrote:
> 
> > When mapping an executable image into user space the kernel reads data
> > into the page cache and then maps the page into user space. For an
> > executable page no copy is done as the mapping is read only.
> 
> Correct.
> 
> The kernel may also share writable pages until they're actually written to.
> This is called copy-on-write (COW).  But executable pages usually aren't
> COW so this case isn't meaningful for us.
> 
> > On my Qube
> > the acting of reading data from the IDE via PIO causes the data to be
> > placed in the D-cache (the RM52xx cache does write allocate), but the
> > page never gets flushed to physical memory and so suffers from cache
> > aliasing problems when it's mapped into user space.
> > 
> > By enabling DMA on the IDE interface (it's off in the default Cobalt
> > config) the kernel suddenly becomes stable (the page in the page cache
> > never gets pulled into the D-cache).
> > 
> > This seems to be a generic kernel problem - all architectures with VI
> > caches and write allocate policies could trigger it.
> 
> Now that's where I'm getting some doubts about your explanation.  Assume
> we're paging in a page that isn't mapped yet:
> 
> In this case do_no_page() will load the page.  Any DMA cache coherency
> issues are supposed to be handled by the driver.  That means for an
> executable page all that's missing is ensuring the I-cache is coherent.
> This is done in these two lines:
> 
> [...]
>                 flush_page_to_ram(new_page);
>                 flush_icache_page(vma, new_page);
> [...]
>         update_mmu_cache(vma, address, entry);
> [...]
> 
>    flush_page_to_ram is (and must be!) a no-op.  So the burden is entirely
>    upto flush_icache_page and update_mmu_cache.  Note flush_dcache_page
>    never enters the picture when mapping an executable because the file has
>    not been written to.  So let's see flush_icache_page:
> 
> static void r4k_flush_icache_page(struct vm_area_struct *vma,
> 	struct page *page)
> {
> 	/*
> 	 * If there's no context yet, or the page isn't executable, no icache
> 	 * flush is needed.
> 	 */
> 	if (!(vma->vm_flags & VM_EXEC))
> 		return;
> 
> All this is only about I-cache coherence.  That is we do nothing at all if
> this isn't an executable page.
> 
> 	/*
> 	 * Tricky ...  Because we don't know the virtual address we've got the
> 	 * choice of either invalidating the entire primary and secondary
> 	 * caches or invalidating the secondary caches also.  With the subset
> 	 * enforcment on R4000SC, R4400SC, R10000 and R12000 invalidating the
> 	 * secondary cache will result in any entries in the primary caches
> 	 * also getting invalidated which hopefully is a bit more economical.
> 	 */
> 	if (cpu_has_subset_pcaches) {
> 		unsigned long addr = (unsigned long) page_address(page);
> 		r4k_blast_scache_page(addr);
> 
> 		return;
> 	}
> 
> This section is only needed for certain processors such as the R4000SC.
> That is it's not of interest here either.
> 
> 	if (!cpu_has_ic_fills_f_dc) {
> 		unsigned long addr = (unsigned long) page_address(page);
> 		r4k_blast_dcache_page(addr);
> 	}
> 
> But cpu_has_ic_fills_f_dc is always zero on Nevada.  Which means we're
> going to flush the page's kernel address from the D-cache here.
> 
> 	/*
> 	 * We're not sure of the virtual address(es) involved here, so
> 	 * we have to flush the entire I-cache.
> 	 */
> 	if (cpu_has_vtag_icache) {
> 		int cpu = smp_processor_id();
> 
> 		if (cpu_context(cpu, vma->vm_mm) != 0)
> 			drop_mmu_context(vma->vm_mm, cpu);
> 
> ... cpu_has_vtag_icache is zero on Nevada so the else case will be taken:
> 	} else
> 		r4k_blast_icache();
> 
> so we just blast away the entire I-cache.  Coherency the hard way.  At
> this point we've established I-cache coherency for executable pages.
> 
> But what this was a non-executable page?  Then flush_icache_page would do
> nothing at all - nor would update_mmu_cache.   The page will be copied to
> userspace and ...  whoops, data may still be in the wrong cache segment,
> game over.  This also explains a few other bugs.
> 

I could see the aliases at the end of do_no_page() (using memcmp()) and
from the code knew they had to be read only so I just assumed they were
executable pages. I missed the fact that flush_icache_page() flushed the
D-cache page. So like you say it must be non-executable read only pages
that cause the problem.

> > So where's the correct place to put the flush_dcache_page() ? :-)
> > 
> > I don't know whether the problem could affect any other IO subsystems
> > ... probably SCSI at least.
> 
> As you describe it it doesn't seem specific to any particular kind of
> device - only DMA or PIO matters; and the DMA coherency thing happens to
> paint over the issue which must be why it wasn't discovered for so long.
> 

So how do we fix it ? Flushing the page really needs to be done just
after the IO into the page cache is complete so we only do it once per
page cache page ?

P.
