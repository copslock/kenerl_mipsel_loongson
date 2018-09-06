Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 11:08:28 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:58318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994635AbeIFJIYNFOHA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 11:08:24 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4C21AF8A;
        Thu,  6 Sep 2018 09:08:18 +0000 (UTC)
Date:   Thu, 6 Sep 2018 11:08:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 27/29] mm: remove nobootmem
Message-ID: <20180906090817.GL14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-28-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-28-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Wed 05-09-18 18:59:42, Mike Rapoport wrote:
> Move a few remaining functions from nobootmem.c to memblock.c and remove
> nobootmem
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/Makefile    |   1 -
>  mm/memblock.c  | 104 ++++++++++++++++++++++++++++++++++++++++++++++
>  mm/nobootmem.c | 128 ---------------------------------------------------------
>  3 files changed, 104 insertions(+), 129 deletions(-)
>  delete mode 100644 mm/nobootmem.c
> 
> diff --git a/mm/Makefile b/mm/Makefile
> index 0a3e72e..fb96c45 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -42,7 +42,6 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>  			   debug.o $(mmu-y)
>  
>  obj-y += init-mm.o
> -obj-y += nobootmem.o
>  obj-y += memblock.o
>  
>  ifdef CONFIG_MMU
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 55d7d50..3f76d40 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -82,6 +82,16 @@
>   * initialization compltes.
>   */
>  
> +#ifndef CONFIG_NEED_MULTIPLE_NODES
> +struct pglist_data __refdata contig_page_data;
> +EXPORT_SYMBOL(contig_page_data);
> +#endif
> +
> +unsigned long max_low_pfn;
> +unsigned long min_low_pfn;
> +unsigned long max_pfn;
> +unsigned long long max_possible_pfn;
> +
>  static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
>  static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> @@ -1959,6 +1969,100 @@ static int __init early_memblock(char *p)
>  }
>  early_param("memblock", early_memblock);
>  
> +static void __init __free_pages_memory(unsigned long start, unsigned long end)
> +{
> +	int order;
> +
> +	while (start < end) {
> +		order = min(MAX_ORDER - 1UL, __ffs(start));
> +
> +		while (start + (1UL << order) > end)
> +			order--;
> +
> +		memblock_free_pages(pfn_to_page(start), start, order);
> +
> +		start += (1UL << order);
> +	}
> +}
> +
> +static unsigned long __init __free_memory_core(phys_addr_t start,
> +				 phys_addr_t end)
> +{
> +	unsigned long start_pfn = PFN_UP(start);
> +	unsigned long end_pfn = min_t(unsigned long,
> +				      PFN_DOWN(end), max_low_pfn);
> +
> +	if (start_pfn >= end_pfn)
> +		return 0;
> +
> +	__free_pages_memory(start_pfn, end_pfn);
> +
> +	return end_pfn - start_pfn;
> +}
> +
> +static unsigned long __init free_low_memory_core_early(void)
> +{
> +	unsigned long count = 0;
> +	phys_addr_t start, end;
> +	u64 i;
> +
> +	memblock_clear_hotplug(0, -1);
> +
> +	for_each_reserved_mem_region(i, &start, &end)
> +		reserve_bootmem_region(start, end);
> +
> +	/*
> +	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
> +	 *  because in some case like Node0 doesn't have RAM installed
> +	 *  low ram will be on Node1
> +	 */
> +	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
> +				NULL)
> +		count += __free_memory_core(start, end);
> +
> +	return count;
> +}
> +
> +static int reset_managed_pages_done __initdata;
> +
> +void reset_node_managed_pages(pg_data_t *pgdat)
> +{
> +	struct zone *z;
> +
> +	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
> +		z->managed_pages = 0;
> +}
> +
> +void __init reset_all_zones_managed_pages(void)
> +{
> +	struct pglist_data *pgdat;
> +
> +	if (reset_managed_pages_done)
> +		return;
> +
> +	for_each_online_pgdat(pgdat)
> +		reset_node_managed_pages(pgdat);
> +
> +	reset_managed_pages_done = 1;
> +}
> +
> +/**
> + * memblock_free_all - release free pages to the buddy allocator
> + *
> + * Return: the number of pages actually released.
> + */
> +unsigned long __init memblock_free_all(void)
> +{
> +	unsigned long pages;
> +
> +	reset_all_zones_managed_pages();
> +
> +	pages = free_low_memory_core_early();
> +	totalram_pages += pages;
> +
> +	return pages;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
>  
>  static int memblock_debug_show(struct seq_file *m, void *private)
> diff --git a/mm/nobootmem.c b/mm/nobootmem.c
> deleted file mode 100644
> index 9608bc5..0000000
> --- a/mm/nobootmem.c
> +++ /dev/null
> @@ -1,128 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  bootmem - A boot-time physical memory allocator and configurator
> - *
> - *  Copyright (C) 1999 Ingo Molnar
> - *                1999 Kanoj Sarcar, SGI
> - *                2008 Johannes Weiner
> - *
> - * Access to this subsystem has to be serialized externally (which is true
> - * for the boot process anyway).
> - */
> -#include <linux/init.h>
> -#include <linux/pfn.h>
> -#include <linux/slab.h>
> -#include <linux/export.h>
> -#include <linux/kmemleak.h>
> -#include <linux/range.h>
> -#include <linux/memblock.h>
> -#include <linux/bootmem.h>
> -
> -#include <asm/bug.h>
> -#include <asm/io.h>
> -
> -#include "internal.h"
> -
> -#ifndef CONFIG_NEED_MULTIPLE_NODES
> -struct pglist_data __refdata contig_page_data;
> -EXPORT_SYMBOL(contig_page_data);
> -#endif
> -
> -unsigned long max_low_pfn;
> -unsigned long min_low_pfn;
> -unsigned long max_pfn;
> -unsigned long long max_possible_pfn;
> -
> -static void __init __free_pages_memory(unsigned long start, unsigned long end)
> -{
> -	int order;
> -
> -	while (start < end) {
> -		order = min(MAX_ORDER - 1UL, __ffs(start));
> -
> -		while (start + (1UL << order) > end)
> -			order--;
> -
> -		memblock_free_pages(pfn_to_page(start), start, order);
> -
> -		start += (1UL << order);
> -	}
> -}
> -
> -static unsigned long __init __free_memory_core(phys_addr_t start,
> -				 phys_addr_t end)
> -{
> -	unsigned long start_pfn = PFN_UP(start);
> -	unsigned long end_pfn = min_t(unsigned long,
> -				      PFN_DOWN(end), max_low_pfn);
> -
> -	if (start_pfn >= end_pfn)
> -		return 0;
> -
> -	__free_pages_memory(start_pfn, end_pfn);
> -
> -	return end_pfn - start_pfn;
> -}
> -
> -static unsigned long __init free_low_memory_core_early(void)
> -{
> -	unsigned long count = 0;
> -	phys_addr_t start, end;
> -	u64 i;
> -
> -	memblock_clear_hotplug(0, -1);
> -
> -	for_each_reserved_mem_region(i, &start, &end)
> -		reserve_bootmem_region(start, end);
> -
> -	/*
> -	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
> -	 *  because in some case like Node0 doesn't have RAM installed
> -	 *  low ram will be on Node1
> -	 */
> -	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
> -				NULL)
> -		count += __free_memory_core(start, end);
> -
> -	return count;
> -}
> -
> -static int reset_managed_pages_done __initdata;
> -
> -void reset_node_managed_pages(pg_data_t *pgdat)
> -{
> -	struct zone *z;
> -
> -	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
> -		z->managed_pages = 0;
> -}
> -
> -void __init reset_all_zones_managed_pages(void)
> -{
> -	struct pglist_data *pgdat;
> -
> -	if (reset_managed_pages_done)
> -		return;
> -
> -	for_each_online_pgdat(pgdat)
> -		reset_node_managed_pages(pgdat);
> -
> -	reset_managed_pages_done = 1;
> -}
> -
> -/**
> - * memblock_free_all - release free pages to the buddy allocator
> - *
> - * Return: the number of pages actually released.
> - */
> -unsigned long __init memblock_free_all(void)
> -{
> -	unsigned long pages;
> -
> -	reset_all_zones_managed_pages();
> -
> -	pages = free_low_memory_core_early();
> -	totalram_pages += pages;
> -
> -	return pages;
> -}
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
