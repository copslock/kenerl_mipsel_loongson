Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 01:51:49 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13194 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024406AbZE1Avn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 01:51:43 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a1ddff90000>; Wed, 27 May 2009 20:51:05 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:51:15 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:51:15 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4S0ocQC027977;
	Wed, 27 May 2009 17:50:38 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4S0o4xP027971;
	Wed, 27 May 2009 17:50:04 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	wli@holomorphy.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/5] MIPS: TLB support for hugeTLBfs.
Date:	Wed, 27 May 2009 17:47:44 -0700
Message-Id: <1243471666-27915-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A1DDED7.3020306@caviumnetworks.com>
References: <4A1DDED7.3020306@caviumnetworks.com>
X-OriginalArrivalTime: 28 May 2009 00:51:15.0033 (UTC) FILETIME=[673D4C90:01C9DF2E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The TLB handlers need to check for huge pages and give them special
handling.  Huge pages consist of two contiguous sub-pages of physical
memory.

* Loading entrylo0 and entrylo1 need to be handled specially.

* The page mask must be set for huge pages and then restored after
  writing the TLB entries.

* The PTE for huge pages resides in the PMD, we halt traversal of the
  tables there.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlb-r4k.c |   43 +++++++++---
 arch/mips/mm/tlbex.c   |  165 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 196 insertions(+), 12 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 9619f66..b8a73c4 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
 
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
@@ -297,21 +298,41 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	pudp = pud_offset(pgdp, address);
 	pmdp = pmd_offset(pudp, address);
 	idx = read_c0_index();
-	ptep = pte_offset_map(pmdp, address);
+#ifdef CONFIG_HUGETLB_PAGE
+	/* this could be a huge page  */
+	if (pmd_huge(*pmdp)) {
+		unsigned long lo;
+		write_c0_pagemask(PM_HUGE_MASK);
+		ptep = (pte_t *)pmdp;
+		lo = pte_val(*ptep) >> 6;
+		write_c0_entrylo0(lo);
+		write_c0_entrylo1(lo + (HPAGE_SIZE >> 7));
+
+		mtc0_tlbw_hazard();
+		if (idx < 0)
+			tlb_write_random();
+		else
+			tlb_write_indexed();
+		write_c0_pagemask(PM_DEFAULT_MASK);
+	} else
+#endif
+	{
+		ptep = pte_offset_map(pmdp, address);
 
 #if defined(CONFIG_64BIT_PHYS_ADDR) && defined(CONFIG_CPU_MIPS32)
-	write_c0_entrylo0(ptep->pte_high);
-	ptep++;
-	write_c0_entrylo1(ptep->pte_high);
+		write_c0_entrylo0(ptep->pte_high);
+		ptep++;
+		write_c0_entrylo1(ptep->pte_high);
 #else
-	write_c0_entrylo0(pte_val(*ptep++) >> 6);
-	write_c0_entrylo1(pte_val(*ptep) >> 6);
+		write_c0_entrylo0(pte_val(*ptep++) >> 6);
+		write_c0_entrylo1(pte_val(*ptep) >> 6);
 #endif
-	mtc0_tlbw_hazard();
-	if (idx < 0)
-		tlb_write_random();
-	else
-		tlb_write_indexed();
+		mtc0_tlbw_hazard();
+		if (idx < 0)
+			tlb_write_random();
+		else
+			tlb_write_indexed();
+	}
 	tlbw_use_hazard();
 	FLUSH_ITLB_VM(vma);
 	EXIT_CRITICAL(flags);
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 62fbd0d..8f606ea 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
  * Copyright (C) 2005, 2007, 2008, 2009  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2008, 2009 Cavium Networks, Inc.
  *
  * ... and the days got worse and worse and now you see
  * I've gone completly out of my mind.
@@ -83,6 +84,9 @@ enum label_id {
 	label_nopage_tlbm,
 	label_smp_pgtable_change,
 	label_r3000_write_probe_fail,
+#ifdef CONFIG_HUGETLB_PAGE
+	label_tlb_huge_update,
+#endif
 };
 
 UASM_L_LA(_second_part)
@@ -99,6 +103,9 @@ UASM_L_LA(_nopage_tlbs)
 UASM_L_LA(_nopage_tlbm)
 UASM_L_LA(_smp_pgtable_change)
 UASM_L_LA(_r3000_write_probe_fail)
+#ifdef CONFIG_HUGETLB_PAGE
+UASM_L_LA(_tlb_huge_update)
+#endif
 
 /*
  * For debug purposes.
@@ -126,6 +133,7 @@ static inline void dump_handler(const u32 *handler, int count)
 #define C0_TCBIND	2, 2
 #define C0_ENTRYLO1	3, 0
 #define C0_CONTEXT	4, 0
+#define C0_PAGEMASK	5, 0
 #define C0_BADVADDR	8, 0
 #define C0_ENTRYHI	10, 0
 #define C0_EPC		14, 0
@@ -383,6 +391,98 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	}
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+static __cpuinit void build_huge_tlb_write_entry(u32 **p,
+						 struct uasm_label **l,
+						 struct uasm_reloc **r,
+						 unsigned int tmp,
+						 enum tlb_write_entry wmode)
+{
+	/* Set huge page tlb entry size */
+	uasm_i_lui(p, tmp, PM_HUGE_MASK >> 16);
+	uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
+	uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+
+	build_tlb_write_entry(p, l, r, wmode);
+
+	/* Reset default page size */
+	if (PM_DEFAULT_MASK >> 16) {
+		uasm_i_lui(p, tmp, PM_DEFAULT_MASK >> 16);
+		uasm_i_ori(p, tmp, tmp, PM_DEFAULT_MASK & 0xffff);
+		uasm_il_b(p, r, label_leave);
+		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+	} else if (PM_DEFAULT_MASK) {
+		uasm_i_ori(p, tmp, 0, PM_DEFAULT_MASK);
+		uasm_il_b(p, r, label_leave);
+		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+	} else {
+		uasm_il_b(p, r, label_leave);
+		uasm_i_mtc0(p, 0, C0_PAGEMASK);
+	}
+}
+
+/*
+ * Check if Huge PTE is present, if so then jump to LABEL.
+ */
+static void __cpuinit
+build_is_huge_pte(u32 **p, struct uasm_reloc **r, unsigned int tmp,
+		unsigned int pmd, int lid)
+{
+	UASM_i_LW(p, tmp, 0, pmd);
+	uasm_i_andi(p, tmp, tmp, _PAGE_HUGE);
+	uasm_il_bnez(p, r, tmp, lid);
+}
+
+static __cpuinit void build_huge_update_entries(u32 **p,
+						unsigned int pte,
+						unsigned int tmp)
+{
+	int small_sequence;
+
+	/*
+	 * A huge PTE describes an area the size of the
+	 * configured huge page size. This is twice the
+	 * of the large TLB entry size we intend to use.
+	 * A TLB entry half the size of the configured
+	 * huge page size is configured into entrylo0
+	 * and entrylo1 to cover the contiguous huge PTE
+	 * address space.
+	 */
+	small_sequence = (HPAGE_SIZE >> 7) < 0x10000;
+
+	/* We can clobber tmp.  It isn't used after this.*/
+	if (!small_sequence)
+		uasm_i_lui(p, tmp, HPAGE_SIZE >> (7 + 16));
+
+	UASM_i_SRL(p, pte, pte, 6); /* convert to entrylo */
+	uasm_i_mtc0(p, pte, C0_ENTRYLO0); /* load it */
+	/* convert to entrylo1 */
+	if (small_sequence)
+		UASM_i_ADDIU(p, pte, pte, HPAGE_SIZE >> 7);
+	else
+		UASM_i_ADDU(p, pte, pte, tmp);
+
+	uasm_i_mtc0(p, pte, C0_ENTRYLO1); /* load it */
+}
+
+static __cpuinit void build_huge_handler_tail(u32 **p,
+					      struct uasm_reloc **r,
+					      struct uasm_label **l,
+					      unsigned int pte,
+					      unsigned int ptr)
+{
+#ifdef CONFIG_SMP
+	UASM_i_SC(p, pte, 0, ptr);
+	uasm_il_beqz(p, r, pte, label_tlb_huge_update);
+	UASM_i_LW(p, pte, 0, ptr); /* Needed because SC killed our PTE */
+#else
+	UASM_i_SW(p, pte, 0, ptr);
+#endif
+	build_huge_update_entries(p, pte, ptr);
+	build_huge_tlb_write_entry(p, l, r, pte, tlb_indexed);
+}
+#endif /* CONFIG_HUGETLB_PAGE */
+
 #ifdef CONFIG_64BIT
 /*
  * TMP and PTR are scratch.
@@ -689,12 +789,23 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	build_get_pgde32(&p, K0, K1); /* get pgd in K1 */
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE
+	build_is_huge_pte(&p, &r, K0, K1, label_tlb_huge_update);
+#endif
+
 	build_get_ptep(&p, K0, K1);
 	build_update_entries(&p, K0, K1);
 	build_tlb_write_entry(&p, &l, &r, tlb_random);
 	uasm_l_leave(&l, p);
 	uasm_i_eret(&p); /* return from trap */
 
+#ifdef CONFIG_HUGETLB_PAGE
+	uasm_l_tlb_huge_update(&l, p);
+	UASM_i_LW(&p, K0, 0, K1);
+	build_huge_update_entries(&p, K0, K1);
+	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random);
+#endif
+
 #ifdef CONFIG_64BIT
 	build_get_pgd_vmalloc64(&p, &l, &r, K0, K1);
 #endif
@@ -733,7 +844,9 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 		uasm_copy_handler(relocs, labels, tlb_handler, p, f);
 		final_len = p - tlb_handler;
 	} else {
-#ifdef MODULE_START
+#if defined(CONFIG_HUGETLB_PAGE)
+		const enum label_id ls = label_tlb_huge_update;
+#elif defined(MODULE_START)
 		const enum label_id ls = label_module_alloc;
 #else
 		const enum label_id ls = label_vmalloc;
@@ -1130,6 +1243,15 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 	build_get_pgde32(p, pte, ptr); /* get pgd in ptr */
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE
+	/*
+	 * For huge tlb entries, pmd doesn't contain an address but
+	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
+	 * see if we need to jump to huge tlb processing.
+	 */
+	build_is_huge_pte(p, r, pte, ptr, label_tlb_huge_update);
+#endif
+
 	UASM_i_MFC0(p, pte, C0_BADVADDR);
 	UASM_i_LW(p, ptr, 0, ptr);
 	UASM_i_SRL(p, pte, pte, PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2);
@@ -1187,6 +1309,19 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	build_make_valid(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
+#ifdef CONFIG_HUGETLB_PAGE
+	/*
+	 * This is the entry point when build_r4000_tlbchange_handler_head
+	 * spots a huge page.
+	 */
+	uasm_l_tlb_huge_update(&l, p);
+	iPTE_LW(&p, K0, K1);
+	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
+	build_tlb_probe_entry(&p);
+	uasm_i_ori(&p, K0, K0, (_PAGE_ACCESSED | _PAGE_VALID));
+	build_huge_handler_tail(&p, &r, &l, K0, K1);
+#endif
+
 	uasm_l_nopage_tlbl(&l, p);
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
 	uasm_i_nop(&p);
@@ -1218,6 +1353,20 @@ static void __cpuinit build_r4000_tlb_store_handler(void)
 	build_make_write(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
+#ifdef CONFIG_HUGETLB_PAGE
+	/*
+	 * This is the entry point when
+	 * build_r4000_tlbchange_handler_head spots a huge page.
+	 */
+	uasm_l_tlb_huge_update(&l, p);
+	iPTE_LW(&p, K0, K1);
+	build_pte_writable(&p, &r, K0, K1, label_nopage_tlbs);
+	build_tlb_probe_entry(&p);
+	uasm_i_ori(&p, K0, K0,
+		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
+	build_huge_handler_tail(&p, &r, &l, K0, K1);
+#endif
+
 	uasm_l_nopage_tlbs(&l, p);
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
@@ -1250,6 +1399,20 @@ static void __cpuinit build_r4000_tlb_modify_handler(void)
 	build_make_write(&p, &r, K0, K1);
 	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
+#ifdef CONFIG_HUGETLB_PAGE
+	/*
+	 * This is the entry point when
+	 * build_r4000_tlbchange_handler_head spots a huge page.
+	 */
+	uasm_l_tlb_huge_update(&l, p);
+	iPTE_LW(&p, K0, K1);
+	build_pte_modifiable(&p, &r, K0, K1, label_nopage_tlbm);
+	build_tlb_probe_entry(&p);
+	uasm_i_ori(&p, K0, K0,
+		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
+	build_huge_handler_tail(&p, &r, &l, K0, K1);
+#endif
+
 	uasm_l_nopage_tlbm(&l, p);
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
-- 
1.6.0.6
