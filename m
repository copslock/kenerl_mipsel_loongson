Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 22:56:26 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7667 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493991AbZLDV4V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 22:56:21 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b19856f0000>; Fri, 04 Dec 2009 13:56:03 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 4 Dec 2009 13:52:40 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 4 Dec 2009 13:52:40 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id nB4Lqbiu006902;
        Fri, 4 Dec 2009 13:52:38 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id nB4Lqadb006900;
        Fri, 4 Dec 2009 13:52:36 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Two-level pagetables for 64-bit kernels with 64KB pages.
Date:   Fri,  4 Dec 2009 13:52:36 -0800
Message-Id: <1259963556-6876-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 04 Dec 2009 21:52:40.0515 (UTC) FILETIME=[19C9D930:01CA752C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For 64-bit kernels with 64KB pages and two level page tables, there
are 42 bits worth of virtual address space This is larger than the 40
bits of virtual address space obtained with the default 4KB Page size
and three levels, so there are no draw backs for using two level
tables with this configuration.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/page.h       |   12 ---------
 arch/mips/include/asm/pgalloc.h    |    4 +-
 arch/mips/include/asm/pgtable-64.h |   36 +++++++++++++++++++++++++++-
 arch/mips/include/asm/pgtable.h    |    2 +-
 arch/mips/kernel/asm-offsets.c     |    4 +++
 arch/mips/mm/init.c                |    2 +-
 arch/mips/mm/pgtable-64.c          |   44 ++++++++++++++++++++++--------------
 arch/mips/mm/tlbex.c               |    2 +
 8 files changed, 71 insertions(+), 35 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index f266295..ac32572 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -107,18 +107,6 @@ typedef struct { unsigned long pte; } pte_t;
 typedef struct page *pgtable_t;
 
 /*
- * For 3-level pagetables we defines these ourselves, for 2-level the
- * definitions are supplied by <asm-generic/pgtable-nopmd.h>.
- */
-#ifdef CONFIG_64BIT
-
-typedef struct { unsigned long pmd; } pmd_t;
-#define pmd_val(x)	((x).pmd)
-#define __pmd(x)	((pmd_t) { (x) } )
-
-#endif
-
-/*
  * Right now we don't support 4-level pagetables, so all pud-related
  * definitions come from <asm-generic/pgtable-nopud.h>.
  */
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 3738f4b..881d18b 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -31,7 +31,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
  */
 extern void pmd_init(unsigned long page, unsigned long pagetable);
 
-#ifdef CONFIG_64BIT
+#ifndef __PAGETABLE_PMD_FOLDED
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 {
@@ -104,7 +104,7 @@ do {							\
 	tlb_remove_page((tlb), pte);			\
 } while (0)
 
-#ifdef CONFIG_64BIT
+#ifndef __PAGETABLE_PMD_FOLDED
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 9cd5089..073a393 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -16,7 +16,11 @@
 #include <asm/cachectl.h>
 #include <asm/fixmap.h>
 
+#ifdef CONFIG_PAGE_SIZE_64KB
+#include <asm-generic/pgtable-nopmd.h>
+#else
 #include <asm-generic/pgtable-nopud.h>
+#endif
 
 /*
  * Each address space has 2 4K pages as its page directory, giving 1024
@@ -37,13 +41,20 @@
  * fault address - VMALLOC_START.
  */
 
+
+/* PGDIR_SHIFT determines what a third-level page table entry can map */
+#ifdef __PAGETABLE_PMD_FOLDED
+#define PGDIR_SHIFT	(PAGE_SHIFT + PAGE_SHIFT + PTE_ORDER - 3)
+#else
+
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
 #define PMD_SHIFT	(PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
 
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
+
 #define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
+#endif
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -92,12 +103,14 @@
 #ifdef CONFIG_PAGE_SIZE_64KB
 #define PGD_ORDER		0
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
-#define PMD_ORDER		0
+#define PMD_ORDER		aieeee_attempt_to_allocate_pmd
 #define PTE_ORDER		0
 #endif
 
 #define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+#ifndef __PAGETABLE_PMD_FOLDED
 #define PTRS_PER_PMD	((PAGE_SIZE << PMD_ORDER) / sizeof(pmd_t))
+#endif
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
 #if PGDIR_SIZE >= TASK_SIZE
@@ -120,15 +133,30 @@
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
+#ifndef __PAGETABLE_PMD_FOLDED
 #define pmd_ERROR(e) \
 	printk("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
+#endif
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 extern pte_t invalid_pte_table[PTRS_PER_PTE];
 extern pte_t empty_bad_page_table[PTRS_PER_PTE];
+
+
+#ifndef __PAGETABLE_PMD_FOLDED
+/*
+ * For 3-level pagetables we defines these ourselves, for 2-level the
+ * definitions are supplied by <asm-generic/pgtable-nopmd.h>.
+ */
+typedef struct { unsigned long pmd; } pmd_t;
+#define pmd_val(x)	((x).pmd)
+#define __pmd(x)	((pmd_t) { (x) } )
+
+
 extern pmd_t invalid_pmd_table[PTRS_PER_PMD];
 extern pmd_t empty_bad_pmd_table[PTRS_PER_PMD];
+#endif
 
 /*
  * Empty pgd/pmd entries point to the invalid_pte_table.
@@ -149,6 +177,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 {
 	pmd_val(*pmdp) = ((unsigned long) invalid_pte_table);
 }
+#ifndef __PAGETABLE_PMD_FOLDED
 
 /*
  * Empty pud entries point to the invalid_pmd_table.
@@ -172,6 +201,7 @@ static inline void pud_clear(pud_t *pudp)
 {
 	pud_val(*pudp) = ((unsigned long) invalid_pmd_table);
 }
+#endif
 
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
@@ -196,6 +226,7 @@ static inline void pud_clear(pud_t *pudp)
 /* to find an entry in a page-table-directory */
 #define pgd_offset(mm, addr)	((mm)->pgd + pgd_index(addr))
 
+#ifndef __PAGETABLE_PMD_FOLDED
 static inline unsigned long pud_page_vaddr(pud_t pud)
 {
 	return pud_val(pud);
@@ -208,6 +239,7 @@ static inline pmd_t *pmd_offset(pud_t * pud, unsigned long address)
 {
 	return (pmd_t *) pud_page_vaddr(*pud) + pmd_index(address);
 }
+#endif
 
 /* Find an entry in the third-level page table.. */
 #define __pte_offset(address)						\
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 1854336..02335fd 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -177,7 +177,7 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
  */
 #define set_pmd(pmdptr, pmdval) do { *(pmdptr) = (pmdval); } while(0)
 
-#ifdef CONFIG_64BIT
+#ifndef __PAGETABLE_PMD_FOLDED
 /*
  * (puds are folded into pgds so this doesn't get actually called,
  * but the define is needed for a generic inline function.)
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 2c1e1d0..ca6c832 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -188,11 +188,15 @@ void output_mm_defines(void)
 	DEFINE(_PTE_T_SIZE, sizeof(pte_t));
 	BLANK();
 	DEFINE(_PGD_T_LOG2, PGD_T_LOG2);
+#ifndef __PAGETABLE_PMD_FOLDED
 	DEFINE(_PMD_T_LOG2, PMD_T_LOG2);
+#endif
 	DEFINE(_PTE_T_LOG2, PTE_T_LOG2);
 	BLANK();
 	DEFINE(_PGD_ORDER, PGD_ORDER);
+#ifndef __PAGETABLE_PMD_FOLDED
 	DEFINE(_PMD_ORDER, PMD_ORDER);
+#endif
 	DEFINE(_PTE_ORDER, PTE_ORDER);
 	BLANK();
 	DEFINE(_PMD_SHIFT, PMD_SHIFT);
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 9e8d003..d070aae 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -477,7 +477,7 @@ unsigned long pgd_current[NR_CPUS];
  * will officially be retired.
  */
 pgd_t swapper_pg_dir[_PTRS_PER_PGD] __page_aligned(_PGD_ORDER);
-#ifdef CONFIG_64BIT
+#ifndef __PAGETABLE_PMD_FOLDED
 pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned(PMD_ORDER);
 #endif
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
index 1121019..78eaa4f 100644
--- a/arch/mips/mm/pgtable-64.c
+++ b/arch/mips/mm/pgtable-64.c
@@ -15,23 +15,31 @@
 void pgd_init(unsigned long page)
 {
 	unsigned long *p, *end;
+	unsigned long entry;
+
+#ifdef __PAGETABLE_PMD_FOLDED
+	entry = (unsigned long)invalid_pte_table;
+#else
+	entry = (unsigned long)invalid_pmd_table;
+#endif
 
  	p = (unsigned long *) page;
 	end = p + PTRS_PER_PGD;
 
 	while (p < end) {
-		p[0] = (unsigned long) invalid_pmd_table;
-		p[1] = (unsigned long) invalid_pmd_table;
-		p[2] = (unsigned long) invalid_pmd_table;
-		p[3] = (unsigned long) invalid_pmd_table;
-		p[4] = (unsigned long) invalid_pmd_table;
-		p[5] = (unsigned long) invalid_pmd_table;
-		p[6] = (unsigned long) invalid_pmd_table;
-		p[7] = (unsigned long) invalid_pmd_table;
+		p[0] = entry;
+		p[1] = entry;
+		p[2] = entry;
+		p[3] = entry;
+		p[4] = entry;
+		p[5] = entry;
+		p[6] = entry;
+		p[7] = entry;
 		p += 8;
 	}
 }
 
+#ifndef __PAGETABLE_PMD_FOLDED
 void pmd_init(unsigned long addr, unsigned long pagetable)
 {
 	unsigned long *p, *end;
@@ -40,17 +48,18 @@ void pmd_init(unsigned long addr, unsigned long pagetable)
 	end = p + PTRS_PER_PMD;
 
 	while (p < end) {
-		p[0] = (unsigned long)pagetable;
-		p[1] = (unsigned long)pagetable;
-		p[2] = (unsigned long)pagetable;
-		p[3] = (unsigned long)pagetable;
-		p[4] = (unsigned long)pagetable;
-		p[5] = (unsigned long)pagetable;
-		p[6] = (unsigned long)pagetable;
-		p[7] = (unsigned long)pagetable;
+		p[0] = pagetable;
+		p[1] = pagetable;
+		p[2] = pagetable;
+		p[3] = pagetable;
+		p[4] = pagetable;
+		p[5] = pagetable;
+		p[6] = pagetable;
+		p[7] = pagetable;
 		p += 8;
 	}
 }
+#endif
 
 void __init pagetable_init(void)
 {
@@ -59,8 +68,9 @@ void __init pagetable_init(void)
 
 	/* Initialize the entire pgd.  */
 	pgd_init((unsigned long)swapper_pg_dir);
+#ifndef __PAGETABLE_PMD_FOLDED
 	pmd_init((unsigned long)invalid_pmd_table, (unsigned long)invalid_pte_table);
-
+#endif
 	pgd_base = swapper_pg_dir;
 	/*
 	 * Fixed mappings:
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index badcf5e..eae45f0 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -549,11 +549,13 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 
 	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PGD - 1)<<3);
 	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pgd offset */
+#ifndef __PAGETABLE_PMD_FOLDED
 	uasm_i_dmfc0(p, tmp, C0_BADVADDR); /* get faulting address */
 	uasm_i_ld(p, ptr, 0, ptr); /* get pmd pointer */
 	uasm_i_dsrl(p, tmp, tmp, PMD_SHIFT-3); /* get pmd offset in bytes */
 	uasm_i_andi(p, tmp, tmp, (PTRS_PER_PMD - 1)<<3);
 	uasm_i_daddu(p, ptr, ptr, tmp); /* add in pmd offset */
+#endif
 }
 
 /*
-- 
1.6.0.6
