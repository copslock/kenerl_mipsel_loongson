Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2006 12:34:17 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.171]:47543 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133442AbWGJLeH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Jul 2006 12:34:07 +0100
Received: by ug-out-1314.google.com with SMTP id k3so3370314ugf
        for <linux-mips@linux-mips.org>; Mon, 10 Jul 2006 04:34:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FT+YLWVgz7JWnmJZO7gSkMPQLi8ZZ9lRyKrTDc0BxFa99fb8lqAHQ32hox0clYAcN/Bj7H1hUiC/2ourau3PnPeFvFnnISsS9dqZj+oXeMgPWce28sNeGownSonPErD7i2KFR/ixhxNaMnHY5v/f3hQ2InSNfK8aR2WSUqrvj2I=
Received: by 10.67.26.7 with SMTP id d7mr4937629ugj;
        Mon, 10 Jul 2006 04:34:06 -0700 (PDT)
Received: by 10.67.100.10 with HTTP; Mon, 10 Jul 2006 04:34:06 -0700 (PDT)
Message-ID: <cda58cb80607100434h13831eb7rc6eda13a0d9e373f@mail.gmail.com>
Date:	Mon, 10 Jul 2006 13:34:06 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] do not count pages in holes with sparsemem
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20060707.002602.75184460.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060706.233634.59465089.anemo@mba.ocn.ne.jp>
	 <44AD2537.1030509@innova-card.com>
	 <cda58cb80607060805yc656114p53516b904188c20f@mail.gmail.com>
	 <20060707.002602.75184460.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/7/6, Atsushi Nemoto <anemo@mba.ocn.ne.jp>:
>
> Sure.  Then this can be a final proposal?
>

could you put the diffstat next time ?

>
> With some memory model other than FLATMEM, the single node can
> contains some holes so there might be many invalid pages.  For
> example, with two 256M memory and one 256M hole, some variables
> (num_physpage, totalpages, nr_kernel_pages, nr_all_pages, etc.) will
> indicate that there are 768MB on this system.  This is not desired
> because, for example, alloc_large_system_hash() allocates too many
> entries.
>
> Use free_area_init_node() with counted zholes_size[] instead of
> free_area_init().
>
> For num_physpages, use number of ram pages instead of max_low_pfn.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 802bdd3..c52497b 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -139,10 +139,36 @@ #endif /* CONFIG_HIGHMEM */
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
>  extern void pagetable_init(void);
>
> +static int __init page_is_ram(unsigned long pagenr)
> +{
> +       int i;
> +
> +       for (i = 0; i < boot_mem_map.nr_map; i++) {
> +               unsigned long addr, end;
> +
> +               if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
> +                       /* not usable memory */
> +                       continue;
> +
> +               addr = PFN_UP(boot_mem_map.map[i].addr);
> +               end = PFN_DOWN(boot_mem_map.map[i].addr +
> +                              boot_mem_map.map[i].size);
> +
> +               if (pagenr >= addr && pagenr < end)
> +                       return 1;
> +       }
> +
> +       return 0;
> +}
> +
>  void __init paging_init(void)
>  {
> -       unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
> +       unsigned long zones_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
>         unsigned long max_dma, high, low;
> +#ifndef CONFIG_FLATMEM
> +       unsigned long zholes_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
> +       unsigned long i, j, pfn;
> +#endif
>
>         pagetable_init();
>
> @@ -174,29 +200,16 @@ #ifdef CONFIG_HIGHMEM
>                 zones_size[ZONE_HIGHMEM] = high - low;
>  #endif
>
> +#ifdef CONFIG_FLATMEM
>         free_area_init(zones_size);
> -}
> -
> -static inline int page_is_ram(unsigned long pagenr)
> -{
> -       int i;
> -
> -       for (i = 0; i < boot_mem_map.nr_map; i++) {
> -               unsigned long addr, end;
> -
> -               if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
> -                       /* not usable memory */
> -                       continue;
> -
> -               addr = PFN_UP(boot_mem_map.map[i].addr);
> -               end = PFN_DOWN(boot_mem_map.map[i].addr +
> -                              boot_mem_map.map[i].size);
> -
> -               if (pagenr >= addr && pagenr < end)
> -                       return 1;
> -       }
> -
> -       return 0;
> +#else
> +       pfn = 0;
> +       for (i = 0; i < MAX_NR_ZONES; i++)
> +               for (j = 0; j < zones_size[i]; j++, pfn++)
> +                       if (!page_is_ram(pfn))

can we use pfn_valid() instead of page_is_ram() ? bootmem_init() and
sparse_init() have already been called so pfn_valid() should be safe
here....

> +                               zholes_size[i]++;
> +       free_area_init_node(0, NODE_DATA(0), zones_size, 0, zholes_size);
> +#endif
>  }
>
>  static struct kcore_list kcore_mem, kcore_vmalloc;
> @@ -213,9 +226,9 @@ #ifdef CONFIG_HIGHMEM
>  #ifdef CONFIG_DISCONTIGMEM
>  #error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
>  #endif
> -       max_mapnr = num_physpages = highend_pfn;
> +       max_mapnr = highend_pfn;
>  #else
> -       max_mapnr = num_physpages = max_low_pfn;
> +       max_mapnr = max_low_pfn;

this is not always true, specially if FLATMEM set and your physical mem
do not start at 0.

>  #endif
>         high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
>
> @@ -229,6 +242,7 @@ #endif

in this loop can we use pfn_valid() instead of page_is_ram() ? Therefore
we could get rid of the latter macro ?

>                         if (PageReserved(pfn_to_page(tmp)))
>                                 reservedpages++;
>                 }
> +       num_physpages = ram;
>
>  #ifdef CONFIG_HIGHMEM
>         for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
> @@ -247,6 +261,7 @@ #endif
>                 totalhigh_pages++;
>         }
>         totalram_pages += totalhigh_pages;
> +       num_physpages += totalhigh_pages;
>  #endif
>
>         codesize =  (unsigned long) &_etext - (unsigned long) &_text;
>

-- 
               Franck
