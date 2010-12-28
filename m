Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 03:09:31 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8885 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491024Ab0L1CIq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 03:08:46 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d1946d90000>; Mon, 27 Dec 2010 18:09:29 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Dec 2010 18:08:43 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Dec 2010 18:08:43 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBS28YfA009241;
        Mon, 27 Dec 2010 18:08:34 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBS28WIe009240;
        Mon, 27 Dec 2010 18:08:32 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Optimize TLB handlers for Octeon CPUs
Date:   Mon, 27 Dec 2010 18:07:57 -0800
Message-Id: <1293502077-9196-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com>
References: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Dec 2010 02:08:43.0713 (UTC) FILETIME=[273ED310:01CBA634]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Octeon can use scratch registers in the TLB handlers.  Octeon II can
use LDX instructions.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |  361 +++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 310 insertions(+), 51 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 883cf76..083d341 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -77,6 +77,40 @@ static int use_bbit_insns(void)
 	}
 }
 
+static int use_lwx_insns(void)
+{
+	switch (current_cpu_type()) {
+	case CPU_CAVIUM_OCTEON2:
+		return 1;
+	default:
+		return 0;
+	}
+}
+#if defined(CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE) && \
+    CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
+static bool scratchpad_available(void)
+{
+	return true;
+}
+static int scratchpad_offset(int i)
+{
+	/*
+	 * CVMSEG starts at address -32768 and extends for
+	 * CAVIUM_OCTEON_CVMSEG_SIZE 128 byte cache lines.
+	 */
+	i += 1; /* Kernel use starts at the top and works down. */
+	return CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE * 128 - (8 * i) - 32768;
+}
+#else
+static bool scratchpad_available(void)
+{
+	return false;
+}
+static int scratchpad_offset(int i)
+{
+	BUG();
+}
+#endif
 /*
  * Found by experiment: At least some revisions of the 4kc throw under
  * some circumstances a machine check exception, triggered by invalid
@@ -187,7 +221,7 @@ static struct uasm_reloc relocs[128] __cpuinitdata;
 static int check_for_high_segbits __cpuinitdata;
 #endif
 
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+static int check_for_high_segbits __cpuinitdata;
 
 static unsigned int kscratch_used_mask __cpuinitdata;
 
@@ -208,9 +242,12 @@ static int __cpuinit allocate_kscratch(void)
 	return r;
 }
 
+static int scratch_reg __cpuinitdata;
 static int pgd_reg __cpuinitdata;
+enum vmalloc64_mode {not_refill, refill_scratch, refill_noscratch};
+
+#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 
-#else /* !CONFIG_MIPS_PGD_C0_CONTEXT*/
 /*
  * CONFIG_MIPS_PGD_C0_CONTEXT implies 64 bit and lack of pgd_current,
  * we cannot do r3000 under these circumstances.
@@ -481,21 +518,43 @@ static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 static __cpuinit void build_restore_pagemask(u32 **p,
 					     struct uasm_reloc **r,
 					     unsigned int tmp,
-					     enum label_id lid)
+					     enum label_id lid,
+					     int restore_scratch)
 {
-	/* Reset default page size */
-	if (PM_DEFAULT_MASK >> 16) {
-		uasm_i_lui(p, tmp, PM_DEFAULT_MASK >> 16);
-		uasm_i_ori(p, tmp, tmp, PM_DEFAULT_MASK & 0xffff);
-		uasm_il_b(p, r, lid);
-		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
-	} else if (PM_DEFAULT_MASK) {
-		uasm_i_ori(p, tmp, 0, PM_DEFAULT_MASK);
-		uasm_il_b(p, r, lid);
-		uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+	if (restore_scratch) {
+		/* Reset default page size */
+		if (PM_DEFAULT_MASK >> 16) {
+			uasm_i_lui(p, tmp, PM_DEFAULT_MASK >> 16);
+			uasm_i_ori(p, tmp, tmp, PM_DEFAULT_MASK & 0xffff);
+			uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+			uasm_il_b(p, r, lid);
+		} else if (PM_DEFAULT_MASK) {
+			uasm_i_ori(p, tmp, 0, PM_DEFAULT_MASK);
+			uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+			uasm_il_b(p, r, lid);
+		} else {
+			uasm_i_mtc0(p, 0, C0_PAGEMASK);
+			uasm_il_b(p, r, lid);
+		}
+		if (scratch_reg > 0)
+			UASM_i_MFC0(p, 1, 31, scratch_reg);
+		else
+			UASM_i_LW(p, 1, scratchpad_offset(0), 0);
 	} else {
-		uasm_il_b(p, r, lid);
-		uasm_i_mtc0(p, 0, C0_PAGEMASK);
+		/* Reset default page size */
+		if (PM_DEFAULT_MASK >> 16) {
+			uasm_i_lui(p, tmp, PM_DEFAULT_MASK >> 16);
+			uasm_i_ori(p, tmp, tmp, PM_DEFAULT_MASK & 0xffff);
+			uasm_il_b(p, r, lid);
+			uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+		} else if (PM_DEFAULT_MASK) {
+			uasm_i_ori(p, tmp, 0, PM_DEFAULT_MASK);
+			uasm_il_b(p, r, lid);
+			uasm_i_mtc0(p, tmp, C0_PAGEMASK);
+		} else {
+			uasm_il_b(p, r, lid);
+			uasm_i_mtc0(p, 0, C0_PAGEMASK);
+		}
 	}
 }
 
@@ -503,7 +562,8 @@ static __cpuinit void build_huge_tlb_write_entry(u32 **p,
 						 struct uasm_label **l,
 						 struct uasm_reloc **r,
 						 unsigned int tmp,
-						 enum tlb_write_entry wmode)
+						 enum tlb_write_entry wmode,
+						 int restore_scratch)
 {
 	/* Set huge page tlb entry size */
 	uasm_i_lui(p, tmp, PM_HUGE_MASK >> 16);
@@ -512,7 +572,7 @@ static __cpuinit void build_huge_tlb_write_entry(u32 **p,
 
 	build_tlb_write_entry(p, l, r, wmode);
 
-	build_restore_pagemask(p, r, tmp, label_leave);
+	build_restore_pagemask(p, r, tmp, label_leave, restore_scratch);
 }
 
 /*
@@ -577,7 +637,7 @@ static __cpuinit void build_huge_handler_tail(u32 **p,
 	UASM_i_SW(p, pte, 0, ptr);
 #endif
 	build_huge_update_entries(p, pte, ptr);
-	build_huge_tlb_write_entry(p, l, r, pte, tlb_indexed);
+	build_huge_tlb_write_entry(p, l, r, pte, tlb_indexed, 0);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -674,7 +734,6 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 #endif
 }
 
-enum vmalloc64_mode {not_refill, refill};
 /*
  * BVADDR is the faulting address, PTR is scratch.
  * PTR will hold the pgd for vmalloc.
@@ -692,7 +751,7 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 
 	uasm_l_vmalloc(l, *p);
 
-	if (mode == refill && check_for_high_segbits) {
+	if (mode != not_refill && check_for_high_segbits) {
 		if (single_insn_swpd) {
 			uasm_il_bltz(p, r, bvaddr, label_vmalloc_done);
 			uasm_i_lui(p, ptr, uasm_rel_hi(swpd));
@@ -715,7 +774,7 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 				uasm_i_daddiu(p, ptr, ptr, uasm_rel_lo(swpd));
 		}
 	}
-	if (mode == refill && check_for_high_segbits) {
+	if (mode != not_refill && check_for_high_segbits) {
 		uasm_l_large_segbits_fault(l, *p);
 		/*
 		 * We get here if we are an xsseg address, or if we are
@@ -731,7 +790,15 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		 */
 		UASM_i_LA(p, ptr, (unsigned long)tlb_do_page_fault_0);
 		uasm_i_jr(p, ptr);
-		uasm_i_nop(p);
+
+		if (mode == refill_scratch) {
+			if (scratch_reg > 0)
+				UASM_i_MFC0(p, 1, 31, scratch_reg);
+			else
+				UASM_i_LW(p, 1, scratchpad_offset(0), 0);
+		} else {
+			uasm_i_nop(p);
+		}
 	}
 }
 
@@ -888,6 +955,185 @@ static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
 #endif
 }
 
+struct mips_huge_tlb_info {
+	int huge_pte;
+	int restore_scratch;
+};
+
+static struct mips_huge_tlb_info __cpuinit
+build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
+			       struct uasm_reloc **r, unsigned int tmp,
+			       unsigned int ptr, int c0_scratch)
+{
+	struct mips_huge_tlb_info rv;
+	unsigned int even, odd;
+	int vmalloc_branch_delay_filled = 0;
+	const int scratch = 1; /* Our extra working register */
+
+	rv.huge_pte = scratch;
+	rv.restore_scratch = 0;
+
+	if (check_for_high_segbits) {
+		UASM_i_MFC0(p, tmp, C0_BADVADDR);
+
+		if (pgd_reg != -1)
+			UASM_i_MFC0(p, ptr, 31, pgd_reg);
+		else
+			UASM_i_MFC0(p, ptr, C0_CONTEXT);
+
+		if (c0_scratch >= 0)
+			UASM_i_MTC0(p, scratch, 31, c0_scratch);
+		else
+			UASM_i_SW(p, scratch, scratchpad_offset(0), 0);
+
+		uasm_i_dsrl_safe(p, scratch, tmp,
+				 PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
+		uasm_il_bnez(p, r, scratch, label_vmalloc);
+
+		if (pgd_reg == -1) {
+			vmalloc_branch_delay_filled = 1;
+			/* Clear lower 23 bits of context. */
+			uasm_i_dins(p, ptr, 0, 0, 23);
+		}
+	} else {
+		if (pgd_reg != -1)
+			UASM_i_MFC0(p, ptr, 31, pgd_reg);
+		else
+			UASM_i_MFC0(p, ptr, C0_CONTEXT);
+
+		UASM_i_MFC0(p, tmp, C0_BADVADDR);
+
+		if (c0_scratch >= 0)
+			UASM_i_MTC0(p, scratch, 31, c0_scratch);
+		else
+			UASM_i_SW(p, scratch, scratchpad_offset(0), 0);
+
+		if (pgd_reg == -1)
+			/* Clear lower 23 bits of context. */
+			uasm_i_dins(p, ptr, 0, 0, 23);
+
+		uasm_il_bltz(p, r, tmp, label_vmalloc);
+	}
+
+	if (pgd_reg == -1) {
+		vmalloc_branch_delay_filled = 1;
+		/* 1 0  1 0 1  << 6  xkphys cached */
+		uasm_i_ori(p, ptr, ptr, 0x540);
+		uasm_i_drotr(p, ptr, ptr, 11);
+	}
+
+#ifdef __PAGETABLE_PMD_FOLDED
+#define LOC_PTEP scratch
+#else
+#define LOC_PTEP ptr
+#endif
+
+	if (!vmalloc_branch_delay_filled)
+		/* get pgd offset in bytes */
+		uasm_i_dsrl_safe(p, scratch, tmp, PGDIR_SHIFT - 3);
+
+	uasm_l_vmalloc_done(l, *p);
+
+	/*
+	 *                         tmp          ptr
+	 * fall-through case =   badvaddr  *pgd_current
+	 * vmalloc case      =   badvaddr  swapper_pg_dir
+	 */
+
+	if (vmalloc_branch_delay_filled)
+		/* get pgd offset in bytes */
+		uasm_i_dsrl_safe(p, scratch, tmp, PGDIR_SHIFT - 3);
+
+#ifdef __PAGETABLE_PMD_FOLDED
+	GET_CONTEXT(p, tmp); /* get context reg */
+#endif
+	uasm_i_andi(p, scratch, scratch, (PTRS_PER_PGD - 1) << 3);
+
+	if (use_lwx_insns()) {
+		UASM_i_LWX(p, LOC_PTEP, scratch, ptr);
+	} else {
+		uasm_i_daddu(p, ptr, ptr, scratch); /* add in pgd offset */
+		uasm_i_ld(p, LOC_PTEP, 0, ptr); /* get pmd pointer */
+	}
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	/* get pmd offset in bytes */
+	uasm_i_dsrl_safe(p, scratch, tmp, PMD_SHIFT - 3);
+	uasm_i_andi(p, scratch, scratch, (PTRS_PER_PMD - 1) << 3);
+	GET_CONTEXT(p, tmp); /* get context reg */
+
+	if (use_lwx_insns()) {
+		UASM_i_LWX(p, scratch, scratch, ptr);
+	} else {
+		uasm_i_daddu(p, ptr, ptr, scratch); /* add in pmd offset */
+		UASM_i_LW(p, scratch, 0, ptr);
+	}
+#endif
+	/* Adjust the context during the load latency. */
+	build_adjust_context(p, tmp);
+
+#ifdef CONFIG_HUGETLB_PAGE
+	uasm_il_bbit1(p, r, scratch, ilog2(_PAGE_HUGE), label_tlb_huge_update);
+	/*
+	 * The in the LWX case we don't want to do the load in the
+	 * delay slot.  It cannot issue in the same cycle and may be
+	 * speculative and unneeded.
+	 */
+	if (use_lwx_insns())
+		uasm_i_nop(p);
+#endif /* CONFIG_HUGETLB_PAGE */
+
+
+	/* build_update_entries */
+	if (use_lwx_insns()) {
+		even = ptr;
+		odd = tmp;
+		UASM_i_LWX(p, even, scratch, tmp);
+		UASM_i_ADDIU(p, tmp, tmp, sizeof(pte_t));
+		UASM_i_LWX(p, odd, scratch, tmp);
+	} else {
+		UASM_i_ADDU(p, ptr, scratch, tmp); /* add in offset */
+		even = tmp;
+		odd = ptr;
+		UASM_i_LW(p, even, 0, ptr); /* get even pte */
+		UASM_i_LW(p, odd, sizeof(pte_t), ptr); /* get odd pte */
+	}
+	if (kernel_uses_smartmips_rixi) {
+		uasm_i_dsrl_safe(p, even, even, ilog2(_PAGE_NO_EXEC));
+		uasm_i_dsrl_safe(p, odd, odd, ilog2(_PAGE_NO_EXEC));
+		uasm_i_drotr(p, even, even,
+			     ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+		UASM_i_MTC0(p, even, C0_ENTRYLO0); /* load it */
+		uasm_i_drotr(p, odd, odd,
+			     ilog2(_PAGE_GLOBAL) - ilog2(_PAGE_NO_EXEC));
+	} else {
+		uasm_i_dsrl_safe(p, even, even, ilog2(_PAGE_GLOBAL));
+		UASM_i_MTC0(p, even, C0_ENTRYLO0); /* load it */
+		uasm_i_dsrl_safe(p, odd, odd, ilog2(_PAGE_GLOBAL));
+	}
+	UASM_i_MTC0(p, odd, C0_ENTRYLO1); /* load it */
+
+	if (c0_scratch >= 0) {
+		UASM_i_MFC0(p, scratch, 31, c0_scratch);
+		build_tlb_write_entry(p, l, r, tlb_random);
+		uasm_l_leave(l, *p);
+		rv.restore_scratch = 1;
+	} else if (PAGE_SHIFT == 14 || PAGE_SHIFT == 13)  {
+		build_tlb_write_entry(p, l, r, tlb_random);
+		uasm_l_leave(l, *p);
+		UASM_i_LW(p, scratch, scratchpad_offset(0), 0);
+	} else {
+		UASM_i_LW(p, scratch, scratchpad_offset(0), 0);
+		build_tlb_write_entry(p, l, r, tlb_random);
+		uasm_l_leave(l, *p);
+		rv.restore_scratch = 1;
+	}
+
+	uasm_i_eret(p); /* return from trap */
+
+	return rv;
+}
+
 /*
  * For a 64-bit kernel, we are using the 64-bit XTLB refill exception
  * because EXL == 0.  If we wrap, we can also use the 32 instruction
@@ -903,54 +1149,67 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 	struct uasm_reloc *r = relocs;
 	u32 *f;
 	unsigned int final_len;
+	struct mips_huge_tlb_info htlb_info;
+	enum vmalloc64_mode vmalloc_mode;
 
 	memset(tlb_handler, 0, sizeof(tlb_handler));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 	memset(final_handler, 0, sizeof(final_handler));
 
-	/*
-	 * create the plain linear handler
-	 */
-	if (bcm1250_m3_war()) {
-		unsigned int segbits = 44;
+	if (scratch_reg == 0)
+		scratch_reg = allocate_kscratch();
 
-		uasm_i_dmfc0(&p, K0, C0_BADVADDR);
-		uasm_i_dmfc0(&p, K1, C0_ENTRYHI);
-		uasm_i_xor(&p, K0, K0, K1);
-		uasm_i_dsrl_safe(&p, K1, K0, 62);
-		uasm_i_dsrl_safe(&p, K0, K0, 12 + 1);
-		uasm_i_dsll_safe(&p, K0, K0, 64 + 12 + 1 - segbits);
-		uasm_i_or(&p, K0, K0, K1);
-		uasm_il_bnez(&p, &r, K0, label_leave);
-		/* No need for uasm_i_nop */
-	}
+	if ((scratch_reg > 0 || scratchpad_available()) && use_bbit_insns()) {
+		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
+							  scratch_reg);
+		vmalloc_mode = refill_scratch;
+	} else {
+		htlb_info.huge_pte = K0;
+		htlb_info.restore_scratch = 0;
+		vmalloc_mode = refill_noscratch;
+		/*
+		 * create the plain linear handler
+		 */
+		if (bcm1250_m3_war()) {
+			unsigned int segbits = 44;
+
+			uasm_i_dmfc0(&p, K0, C0_BADVADDR);
+			uasm_i_dmfc0(&p, K1, C0_ENTRYHI);
+			uasm_i_xor(&p, K0, K0, K1);
+			uasm_i_dsrl_safe(&p, K1, K0, 62);
+			uasm_i_dsrl_safe(&p, K0, K0, 12 + 1);
+			uasm_i_dsll_safe(&p, K0, K0, 64 + 12 + 1 - segbits);
+			uasm_i_or(&p, K0, K0, K1);
+			uasm_il_bnez(&p, &r, K0, label_leave);
+			/* No need for uasm_i_nop */
+		}
 
 #ifdef CONFIG_64BIT
-	build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd in K1 */
+		build_get_pmde64(&p, &l, &r, K0, K1); /* get pmd in K1 */
 #else
-	build_get_pgde32(&p, K0, K1); /* get pgd in K1 */
+		build_get_pgde32(&p, K0, K1); /* get pgd in K1 */
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
-	build_is_huge_pte(&p, &r, K0, K1, label_tlb_huge_update);
+		build_is_huge_pte(&p, &r, K0, K1, label_tlb_huge_update);
 #endif
 
-	build_get_ptep(&p, K0, K1);
-	build_update_entries(&p, K0, K1);
-	build_tlb_write_entry(&p, &l, &r, tlb_random);
-	uasm_l_leave(&l, p);
-	uasm_i_eret(&p); /* return from trap */
-
+		build_get_ptep(&p, K0, K1);
+		build_update_entries(&p, K0, K1);
+		build_tlb_write_entry(&p, &l, &r, tlb_random);
+		uasm_l_leave(&l, p);
+		uasm_i_eret(&p); /* return from trap */
+	}
 #ifdef CONFIG_HUGETLB_PAGE
 	uasm_l_tlb_huge_update(&l, p);
-	UASM_i_LW(&p, K0, 0, K1);
-	build_huge_update_entries(&p, K0, K1);
-	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random);
+	build_huge_update_entries(&p, htlb_info.huge_pte, K1);
+	build_huge_tlb_write_entry(&p, &l, &r, K0, tlb_random,
+				   htlb_info.restore_scratch);
 #endif
 
 #ifdef CONFIG_64BIT
-	build_get_pgd_vmalloc64(&p, &l, &r, K0, K1, refill);
+	build_get_pgd_vmalloc64(&p, &l, &r, K0, K1, vmalloc_mode);
 #endif
 
 	/*
@@ -1616,7 +1875,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		 * We clobbered C0_PAGEMASK, restore it.  On the other branch
 		 * it is restored in build_huge_tlb_write_entry.
 		 */
-		build_restore_pagemask(&p, &r, K0, label_nopage_tlbl);
+		build_restore_pagemask(&p, &r, K0, label_nopage_tlbl, 0);
 
 		uasm_l_tlbl_goaround2(&l, p);
 	}
-- 
1.7.2.3
