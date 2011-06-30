Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2011 00:31:19 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13672 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491162Ab1F3WbL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jul 2011 00:31:11 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e0cf96f0000>; Thu, 30 Jun 2011 15:32:15 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 30 Jun 2011 15:31:08 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 30 Jun 2011 15:31:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p5UMV4FQ011074;
        Thu, 30 Jun 2011 15:31:05 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p5UMV47f011073;
        Thu, 30 Jun 2011 15:31:04 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Close races in TLB modify handlers.
Date:   Thu, 30 Jun 2011 15:31:02 -0700
Message-Id: <1309473062-11041-1-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 30 Jun 2011 22:31:08.0017 (UTC) FILETIME=[67DD7610:01CC3775]
X-archive-position: 30572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 97

Page table entries are made invalid by writing a zero into the the PTE
slot in a page table.  This creates a race condition with the TLB
modify handlers when they are updating the PTE.

CPU0                              CPU1

Test for _PAGE_PRESENT
.                                 set to not _PAGE_PRESENT (zero)
Set to _PAGE_VALID

So now the page not present value (zero) is suddenly valid and user
space programs have access to physical page zero.

We close the race by putting the test for _PAGE_PRESENT and setting of
_PAGE_VALID into an atomic LL/SC section.  This requires more
registers than just K0 and K1 in the handlers, so we need to save some
registers to a save area and then restore them when we are done.

The save area is an array of cacheline aligned structures that should
not suffer cache line bouncing as they are CPU private.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/tlbex.c |  251 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 157 insertions(+), 94 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 424ed4b..5335901 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -42,6 +42,18 @@
 extern void tlb_do_page_fault_0(void);
 extern void tlb_do_page_fault_1(void);
 
+struct work_registers {
+	int r1;
+	int r2;
+	int r3;
+};
+
+struct tlb_reg_save {
+	unsigned long a;
+	unsigned long b;
+} ____cacheline_aligned_in_smp;
+
+static struct tlb_reg_save handler_reg_save[NR_CPUS];
 
 static inline int r45k_bvahwbug(void)
 {
@@ -197,6 +209,7 @@ static inline void dump_handler(const u32 *handler, int count)
 #define C0_BADVADDR	8, 0
 #define C0_ENTRYHI	10, 0
 #define C0_EPC		14, 0
+#define C0_EBASE	15, 1
 #define C0_XCONTEXT	20, 0
 
 #ifdef CONFIG_64BIT
@@ -227,6 +240,38 @@ static int check_for_high_segbits __cpuinitdata;
 
 static unsigned int kscratch_used_mask __cpuinitdata;
 
+static struct work_registers __cpuinit build_get_work_registers(u32 **p)
+{
+	struct work_registers r;
+
+#ifdef CONFIG_SMP
+	/* Mask CPU number out of EBase */
+	UASM_i_MFC0(p, K0, C0_EBASE);
+	uasm_i_andi(p, K0, K0, 0x3ff);
+	/* handler_reg_save index in K0 */
+	UASM_i_SLL(p, K0, K0, ilog2(sizeof(struct tlb_reg_save)));
+
+	UASM_i_LA(p, K1, (long)&handler_reg_save);
+	UASM_i_ADDU(p, K0, K0, K1);
+#else
+	UASM_i_LA(p, K0, (long)&handler_reg_save);
+#endif
+	/* K0 now points to save area, save $1 and $2  */
+	UASM_i_SW(p, 1, offsetof(struct tlb_reg_save, a), K0);
+	UASM_i_SW(p, 2, offsetof(struct tlb_reg_save, b), K0);
+
+	r.r1 = K1;
+	r.r2 = 1;
+	r.r3 = 2;
+	return r;
+}
+static void __cpuinit build_restore_work_registers(u32 **p)
+{
+	/* K0 already points to save area, restore $1 and $2  */
+	UASM_i_LW(p, 1, offsetof(struct tlb_reg_save, a), K0);
+	UASM_i_LW(p, 2, offsetof(struct tlb_reg_save, b), K0);
+}
+
 static int __cpuinit allocate_kscratch(void)
 {
 	int r;
@@ -1462,22 +1507,28 @@ iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
  */
 static void __cpuinit
 build_pte_present(u32 **p, struct uasm_reloc **r,
-		  unsigned int pte, unsigned int ptr, enum label_id lid)
+		  int pte, int ptr, int scratch, enum label_id lid)
 {
+	int t = scratch >= 0 ? scratch : pte;
+
 	if (kernel_uses_smartmips_rixi) {
 		if (use_bbit_insns()) {
 			uasm_il_bbit0(p, r, pte, ilog2(_PAGE_PRESENT), lid);
 			uasm_i_nop(p);
 		} else {
-			uasm_i_andi(p, pte, pte, _PAGE_PRESENT);
-			uasm_il_beqz(p, r, pte, lid);
-			iPTE_LW(p, pte, ptr);
+			uasm_i_andi(p, t, pte, _PAGE_PRESENT);
+			uasm_il_beqz(p, r, t, lid);
+			if (pte == t)
+				/* You lose the SMP race :-(*/
+				iPTE_LW(p, pte, ptr);
 		}
 	} else {
-		uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
-		uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_READ);
-		uasm_il_bnez(p, r, pte, lid);
-		iPTE_LW(p, pte, ptr);
+		uasm_i_andi(p, t, pte, _PAGE_PRESENT | _PAGE_READ);
+		uasm_i_xori(p, t, t, _PAGE_PRESENT | _PAGE_READ);
+		uasm_il_bnez(p, r, t, lid);
+		if (pte == t)
+			/* You lose the SMP race :-(*/
+			iPTE_LW(p, pte, ptr);
 	}
 }
 
@@ -1497,19 +1548,19 @@ build_make_valid(u32 **p, struct uasm_reloc **r, unsigned int pte,
  */
 static void __cpuinit
 build_pte_writable(u32 **p, struct uasm_reloc **r,
-		   unsigned int pte, unsigned int ptr, enum label_id lid)
+		   unsigned int pte, unsigned int ptr, int scratch,
+		   enum label_id lid)
 {
-	if (use_bbit_insns()) {
-		uasm_il_bbit0(p, r, pte, ilog2(_PAGE_PRESENT), lid);
-		uasm_i_nop(p);
-		uasm_il_bbit0(p, r, pte, ilog2(_PAGE_WRITE), lid);
-		uasm_i_nop(p);
-	} else {
-		uasm_i_andi(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
-		uasm_i_xori(p, pte, pte, _PAGE_PRESENT | _PAGE_WRITE);
-		uasm_il_bnez(p, r, pte, lid);
+	int t = scratch >= 0 ? scratch : pte;
+
+	uasm_i_andi(p, t, pte, _PAGE_PRESENT | _PAGE_WRITE);
+	uasm_i_xori(p, t, t, _PAGE_PRESENT | _PAGE_WRITE);
+	uasm_il_bnez(p, r, t, lid);
+	if (pte == t)
+		/* You lose the SMP race :-(*/
 		iPTE_LW(p, pte, ptr);
-	}
+	else
+		uasm_i_nop(p);
 }
 
 /* Make PTE writable, update software status bits as well, then store
@@ -1531,15 +1582,19 @@ build_make_write(u32 **p, struct uasm_reloc **r, unsigned int pte,
  */
 static void __cpuinit
 build_pte_modifiable(u32 **p, struct uasm_reloc **r,
-		     unsigned int pte, unsigned int ptr, enum label_id lid)
+		     unsigned int pte, unsigned int ptr, int scratch,
+		     enum label_id lid)
 {
 	if (use_bbit_insns()) {
 		uasm_il_bbit0(p, r, pte, ilog2(_PAGE_WRITE), lid);
 		uasm_i_nop(p);
 	} else {
-		uasm_i_andi(p, pte, pte, _PAGE_WRITE);
-		uasm_il_beqz(p, r, pte, lid);
-		iPTE_LW(p, pte, ptr);
+		int t = scratch >= 0 ? scratch : pte;
+		uasm_i_andi(p, t, pte, _PAGE_WRITE);
+		uasm_il_beqz(p, r, t, lid);
+		if (pte == t)
+			/* You lose the SMP race :-(*/
+			iPTE_LW(p, pte, ptr);
 	}
 }
 
@@ -1619,7 +1674,7 @@ static void __cpuinit build_r3000_tlb_load_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
-	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
+	build_pte_present(&p, &r, K0, K1, -1, label_nopage_tlbl);
 	uasm_i_nop(&p); /* load delay */
 	build_make_valid(&p, &r, K0, K1);
 	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
@@ -1649,7 +1704,7 @@ static void __cpuinit build_r3000_tlb_store_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 
 	build_r3000_tlbchange_handler_head(&p, K0, K1);
-	build_pte_writable(&p, &r, K0, K1, label_nopage_tlbs);
+	build_pte_writable(&p, &r, K0, K1, -1, label_nopage_tlbs);
 	uasm_i_nop(&p); /* load delay */
 	build_make_write(&p, &r, K0, K1);
 	build_r3000_tlb_reload_write(&p, &l, &r, K0, K1);
@@ -1702,15 +1757,16 @@ static void __cpuinit build_r3000_tlb_modify_handler(void)
 /*
  * R4000 style TLB load/store/modify handlers.
  */
-static void __cpuinit
+static struct work_registers __cpuinit
 build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
-				   struct uasm_reloc **r, unsigned int pte,
-				   unsigned int ptr)
+				   struct uasm_reloc **r)
 {
+	struct work_registers wr = build_get_work_registers(p);
+
 #ifdef CONFIG_64BIT
-	build_get_pmde64(p, l, r, pte, ptr); /* get pmd in ptr */
+	build_get_pmde64(p, l, r, wr.r1, wr.r2); /* get pmd in ptr */
 #else
-	build_get_pgde32(p, pte, ptr); /* get pgd in ptr */
+	build_get_pgde32(p, wr.r1, wr.r2); /* get pgd in ptr */
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
@@ -1719,21 +1775,22 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 	 * instead contains the tlb pte. Check the PAGE_HUGE bit and
 	 * see if we need to jump to huge tlb processing.
 	 */
-	build_is_huge_pte(p, r, pte, ptr, label_tlb_huge_update);
+	build_is_huge_pte(p, r, wr.r1, wr.r2, label_tlb_huge_update);
 #endif
 
-	UASM_i_MFC0(p, pte, C0_BADVADDR);
-	UASM_i_LW(p, ptr, 0, ptr);
-	UASM_i_SRL(p, pte, pte, PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2);
-	uasm_i_andi(p, pte, pte, (PTRS_PER_PTE - 1) << PTE_T_LOG2);
-	UASM_i_ADDU(p, ptr, ptr, pte);
+	UASM_i_MFC0(p, wr.r1, C0_BADVADDR);
+	UASM_i_LW(p, wr.r2, 0, wr.r2);
+	UASM_i_SRL(p, wr.r1, wr.r1, PAGE_SHIFT + PTE_ORDER - PTE_T_LOG2);
+	uasm_i_andi(p, wr.r1, wr.r1, (PTRS_PER_PTE - 1) << PTE_T_LOG2);
+	UASM_i_ADDU(p, wr.r2, wr.r2, wr.r1);
 
 #ifdef CONFIG_SMP
 	uasm_l_smp_pgtable_change(l, *p);
 #endif
-	iPTE_LW(p, pte, ptr); /* get even pte */
+	iPTE_LW(p, wr.r1, wr.r2); /* get even pte */
 	if (!m4kc_tlbp_war())
 		build_tlb_probe_entry(p);
+	return wr;
 }
 
 static void __cpuinit
@@ -1746,6 +1803,7 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
 	build_update_entries(p, tmp, ptr);
 	build_tlb_write_entry(p, l, r, tlb_indexed);
 	uasm_l_leave(l, *p);
+	build_restore_work_registers(p);
 	uasm_i_eret(p); /* return from trap */
 
 #ifdef CONFIG_64BIT
@@ -1758,6 +1816,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	u32 *p = handle_tlbl;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
+	struct work_registers wr;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1777,8 +1836,8 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		/* No need for uasm_i_nop */
 	}
 
-	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
-	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
+	wr = build_r4000_tlbchange_handler_head(&p, &l, &r);
+	build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 
@@ -1788,44 +1847,43 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		 * have triggered it.  Skip the expensive test..
 		 */
 		if (use_bbit_insns()) {
-			uasm_il_bbit0(&p, &r, K0, ilog2(_PAGE_VALID),
+			uasm_il_bbit0(&p, &r, wr.r1, ilog2(_PAGE_VALID),
 				      label_tlbl_goaround1);
 		} else {
-			uasm_i_andi(&p, K0, K0, _PAGE_VALID);
-			uasm_il_beqz(&p, &r, K0, label_tlbl_goaround1);
+			uasm_i_andi(&p, wr.r3, wr.r1, _PAGE_VALID);
+			uasm_il_beqz(&p, &r, wr.r3, label_tlbl_goaround1);
 		}
 		uasm_i_nop(&p);
 
 		uasm_i_tlbr(&p);
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
-			uasm_i_bbit0(&p, K1, ilog2(sizeof(pte_t)), 8);
+			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
 		} else {
-			uasm_i_andi(&p, K0, K1, sizeof(pte_t));
-			uasm_i_beqz(&p, K0, 8);
+			uasm_i_andi(&p, wr.r3, wr.r2, sizeof(pte_t));
+			uasm_i_beqz(&p, wr.r3, 8);
 		}
-
-		UASM_i_MFC0(&p, K0, C0_ENTRYLO0); /* load it in the delay slot*/
-		UASM_i_MFC0(&p, K0, C0_ENTRYLO1); /* load it if ptr is odd */
+		/* load it in the delay slot*/
+		UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO0);
+		/* load it if ptr is odd */
+		UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO1);
 		/*
-		 * If the entryLo (now in K0) is valid (bit 1), RI or
+		 * If the entryLo (now in wr.r3) is valid (bit 1), RI or
 		 * XI must have triggered it.
 		 */
 		if (use_bbit_insns()) {
-			uasm_il_bbit1(&p, &r, K0, 1, label_nopage_tlbl);
-			/* Reload the PTE value */
-			iPTE_LW(&p, K0, K1);
+			uasm_il_bbit1(&p, &r, wr.r3, 1, label_nopage_tlbl);
+			uasm_i_nop(&p);
 			uasm_l_tlbl_goaround1(&l, p);
 		} else {
-			uasm_i_andi(&p, K0, K0, 2);
-			uasm_il_bnez(&p, &r, K0, label_nopage_tlbl);
-			uasm_l_tlbl_goaround1(&l, p);
-			/* Reload the PTE value */
-			iPTE_LW(&p, K0, K1);
+			uasm_i_andi(&p, wr.r3, wr.r3, 2);
+			uasm_il_bnez(&p, &r, wr.r3, label_nopage_tlbl);
+			uasm_i_nop(&p);
 		}
+		uasm_l_tlbl_goaround1(&l, p);
 	}
-	build_make_valid(&p, &r, K0, K1);
-	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
+	build_make_valid(&p, &r, wr.r1, wr.r2);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
 
 #ifdef CONFIG_HUGETLB_PAGE
 	/*
@@ -1833,8 +1891,8 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 	 * spots a huge page.
 	 */
 	uasm_l_tlb_huge_update(&l, p);
-	iPTE_LW(&p, K0, K1);
-	build_pte_present(&p, &r, K0, K1, label_nopage_tlbl);
+	iPTE_LW(&p, wr.r1, wr.r2);
+	build_pte_present(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbl);
 	build_tlb_probe_entry(&p);
 
 	if (kernel_uses_smartmips_rixi) {
@@ -1843,50 +1901,51 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		 * have triggered it.  Skip the expensive test..
 		 */
 		if (use_bbit_insns()) {
-			uasm_il_bbit0(&p, &r, K0, ilog2(_PAGE_VALID),
+			uasm_il_bbit0(&p, &r, wr.r1, ilog2(_PAGE_VALID),
 				      label_tlbl_goaround2);
 		} else {
-			uasm_i_andi(&p, K0, K0, _PAGE_VALID);
-			uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+			uasm_i_andi(&p, wr.r3, wr.r1, _PAGE_VALID);
+			uasm_il_beqz(&p, &r, wr.r3, label_tlbl_goaround2);
 		}
 		uasm_i_nop(&p);
 
 		uasm_i_tlbr(&p);
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
-			uasm_i_bbit0(&p, K1, ilog2(sizeof(pte_t)), 8);
+			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
 		} else {
-			uasm_i_andi(&p, K0, K1, sizeof(pte_t));
-			uasm_i_beqz(&p, K0, 8);
+			uasm_i_andi(&p, wr.r3, wr.r2, sizeof(pte_t));
+			uasm_i_beqz(&p, wr.r3, 8);
 		}
-		UASM_i_MFC0(&p, K0, C0_ENTRYLO0); /* load it in the delay slot*/
-		UASM_i_MFC0(&p, K0, C0_ENTRYLO1); /* load it if ptr is odd */
+		/* load it in the delay slot*/
+		UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO0);
+		/* load it if ptr is odd */
+		UASM_i_MFC0(&p, wr.r3, C0_ENTRYLO1);
 		/*
-		 * If the entryLo (now in K0) is valid (bit 1), RI or
+		 * If the entryLo (now in wr.r3) is valid (bit 1), RI or
 		 * XI must have triggered it.
 		 */
 		if (use_bbit_insns()) {
-			uasm_il_bbit0(&p, &r, K0, 1, label_tlbl_goaround2);
+			uasm_il_bbit0(&p, &r, wr.r3, 1, label_tlbl_goaround2);
 		} else {
-			uasm_i_andi(&p, K0, K0, 2);
-			uasm_il_beqz(&p, &r, K0, label_tlbl_goaround2);
+			uasm_i_andi(&p, wr.r3, wr.r3, 2);
+			uasm_il_beqz(&p, &r, wr.r3, label_tlbl_goaround2);
 		}
-		/* Reload the PTE value */
-		iPTE_LW(&p, K0, K1);
 
 		/*
 		 * We clobbered C0_PAGEMASK, restore it.  On the other branch
 		 * it is restored in build_huge_tlb_write_entry.
 		 */
-		build_restore_pagemask(&p, &r, K0, label_nopage_tlbl, 0);
+		build_restore_pagemask(&p, &r, wr.r3, label_nopage_tlbl, 0);
 
 		uasm_l_tlbl_goaround2(&l, p);
 	}
-	uasm_i_ori(&p, K0, K0, (_PAGE_ACCESSED | _PAGE_VALID));
-	build_huge_handler_tail(&p, &r, &l, K0, K1);
+	uasm_i_ori(&p, wr.r1, wr.r1, (_PAGE_ACCESSED | _PAGE_VALID));
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
 #endif
 
 	uasm_l_nopage_tlbl(&l, p);
+	build_restore_work_registers(&p);
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
 	uasm_i_nop(&p);
 
@@ -1905,17 +1964,18 @@ static void __cpuinit build_r4000_tlb_store_handler(void)
 	u32 *p = handle_tlbs;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
+	struct work_registers wr;
 
 	memset(handle_tlbs, 0, sizeof(handle_tlbs));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
-	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
-	build_pte_writable(&p, &r, K0, K1, label_nopage_tlbs);
+	wr = build_r4000_tlbchange_handler_head(&p, &l, &r);
+	build_pte_writable(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbs);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
-	build_make_write(&p, &r, K0, K1);
-	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
+	build_make_write(&p, &r, wr.r1, wr.r2);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
 
 #ifdef CONFIG_HUGETLB_PAGE
 	/*
@@ -1923,15 +1983,16 @@ static void __cpuinit build_r4000_tlb_store_handler(void)
 	 * build_r4000_tlbchange_handler_head spots a huge page.
 	 */
 	uasm_l_tlb_huge_update(&l, p);
-	iPTE_LW(&p, K0, K1);
-	build_pte_writable(&p, &r, K0, K1, label_nopage_tlbs);
+	iPTE_LW(&p, wr.r1, wr.r2);
+	build_pte_writable(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbs);
 	build_tlb_probe_entry(&p);
-	uasm_i_ori(&p, K0, K0,
+	uasm_i_ori(&p, wr.r1, wr.r1,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, K0, K1);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
 #endif
 
 	uasm_l_nopage_tlbs(&l, p);
+	build_restore_work_registers(&p);
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
 
@@ -1950,18 +2011,19 @@ static void __cpuinit build_r4000_tlb_modify_handler(void)
 	u32 *p = handle_tlbm;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
+	struct work_registers wr;
 
 	memset(handle_tlbm, 0, sizeof(handle_tlbm));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
 
-	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
-	build_pte_modifiable(&p, &r, K0, K1, label_nopage_tlbm);
+	wr = build_r4000_tlbchange_handler_head(&p, &l, &r);
+	build_pte_modifiable(&p, &r, wr.r1, wr.r2, wr.r3, label_nopage_tlbm);
 	if (m4kc_tlbp_war())
 		build_tlb_probe_entry(&p);
 	/* Present and writable bits set, set accessed and dirty bits. */
-	build_make_write(&p, &r, K0, K1);
-	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
+	build_make_write(&p, &r, wr.r1, wr.r2);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, wr.r1, wr.r2);
 
 #ifdef CONFIG_HUGETLB_PAGE
 	/*
@@ -1969,15 +2031,16 @@ static void __cpuinit build_r4000_tlb_modify_handler(void)
 	 * build_r4000_tlbchange_handler_head spots a huge page.
 	 */
 	uasm_l_tlb_huge_update(&l, p);
-	iPTE_LW(&p, K0, K1);
-	build_pte_modifiable(&p, &r, K0, K1, label_nopage_tlbm);
+	iPTE_LW(&p, wr.r1, wr.r2);
+	build_pte_modifiable(&p, &r, wr.r1, wr.r2,  wr.r3, label_nopage_tlbm);
 	build_tlb_probe_entry(&p);
-	uasm_i_ori(&p, K0, K0,
+	uasm_i_ori(&p, wr.r1, wr.r1,
 		   _PAGE_ACCESSED | _PAGE_MODIFIED | _PAGE_VALID | _PAGE_DIRTY);
-	build_huge_handler_tail(&p, &r, &l, K0, K1);
+	build_huge_handler_tail(&p, &r, &l, wr.r1, wr.r2);
 #endif
 
 	uasm_l_nopage_tlbm(&l, p);
+	build_restore_work_registers(&p);
 	uasm_i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
 	uasm_i_nop(&p);
 
-- 
1.7.2.3
