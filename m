Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Sep 2006 10:48:45 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.183]:5742 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20037704AbWIXJso convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 24 Sep 2006 10:48:44 +0100
Received: by py-out-1112.google.com with SMTP id i49so1709229pyi
        for <linux-mips@linux-mips.org>; Sun, 24 Sep 2006 02:48:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:user-agent:date:subject:from:to:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=Slz6jICh4G6g0O548cNfdhd364CnkFsk3oNXyIvd5u0GyeXmL5ZmZRvhXUKpObSTKkWgyF0OsHXwpqGun49zWUsOP8VIXIFhwZDVcdQHRT2rkot9GWAa3MEgeZvwZto/ur4Nzi6oQahEkY9zLHzxaLRk2JqBM0t54zoK3Qj9KI4=
Received: by 10.35.50.1 with SMTP id c1mr5696011pyk;
        Sun, 24 Sep 2006 02:48:42 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id k13sm1287363pyf.2006.09.24.02.48.41;
        Sun, 24 Sep 2006 02:48:42 -0700 (PDT)
User-Agent: Microsoft-Entourage/11.2.1.051004
Date:	Sun, 24 Sep 2006 18:48:38 +0900
Subject: Re: [PATCH] do not count pages in holes with sparsemem
From:	girish <girishvg@gmail.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Message-ID: <C13C8386.632E%girishvg@gmail.com>
Thread-Topic: [PATCH] do not count pages in holes with sparsemem
Thread-Index: Acbfvpv12nHOTEuxEdulewATIGIqNA==
In-Reply-To: <20060705.221354.74751389.anemo@mba.ocn.ne.jp>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Content-transfer-encoding: 8BIT
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips


The system I am concerned with, likewise many MIPS based systems have 256MB
RAM + 256MB I/O in lowmem area. Additional RAM is placed at top of this
area, starting or could even be beyond 2000_0000.

My {quick, dirty, naïve} hack to support HIGHMEM in this case, would be to -
    .1 during bootmem_init, (we need EFI), move highstart_pfn as RAM gets
added beyond lowmem area.
    .2 add I/O space into ZONE_NORMAL (marked reserved later on)
    .3 add Non-RAM pages into ZONE_NORMAL (see below #4)
    .4 reset ZONE_NORMAL num. pages to zero, at the end of free_area_init

At the end zone table looks like -
     ZONE_DMA   = 256MB
    ZONE_NORMAL = 0
    ZONE_HIGHMEM= 256MB (additional RAM for example)

Of course with this approach there will be an overhead of reserved pages.
But then again it also has an use. Consider this, MIPS/UML can make use of
these reserved pages of I/O space (of course marking them un-cached) through
kmap for temporary access or through /dev/kmem for process-term access. For
example, the mmap call on /dev/kmem with offset hint of physical address
1000_0000 where all I/O begins, sets vma->vm_pgoff which in turn extracts an
already reserved page for this frame. The user application (driver?) has
access to I/O space.

Is it possible?


On 7/5/06 10:13 PM, "Atsushi Nemoto" <anemo@mba.ocn.ne.jp> wrote:

> With SPARSEMEM, the single node can contains some holes so there might
> be many invalid pages.  For example, with two 256M memory and one 256M
> hole, some variables (num_physpage, totalpages, nr_kernel_pages,
> nr_all_pages, etc.) will indicate that there are 768MB on this system.
> This is not desired because, for example, alloc_large_system_hash()
> allocates too many entries.
> 
> Use free_area_init_node() with counted zholes_size[] instead of
> free_area_init().
> 
> For num_physpages, use number of ram pages instead of max_low_pfn.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 802bdd3..d41dee5 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -139,10 +139,36 @@ #endif /* CONFIG_HIGHMEM */
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
>  extern void pagetable_init(void);
>  
> +static int __init page_is_ram(unsigned long pagenr)
> +{
> + int i;
> +
> + for (i = 0; i < boot_mem_map.nr_map; i++) {
> +  unsigned long addr, end;
> +
> +  if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
> +   /* not usable memory */
> +   continue;
> +
> +  addr = PFN_UP(boot_mem_map.map[i].addr);
> +  end = PFN_DOWN(boot_mem_map.map[i].addr +
> +          boot_mem_map.map[i].size);
> +
> +  if (pagenr >= addr && pagenr < end)
> +   return 1;
> + }
> +
> + return 0;
> +}
> +
>  void __init paging_init(void)
>  {
> - unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
> + unsigned long zones_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
> unsigned long max_dma, high, low;
> +#ifdef CONFIG_SPARSEMEM
> + unsigned long zholes_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
> + unsigned long i, j, pfn;
> +#endif
>  
> pagetable_init();
>  
> @@ -174,29 +200,17 @@ #ifdef CONFIG_HIGHMEM
> zones_size[ZONE_HIGHMEM] = high - low;
>  #endif
>  
> +#ifdef CONFIG_SPARSEMEM
> + pfn = 0;
> + for (i = 0; i < MAX_NR_ZONES; i++)
> +  for (j = 0; j < zones_size[i]; j++, pfn++)
> +   if (!page_is_ram(pfn))
> +    zholes_size[i]++;
> + free_area_init_node(0, NODE_DATA(0), zones_size,
> +       __pa(PAGE_OFFSET), zholes_size);
> +#else
> free_area_init(zones_size);
> -}
> -
> -static inline int page_is_ram(unsigned long pagenr)
> -{
> - int i;
> -
> - for (i = 0; i < boot_mem_map.nr_map; i++) {
> -  unsigned long addr, end;
> -
> -  if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
> -   /* not usable memory */
> -   continue;
> -
> -  addr = PFN_UP(boot_mem_map.map[i].addr);
> -  end = PFN_DOWN(boot_mem_map.map[i].addr +
> -          boot_mem_map.map[i].size);
> -
> -  if (pagenr >= addr && pagenr < end)
> -   return 1;
> - }
> -
> - return 0;
> +#endif
>  }
>  
>  static struct kcore_list kcore_mem, kcore_vmalloc;
> @@ -213,9 +227,9 @@ #ifdef CONFIG_HIGHMEM
>  #ifdef CONFIG_DISCONTIGMEM
>  #error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
>  #endif
> - max_mapnr = num_physpages = highend_pfn;
> + max_mapnr = highend_pfn;
>  #else
> - max_mapnr = num_physpages = max_low_pfn;
> + max_mapnr = max_low_pfn;
>  #endif
> high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
>  
> @@ -229,6 +243,7 @@ #endif
> if (PageReserved(pfn_to_page(tmp)))
> reservedpages++;
> }
> + num_physpages = ram;
>  
>  #ifdef CONFIG_HIGHMEM
> for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
> @@ -247,6 +262,7 @@ #endif
> totalhigh_pages++;
> }
> totalram_pages += totalhigh_pages;
> + num_physpages += totalhigh_pages;
>  #endif
>  
> codesize =  (unsigned long) &_etext - (unsigned long) &_text;
> 


-- 
First of all - I am an Engineer. I care less for Copyrights/Patents, at
least I have none of my own! I love software development & it pays me to run
my family. I try to dedicate some time thinking about Open Source movement &
sometime contributing to it actually. I often get paid by claiming knowledge
in software developed by Open Source community. Lots of things I know today
& still learning are due to Open Source community.
