Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 21:16:12 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:55817 "EHLO
	mms1.broadcom.com") by lappi.linux-mips.net with ESMTP
	id S1102629AbYDBTQG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Apr 2008 21:16:06 +0200
Received: from [10.11.16.99] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 02 Apr 2008 12:14:43 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 8AAA32B1; Wed, 2 Apr 2008 12:14:43 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 760C02B0; Wed, 2 Apr
 2008 12:14:43 -0700 (PDT)
Received: from mail-irva-12.broadcom.com (mail-irva-12.broadcom.com
 [10.11.16.101]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GSL01811; Wed, 2 Apr 2008 12:14:43 -0700 (PDT)
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-12.broadcom.com (Postfix) with ESMTP id 2930369CA4; Wed, 2
 Apr 2008 12:14:42 -0700 (PDT)
Subject: Re: [PATCH 2.6.24][MIPS]Work in progress: fix HIGHMEM-enabled
 dcache flushing on 32-bit processor
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"David VomLehn" <dvomlehn@cisco.com>
cc:	linux-mips@linux-mips.org
In-Reply-To: <47D89211.1020504@cisco.com>
References: <47D89211.1020504@cisco.com>
Organization: Broadcom
Date:	Wed, 02 Apr 2008 15:14:41 -0400
Message-ID: <1207163681.32277.132.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8)
X-WSS-ID: 6BED04A94RG115300-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips

Did this fix your NFS problem?

I'm working on discontiguous memory platforms as well.

Jon Fraser
Broadcom
Andover, Mass.



On Wed, 2008-03-12 at 19:31 -0700, David VomLehn wrote:
> This patch is a work in progress, per Ralf's suggestion from last week. It is 
> intended to fix dcache flushing issues when using HIGHMEM support. We get much 
> better results with this patch applied, but I would not characterize our 2.6.24 
> port as stable, yet, so there may be other HIGHMEM-related issues.
> 
> Any comments welcome. Thanks!
> 
> David VomLehn
> 
> diff -urN a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> --- a/arch/mips/mm/cache.c	2008-01-24 14:58:37.000000000 -0800
> +++ b/arch/mips/mm/cache.c	2008-03-12 19:11:39.000000000 -0700
> @@ -19,6 +19,7 @@
>   #include <asm/processor.h>
>   #include <asm/cpu.h>
>   #include <asm/cpu-features.h>
> +#include <asm/highmem.h>
> 
>   /* Cache operations. */
>   void (*flush_cache_all)(void);
> @@ -70,10 +71,28 @@
>   void __flush_dcache_page(struct page *page)
>   {
>   	struct address_space *mapping = page_mapping(page);
> -	unsigned long addr;
> +	void	* addr;
> 
> +#ifndef CONFIG_HIGHMEM
>   	if (PageHighMem(page))
>   		return;
> +#endif
> +
> +	/* If there is a temporary kernel mapping, i.e. if kmap_atomic was
> +	 * used to map a page, we only need to flush the page. We can skip
> +	 * the other work here because it won't be used in any other way. */
> +	if (PageHighMem(page)) {
> +		addr = kmap_atomic_to_vaddr(page);
> +		if (addr != NULL) {
> +			flush_data_cache_page((unsigned long) addr);
> +			return;
> +		}
> +	}
> +
> +	/* If page_mapping returned a non-NULL value, then the page is not
> +	 * in the swap cache and it isn't anonymously mapped. If it's not
> +	 * already mapped into user space, we can just set the dirty bit to
> +	 * get the cache flushed later, if needed */
>   	if (mapping && !mapping_mapped(mapping)) {
>   		SetPageDcacheDirty(page);
>   		return;
> @@ -84,8 +103,10 @@
>   	 * case is for exec env/arg pages and those are %99 certainly going to
>   	 * get faulted into the tlb (and thus flushed) anyways.
>   	 */
> -	addr = (unsigned long) page_address(page);
> -	flush_data_cache_page(addr);
> +	addr = page_address(page);
> +	/* If the page is not mapped for kernel access, don't flush it */
> +	if (addr != NULL)
> +		flush_data_cache_page((unsigned long) addr);
>   }
> 
>   EXPORT_SYMBOL(__flush_dcache_page);
> diff -urN a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
> --- a/arch/mips/mm/highmem.c	2008-01-24 14:58:37.000000000 -0800
> +++ b/arch/mips/mm/highmem.c	2008-03-12 18:58:10.000000000 -0700
> @@ -25,6 +25,25 @@
>   }
> 
>   /*
> + * Describes one page->virtual association in kmap_atomic
> + */
> +struct kmap_atomic_map {
> +	struct list_head list;
> +	struct page *page;
> +};
> +
> +/*
> + * Array of linked lists of the mappings currently in use. The array is
> + * indexed by the CPU number, so we don't have to worry about synchronizing
> + * between the CPUs. We can add maps in interrupt handlers, however, so
> + * we will need to block interrupts when manipulating the linked list.
> + */
> +static struct kmap_atomic_map_list {
> +	struct list_head lh;
> +	struct kmap_atomic_map map_pool[KM_TYPE_NR];
> +} ____cacheline_aligned_in_smp map_list[NR_CPUS];
> +
> +/*
>    * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
>    * no global lock is needed and because the kmap code must perform a global TLB
>    * invalidation when the kmap pool wraps.
> @@ -37,6 +56,7 @@
>   {
>   	enum fixed_addresses idx;
>   	unsigned long vaddr;
> +	unsigned long flags;
> 
>   	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
>   	pagefault_disable();
> @@ -52,11 +72,18 @@
>   	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
>   	local_flush_tlb_one((unsigned long)vaddr);
> 
> +	local_irq_save(flags);
> +	map_list[smp_processor_id()].map_pool[type].page = page;
> +	list_add(&(map_list[smp_processor_id()].map_pool[type]).list, 
> &map_list[smp_processor_id()].lh);
> +	local_irq_restore(flags);
> +
>   	return (void*) vaddr;
>   }
> 
>   void __kunmap_atomic(void *kvaddr, enum km_type type)
>   {
> +	unsigned long flags;
> +
>   #ifdef CONFIG_DEBUG_HIGHMEM
>   	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
>   	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
> @@ -75,8 +102,14 @@
>   	 */
>   	pte_clear(&init_mm, vaddr, kmap_pte-idx);
>   	local_flush_tlb_one(vaddr);
> +
> +	map_list[smp_processor_id()].map_pool[type].page = NULL;
>   #endif
> 
> +	local_irq_save(flags);
> +	list_del(&(map_list[smp_processor_id()].map_pool[type]).list);
> +	local_irq_restore(flags);
> +
>   	pagefault_enable();
>   }
> 
> @@ -112,6 +145,40 @@
>   	return pte_page(*pte);
>   }
> 
> +void *kmap_atomic_to_vaddr(struct page *page)
> +{
> +	unsigned long flags;
> +	struct kmap_atomic_map *map;
> +	unsigned long vaddr = 0;
> +
> +	local_irq_save(flags);
> +	list_for_each_entry(map, &map_list[smp_processor_id()].lh, list) {
> +		if (map->page == page) {
> +			vaddr = __fix_to_virt(FIX_KMAP_BEGIN +
> +				(map - map_list[smp_processor_id()].map_pool));
> +			break;
> +		}
> +	}
> +	local_irq_restore(flags);
> +
> +	return (void *)vaddr;		
> +}
> +
> +void __init kmap_atomic_init(void)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < NR_CPUS; i++) {
> +		INIT_LIST_HEAD(&map_list[i].lh);
> +#ifdef CONFIG_DEBUG_HIGHMEM
> +		for (j = 0; j < KM_TYPE_NR; j++) {
> +			INIT_LIST_HEAD(&(map_list[i].map_pool[j]).list);
> +			map_list[i].map_pool[j].page = NULL;
> +		}
> +#endif
> +	}
> +}
> +
>   EXPORT_SYMBOL(__kmap);
>   EXPORT_SYMBOL(__kunmap);
>   EXPORT_SYMBOL(__kmap_atomic);
> diff -urN a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> --- a/arch/mips/mm/init.c	2008-01-24 14:58:37.000000000 -0800
> +++ b/arch/mips/mm/init.c	2008-03-12 19:12:51.000000000 -0700
> @@ -354,6 +354,7 @@
> 
>   #ifdef CONFIG_HIGHMEM
>   	kmap_init();
> +	kmap_atomic_init();
>   #endif
>   	kmap_coherent_init();
> 
> diff -urN a/include/asm-mips/highmem.h b/include/asm-mips/highmem.h
> --- a/include/asm-mips/highmem.h	2008-01-24 14:58:37.000000000 -0800
> +++ b/include/asm-mips/highmem.h	2008-03-12 18:57:22.000000000 -0700
> @@ -55,6 +55,9 @@
>   extern void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
>   extern struct page *__kmap_atomic_to_page(void *ptr);
> 
> +extern void *kmap_atomic_to_vaddr(struct page *page);
> +extern void kmap_atomic_init(void);
> +
>   #define kmap			__kmap
>   #define kunmap			__kunmap
>   #define kmap_atomic		__kmap_atomic
> 
> 
> 
