Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 12:41:19 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:34734 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903735Ab2FGKlO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 12:41:14 +0200
Received: by yhjj52 with SMTP id j52so302313yhj.36
        for <linux-mips@linux-mips.org>; Thu, 07 Jun 2012 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=rWD+8FTi1HDtlq6EUGOISh5BVT+HyrBdwjFZ0LRDwVM=;
        b=igFd6OXETh3aaqflHDyitSy+c9uO7Es0hnaFakriIVEViCMDo8AmTy3MseKp8RKZy/
         lOoVmeLegCpuZ4qvgEufNc6Z4QZzSHQH3r7SvgFLiQzijIASapv77cx0n0bxtYgqtghT
         A96OpTKyGL7RJxbWOENz8s4+Ab8jihcdNstEMf33Fsr/hjYwvguu2JYT66/douz8CkUf
         aj9Wbnq2e44sRv/tuqIZ+lmUYEv3ln0VA1x3ifEV+0C9NHW+QYUmWXs2LCWvyBkeNBqk
         hd4eY05+ZBh+ZRZQ0T+yZmfQSXeiYaHR3ToND8hCxM7yEZ+0pZegOjTCScEg7c3ChVfU
         MNsw==
MIME-Version: 1.0
Received: by 10.236.173.135 with SMTP id v7mr1525232yhl.19.1339065667772; Thu,
 07 Jun 2012 03:41:07 -0700 (PDT)
Received: by 10.146.205.5 with HTTP; Thu, 7 Jun 2012 03:41:07 -0700 (PDT)
Date:   Thu, 7 Jun 2012 20:41:07 +1000
Message-ID: <CANpj82+h1a0qBfaaYpqmuL69JpbB+T_z0pg0iL=5JPBvDE9A2w@mail.gmail.com>
Subject: Patch for the "ug" bug
From:   Jean-Yves Avenard <jyavenard@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jyavenard@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello

This is my first post here, so hopefully I'm doing it the right way.

I recently an Asus RT-N66U router, powered by a Broadcom BCM5300. MIPS
based obviously.

I am an infrequent committer of the Tomato firmware team.
One issue was reported that caused quite surprising problems. We call
it the "ug" bug.

In a shell:
cd /tmp
echo "#!/bin/sh" >bug
echo 'echo -n $1.' >>bug
chmod +x bug
for i in 0 1 2 3 4 5 6 7 8 9; do bug $i; done

would result in random data being output.
Typically it would look something like:
ug.1.ug.3.ug.5.ug.ug.ug.ug.root@RT-N66U:/tmp#

This issue affects a few other firmware (ddwrt) in particular. This
doesn't affect Asus stock firmware

After a short investigation, I ruled out that the problem was either
in uclibc or busybox and is something related to an issue in the
kernel

Looking at the kernel shipped with the Asus, they have made some
modifications in how pages are initialised...

The following patch, is a port of the required changes that fix the
memory corruption exposed by the "ug" bug...

Let me know if you would like this patch to be submitted differently.
Not knowing the submit policy, I put it inline, but due to the
presence of tabs (ugh!) it may not come out properly.

The patch is for the linux that ships with Tomato obviously, but
checking the linux git repository, it will apply with minor mod. Let
me know if you want me to do those mods for you..

Best regards
Jean-Yves Avenard


>From 6e9e332d29f6cb6e5439f728a2b7cb2adf861002 Mon Sep 17 00:00:00 2001
From: Jean-Yves Avenard <jyavenard@mythtv.org>
Date: Thu, 7 Jun 2012 20:31:54 +1000
Subject: [PATCH] Fix "ug" bug

Port page map changes from Asus RT-N66U stock firmware
---
 .../linux/linux-2.6/arch/mips/kernel/syscall.c     |    2 +
 .../src-rt/linux/linux-2.6/arch/mips/mm/c-r4k.c    |   31 ++++++++++---
 .../src-rt/linux/linux-2.6/arch/mips/mm/cache.c    |    9 ++++
 .../src-rt/linux/linux-2.6/arch/mips/mm/highmem.c  |   48 ++++++++++++++------
 release/src-rt/linux/linux-2.6/arch/mips/mm/init.c |    5 +-
 .../linux/linux-2.6/arch/mips/mm/pgtable-32.c      |    2 +-
 .../linux/linux-2.6/include/asm-mips/fixmap.h      |   11 ++++-
 .../src-rt/linux/linux-2.6/include/asm-mips/page.h |    8 ++++
 8 files changed, 92 insertions(+), 24 deletions(-)

diff --git a/release/src-rt/linux/linux-2.6/arch/mips/kernel/syscall.c
b/release/src-rt/linux/linux-2.6/arch/mips/kernel/syscall.c
index a0a3771..54cbf54 100644
--- a/release/src-rt/linux/linux-2.6/arch/mips/kernel/syscall.c
+++ b/release/src-rt/linux/linux-2.6/arch/mips/kernel/syscall.c
@@ -56,8 +56,10 @@ out:
 }

 unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
+unsigned char shm_align_shift = PAGE_SHIFT;	/* Sane caches */

 EXPORT_SYMBOL(shm_align_mask);
+EXPORT_SYMBOL(shm_align_shift);

 #define COLOUR_ALIGN(addr,pgoff)				\
 	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
diff --git a/release/src-rt/linux/linux-2.6/arch/mips/mm/c-r4k.c
b/release/src-rt/linux/linux-2.6/arch/mips/mm/c-r4k.c
index 23e8fe3..67a7171 100644
--- a/release/src-rt/linux/linux-2.6/arch/mips/mm/c-r4k.c
+++ b/release/src-rt/linux/linux-2.6/arch/mips/mm/c-r4k.c
@@ -994,6 +994,30 @@ static void __cpuinit probe_pcache(void)
 	       dcache_size >> 10, way_string[c->dcache.ways], c->dcache.linesz);
 }

+void __init r4k_probe_cache(void)
+{
+	unsigned long config1 = read_c0_config1();
+	unsigned int dcache_size, lsize, ways, sets;
+
+	if ((lsize = ((config1 >> 10) & 7)))
+		lsize = 2 << lsize;
+
+	sets = 64 << ((config1 >> 13) & 7);
+	ways = 1 + ((config1 >> 7) & 7);
+
+	if (lsize) {
+                shm_align_mask = max_t( unsigned long,
+                                        sets * lsize - 1,
+                                        PAGE_SIZE - 1);
+
+                if (shm_align_mask != (PAGE_SIZE - 1))
+                        shm_align_shift = ffs((shm_align_mask + 1)) - 1;
+        } else
+                shm_align_mask = PAGE_SIZE-1;
+
+		
+}
+
 /*
  * If you even _breathe_ on this function, look at the gcc output and make sure
  * it does not pop things on and off the stack for the cache sizing loop that
@@ -1262,12 +1286,7 @@ void __cpuinit r4k_cache_init(void)
 	 * This code supports virtually indexed processors and will be
 	 * unnecessarily inefficient on physically indexed processors.
 	 */
-	if (c->dcache.linesz)
-		shm_align_mask = max_t( unsigned long,
-					c->dcache.sets * c->dcache.linesz - 1,
-					PAGE_SIZE - 1);
-	else
-		shm_align_mask = PAGE_SIZE-1;
+
 	flush_cache_all		= r4k_flush_cache_all;
 	__flush_cache_all	= r4k___flush_cache_all;
 	flush_cache_mm		= r4k_flush_cache_mm;
diff --git a/release/src-rt/linux/linux-2.6/arch/mips/mm/cache.c
b/release/src-rt/linux/linux-2.6/arch/mips/mm/cache.c
index cc26edb..3acb137 100644
--- a/release/src-rt/linux/linux-2.6/arch/mips/mm/cache.c
+++ b/release/src-rt/linux/linux-2.6/arch/mips/mm/cache.c
@@ -148,6 +148,15 @@ void __update_cache(struct vm_area_struct *vma,
unsigned long address,
 static char cache_panic[] __cpuinitdata =
 	"Yeee, unsupported cache architecture.";

+void __init cpu_early_probe_cache(void)
+{
+	if (cpu_has_4k_cache) {
+		extern void __weak r4k_probe_cache(void);
+
+		return r4k_probe_cache();
+	}
+}
+
 void __cpuinit cpu_cache_init(void)
 {
 	if (cpu_has_3k_cache) {
diff --git a/release/src-rt/linux/linux-2.6/arch/mips/mm/highmem.c
b/release/src-rt/linux/linux-2.6/arch/mips/mm/highmem.c
index e2e3c6b..2feb5b7 100644
--- a/release/src-rt/linux/linux-2.6/arch/mips/mm/highmem.c
+++ b/release/src-rt/linux/linux-2.6/arch/mips/mm/highmem.c
@@ -39,6 +39,7 @@ void __kunmap(struct page *page)
 struct kmap_map {
 	struct page *page;
 	void        *vaddr;
+	unsigned long	pfn;
 };

 struct {
@@ -61,8 +62,9 @@ kmap_atomic_page_address(struct page *page)

 void *__kmap_atomic(struct page *page, enum km_type type)
 {
-	enum fixed_addresses idx;
+	unsigned int idx;
 	unsigned long vaddr;
+	unsigned long pfn;

 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	pagefault_disable();
@@ -70,31 +72,38 @@ void *__kmap_atomic(struct page *page, enum km_type type)
 		return page_address(page);

 	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	pfn = page_to_pfn(page);
+	vaddr = fix_to_virt_noalias(VALIAS_IDX(FIX_KMAP_BEGIN + idx), pfn);
 #ifdef CONFIG_DEBUG_HIGHMEM
-	if (!pte_none(*(kmap_pte-idx)))
+	if (!pte_none(*(kmap_pte-(virt_to_fix(vaddr) - VALIAS_IDX(FIX_KMAP_BEGIN)))))
 		BUG();
 #endif
-	set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
+	/* Vaddr could have been adjusted to avoid virt aliasing,
+	 * recalculate the idx from vaddr.
+	 */
+	set_pte(kmap_pte-(virt_to_fix(vaddr) - VALIAS_IDX(FIX_KMAP_BEGIN)), \
+		 mk_pte(page, kmap_prot));
 	local_flush_tlb_one((unsigned long)vaddr);

 	kmap_atomic_maps[smp_processor_id()].map[type].page = page;
 	kmap_atomic_maps[smp_processor_id()].map[type].vaddr = (void *)vaddr;
-
+	kmap_atomic_maps[smp_processor_id()].map[type].pfn = pfn;
+	
 	return (void*) vaddr;
 }

 void __kunmap_atomic(void *kvaddr, enum km_type type)
 {
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
+	unsigned int idx = type + KM_TYPE_NR*smp_processor_id();
+	unsigned long pfn  = kmap_atomic_maps[smp_processor_id()].map[type].pfn;

 	if (vaddr < FIXADDR_START) { // FIXME
 		pagefault_enable();
 		return;
 	}

-	if (vaddr != __fix_to_virt(FIX_KMAP_BEGIN+idx))
+	if (vaddr != fix_to_virt_noalias(VALIAS_IDX(FIX_KMAP_BEGIN + idx), pfn))
 		BUG();

 	/*
@@ -104,7 +113,8 @@ void __kunmap_atomic(void *kvaddr, enum km_type type)
 	if ( kmap_atomic_maps[smp_processor_id()].map[type].vaddr ) {
 		kmap_atomic_maps[smp_processor_id()].map[type].page = (struct page *)0;
 		kmap_atomic_maps[smp_processor_id()].map[type].vaddr = (void *) 0;
-
+		kmap_atomic_maps[smp_processor_id()].map[type].pfn = 0;
+		
 		flush_data_cache_page((unsigned long)vaddr);
 	}

@@ -113,7 +123,7 @@ void __kunmap_atomic(void *kvaddr, enum km_type type)
 	 * force other mappings to Oops if they'll try to access
 	 * this pte without first remap it
 	 */
-	pte_clear(&init_mm, vaddr, kmap_pte-idx);
+	pte_clear(&init_mm, vaddr, kmap_pte-(virt_to_fix(vaddr) -
VALIAS_IDX(FIX_KMAP_BEGIN)));
 	local_flush_tlb_one(vaddr);
 #endif

@@ -126,14 +136,23 @@ void __kunmap_atomic(void *kvaddr, enum km_type type)
  */
 void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
 {
-	enum fixed_addresses idx;
+	unsigned int idx;
 	unsigned long vaddr;

 	pagefault_disable();

 	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));
+	vaddr = fix_to_virt_noalias(VALIAS_IDX(FIX_KMAP_BEGIN + idx), pfn);
+	/* Vaddr could have been adjusted to avoid virt aliasing,
+	 * recalculate the idx from vaddr.
+	 */
+	set_pte(kmap_pte-(virt_to_fix(vaddr) - VALIAS_IDX(FIX_KMAP_BEGIN)), \
+		 pfn_pte(pfn, kmap_prot));
+
+	kmap_atomic_maps[smp_processor_id()].map[type].page = (struct page *)0;
+	kmap_atomic_maps[smp_processor_id()].map[type].vaddr = (void *) vaddr;
+	kmap_atomic_maps[smp_processor_id()].map[type].pfn = pfn;
+	
 	flush_tlb_one(vaddr);

 	return (void*) vaddr;
@@ -141,14 +160,13 @@ void *kmap_atomic_pfn(unsigned long pfn, enum
km_type type)

 struct page *__kmap_atomic_to_page(void *ptr)
 {
-	unsigned long idx, vaddr = (unsigned long)ptr;
+	unsigned long vaddr = (unsigned long)ptr;
 	pte_t *pte;

 	if (vaddr < FIXADDR_START)
 		return virt_to_page(ptr);

-	idx = virt_to_fix(vaddr);
-	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
+	pte = kmap_pte - (virt_to_fix(vaddr) - VALIAS_IDX(FIX_KMAP_BEGIN));
 	return pte_page(*pte);
 }

diff --git a/release/src-rt/linux/linux-2.6/arch/mips/mm/init.c
b/release/src-rt/linux/linux-2.6/arch/mips/mm/init.c
index 12793c9..528a6ee 100644
--- a/release/src-rt/linux/linux-2.6/arch/mips/mm/init.c
+++ b/release/src-rt/linux/linux-2.6/arch/mips/mm/init.c
@@ -62,6 +62,7 @@
 #endif /* CONFIG_MIPS_MT_SMTC */

 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+extern void cpu_early_probe_cache();

 /*
  * We have up to 8 empty zeroed pages so we can map one of the right colour
@@ -286,7 +287,7 @@ static void __init kmap_init(void)
 	unsigned long kmap_vstart;

 	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
+	kmap_vstart = __fix_to_virt(VALIAS_IDX(FIX_KMAP_BEGIN));
 	kmap_pte = kmap_get_fixmap_pte(kmap_vstart);

 	kmap_prot = PAGE_KERNEL;
@@ -362,6 +363,8 @@ void __init paging_init(void)
 	unsigned long lastpfn;
 #endif /* CONFIG_FLATMEM */

+	cpu_early_probe_cache();
+	
 	pagetable_init();

 #ifdef CONFIG_HIGHMEM
diff --git a/release/src-rt/linux/linux-2.6/arch/mips/mm/pgtable-32.c
b/release/src-rt/linux/linux-2.6/arch/mips/mm/pgtable-32.c
index adc6911..7a89f48 100644
--- a/release/src-rt/linux/linux-2.6/arch/mips/mm/pgtable-32.c
+++ b/release/src-rt/linux/linux-2.6/arch/mips/mm/pgtable-32.c
@@ -51,7 +51,7 @@ void __init pagetable_init(void)
 	/*
 	 * Fixed mappings:
 	 */
-	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
+	vaddr = __fix_to_virt(VALIAS_IDX(__end_of_fixed_addresses - 1)) & PMD_MASK;
 	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);

 #ifdef CONFIG_HIGHMEM
diff --git a/release/src-rt/linux/linux-2.6/include/asm-mips/fixmap.h
b/release/src-rt/linux/linux-2.6/include/asm-mips/fixmap.h
index 4c23947..a6761c6 100644
--- a/release/src-rt/linux/linux-2.6/include/asm-mips/fixmap.h
+++ b/release/src-rt/linux/linux-2.6/include/asm-mips/fixmap.h
@@ -84,12 +84,21 @@ extern void __set_fixmap (enum fixed_addresses idx,
 #else
 #define FIXADDR_TOP	((unsigned long)(long)(int)0xfffe0000)
 #endif
-#define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_SIZE	(__end_of_fixed_addresses << (VALIAS_PAGE_SHIFT))
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)

 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)

+static inline unsigned long fix_to_virt_noalias(const unsigned int x,
unsigned long pfn)
+{
+	unsigned long vaddr = __fix_to_virt(x);
+	unsigned long poffset = (pfn << PAGE_SHIFT) & VALIAS_PAGE_OFFSET_MASK;
+	unsigned long voffset = vaddr & VALIAS_PAGE_OFFSET_MASK;
+
+	return ((!voffset || (poffset >= voffset)) ? (vaddr |
poffset):(vaddr | poffset | VALIAS_PAGE_SIZE));
+}
+
 extern void __this_fixmap_does_not_exist(void);

 /*
diff --git a/release/src-rt/linux/linux-2.6/include/asm-mips/page.h
b/release/src-rt/linux/linux-2.6/include/asm-mips/page.h
index fa7289f..96f5245 100644
--- a/release/src-rt/linux/linux-2.6/include/asm-mips/page.h
+++ b/release/src-rt/linux/linux-2.6/include/asm-mips/page.h
@@ -56,6 +56,14 @@ extern void clear_page(void * page);
 extern void copy_page(void * to, void * from);

 extern unsigned long shm_align_mask;
+extern unsigned char shm_align_shift;
+
+#define VALIAS_PAGE_OFFSET_MASK	(shm_align_mask)
+#define VALIAS_PAGE_MASK	(~VALIAS_PAGE_OFFSET_MASK)
+#define VALIAS_PAGE_SHIFT	(shm_align_shift)
+#define VALIAS_SHIFT		(VALIAS_PAGE_SHIFT - PAGE_SHIFT)
+#define VALIAS_PAGE_SIZE	(1UL << VALIAS_PAGE_SHIFT)
+#define VALIAS_IDX(x)		((x) << VALIAS_SHIFT)

 static inline unsigned long pages_do_alias(unsigned long addr1,
 	unsigned long addr2)
-- 
1.7.9.5
