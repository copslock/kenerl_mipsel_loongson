Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 13:08:17 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:480 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133476AbWBNNIG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2006 13:08:06 +0000
Received: from localhost (p3141-ipad30funabasi.chiba.ocn.ne.jp [221.184.78.141])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 75E36AEB9; Tue, 14 Feb 2006 22:14:22 +0900 (JST)
Date:	Tue, 14 Feb 2006 22:14:08 +0900 (JST)
Message-Id: <20060214.221408.74751414.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060214.191215.115641299.nemoto@toshiba-tops.co.jp>
References: <20060214.164216.48797359.nemoto@toshiba-tops.co.jp>
	<200602140856.k1E8uvm1021728@mbox03.po.2iij.net>
	<20060214.191215.115641299.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Revised.

There are several cache-related problems with multi-threaded program
and fork().


Problem-1:  copy-on-write and signal trampoline on harvard-cache.
[previously reported with subject: missing data cache flush for signal trampoline on fork]

A program which is heavily using signal and fork occasionally killed
by SIGSEGV, etc.  When it was killed, PC is always near the stack
pointer.

This would happen on CPUs without MIPS_CACHE_IC_F_DC.  D-cache
aliasing is irrelevant.

1. To handle a delivered signal, a signal-trampoline code are written
to the stack page.

2. They are flushed to memory immediately and I-cache are invalidated.

3. If other thread called fork() before the signal handler is
executed, all writable pages (including the stack page) are marked as
COW page.

4. When the user signal handler is to write to the stack, the page
will be copied to new physical page by copy_user_highpage(), but not
flushed to main memory.

5. Then flush_cache_page() is called for the stack page, but it does
not flush the cache written by copy_user_highpage() because new PTE is
not established yet.

6. When returned from the user signal handler, the signal trampoline
code might not be written to main memory.  Garbage code will be
executed and the program will die.


Problem-2:  copy-on-write and dcache-aliasing
[previously reported with subject: dcache aliasing problem on fork]

1. Now there is a process containing two thread (T1 and T2).  The
   thread T1 calls fork().  Then dup_mmap() function called on T1 context.

static inline int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
	...
	flush_cache_mm(current->mm);
	...	/* A */
	(write-protect all Copy-On-Write pages)
	...	/* B */
	flush_tlb_mm(current->mm);
	...

2. When preemption happens between A and B (or on SMP kernel), the
   thread T2 can run and modify data on COW pages without page fault
   (modified data will stay in cache).

3. Some time after fork() completed, the thread T2 may cause a page
   fault by write-protect on a COW page.

4. Then data of the COW page will be copied to newly allocated
   physical page (copy_cow_page()).  It reads data via kernel mapping.
   The kernel mapping can have different 'color' with user space
   mapping of the thread T2 (dcache aliasing).  Therefore
   copy_cow_page() will copy stale data.  Then the modified data in
   cache will be lost.


This patch fixes above problems using custom copy_user_highpage().  It
uses kmap_coherent() to map an user page for kernel with same color.
Also copy_to_user_page() and copy_from_user_page() are rewritten using
the kmap_coherent() to avoid extra cache flushing.


The main part of this patch was originally written by Ralf Baechle.

 arch/mips/mm/init.c           |  138 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-mips/cacheflush.h |   14 ++--
 include/asm-mips/fixmap.h     |    8 +-
 include/asm-mips/page.h       |   14 +---
 include/linux/highmem.h       |    7 +-
 mm/memory.c                   |    8 +-
 6 files changed, 166 insertions(+), 23 deletions(-)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 0ff9a34..dee0b2b 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -30,11 +30,15 @@
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
+#include <asm/interrupt.h>
+#include <asm/kmap_types.h>
+#include <asm/mipsmtregs.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/fixmap.h>
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
@@ -79,6 +83,140 @@ unsigned long setup_zero_pages(void)
 	return 1UL << order;
 }
 
+/*
+ * These are almost like kmap_atomic / kunmap_atmic except they take an
+ * additional address argument as the hint.
+ */
+
+static inline void *kmap_coherent(struct page *page, unsigned long addr)
+{
+	unsigned long vaddr, flags, entrylo;
+	enum fixed_addresses idx;
+	unsigned long asid;
+	unsigned int vpflags;
+	unsigned int wired;
+	pte_t pte;
+
+	if (!cpu_has_dc_aliases)
+		return page_address(page);
+	inc_preempt_count();
+
+	if (cpu_has_mipsmt)
+		vpflags = dvpe();
+	local_irq_save(flags);
+
+	idx = (addr >> 12) & 7;
+	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
+
+	asid = read_c0_entryhi();
+	wired = read_c0_wired();
+	write_c0_wired(wired + 1);
+	write_c0_index(wired);
+	write_c0_entryhi(vaddr & (PAGE_MASK << 1));
+	pte = mk_pte(page, PAGE_KERNEL);
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+	entrylo = pte.pte_high;
+#else
+	entrylo = pte_val(pte) >> 6;
+#endif
+	write_c0_entrylo0(entrylo);
+	write_c0_entrylo1(entrylo);
+	mtc0_tlbw_hazard();
+	tlb_write_indexed();
+	write_c0_entryhi(asid);
+
+	local_irq_restore(flags);
+	if (cpu_has_mipsmt)
+		evpe(vpflags);
+
+	return (void*) vaddr;
+}
+
+#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
+
+static inline void kunmap_coherent(void)
+{
+	unsigned int vpflags, wired;
+	unsigned long flags, asid;
+
+	if (!cpu_has_dc_aliases)
+		return;
+	if (cpu_has_mipsmt)
+		vpflags = dvpe();
+	local_irq_save(flags);
+
+	asid = read_c0_entryhi();
+	wired = read_c0_wired() - 1;
+	write_c0_wired(wired);
+	write_c0_index(wired);
+	write_c0_entryhi(UNIQUE_ENTRYHI(wired));
+	write_c0_entrylo0(0);
+	write_c0_entrylo1(0);
+	mtc0_tlbw_hazard();
+	tlb_write_indexed();
+	write_c0_entryhi(asid);
+
+	local_irq_restore(flags);
+	if (cpu_has_mipsmt)
+		evpe(vpflags);
+
+	dec_preempt_count();
+	preempt_check_resched();
+}
+
+void copy_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma)
+{
+	char *vfrom, *vto;
+	/*
+	 * Map 'from' page to same color with vaddr and map 'to' page
+	 * to kernel, and flush 'to' page if needed.
+	 * Just using kmap_coherent for both 'from' and 'to' (and no
+	 * flushing) is not enough because:
+	 * 1. The signal trampoline code should be flushed to main memory.
+	 * 2. The page 'to' might have been cached via kernel mapping.
+	 */
+	vfrom = kmap_coherent(from, vaddr);
+	vto = kmap_atomic(to, KM_USER1);
+	copy_page(vto, vfrom);
+	if (((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc) ||
+	    (cpu_has_dc_aliases && pages_do_alias((unsigned long)vto, vaddr)))
+		flush_data_cache_page((unsigned long)vto);
+	kunmap_atomic(vto, KM_USER1);
+	kunmap_coherent();
+	/* Make sure this page is cleared on other CPU's too before using it */
+	smp_wmb();
+}
+
+EXPORT_SYMBOL(copy_user_highpage);
+
+void __copy_to_user_page(struct vm_area_struct *vma,
+	struct page *page, unsigned long vaddr, const void *src,
+	unsigned long len)
+{
+	char *vto;
+
+	vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
+	memcpy(vto, src, len);
+	kunmap_coherent();
+	flush_icache_page(vma, page);
+}
+
+EXPORT_SYMBOL(__copy_to_user_page);
+
+void __copy_from_user_page(struct page *page, unsigned long vaddr,
+	void *dst, unsigned long len)
+{
+	char *vfrom;
+
+	vfrom = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
+	memcpy(dst, vfrom, len);
+	kunmap_coherent();
+}
+
+EXPORT_SYMBOL(__copy_from_user_page);
+
+
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
 pgprot_t kmap_prot;
diff --git a/include/asm-mips/cacheflush.h b/include/asm-mips/cacheflush.h
index aeae9fa..7e4c30d 100644
--- a/include/asm-mips/cacheflush.h
+++ b/include/asm-mips/cacheflush.h
@@ -53,23 +53,23 @@ extern void (*flush_icache_range)(unsign
 #define flush_cache_vmap(start, end)		flush_cache_all()
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
+extern void __copy_to_user_page(struct vm_area_struct *vma,
+	struct page *page, unsigned long vaddr, const void *src,
+	unsigned long len);
 static inline void copy_to_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len)
 {
-	if (cpu_has_dc_aliases)
-		flush_cache_page(vma, vaddr, page_to_pfn(page));
-	memcpy(dst, src, len);
-	flush_icache_page(vma, page);
+	__copy_to_user_page(vma, page, vaddr, src, len);
 }
 
+extern void __copy_from_user_page(struct page *page, unsigned long vaddr,
+	void *dst, unsigned long len);
 static inline void copy_from_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len)
 {
-	if (cpu_has_dc_aliases)
-		flush_cache_page(vma, vaddr, page_to_pfn(page));
-	memcpy(dst, src, len);
+	__copy_from_user_page(page, vaddr, dst, len);
 }
 
 extern void (*flush_cache_sigtramp)(unsigned long addr);
diff --git a/include/asm-mips/fixmap.h b/include/asm-mips/fixmap.h
index 73a3028..3dc8af6 100644
--- a/include/asm-mips/fixmap.h
+++ b/include/asm-mips/fixmap.h
@@ -46,8 +46,12 @@
  * fix-mapped?
  */
 enum fixed_addresses {
+#define FIX_N_COLOURS 8
+	FIX_CMAP_BEGIN,
+	FIX_CMAP_END = FIX_CMAP_BEGIN + FIX_N_COLOURS,
 #ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
+	/* reserved pte's for temporary kernel mappings */
+	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
 	__end_of_fixed_addresses
@@ -70,7 +74,7 @@ extern void __set_fixmap (enum fixed_add
  * the start of the fixmap, and leave one page empty
  * at the top of mem..
  */
-#define FIXADDR_TOP	(0xffffe000UL)
+#define FIXADDR_TOP	((unsigned long)(long)(int)0xfffe0000)
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index ee25a77..a896495 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -62,15 +62,11 @@ static inline void clear_user_page(void 
 		flush_data_cache_page((unsigned long)addr);
 }
 
-static inline void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-	struct page *to)
-{
-	extern void (*flush_data_cache_page)(unsigned long addr);
-
-	copy_page(vto, vfrom);
-	if (pages_do_alias((unsigned long)vto, vaddr))
-		flush_data_cache_page((unsigned long)vto);
-}
+struct vm_area_struct;
+extern void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
+
+#define __HAVE_ARCH_COPY_USER_HIGHPAGE
 
 /*
  * These are used to make use of C type-checking..
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6bece92..768914a 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -78,7 +78,10 @@ static inline void memclear_highpage_flu
 	kunmap_atomic(kaddr, KM_USER0);
 }
 
-static inline void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
+#ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
+
+static inline void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma)
 {
 	char *vfrom, *vto;
 
@@ -91,6 +94,8 @@ static inline void copy_user_highpage(st
 	smp_wmb();
 }
 
+#endif
+
 static inline void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
diff --git a/mm/memory.c b/mm/memory.c
index 2bee1f2..653b08f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1386,7 +1386,7 @@ static inline pte_t maybe_mkwrite(pte_t 
 	return pte;
 }
 
-static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va)
+static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
 {
 	/*
 	 * If the source page was a PFN mapping, we don't have
@@ -1410,7 +1410,7 @@ static inline void cow_user_page(struct 
 		return;
 		
 	}
-	copy_user_highpage(dst, src, va);
+	copy_user_highpage(dst, src, va, vma);
 }
 
 /*
@@ -1475,7 +1475,7 @@ gotten:
 		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!new_page)
 			goto oom;
-		cow_user_page(new_page, old_page, address);
+		cow_user_page(new_page, old_page, address, vma);
 	}
 
 	/*
@@ -2074,7 +2074,7 @@ retry:
 		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!page)
 			goto oom;
-		copy_user_highpage(page, new_page, address);
+		copy_user_highpage(page, new_page, address, vma);
 		page_cache_release(new_page);
 		new_page = page;
 		anon = 1;
