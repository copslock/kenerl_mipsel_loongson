Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2008 02:32:02 +0000 (GMT)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:50249 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28580631AbYCMCb7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Mar 2008 02:31:59 +0000
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-2.cisco.com with ESMTP; 12 Mar 2008 19:31:51 -0700
Received: from sj-core-3.cisco.com (sj-core-3.cisco.com [171.68.223.137])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id m2D2Vo3P016677
	for <linux-mips@linux-mips.org>; Wed, 12 Mar 2008 19:31:50 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-3.cisco.com (8.13.8/8.13.8) with ESMTP id m2D2Vo9R026416
	for <linux-mips@linux-mips.org>; Thu, 13 Mar 2008 02:31:50 GMT
Received: from [127.0.0.1] ([64.100.151.68]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id CAA15997 for <linux-mips@linux-mips.org>; Thu, 13 Mar 2008 02:31:49 GMT
Message-ID: <47D89211.1020504@cisco.com>
Date:	Wed, 12 Mar 2008 19:31:45 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH 2.6.24][MIPS]Work in progress: fix HIGHMEM-enabled dcache
 flushing on 32-bit processor
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=6178; t=1205375510; x=1206239510;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20[PATCH=202.6.24][MIPS]Work=20in=20progress=3A=2
	0fix=20HIGHMEM-enabled=20dcache=0A=20flushing=20on=2032-bit=
	20processor
	|Sender:=20;
	bh=Y/n3TOKq75DuMgg4qyR/Yb1m1CXyHGNqn7R5BgDZ20c=;
	b=AQDqQajAkFd0xRKChiGcbVJBvzUwlVafAKCFJDCb1pCZ808FV0aiYaIuwl
	OadzlZSB2FZhrXznB5o9MT4HfOoczAl2o9WfoTOaOgBZAmvfTWcOm761m6JU
	1gcfiaeaOL;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

This patch is a work in progress, per Ralf's suggestion from last week. It is 
intended to fix dcache flushing issues when using HIGHMEM support. We get much 
better results with this patch applied, but I would not characterize our 2.6.24 
port as stable, yet, so there may be other HIGHMEM-related issues.

Any comments welcome. Thanks!

David VomLehn

diff -urN a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
--- a/arch/mips/mm/cache.c	2008-01-24 14:58:37.000000000 -0800
+++ b/arch/mips/mm/cache.c	2008-03-12 19:11:39.000000000 -0700
@@ -19,6 +19,7 @@
  #include <asm/processor.h>
  #include <asm/cpu.h>
  #include <asm/cpu-features.h>
+#include <asm/highmem.h>

  /* Cache operations. */
  void (*flush_cache_all)(void);
@@ -70,10 +71,28 @@
  void __flush_dcache_page(struct page *page)
  {
  	struct address_space *mapping = page_mapping(page);
-	unsigned long addr;
+	void	* addr;

+#ifndef CONFIG_HIGHMEM
  	if (PageHighMem(page))
  		return;
+#endif
+
+	/* If there is a temporary kernel mapping, i.e. if kmap_atomic was
+	 * used to map a page, we only need to flush the page. We can skip
+	 * the other work here because it won't be used in any other way. */
+	if (PageHighMem(page)) {
+		addr = kmap_atomic_to_vaddr(page);
+		if (addr != NULL) {
+			flush_data_cache_page((unsigned long) addr);
+			return;
+		}
+	}
+
+	/* If page_mapping returned a non-NULL value, then the page is not
+	 * in the swap cache and it isn't anonymously mapped. If it's not
+	 * already mapped into user space, we can just set the dirty bit to
+	 * get the cache flushed later, if needed */
  	if (mapping && !mapping_mapped(mapping)) {
  		SetPageDcacheDirty(page);
  		return;
@@ -84,8 +103,10 @@
  	 * case is for exec env/arg pages and those are %99 certainly going to
  	 * get faulted into the tlb (and thus flushed) anyways.
  	 */
-	addr = (unsigned long) page_address(page);
-	flush_data_cache_page(addr);
+	addr = page_address(page);
+	/* If the page is not mapped for kernel access, don't flush it */
+	if (addr != NULL)
+		flush_data_cache_page((unsigned long) addr);
  }

  EXPORT_SYMBOL(__flush_dcache_page);
diff -urN a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
--- a/arch/mips/mm/highmem.c	2008-01-24 14:58:37.000000000 -0800
+++ b/arch/mips/mm/highmem.c	2008-03-12 18:58:10.000000000 -0700
@@ -25,6 +25,25 @@
  }

  /*
+ * Describes one page->virtual association in kmap_atomic
+ */
+struct kmap_atomic_map {
+	struct list_head list;
+	struct page *page;
+};
+
+/*
+ * Array of linked lists of the mappings currently in use. The array is
+ * indexed by the CPU number, so we don't have to worry about synchronizing
+ * between the CPUs. We can add maps in interrupt handlers, however, so
+ * we will need to block interrupts when manipulating the linked list.
+ */
+static struct kmap_atomic_map_list {
+	struct list_head lh;
+	struct kmap_atomic_map map_pool[KM_TYPE_NR];
+} ____cacheline_aligned_in_smp map_list[NR_CPUS];
+
+/*
   * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
   * no global lock is needed and because the kmap code must perform a global TLB
   * invalidation when the kmap pool wraps.
@@ -37,6 +56,7 @@
  {
  	enum fixed_addresses idx;
  	unsigned long vaddr;
+	unsigned long flags;

  	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
  	pagefault_disable();
@@ -52,11 +72,18 @@
  	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
  	local_flush_tlb_one((unsigned long)vaddr);

+	local_irq_save(flags);
+	map_list[smp_processor_id()].map_pool[type].page = page;
+	list_add(&(map_list[smp_processor_id()].map_pool[type]).list, 
&map_list[smp_processor_id()].lh);
+	local_irq_restore(flags);
+
  	return (void*) vaddr;
  }

  void __kunmap_atomic(void *kvaddr, enum km_type type)
  {
+	unsigned long flags;
+
  #ifdef CONFIG_DEBUG_HIGHMEM
  	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
  	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
@@ -75,8 +102,14 @@
  	 */
  	pte_clear(&init_mm, vaddr, kmap_pte-idx);
  	local_flush_tlb_one(vaddr);
+
+	map_list[smp_processor_id()].map_pool[type].page = NULL;
  #endif

+	local_irq_save(flags);
+	list_del(&(map_list[smp_processor_id()].map_pool[type]).list);
+	local_irq_restore(flags);
+
  	pagefault_enable();
  }

@@ -112,6 +145,40 @@
  	return pte_page(*pte);
  }

+void *kmap_atomic_to_vaddr(struct page *page)
+{
+	unsigned long flags;
+	struct kmap_atomic_map *map;
+	unsigned long vaddr = 0;
+
+	local_irq_save(flags);
+	list_for_each_entry(map, &map_list[smp_processor_id()].lh, list) {
+		if (map->page == page) {
+			vaddr = __fix_to_virt(FIX_KMAP_BEGIN +
+				(map - map_list[smp_processor_id()].map_pool));
+			break;
+		}
+	}
+	local_irq_restore(flags);
+
+	return (void *)vaddr;		
+}
+
+void __init kmap_atomic_init(void)
+{
+	int i, j;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		INIT_LIST_HEAD(&map_list[i].lh);
+#ifdef CONFIG_DEBUG_HIGHMEM
+		for (j = 0; j < KM_TYPE_NR; j++) {
+			INIT_LIST_HEAD(&(map_list[i].map_pool[j]).list);
+			map_list[i].map_pool[j].page = NULL;
+		}
+#endif
+	}
+}
+
  EXPORT_SYMBOL(__kmap);
  EXPORT_SYMBOL(__kunmap);
  EXPORT_SYMBOL(__kmap_atomic);
diff -urN a/arch/mips/mm/init.c b/arch/mips/mm/init.c
--- a/arch/mips/mm/init.c	2008-01-24 14:58:37.000000000 -0800
+++ b/arch/mips/mm/init.c	2008-03-12 19:12:51.000000000 -0700
@@ -354,6 +354,7 @@

  #ifdef CONFIG_HIGHMEM
  	kmap_init();
+	kmap_atomic_init();
  #endif
  	kmap_coherent_init();

diff -urN a/include/asm-mips/highmem.h b/include/asm-mips/highmem.h
--- a/include/asm-mips/highmem.h	2008-01-24 14:58:37.000000000 -0800
+++ b/include/asm-mips/highmem.h	2008-03-12 18:57:22.000000000 -0700
@@ -55,6 +55,9 @@
  extern void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
  extern struct page *__kmap_atomic_to_page(void *ptr);

+extern void *kmap_atomic_to_vaddr(struct page *page);
+extern void kmap_atomic_init(void);
+
  #define kmap			__kmap
  #define kunmap			__kunmap
  #define kmap_atomic		__kmap_atomic
