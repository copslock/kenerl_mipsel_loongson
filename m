Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2006 20:06:54 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:30163 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20037738AbWKAUGp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Nov 2006 20:06:45 +0000
Received: (qmail 25640 invoked by uid 101); 1 Nov 2006 20:06:34 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 1 Nov 2006 20:06:34 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id kA1K6PPd022922
	for <linux-mips@linux-mips.org>; Wed, 1 Nov 2006 12:06:34 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <VY7RV4BN>; Wed, 1 Nov 2006 12:06:25 -0800
Message-ID: <E8C8A5231DDE104C816ADF532E0639120194F4B2@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Problems booting Linux 2.6.18.1 on MIPS34K core
Date:	Wed, 1 Nov 2006 12:06:15 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Trevor_Hamm@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Trevor_Hamm@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Since upgrading our Linux kernel from 2.6.17 to 2.6.18.1, we've had problems booting a board using the MIPS 34K core.  The kernel is configured for UP (no SMP or SMTC).  The boot hangs right around the time when /sbin/init is executed (after the "Freeing unused kernel memory" message).  This only happens when booting right after power-cycling the board.  The boot succeeds after a reset.

My investigation shows this behaviour was introduced between 2.6.17.10 and 2.6.17.12 (2.6.17.11 failed to build, so I didn't test that version).  In fact, the patch below, applied against 2.6.17.10, is sufficient to cause the boot problem.  The bulk of this patch includes a fix from Aug. 31, 2006 for dcache aliasing on fork.  If I exclude the dcache aliasing fix from this patch, the boot problem apparently disappears.

Some more interesting details:
- We're using a squashfs root filesystem in RAM (squashfs 3.1-r2).  We have not been able to reproduce with cramfs.
- /sbin/init is from util-linux 2.12r.  We have not been able to reproduce with sysvinit 2.86.
- When using a EJTAG probe to trace what the kernel is doing at this time it appears to be looping through do_signal(), work_notifysig(), do_notify_resume().

Any insight into possible causes for this lock-up would be greatly appreciated.

Thanks,
Trevor

2.6.17.10-2.6.17.12 patch
=========================

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 6344be4..ff59d8e 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -648,6 +648,10 @@ #endif /* CONFIG_MIPS_MT_FPAFF */
 	sys	sys_splice		4
 	sys	sys_sync_file_range	7	/* 4305 */
 	sys	sys_tee			4
+	sys	sys_vmsplice		4
+	sys	sys_ni_syscall		0
+	sys	sys_set_robust_list	2
+	sys	sys_get_robust_list	3
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 12d96c7..9de0778 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -463,3 +463,7 @@ sys_call_table:
 	PTR	sys_splice
 	PTR	sys_sync_file_range
 	PTR	sys_tee				/* 5265 */
+	PTR	sys_vmsplice
+	PTR	sys_ni_syscall
+	PTR	sys_set_robust_list
+	PTR	sys_get_robust_list
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 6856985..13e36b6 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -389,3 +389,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_splice
 	PTR	sys_sync_file_range
 	PTR	sys_tee
+	PTR	sys_vmsplice			/* 6270 */
+	PTR	sys_ni_syscall
+	PTR	compat_sys_set_robust_list
+	PTR	compat_sys_get_robust_list
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 0e63293..e6c8d1a 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -511,4 +511,8 @@ sys_call_table:
 	PTR	sys_splice
 	PTR	sys32_sync_file_range		/* 4305 */
 	PTR	sys_tee
+	PTR	sys_vmsplice
+	PTR	sys_ni_syscall
+	PTR	compat_sys_set_robust_list
+	PTR	compat_sys_get_robust_list	/* 4310 */
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 5e8a18a..b280f51 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -117,6 +117,22 @@ unsigned long arch_get_unmapped_area(str
 	}
 }
 
+int mips_mmap_check(unsigned long addr, unsigned long len,
+	unsigned long flags)
+{
+#ifdef CONFIG_MIPS32_COMPAT
+	if (current->thread.mflags & MF_32BIT_ADDR) {
+		if (len > TASK_SIZE32)
+			return -EINVAL;
+		if (flags & MAP_FIXED &&
+		    (addr >= TASK_SIZE32 || addr + len >= TASK_SIZE32))
+			return -EINVAL;
+	}
+#endif
+
+	return 0;
+}
+
 /* common code for old and new mmaps */
 static inline unsigned long
 do_mmap2(unsigned long addr, unsigned long len, unsigned long prot,
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index de327b1..e18c39b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -456,7 +456,7 @@ static inline void local_r4k_flush_cache
 		}
 	}
 	if (exec) {
-		if (cpu_has_vtag_icache) {
+		if (cpu_has_vtag_icache && mm == current->active_mm) {
 			int cpu = smp_processor_id();
 
 			if (cpu_context(cpu, mm) != 0)
@@ -580,7 +580,7 @@ static inline void local_r4k_flush_icach
 	 * We're not sure of the virtual address(es) involved here, so
 	 * we have to flush the entire I-cache.
 	 */
-	if (cpu_has_vtag_icache) {
+	if (cpu_has_vtag_icache && vma->vm_mm == current->active_mm) {
 		int cpu = smp_processor_id();
 
 		if (cpu_context(cpu, vma->vm_mm) != 0)
diff --git a/arch/mips/mm/c-sb1.c b/arch/mips/mm/c-sb1.c
index 87c417f..7849678 100644
--- a/arch/mips/mm/c-sb1.c
+++ b/arch/mips/mm/c-sb1.c
@@ -156,6 +156,26 @@ static inline void __sb1_flush_icache_al
 }
 
 /*
+ * Invalidate a range of the icache.  The addresses are virtual, and
+ * the cache is virtually indexed and tagged.  However, we don't
+ * necessarily have the right ASID context, so use index ops instead
+ * of hit ops.
+ */
+static inline void __sb1_flush_icache_range(unsigned long start,
+	unsigned long end)
+{
+	start &= ~(icache_line_size - 1);
+	end = (end + icache_line_size - 1) & ~(icache_line_size - 1);
+
+	while (start != end) {
+		cache_set_op(Index_Invalidate_I, start & icache_index_mask);
+		start += icache_line_size;
+	}
+	mispredict();
+	sync();
+}
+
+/*
  * Flush the icache for a given physical page.  Need to writeback the
  * dcache first, then invalidate the icache.  If the page isn't
  * executable, nothing is required.
@@ -174,8 +194,11 @@ #endif
 	/*
 	 * Bumping the ASID is probably cheaper than the flush ...
 	 */
-	if (cpu_context(cpu, vma->vm_mm) != 0)
-		drop_mmu_context(vma->vm_mm, cpu);
+	if (vma->vm_mm == current->active_mm) {
+		if (cpu_context(cpu, vma->vm_mm) != 0)
+			drop_mmu_context(vma->vm_mm, cpu);
+	} else
+		__sb1_flush_icache_range(addr, addr + PAGE_SIZE);
 }
 
 #ifdef CONFIG_SMP
@@ -211,26 +234,6 @@ void sb1_flush_cache_page(struct vm_area
 	__attribute__((alias("local_sb1_flush_cache_page")));
 #endif
 
-/*
- * Invalidate a range of the icache.  The addresses are virtual, and
- * the cache is virtually indexed and tagged.  However, we don't
- * necessarily have the right ASID context, so use index ops instead
- * of hit ops.
- */
-static inline void __sb1_flush_icache_range(unsigned long start,
-	unsigned long end)
-{
-	start &= ~(icache_line_size - 1);
-	end = (end + icache_line_size - 1) & ~(icache_line_size - 1);
-
-	while (start != end) {
-		cache_set_op(Index_Invalidate_I, start & icache_index_mask);
-		start += icache_line_size;
-	}
-	mispredict();
-	sync();
-}
-
 
 /*
  * Invalidate all caches on this CPU
@@ -327,9 +330,12 @@ #endif
 	 * If there's a context, bump the ASID (cheaper than a flush,
 	 * since we don't know VAs!)
 	 */
-	if (cpu_context(cpu, vma->vm_mm) != 0) {
-		drop_mmu_context(vma->vm_mm, cpu);
-	}
+	if (vma->vm_mm == current->active_mm) {
+		if (cpu_context(cpu, vma->vm_mm) != 0)
+			drop_mmu_context(vma->vm_mm, cpu);
+	} else
+		__sb1_flush_icache_range(start, start + PAGE_SIZE);
+
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 33f6e1c..9068eb3 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -31,11 +31,39 @@ #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
+#include <asm/kmap_types.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/fixmap.h>
+
+/* CP0 hazard avoidance. */
+#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
+				     "nop; nop; nop; nop; nop; nop;\n\t" \
+				     ".set reorder\n\t")
+
+/* Atomicity and interruptability */
+#ifdef CONFIG_MIPS_MT_SMTC
+
+#include <asm/mipsmtregs.h>
+
+#define ENTER_CRITICAL(flags) \
+	{ \
+	unsigned int mvpflags; \
+	local_irq_save(flags);\
+	mvpflags = dvpe()
+#define EXIT_CRITICAL(flags) \
+	evpe(mvpflags); \
+	local_irq_restore(flags); \
+	}
+#else
+
+#define ENTER_CRITICAL(flags) local_irq_save(flags)
+#define EXIT_CRITICAL(flags) local_irq_restore(flags)
+
+#endif /* CONFIG_MIPS_MT_SMTC */
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
@@ -81,13 +109,183 @@ unsigned long setup_zero_pages(void)
 	return 1UL << order;
 }
 
-#ifdef CONFIG_HIGHMEM
-pte_t *kmap_pte;
-pgprot_t kmap_prot;
+/*
+ * These are almost like kmap_atomic / kunmap_atmic except they take an
+ * additional address argument as the hint.
+ */
 
 #define kmap_get_fixmap_pte(vaddr)					\
 	pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr)), (vaddr))
 
+#ifdef CONFIG_MIPS_MT_SMTC
+static pte_t *kmap_coherent_pte;
+static void __init kmap_coherent_init(void)
+{
+	unsigned long vaddr;
+
+	/* cache the first coherent kmap pte */
+	vaddr = __fix_to_virt(FIX_CMAP_BEGIN);
+	kmap_coherent_pte = kmap_get_fixmap_pte(vaddr);
+}
+#else
+static inline void kmap_coherent_init(void) {}
+#endif
+
+static inline void *kmap_coherent(struct page *page, unsigned long addr)
+{
+	enum fixed_addresses idx;
+	unsigned long vaddr, flags, entrylo;
+	unsigned long old_ctx;
+	pte_t pte;
+	unsigned int tlbidx;
+
+	inc_preempt_count();
+	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
+#ifdef CONFIG_MIPS_MT_SMTC
+	idx += FIX_N_COLOURS * smp_processor_id();
+#endif
+	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
+	pte = mk_pte(page, PAGE_KERNEL);
+#if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32_R1)
+	entrylo = pte.pte_high;
+#else
+	entrylo = pte_val(pte) >> 6;
+#endif
+
+	ENTER_CRITICAL(flags);
+	old_ctx = read_c0_entryhi();
+	write_c0_entryhi(vaddr & (PAGE_MASK << 1));
+	write_c0_entrylo0(entrylo);
+	write_c0_entrylo1(entrylo);
+#ifdef CONFIG_MIPS_MT_SMTC
+	set_pte(kmap_coherent_pte - (FIX_CMAP_END - idx), pte);
+	/* preload TLB instead of local_flush_tlb_one() */
+	mtc0_tlbw_hazard();
+	tlb_probe();
+	BARRIER;
+	tlbidx = read_c0_index();
+	mtc0_tlbw_hazard();
+	if (tlbidx < 0)
+		tlb_write_random();
+	else
+		tlb_write_indexed();
+#else
+	tlbidx = read_c0_wired();
+	write_c0_wired(tlbidx + 1);
+	write_c0_index(tlbidx);
+	mtc0_tlbw_hazard();
+	tlb_write_indexed();
+#endif
+	tlbw_use_hazard();
+	write_c0_entryhi(old_ctx);
+	EXIT_CRITICAL(flags);
+
+	return (void*) vaddr;
+}
+
+#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
+
+static inline void kunmap_coherent(struct page *page)
+{
+#ifndef CONFIG_MIPS_MT_SMTC
+	unsigned int wired;
+	unsigned long flags, old_ctx;
+
+	ENTER_CRITICAL(flags);
+	old_ctx = read_c0_entryhi();
+	wired = read_c0_wired() - 1;
+	write_c0_wired(wired);
+	write_c0_index(wired);
+	write_c0_entryhi(UNIQUE_ENTRYHI(wired));
+	write_c0_entrylo0(0);
+	write_c0_entrylo1(0);
+	mtc0_tlbw_hazard();
+	tlb_write_indexed();
+	write_c0_entryhi(old_ctx);
+	EXIT_CRITICAL(flags);
+#endif
+	dec_preempt_count();
+	preempt_check_resched();
+}
+
+void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma)
+{
+	void *vfrom, *vto;
+
+	vto = kmap_atomic(to, KM_USER1);
+	if (cpu_has_dc_aliases) {
+		vfrom = kmap_coherent(from, vaddr);
+		copy_page(vto, vfrom);
+		kunmap_coherent(from);
+	} else {
+		vfrom = kmap_atomic(from, KM_USER0);
+		copy_page(vto, vfrom);
+		kunmap_atomic(vfrom, KM_USER0);
+	}
+	if (((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc) ||
+	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
+		flush_data_cache_page((unsigned long)vto);
+	kunmap_atomic(vto, KM_USER1);
+	/* Make sure this page is cleared on other CPU's too before using it */
+	smp_wmb();
+}
+
+EXPORT_SYMBOL(copy_user_highpage);
+
+void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
+	struct page *to)
+{
+	if (cpu_has_dc_aliases) {
+		struct page *from = virt_to_page(vfrom);
+		vfrom = kmap_coherent(from, vaddr);
+		copy_page(vto, vfrom);
+		kunmap_coherent(from);
+	} else
+		copy_page(vto, vfrom);
+	if (!cpu_has_ic_fills_f_dc ||
+	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
+		flush_data_cache_page((unsigned long)vto);
+}
+
+EXPORT_SYMBOL(copy_user_page);
+
+void copy_to_user_page(struct vm_area_struct *vma,
+	struct page *page, unsigned long vaddr, void *dst, const void *src,
+	unsigned long len)
+{
+	if (cpu_has_dc_aliases) {
+		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
+		memcpy(vto, src, len);
+		kunmap_coherent(page);
+	} else
+		memcpy(dst, src, len);
+	if ((vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc)
+		flush_cache_page(vma, vaddr, page_to_pfn(page));
+}
+
+EXPORT_SYMBOL(copy_to_user_page);
+
+void copy_from_user_page(struct vm_area_struct *vma,
+	struct page *page, unsigned long vaddr, void *dst, const void *src,
+	unsigned long len)
+{
+	if (cpu_has_dc_aliases) {
+		void *vfrom =
+			kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
+		memcpy(dst, vfrom, len);
+		kunmap_coherent(page);
+	} else
+		memcpy(dst, src, len);
+}
+
+EXPORT_SYMBOL(copy_from_user_page);
+
+
+#ifdef CONFIG_HIGHMEM
+pte_t *kmap_pte;
+pgprot_t kmap_prot;
+
 static void __init kmap_init(void)
 {
 	unsigned long kmap_vstart;
@@ -98,11 +296,12 @@ static void __init kmap_init(void)
 
 	kmap_prot = PAGE_KERNEL;
 }
+#endif /* CONFIG_HIGHMEM */
 
-#ifdef CONFIG_32BIT
 void __init fixrange_init(unsigned long start, unsigned long end,
 	pgd_t *pgd_base)
 {
+#if defined(CONFIG_HIGHMEM) || defined(CONFIG_MIPS_MT_SMTC)
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
@@ -123,7 +322,7 @@ void __init fixrange_init(unsigned long 
 			for (; (k < PTRS_PER_PMD) && (vaddr != end); pmd++, k++) {
 				if (pmd_none(*pmd)) {
 					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-					set_pmd(pmd, __pmd(pte));
+					set_pmd(pmd, __pmd((unsigned long)pte));
 					if (pte != pte_offset_kernel(pmd, 0))
 						BUG();
 				}
@@ -133,9 +332,8 @@ void __init fixrange_init(unsigned long 
 		}
 		j = 0;
 	}
+#endif
 }
-#endif /* CONFIG_32BIT */
-#endif /* CONFIG_HIGHMEM */
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 extern void pagetable_init(void);
@@ -150,6 +348,7 @@ void __init paging_init(void)
 #ifdef CONFIG_HIGHMEM
 	kmap_init();
 #endif
+	kmap_coherent_init();
 
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 	low = max_low_pfn;
diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index 4a3c491..9977f03 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -32,9 +32,10 @@ void pgd_init(unsigned long page)
 
 void __init pagetable_init(void)
 {
-#ifdef CONFIG_HIGHMEM
 	unsigned long vaddr;
-	pgd_t *pgd, *pgd_base;
+	pgd_t *pgd_base;
+#ifdef CONFIG_HIGHMEM
+	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -45,7 +46,6 @@ #endif
 	pgd_init((unsigned long)swapper_pg_dir
 		 + sizeof(pgd_t) * USER_PTRS_PER_PGD);
 
-#ifdef CONFIG_HIGHMEM
 	pgd_base = swapper_pg_dir;
 
 	/*
@@ -54,6 +54,7 @@ #ifdef CONFIG_HIGHMEM
 	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
 	fixrange_init(vaddr, 0, pgd_base);
 
+#ifdef CONFIG_HIGHMEM
 	/*
 	 * Permanent kmaps:
 	 */
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index 44b5e97..8d600d3 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -8,6 +8,7 @@
  */
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <asm/fixmap.h>
 #include <asm/pgtable.h>
 
 void pgd_init(unsigned long page)
@@ -52,7 +53,17 @@ void pmd_init(unsigned long addr, unsign
 
 void __init pagetable_init(void)
 {
+	unsigned long vaddr;
+	pgd_t *pgd_base;
+
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
 	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
+
+	pgd_base = swapper_pg_dir;
+	/*
+	 * Fixed mappings:
+	 */
+	vaddr = __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
+	fixrange_init(vaddr, 0, pgd_base);
 }
diff --git a/arch/mips/pci/ops-au1000.c b/arch/mips/pci/ops-au1000.c
index be14201..25e6fad 100644
--- a/arch/mips/pci/ops-au1000.c
+++ b/arch/mips/pci/ops-au1000.c
@@ -111,7 +111,7 @@ #if defined( CONFIG_SOC_AU1500 ) || defi
 	if (first_cfg) {
 		/* reserve a wired entry for pci config accesses */
 		first_cfg = 0;
-		pci_cfg_vm = get_vm_area(0x2000, 0);
+		pci_cfg_vm = get_vm_area(0x2000, VM_IOREMAP);
 		if (!pci_cfg_vm)
 			panic (KERN_ERR "PCI unable to get vm area\n");
 		pci_cfg_wired_entry = read_c0_wired();
diff --git a/include/asm-mips/cacheflush.h b/include/asm-mips/cacheflush.h
index 36416fd..d10517c 100644
--- a/include/asm-mips/cacheflush.h
+++ b/include/asm-mips/cacheflush.h
@@ -57,24 +57,13 @@ extern void (*flush_icache_range)(unsign
 #define flush_cache_vmap(start, end)		flush_cache_all()
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
-static inline void copy_to_user_page(struct vm_area_struct *vma,
+extern void copy_to_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
-	unsigned long len)
-{
-	if (cpu_has_dc_aliases)
-		flush_cache_page(vma, vaddr, page_to_pfn(page));
-	memcpy(dst, src, len);
-	__flush_icache_page(vma, page);
-}
+	unsigned long len);
 
-static inline void copy_from_user_page(struct vm_area_struct *vma,
+extern void copy_from_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
-	unsigned long len)
-{
-	if (cpu_has_dc_aliases)
-		flush_cache_page(vma, vaddr, page_to_pfn(page));
-	memcpy(dst, src, len);
-}
+	unsigned long len);
 
 extern void (*flush_cache_sigtramp)(unsigned long addr);
 extern void (*flush_icache_all)(void);
diff --git a/include/asm-mips/fixmap.h b/include/asm-mips/fixmap.h
index 73a3028..4878926 100644
--- a/include/asm-mips/fixmap.h
+++ b/include/asm-mips/fixmap.h
@@ -46,8 +46,16 @@ #endif
  * fix-mapped?
  */
 enum fixed_addresses {
+#define FIX_N_COLOURS 8
+	FIX_CMAP_BEGIN,
+#ifdef CONFIG_MIPS_MT_SMTC
+	FIX_CMAP_END = FIX_CMAP_BEGIN + (FIX_N_COLOURS * NR_CPUS),
+#else
+	FIX_CMAP_END = FIX_CMAP_BEGIN + FIX_N_COLOURS,
+#endif
 #ifdef CONFIG_HIGHMEM
-	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
+	/* reserved pte's for temporary kernel mappings */
+	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
 	__end_of_fixed_addresses
@@ -70,7 +78,7 @@ #define set_fixmap_nocache(idx, phys) \
  * the start of the fixmap, and leave one page empty
  * at the top of mem..
  */
-#define FIXADDR_TOP	(0xffffe000UL)
+#define FIXADDR_TOP    ((unsigned long)(long)(int)0xfffe0000)
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
diff --git a/include/asm-mips/mman.h b/include/asm-mips/mman.h
index 046cf68..e39c01b 100644
--- a/include/asm-mips/mman.h
+++ b/include/asm-mips/mman.h
@@ -75,4 +75,13 @@ #define MADV_DOFORK	11		/* do inherit ac
 #define MAP_ANON	MAP_ANONYMOUS
 #define MAP_FILE	0
 
+#ifdef __KERNEL__
+
+#define arch_mmap_check mips_mmap_check
+
+extern int mips_mmap_check(unsigned long addr, unsigned long len,
+	unsigned long flags);
+
+#endif
+
 #endif /* _ASM_MMAN_H */
diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index c014279..152e573 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -39,8 +39,6 @@ #define PAGE_MASK       (~((1 << PAGE_SH
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-#include <asm/cpu-features.h>
-
 extern void clear_page(void * page);
 extern void copy_page(void * to, void * from);
 
@@ -64,16 +62,13 @@ static inline void clear_user_page(void 
 		flush_data_cache_page((unsigned long)addr);
 }
 
-static inline void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-	struct page *to)
-{
-	extern void (*flush_data_cache_page)(unsigned long addr);
+extern void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
+	struct page *to);
+struct vm_area_struct;
+extern void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma);
 
-	copy_page(vto, vfrom);
-	if (!cpu_has_ic_fills_f_dc ||
-	    pages_do_alias((unsigned long)vto, vaddr & PAGE_MASK))
-		flush_data_cache_page((unsigned long)vto);
-}
+#define __HAVE_ARCH_COPY_USER_HIGHPAGE
 
 /*
  * These are used to make use of C type-checking..
@@ -82,15 +77,17 @@ #ifdef CONFIG_64BIT_PHYS_ADDR
   #ifdef CONFIG_CPU_MIPS32
     typedef struct { unsigned long pte_low, pte_high; } pte_t;
     #define pte_val(x)    ((x).pte_low | ((unsigned long long)(x).pte_high << 32))
+    #define __pte(x)      ({ pte_t __pte = {(x), ((unsigned long long)(x)) >> 32}; __pte; })
   #else
      typedef struct { unsigned long long pte; } pte_t;
      #define pte_val(x)	((x).pte)
+     #define __pte(x)	((pte_t) { (x) } )
   #endif
 #else
 typedef struct { unsigned long pte; } pte_t;
 #define pte_val(x)	((x).pte)
-#endif
 #define __pte(x)	((pte_t) { (x) } )
+#endif
 
 /*
  * For 3-level pagetables we defines these ourselves, for 2-level the
diff --git a/include/asm-mips/spinlock.h b/include/asm-mips/spinlock.h
index 669b8e3..4c1a1b5 100644
--- a/include/asm-mips/spinlock.h
+++ b/include/asm-mips/spinlock.h
@@ -239,7 +239,51 @@ static inline void __raw_write_unlock(ra
 	: "memory");
 }
 
-#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
+static inline int __raw_read_trylock(raw_rwlock_t *rw)
+{
+	unsigned int tmp;
+	int ret;
+
+	if (R10000_LLSC_WAR) {
+		__asm__ __volatile__(
+		"	.set	noreorder	# __raw_read_trylock	\n"
+		"	li	%2, 0					\n"
+		"1:	ll	%1, %3					\n"
+		"	bnez	%1, 2f					\n"
+		"	 addu	%1, 1					\n"
+		"	sc	%1, %0					\n"
+		"	beqzl	%1, 1b					\n"
+		"	.set	reorder					\n"
+#ifdef CONFIG_SMP
+		"	 sync						\n"
+#endif
+		"	li	%2, 1					\n"
+		"2:							\n"
+		: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: "m" (rw->lock)
+		: "memory");
+	} else {
+		__asm__ __volatile__(
+		"	.set	noreorder	# __raw_read_trylock	\n"
+		"	li	%2, 0					\n"
+		"1:	ll	%1, %3					\n"
+		"	bnez	%1, 2f					\n"
+		"	 addu	%1, 1					\n"
+		"	sc	%1, %0					\n"
+		"	beqz	%1, 1b					\n"
+		"	.set	reorder					\n"
+#ifdef CONFIG_SMP
+		"	 sync						\n"
+#endif
+		"	li	%2, 1					\n"
+		"2:							\n"
+		: "=m" (rw->lock), "=&r" (tmp), "=&r" (ret)
+		: "m" (rw->lock)
+		: "memory");
+	}
+
+	return ret;
+}
 
 static inline int __raw_write_trylock(raw_rwlock_t *rw)
 {
@@ -283,4 +327,5 @@ static inline int __raw_write_trylock(ra
 	return ret;
 }
 
+
 #endif /* _ASM_SPINLOCK_H */
diff --git a/include/asm-mips/unistd.h b/include/asm-mips/unistd.h
index 13fe6e8..2031601 100644
--- a/include/asm-mips/unistd.h
+++ b/include/asm-mips/unistd.h
@@ -327,16 +327,20 @@ #define __NR_unshare			(__NR_Linux + 303
 #define __NR_splice			(__NR_Linux + 304)
 #define __NR_sync_file_range		(__NR_Linux + 305)
 #define __NR_tee			(__NR_Linux + 306)
+#define __NR_vmsplice			(__NR_Linux + 307)
+#define __NR_move_pages			(__NR_Linux + 308)
+#define __NR_set_robust_list		(__NR_Linux + 309)
+#define __NR_get_robust_list		(__NR_Linux + 310)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		306
+#define __NR_Linux_syscalls		310
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		306
+#define __NR_O32_Linux_syscalls		310
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -610,16 +614,20 @@ #define __NR_unshare			(__NR_Linux + 262
 #define __NR_splice			(__NR_Linux + 263)
 #define __NR_sync_file_range		(__NR_Linux + 264)
 #define __NR_tee			(__NR_Linux + 265)
+#define __NR_vmsplice			(__NR_Linux + 266)
+#define __NR_move_pages			(__NR_Linux + 267)
+#define __NR_set_robust_list		(__NR_Linux + 268)
+#define __NR_get_robust_list		(__NR_Linux + 269)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		265
+#define __NR_Linux_syscalls		269
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		265
+#define __NR_64_Linux_syscalls		269
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -897,16 +905,20 @@ #define __NR_unshare			(__NR_Linux + 266
 #define __NR_splice			(__NR_Linux + 267)
 #define __NR_sync_file_range		(__NR_Linux + 268)
 #define __NR_tee			(__NR_Linux + 269)
+#define __NR_vmsplice			(__NR_Linux + 270)
+#define __NR_move_pages			(__NR_Linux + 271)
+#define __NR_set_robust_list		(__NR_Linux + 272)
+#define __NR_get_robust_list		(__NR_Linux + 273)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		269
+#define __NR_Linux_syscalls		273
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		269
+#define __NR_N32_Linux_syscalls		273
 
 #ifndef __ASSEMBLY__
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 892c4ea..26e49a1 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -90,7 +90,10 @@ static inline void memclear_highpage_flu
 	kunmap_atomic(kaddr, KM_USER0);
 }
 
-static inline void copy_user_highpage(struct page *to, struct page *from, unsigned long vaddr)
+#ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
+
+static inline void copy_user_highpage(struct page *to, struct page *from,
+	unsigned long vaddr, struct vm_area_struct *vma)
 {
 	char *vfrom, *vto;
 
@@ -103,6 +106,8 @@ static inline void copy_user_highpage(st
 	smp_wmb();
 }
 
+#endif
+
 static inline void copy_highpage(struct page *to, struct page *from)
 {
 	char *vfrom, *vto;
diff --git a/mm/memory.c b/mm/memory.c
index 0ec7bc6..3acd848 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1394,7 +1394,8 @@ static inline pte_t maybe_mkwrite(pte_t 
 	return pte;
 }
 
-static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va)
+static inline void cow_user_page(struct page *dst, struct page *src,
+	unsigned long va, struct vm_area_struct *vma)
 {
 	/*
 	 * If the source page was a PFN mapping, we don't have
@@ -1418,7 +1419,7 @@ static inline void cow_user_page(struct 
 		return;
 		
 	}
-	copy_user_highpage(dst, src, va);
+	copy_user_highpage(dst, src, va, vma);
 }
 
 /*
@@ -1483,7 +1484,7 @@ gotten:
 		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!new_page)
 			goto oom;
-		cow_user_page(new_page, old_page, address);
+		cow_user_page(new_page, old_page, address, vma);
 	}
 
 	/*
@@ -2082,7 +2083,7 @@ retry:
 		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!page)
 			goto oom;
-		copy_user_highpage(page, new_page, address);
+		copy_user_highpage(page, new_page, address, vma);
 		page_cache_release(new_page);
 		new_page = page;
 		anon = 1;
