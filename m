Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jun 2015 17:29:14 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:37907 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008912AbbFRP3M0UtBQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jun 2015 17:29:12 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E116AAB2;
        Thu, 18 Jun 2015 15:29:11 +0000 (UTC)
Date:   Thu, 18 Jun 2015 17:29:07 +0200
From:   Michal Hocko <mhocko@suse.cz>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH V2 1/3] Add mmap flag to request pages are locked
 after page fault
Message-ID: <20150618152907.GG5858@dhcp22.suse.cz>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>
 <1433942810-7852-2-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433942810-7852-2-git-send-email-emunson@akamai.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mhocko@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@suse.cz
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

[Sorry for the late reply - I meant to answer in the previous threads
 but something always preempted me from that]

On Wed 10-06-15 09:26:48, Eric B Munson wrote:
> The cost of faulting in all memory to be locked can be very high when
> working with large mappings.  If only portions of the mapping will be
> used this can incur a high penalty for locking.
> 
> For the example of a large file, this is the usage pattern for a large
> statical language model (probably applies to other statical or graphical
> models as well).  For the security example, any application transacting
> in data that cannot be swapped out (credit card data, medical records,
> etc).

Such a use case makes some sense to me but I am not sure the way you
implement it is the right one. This is another mlock related flag for
mmap with a different semantic. You do not want to prefault but e.g. is
the readahead or fault around acceptable? I do not see anything in your
patch to handle those...

Wouldn't it be much more reasonable and straightforward to have
MAP_FAULTPOPULATE as a counterpart for MAP_POPULATE which would
explicitly disallow any form of pre-faulting? It would be usable for
other usecases than with MAP_LOCKED combination.

> This patch introduces the ability to request that pages are not
> pre-faulted, but are placed on the unevictable LRU when they are finally
> faulted in.
> 
> To keep accounting checks out of the page fault path, users are billed
> for the entire mapping lock as if MAP_LOCKED was used.
> 
> Signed-off-by: Eric B Munson <emunson@akamai.com>
> Cc: Michal Hocko <mhocko@suse.cz>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> ---
>  arch/alpha/include/uapi/asm/mman.h   | 1 +
>  arch/mips/include/uapi/asm/mman.h    | 1 +
>  arch/parisc/include/uapi/asm/mman.h  | 1 +
>  arch/powerpc/include/uapi/asm/mman.h | 1 +
>  arch/sparc/include/uapi/asm/mman.h   | 1 +
>  arch/tile/include/uapi/asm/mman.h    | 1 +
>  arch/xtensa/include/uapi/asm/mman.h  | 1 +
>  include/linux/mm.h                   | 1 +
>  include/linux/mman.h                 | 3 ++-
>  include/uapi/asm-generic/mman.h      | 1 +
>  mm/mmap.c                            | 4 ++--
>  mm/swap.c                            | 3 ++-
>  12 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> index 0086b47..15e96e1 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -30,6 +30,7 @@
>  #define MAP_NONBLOCK	0x40000		/* do not block on IO */
>  #define MAP_STACK	0x80000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x100000	/* create a huge page mapping */
> +#define MAP_LOCKONFAULT	0x200000	/* Lock pages after they are faulted in, do not prefault */
>  
>  #define MS_ASYNC	1		/* sync memory asynchronously */
>  #define MS_SYNC		2		/* synchronous memory sync */
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> index cfcb876..47846a5 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -48,6 +48,7 @@
>  #define MAP_NONBLOCK	0x20000		/* do not block on IO */
>  #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
> +#define MAP_LOCKONFAULT	0x100000	/* Lock pages after they are faulted in, do not prefault */
>  
>  /*
>   * Flags for msync
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> index 294d251..1514cd7 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -24,6 +24,7 @@
>  #define MAP_NONBLOCK	0x20000		/* do not block on IO */
>  #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
> +#define MAP_LOCKONFAULT	0x100000	/* Lock pages after they are faulted in, do not prefault */
>  
>  #define MS_SYNC		1		/* synchronous memory sync */
>  #define MS_ASYNC	2		/* sync memory asynchronously */
> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
> index 6ea26df..fce74fe 100644
> --- a/arch/powerpc/include/uapi/asm/mman.h
> +++ b/arch/powerpc/include/uapi/asm/mman.h
> @@ -27,5 +27,6 @@
>  #define MAP_NONBLOCK	0x10000		/* do not block on IO */
>  #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
> +#define MAP_LOCKONFAULT	0x80000		/* Lock pages after they are faulted in, do not prefault */
>  
>  #endif /* _UAPI_ASM_POWERPC_MMAN_H */
> diff --git a/arch/sparc/include/uapi/asm/mman.h b/arch/sparc/include/uapi/asm/mman.h
> index 0b14df3..12425d8 100644
> --- a/arch/sparc/include/uapi/asm/mman.h
> +++ b/arch/sparc/include/uapi/asm/mman.h
> @@ -22,6 +22,7 @@
>  #define MAP_NONBLOCK	0x10000		/* do not block on IO */
>  #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
> +#define MAP_LOCKONFAULT	0x80000		/* Lock pages after they are faulted in, do not prefault */
>  
>  
>  #endif /* _UAPI__SPARC_MMAN_H__ */
> diff --git a/arch/tile/include/uapi/asm/mman.h b/arch/tile/include/uapi/asm/mman.h
> index 81b8fc3..ec04eaf 100644
> --- a/arch/tile/include/uapi/asm/mman.h
> +++ b/arch/tile/include/uapi/asm/mman.h
> @@ -29,6 +29,7 @@
>  #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
>  #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
>  #define MAP_HUGETLB	0x4000		/* create a huge page mapping */
> +#define MAP_LOCKONFAULT	0x8000		/* Lock pages after they are faulted in, do not prefault */
>  
>  
>  /*
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> index 201aec0..42d43cc 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -55,6 +55,7 @@
>  #define MAP_NONBLOCK	0x20000		/* do not block on IO */
>  #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
> +#define MAP_LOCKONFAULT	0x100000	/* Lock pages after they are faulted in, do not prefault */
>  #ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
>  # define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
>  					 * uninitialized */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0755b9f..3e31457 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -126,6 +126,7 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
>  #define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
>  
> +#define VM_LOCKONFAULT	0x00001000	/* Lock the pages covered when they are faulted in */
>  #define VM_LOCKED	0x00002000
>  #define VM_IO           0x00004000	/* Memory mapped I/O or similar */
>  
> diff --git a/include/linux/mman.h b/include/linux/mman.h
> index 16373c8..437264b 100644
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -86,7 +86,8 @@ calc_vm_flag_bits(unsigned long flags)
>  {
>  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>  	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
> -	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
> +	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> +	       _calc_vm_trans(flags, MAP_LOCKONFAULT,VM_LOCKONFAULT);
>  }
>  
>  unsigned long vm_commit_limit(void);
> diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
> index e9fe6fd..fc4e586 100644
> --- a/include/uapi/asm-generic/mman.h
> +++ b/include/uapi/asm-generic/mman.h
> @@ -12,6 +12,7 @@
>  #define MAP_NONBLOCK	0x10000		/* do not block on IO */
>  #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
> +#define MAP_LOCKONFAULT	0x80000		/* Lock pages after they are faulted in, do not prefault */
>  
>  /* Bits [26:31] are reserved, see mman-common.h for MAP_HUGETLB usage */
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bb50cac..ba1a6bf 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1233,7 +1233,7 @@ static inline int mlock_future_check(struct mm_struct *mm,
>  	unsigned long locked, lock_limit;
>  
>  	/*  mlock MCL_FUTURE? */
> -	if (flags & VM_LOCKED) {
> +	if (flags & (VM_LOCKED | VM_LOCKONFAULT)) {
>  		locked = len >> PAGE_SHIFT;
>  		locked += mm->locked_vm;
>  		lock_limit = rlimit(RLIMIT_MEMLOCK);
> @@ -1301,7 +1301,7 @@ unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
>  	vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags) |
>  			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
>  
> -	if (flags & MAP_LOCKED)
> +	if (flags & (MAP_LOCKED | MAP_LOCKONFAULT))
>  		if (!can_do_mlock())
>  			return -EPERM;
>  
> diff --git a/mm/swap.c b/mm/swap.c
> index a7251a8..07c905e 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -711,7 +711,8 @@ void lru_cache_add_active_or_unevictable(struct page *page,
>  {
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> -	if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED)) {
> +	if (likely((vma->vm_flags & (VM_LOCKED | VM_LOCKONFAULT)) == 0) ||
> +		   (vma->vm_flags & VM_SPECIAL)) {
>  		SetPageActive(page);
>  		lru_cache_add(page);
>  		return;
> -- 
> 1.9.1
> 

-- 
Michal Hocko
SUSE Labs
