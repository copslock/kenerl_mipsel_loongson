Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 22:51:10 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:42467 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009415AbaKMVvGfNy1n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 22:51:06 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1Xp2I7-0001PX-HA from Maciej_Rozycki@mentor.com ; Thu, 13 Nov 2014 13:50:59 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Thu, 13 Nov
 2014 21:50:58 +0000
Date:   Thu, 13 Nov 2014 21:50:54 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: copy_to_user_page: Avoid ptrace(2) I-cache
 incoherency
In-Reply-To: <20140321100727.GJ4365@linux-mips.org>
Message-ID: <alpine.DEB.1.10.1411132049590.2881@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1311071758410.21686@tp.orcam.me.uk> <20140321100727.GJ4365@linux-mips.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Fri, 21 Mar 2014, Ralf Baechle wrote:

> >  Please apply.  I've seen these SIGTRAPs in some NetLogic GDB testing and 
> > the removal of this cpu_has_ic_fills_f_dc condition from copy_to_user_page 
> > is really necessary; also the Au1200 document is very explicit about the 
> > requirement of I-cache invalidation in software (see Section 2.3.7.3 
> > "Instruction Cache Coherency").
> 
> You found a bug and yes, the fix you sent improves things a bit.  But
> there is also the cache on a cache coherent system where a page might
> be marked for a delayed cache flush with SetPageDcacheDirty(), then
> flushed by flush_cache_page() before eventually the delayed cacheflush
> flushes it once more for a good meassure.
> 
> What do you think about below patch to also deal with the duplicate flushing?
> 
>   Ralf
> 
>  arch/mips/mm/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 6b59617..80072ef 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -227,13 +227,13 @@ void copy_to_user_page(struct vm_area_struct *vma,
>  		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
>  		memcpy(vto, src, len);
>  		kunmap_coherent();
> +		if (vma->vm_flags & VM_EXEC)
> +			flush_cache_page(vma, vaddr, page_to_pfn(page));
>  	} else {
>  		memcpy(dst, src, len);
>  		if (cpu_has_dc_aliases)
>  			SetPageDcacheDirty(page);
>  	}
> -	if ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc)
> -		flush_cache_page(vma, vaddr, page_to_pfn(page));
>  }
>  
>  void copy_from_user_page(struct vm_area_struct *vma,

 This clearly won't work, because `cpu_has_dc_aliases' is unset for 
NetLogic processors and therefore the second leg of the conditional you 
propose to patch is taken, whereas your change applies to the first leg.

 So if you want to tackle the case of SetPageDcacheDirty, then here it 
has to be something along the lines of:

{
	int delayed_cache_flush = 0

        if (cpu_has_dc_aliases &&
	    page_mapped(page) && !Page_dcache_dirty(page)) {
		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
		memcpy(vto, src, len);
		kunmap_coherent();
	} else {
		memcpy(dst, src, len);
		if (cpu_has_dc_aliases) {
			delayed_cache_flush = 1;
			SetPageDcacheDirty(page);
		}
	}
	if (!delayed_cache_flush && (vma->vm_flags & VM_EXEC))
		flush_cache_page(vma, vaddr, page_to_pfn(page));
}

and then all the places where the delayed flush is made (a couple, 
according to Page_dcache_dirty() references) updated accordingly to 
synchronise the I-cache too.

 Although it seems to me we may have no easy way to access VM flags 
there, so perhaps another page flag to mark the required I-cache flush 
too?  Like:

	if ((vma->vm_flags & VM_EXEC)) {
		if (delayed_cache_flush)
			SetPageIcacheStale(page);
		else
			flush_cache_page(vma, vaddr, page_to_pfn(page));
	}

?  WDYT?

On Fri, 21 Mar 2014, David Daney wrote:

> The problem only happens when modifying target executable code through the
> ptrace() system call.
> 
> For all cases where a program is modifying its own executable memory, 
> we require that it make the special mips cacheflush system call.
> 
> I don't object to modifying this file, but I wonder if the call to the 
> flushing function should be pushed up into the ptrace() code.

 Hmm, good point, although it looks to me a lot of __access_remote_vm() 
code would have to be carried over or maybe factored out somehow from 
mm/memory.c to arch/mips/kernel/ptrace.c.  So although it sounds to me 
like a reasonable idea overall, it also appears to me it would best be 
done as a separate project rather than a part of a fix for this specific 
bug.

 Especially as overall what we do here is an extreme overkill.  Call to 
ptrace(PTRACE_POKETEXT, ...) are typically made to patch up single 
instructions so at most two cache lines need to be sychronised whereas 
we use a sledgehammer and kill a whole page worth of cache data -- 
always painful and even more painful if you go up to 16kB let alone 64kB 
with the page size.  Then from the MIPS32r2 ISA onwards we have the 
SYNCI instruction that could be used instead that would save even more.

  Maciej
