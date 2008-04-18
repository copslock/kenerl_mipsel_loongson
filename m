Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2008 19:01:43 +0100 (BST)
Received: from mms2.broadcom.com ([216.31.210.18]:65038 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S28573866AbYDRSBl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Apr 2008 19:01:41 +0100
Received: from [10.11.16.99] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Fri, 18 Apr 2008 11:01:19 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 BEA3F2B5; Fri, 18 Apr 2008 11:01:19 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id A9D5A2B3 for
 <linux-mips@linux-mips.org>; Fri, 18 Apr 2008 11:01:19 -0700 (PDT)
Received: from mail-irva-13.broadcom.com (mail-irva-13.broadcom.com
 [10.11.16.103]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GUF24191; Fri, 18 Apr 2008 11:00:57 -0700 (PDT)
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id 2702974D19; Fri,
 18 Apr 2008 11:00:51 -0700 (PDT)
Subject: Re: [PATCH 2.6.24][MIPS]Work in progress: fix HIGHMEM-enabled
 dcache flushing on 32-bit processor
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	linux-mips@linux-mips.org
In-Reply-To: <47D89211.1020504@cisco.com>
References: <47D89211.1020504@cisco.com>
Organization: Broadcom
Date:	Fri, 18 Apr 2008 14:00:50 -0400
Message-ID: <1208541650.9942.203.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8)
X-WSS-ID: 64163E654YC25959650-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips

Dave,

  You might want to try out this patch to arch/mips/mm/dma-default.c.
The code for dma_map_sg will fail for the HIGHMEM case since there's no
permanent mapping for the pages.

     I don't know if the address range checks are valid for your platform.
r4k_dma_cache_wback_inv can't handle bad addresses on our platform. 

     Once we made this fix, we could do IO to HIGHMEM and some crashes which
appeared to be memory corruption went away.

Jon
______________________________
--- linux-2.6.24-virgin/arch/mips/mm/dma-default.c	2008-01-25
06:23:51.000000000 -0500
+++ stblinux-2.6.24/arch/mips/mm/dma-default.c	2008-04-18
10:49:43.000000000 -0400
@@ -132,6 +132,9 @@
 static inline void __dma_sync(unsigned long addr, size_t size,
 	enum dma_data_direction direction)
 {
+
+	BUG_ON(addr < KSEG0);
+
 	switch (direction) {
 	case DMA_TO_DEVICE:
 		dma_cache_wback(addr, size);
@@ -185,11 +188,13 @@
 	for (i = 0; i < nents; i++, sg++) {
 		unsigned long addr;
 
+	        BUG_ON(!sg_page(sg));
+
 		addr = (unsigned long) sg_virt(sg);
-		if (!plat_device_is_coherent(dev) && addr)
+		if (!plat_device_is_coherent(dev) && (addr >= KSEG0))
 			__dma_sync(addr, sg->length, direction);
-		sg->dma_address = plat_map_dma_mem(dev,
-				                   (void *)addr, sg->length);
+
+		sg->dma_address = sg_phys(sg);
 	}
 
 	return nents;
@@ -206,6 +211,7 @@
 		unsigned long addr;
 
 		addr = (unsigned long) page_address(page) + offset;
+		if (addr >= KSEG0)
 		dma_cache_wback_inv(addr, size);
 	}
 
@@ -221,8 +227,11 @@
 
 	if (!plat_device_is_coherent(dev) && direction != DMA_TO_DEVICE) {
 		unsigned long addr;
+		unsigned int offset;
 
-		addr = plat_dma_addr_to_phys(dma_address);
+		offset = dma_address & ~PAGE_MASK;
+		addr = (unsigned long)page_address(pfn_to_page(dma_address >>
PAGE_SHIFT)) + offset;
+		if (addr >= KSEG0)
 		dma_cache_wback_inv(addr, size);
 	}
 
@@ -243,7 +252,7 @@
 		if (!plat_device_is_coherent(dev) &&
 		    direction != DMA_TO_DEVICE) {
 			addr = (unsigned long) sg_virt(sg);
-			if (addr)
+			if (addr >= KSEG0)
 				__dma_sync(addr, sg->length, direction);
 		}
 		plat_unmap_dma_mem(sg->dma_address);
@@ -381,6 +390,7 @@
 	       enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);
+	BUG_ON(vaddr < (void *)KSEG0);
 
 	if (!plat_device_is_coherent(dev))
 		dma_cache_wback_inv((unsigned long)vaddr, size);


_______________________________

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
