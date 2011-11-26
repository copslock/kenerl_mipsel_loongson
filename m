Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Nov 2011 20:04:50 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:32179 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903661Ab1KZTEl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 Nov 2011 20:04:41 +0100
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAQJ4UbV030248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 26 Nov 2011 14:04:33 -0500
Received: from random.random (ovpn-113-57.phx2.redhat.com [10.3.113.57])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id pAQHVqDB028279;
        Sat, 26 Nov 2011 12:31:53 -0500
Date:   Sat, 26 Nov 2011 18:31:51 +0100
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Hillf Danton <dhillf@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] MIPS: changes in VM core for adding THP
Message-ID: <20111126173151.GF8397@redhat.com>
References: <CAJd=RBB2gSCaJSsFfJXBg2zmgzNjXPAn8OakAZACNG0mv2D7nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJd=RBB2gSCaJSsFfJXBg2zmgzNjXPAn8OakAZACNG0mv2D7nQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
X-archive-position: 32000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aarcange@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21896

On Sat, Nov 26, 2011 at 10:43:15PM +0800, Hillf Danton wrote:
> In VM core, window is opened for MIPS to use THP.
> 
> And two simple helper functions are added to easy MIPS a bit.
> 
> Signed-off-by: Hillf Danton <dhillf@gmail.com>
> ---
> 
> --- a/mm/Kconfig	Thu Nov 24 21:12:00 2011
> +++ b/mm/Kconfig	Sat Nov 26 22:12:56 2011
> @@ -307,7 +307,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
> 
>  config TRANSPARENT_HUGEPAGE
>  	bool "Transparent Hugepage Support"
> -	depends on X86 && MMU
> +	depends on MMU
>  	select COMPACTION
>  	help
>  	  Transparent Hugepages allows the kernel to use huge pages and

Then the build will break for all archs if they enable it, better to
limit the option to those archs that supports it.

> --- a/mm/huge_memory.c	Thu Nov 24 21:12:48 2011
> +++ b/mm/huge_memory.c	Sat Nov 26 22:30:24 2011
> @@ -17,6 +17,7 @@
>  #include <linux/khugepaged.h>
>  #include <linux/freezer.h>
>  #include <linux/mman.h>
> +#include <linux/pagemap.h>
>  #include <asm/tlb.h>
>  #include <asm/pgalloc.h>
>  #include "internal.h"
> @@ -135,6 +136,30 @@ static int set_recommended_min_free_kbyt
>  }
>  late_initcall(set_recommended_min_free_kbytes);
> 
> +/* helper function for MIPS to call pmd_page() indirectly */
> +static inline struct page *__pmd_page(pmd_t pmd)
> +{
> +	struct page *page;
> +
> +#ifdef __HAVE_ARCH_THP_PMD_PAGE
> +	page = thp_pmd_page(pmd);
> +#else
> +	page = pmd_page(pmd);
> +#endif
> +	return page;
> +}

Why do you need this and also a branch in thp_pmd_page checking for
pmd_trans_huge? If you fallback in pmd_page that would mean you're
called by hugetlbfs. Doesn't make much sense to fallback in pmd_page
if the hugepmd format for thp and hugetlbfs is different.

Couldn't you set a different _PAGE_HUGE flag in the pmd in the thp
case to avoid the above? Then you could have a pmd_page that works on
both. Ok it'll be slower and require 1 more branch (but you already
have a branch for something that doesn't seem needed).

pmd_page is only called by hugetlbfs/thp, rest uses pte_offset* so I
don't think a branch would be a big deal and you could hide the fact
he format of the pmd between hugetlbfs and thp is different with a
bitflag on the pmd (if any reserved is available to use to software).

> +
> +/* helper function for MIPS to call update_mmu_cache() indirectly */
> +static inline void __update_mmu_cache(struct vm_area_struct *vma,
> +					unsigned long addr, pmd_t *pmdp)
> +{
> +#ifdef __HAVE_ARCH_UPDATE_MMU_THP
> +	update_mmu_thp(vma, addr, pmdp);
> +#else
> +	update_mmu_cache(vma, addr, pmdp);
> +#endif
> +}

Maybe here same, check pmd_trans_huge (and make it succeed only in the
thp case and not the hugetlbfs case) and avoid it the __ and the ifdefs.

Thanks!
Andrea
