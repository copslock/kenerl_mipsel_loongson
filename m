Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 00:41:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61462 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993953AbdFBWkaPiTa3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Jun 2017 00:40:30 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7C0EA160C507C;
        Fri,  2 Jun 2017 23:40:18 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 23:40:22
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 6/6] MIPS: tlbex: Remove struct work_registers
Date:   Fri, 2 Jun 2017 15:38:06 -0700
Message-ID: <20170602223806.5078-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602223806.5078-1-paul.burton@imgtec.com>
References: <20170602223806.5078-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The registers used for TLB exceptions are now always K0, K1 & AT making
struct work_registers redundant. Remove it such that register use is
easier to read & reason about throughout the TLB exception handler
generation code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org

---

 arch/mips/mm/tlbex.c | 153 +++++++++++++++++++++++----------------------------
 1 file changed, 68 insertions(+), 85 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 22e0281e81cc..776482a31a51 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -57,12 +57,6 @@ __setup("noxpa", xpa_disable);
 extern void tlb_do_page_fault_0(void);
 extern void tlb_do_page_fault_1(void);
 
-struct work_registers {
-	int r1;
-	int r2;
-	int r3;
-};
-
 static inline int r45k_bvahwbug(void)
 {
 	/* XXX: We should probe for the presence of this bug, but we don't. */
@@ -264,6 +258,7 @@ static inline void dump_handler(const char *symbol, const u32 *handler, int coun
 }
 
 /* The only general purpose registers allowed in TLB handlers. */
+#define AT		1
 #define K0		26
 #define K1		27
 
@@ -343,29 +338,21 @@ int pgd_reg;
 EXPORT_SYMBOL_GPL(pgd_reg);
 enum vmalloc64_mode {not_refill, refill_scratch, refill_noscratch};
 
-static struct work_registers build_get_work_registers(u32 **p)
+static void build_get_work_registers(u32 **p)
 {
-	struct work_registers r;
-
 	/* Save in CPU local C0_KScratch? */
 	if (scratch_reg >= 0)
-		UASM_i_MTC0(p, 1, c0_kscratch(), scratch_reg);
+		UASM_i_MTC0(p, AT, c0_kscratch(), scratch_reg);
 	else
-		UASM_i_MTC0(p, 1, C0_ERROREPC);
-
-	r.r1 = K0;
-	r.r2 = K1;
-	r.r3 = 1;
-
-	return r;
+		UASM_i_MTC0(p, AT, C0_ERROREPC);
 }
 
 static void build_restore_work_registers(u32 **p)
 {
 	if (scratch_reg >= 0)
-		UASM_i_MFC0(p, 1, c0_kscratch(), scratch_reg);
+		UASM_i_MFC0(p, AT, c0_kscratch(), scratch_reg);
 	else
-		UASM_i_MFC0(p, 1, C0_ERROREPC);
+		UASM_i_MFC0(p, AT, C0_ERROREPC);
 }
 
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
@@ -2009,16 +1996,16 @@ static bool cpu_has_tlbex_tlbp_race(void)
 /*
  * R4000 style TLB load/store/modify handlers.
  */
-static struct work_registers
+static void
 build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 				   struct uasm_reloc **r)
 {
-	struct work_registers wr = build_get_work_registers(p);
+	build_get_work_registers(p);
 
 #ifdef CONFIG_64BIT
-	build_get_pmde64(p, l, r, wr.r1, wr.r2); /* get pmd in ptr */
+	build_get_pmde64(p, l, r, K0, K1); /* get pmd in ptr */
 #else
-	build_get_pgde32(p, wr.r1, wr.r2); /* get pgd in ptr */
+	build_get_pgde32(p, K0, K1); /* get pgd in ptr */
 #endif
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
@@ -2027,30 +2014,29 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
 	 * see if we need to jump to huge tlb processing.
 	 */
-	build_is_huge_pte(p, r, wr.r1, wr.r2, label_tlb_huge_update);
+	build_is_huge_pte(p, r, K0, K1, label_tlb_huge_update);
 #endif
 
-	UASM_i_MFC0(p, wr.r1, C0_BADVADDR);
-	UASM_i_LW(p, wr.r2, 0, wr.r2);
-	UASM_i_SRL(p, wr.r1, wr.r1, PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2);
-	uasm_i_andi(p, wr.r1, wr.r1, (PTRS_PER_PTE - 1) << PTE_T_LOG2);
-	UASM_i_ADDU(p, wr.r2, wr.r2, wr.r1);
+	UASM_i_MFC0(p, K0, C0_BADVADDR);
+	UASM_i_LW(p, K1, 0, K1);
+	UASM_i_SRL(p, K0, K0, PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2);
+	uasm_i_andi(p, K0, K0, (PTRS_PER_PTE - 1) << PTE_T_LOG2);
+	UASM_i_ADDU(p, K1, K1, K0);
 
 #ifdef CONFIG_SMP
 	uasm_l_smp_pgtable_change(l, *p);
 #endif
-	iPTE_LW(p, wr.r1, wr.r2); /* get even pte */
+	iPTE_LW(p, K0, K1); /* get even pte */
 	if (!m4kc_tlbp_war()) {
 		build_tlb_probe_entry(p);
 		if (cpu_has_tlbex_tlbp_race()) {
 			/* race condition happens, leaving */
 			uasm_i_ehb(p);
-			uasm_i_mfc0(p, wr.r3, C0_INDEX);
-			uasm_il_bltz(p, r, wr.r3, label_leave);
+			uasm_i_mfc0(p, AT, C0_INDEX);
+			uasm_il_bltz(p, r, AT, label_leave);
 			uasm_i_nop(p);
 		}
 	}
-	return wr;
 }
 
 static void
@@ -2077,7 +2063,6 @@ static void build_r4000_tlb_load_handler(void)
 	const int handle_tlbl_size = handle_tlbl_end - handle_tlbl;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
-	struct work_registers wr;
 
 	memset(handle_tlbl, 0, handle_tlbl_size * sizeof(handle_tlbl[0]));
 	memset(labels, 0, sizeof(labels));
@@ -2097,8 +2082,8 @@ static void build_r4000_tlb_load_handler(void)
 		/* No need for uasm_i_nop */
 	}
 
-	wr = build_r4000_tlbchange_handler_head(&p, &l, &r);
-	build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
+	build_r4000_tlbchange_handler_head(&p, &l, &r);
+	build_pte_present(&p, &r, K0, K1, AT, label_nopage_tlbl);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 
@@ -2108,11 +2093,11 @@ static void build_r4000_tlb_load_handler(void)
 		 * have triggered it.  Skip the expensive test..
 		 */
 		if (use_bbit_insns()) {
-			uasm_il_bbit0(&p, &r, wr.r1, ilog2(_PAGE_VALID),
+			uasm_il_bbit0(&p, &r, K0, ilog2(_PAGE_VALID),
 				      label_tlbl_goaround1);
 		} else {
-			uasm_i_andi(&p, wr.r3, wr.r1, _PAGE_VALID);
-			uasm_il_beqz(&p, &r, wr.r3, label_tlbl_goaround1);
+			uasm_i_andi(&p, AT, K0, _PAGE_VALID);
+			uasm_il_beqz(&p, &r, AT, label_tlbl_goaround1);
 		}
 		uasm_i_nop(&p);
 
@@ -2140,32 +2125,32 @@ static void build_r4000_tlb_load_handler(void)
 
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
-			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
+			uasm_i_bbit0(&p, K1, ilog2(sizeof(pte_t)), 8);
 		} else {
-			uasm_i_andi(&p, wr.r3, wr.r2, sizeof(pte_t));
-			uasm_i_beqz(&p, wr.r3, 8);
+			uasm_i_andi(&p, AT, K1, sizeof(pte_t));
+			uasm_i_beqz(&p, AT, 8);
 		}
 		/* load it in the delay slot*/
-		UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO0);
+		UASM_i_MFC0(&p, AT, C0_ENTRYLO0);
 		/* load it if ptr is odd */
-		UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO1);
+		UASM_i_MFC0(&p, AT, C0_ENTRYLO1);
 		/*
-		 * If the entryLo (now in wr.r3) is valid (bit 1), RI or
+		 * If the entryLo (now in AT) is valid (bit 1), RI or
 		 * XI must have triggered it.
 		 */
 		if (use_bbit_insns()) {
-			uasm_il_bbit1(&p, &r, wr.r3, 1, label_nopage_tlbl);
+			uasm_il_bbit1(&p, &r, AT, 1, label_nopage_tlbl);
 			uasm_i_nop(&p);
 			uasm_l_tlbl_goaround1(&l, p);
 		} else {
-			uasm_i_andi(&p, wr.r3, wr.r3, 2);
-			uasm_il_bnez(&p, &r, wr.r3, label_nopage_tlbl);
+			uasm_i_andi(&p, AT, AT, 2);
+			uasm_il_bnez(&p, &r, AT, label_nopage_tlbl);
 			uasm_i_nop(&p);
 		}
 		uasm_l_tlbl_goaround1(&l, p);
 	}
-	build_make_valid(&p, &r, wr.r1, wr.r2, wr.r3);
-	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
+	build_make_valid(&p, &r, K0, K1, AT);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	/*
@@ -2173,8 +2158,8 @@ static void build_r4000_tlb_load_handler(void)
 	 * spots a huge page.
 	 */
 	uasm_l_tlb_huge_update(&l, p);
-	iPTE_LW(&p, wr.r1, wr.r2);
-	build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
+	iPTE_LW(&p, K0, K1);
+	build_pte_present(&p, &r, K0, K1, AT, label_nopage_tlbl);
 	build_tlb_probe_entry(&p);
 
 	if (cpu_has_rixi && !cpu_has_rixiex) {
@@ -2183,11 +2168,11 @@ static void build_r4000_tlb_load_handler(void)
 		 * have triggered it.  Skip the expensive test..
 		 */
 		if (use_bbit_insns()) {
-			uasm_il_bbit0(&p, &r, wr.r1, ilog2(_PAGE_VALID),
+			uasm_il_bbit0(&p, &r, K0, ilog2(_PAGE_VALID),
 				      label_tlbl_goaround2);
 		} else {
-			uasm_i_andi(&p, wr.r3, wr.r1, _PAGE_VALID);
-			uasm_il_beqz(&p, &r, wr.r3, label_tlbl_goaround2);
+			uasm_i_andi(&p, AT, K0, _PAGE_VALID);
+			uasm_il_beqz(&p, &r, AT, label_tlbl_goaround2);
 		}
 		uasm_i_nop(&p);
 
@@ -2215,24 +2200,24 @@ static void build_r4000_tlb_load_handler(void)
 
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
-			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
+			uasm_i_bbit0(&p, K1, ilog2(sizeof(pte_t)), 8);
 		} else {
-			uasm_i_andi(&p, wr.r3, wr.r2, sizeof(pte_t));
-			uasm_i_beqz(&p, wr.r3, 8);
+			uasm_i_andi(&p, AT, K1, sizeof(pte_t));
+			uasm_i_beqz(&p, AT, 8);
 		}
 		/* load it in the delay slot*/
-		UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO0);
+		UASM_i_MFC0(&p, AT, C0_ENTRYLO0);
 		/* load it if ptr is odd */
-		UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO1);
+		UASM_i_MFC0(&p, AT, C0_ENTRYLO1);
 		/*
-		 * If the entryLo (now in wr.r3) is valid (bit 1), RI or
+		 * If the entryLo (now in AT) is valid (bit 1), RI or
 		 * XI must have triggered it.
 		 */
 		if (use_bbit_insns()) {
-			uasm_il_bbit0(&p, &r, wr.r3, 1, label_tlbl_goaround2);
+			uasm_il_bbit0(&p, &r, AT, 1, label_tlbl_goaround2);
 		} else {
-			uasm_i_andi(&p, wr.r3, wr.r3, 2);
-			uasm_il_beqz(&p, &r, wr.r3, label_tlbl_goaround2);
+			uasm_i_andi(&p, AT, AT, 2);
+			uasm_il_beqz(&p, &r, AT, label_tlbl_goaround2);
 		}
 		if (PM_DEFAULT_MASK == 0)
 			uasm_i_nop(&p);
@@ -2240,12 +2225,12 @@ static void build_r4000_tlb_load_handler(void)
 		 * We clobbered C0_PAGEMASK, restore it.  On the other branch
 		 * it is restored in build_huge_tlb_write_entry.
 		 */
-		build_restore_pagemask(&p, &r, wr.r3, label_nopage_tlbl, 0);
+		build_restore_pagemask(&p, &r, AT, label_nopage_tlbl, 0);
 
 		uasm_l_tlbl_goaround2(&l, p);
 	}
-	uasm_i_ori(&p, wr.r1, wr.r1, (_PAGE_ACCESSED | _PAGE_VALID));
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 1);
+	uasm_i_ori(&p, K0, K0, (_PAGE_ACCESSED | _PAGE_VALID));
+	build_huge_handler_tail(&p, &r, &l, K0, K1, 1);
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
@@ -2276,18 +2261,17 @@ static void build_r4000_tlb_store_handler(void)
 	const int handle_tlbs_size = handle_tlbs_end - handle_tlbs;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
-	struct work_registers wr;
 
 	memset(handle_tlbs, 0, handle_tlbs_size * sizeof(handle_tlbs[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
-	wr = build_r4000_tlbchange_handler_head(&p, &l, &r);
-	build_pte_writable(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbs);
+	build_r4000_tlbchange_handler_head(&p, &l, &r);
+	build_pte_writable(&p, &r, K0, K1, AT, label_nopage_tlbs);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
-	build_make_write(&p, &r, wr.r1, wr.r2, wr.r3);
-	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
+	build_make_write(&p, &r, K0, K1, AT);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	/*
@@ -2295,12 +2279,12 @@ static void build_r4000_tlb_store_handler(void)
 	 * build_r4000_tlbchange_handler_head spots a huge page.
 	 */
 	uasm_l_tlb_huge_update(&l, p);
-	iPTE_LW(&p, wr.r1, wr.r2);
-	build_pte_writable(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbs);
+	iPTE_LW(&p, K0, K1);
+	build_pte_writable(&p, &r, K0, K1, AT, label_nopage_tlbs);
 	build_tlb_probe_entry(&p);
-	uasm_i_ori(&p, wr.r1, wr.r1,
+	uasm_i_ori(&p, K0, K0,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 1);
+	build_huge_handler_tail(&p, &r, &l, K0, K1, 1);
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
@@ -2331,19 +2315,18 @@ static void build_r4000_tlb_modify_handler(void)
 	const int handle_tlbm_size = handle_tlbm_end - handle_tlbm;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
-	struct work_registers wr;
 
 	memset(handle_tlbm, 0, handle_tlbm_size * sizeof(handle_tlbm[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
-	wr = build_r4000_tlbchange_handler_head(&p, &l, &r);
-	build_pte_modifiable(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbm);
+	build_r4000_tlbchange_handler_head(&p, &l, &r);
+	build_pte_modifiable(&p, &r, K0, K1, AT, label_nopage_tlbm);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 	/* Present and writable bits set, set accessed and dirty bits. */
-	build_make_write(&p, &r, wr.r1, wr.r2, wr.r3);
-	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
+	build_make_write(&p, &r, K0, K1, AT);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
 
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	/*
@@ -2351,12 +2334,12 @@ static void build_r4000_tlb_modify_handler(void)
 	 * build_r4000_tlbchange_handler_head spots a huge page.
 	 */
 	uasm_l_tlb_huge_update(&l, p);
-	iPTE_LW(&p, wr.r1, wr.r2);
-	build_pte_modifiable(&p, &r, wr.r1, wr.r2,  wr.r3, label_nopage_tlbm);
+	iPTE_LW(&p, K0, K1);
+	build_pte_modifiable(&p, &r, K0, K1,  AT, label_nopage_tlbm);
 	build_tlb_probe_entry(&p);
-	uasm_i_ori(&p, wr.r1, wr.r1,
+	uasm_i_ori(&p, K0, K0,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2, 0);
+	build_huge_handler_tail(&p, &r, &l, K0, K1, 0);
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
-- 
2.13.0
