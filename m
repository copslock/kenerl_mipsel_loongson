Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 21:17:27 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9083 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492609Ab0D1TRR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 21:17:17 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bd889c90001>; Wed, 28 Apr 2010 12:17:29 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 12:16:27 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 12:16:27 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o3SJGNUX004767;
        Wed, 28 Apr 2010 12:16:23 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o3SJGNA3004766;
        Wed, 28 Apr 2010 12:16:23 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/3] MIPS: Check for accesses beyond the end of the PGD.
Date:   Wed, 28 Apr 2010 12:16:18 -0700
Message-Id: <1272482178-4712-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1272482178-4712-1-git-send-email-ddaney@caviumnetworks.com>
References: <1272482178-4712-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Apr 2010 19:16:27.0635 (UTC) FILETIME=[4D039C30:01CAE707]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For some combinations of PAGE_SIZE and vmbits, it is possible to have
userspace access that are beyond what is covered by the PGD, but
within vmbits.  Such an access would cause the TLB refill handler to
load garbage values for PMD and PTE potentially giving userspace
access to parts of the physical address space to which it is not
entitled.

In the TLB refill hot path, we add a single dsrl instruction so we can
check if any bits outside of the range covered by the PGD are set.  In
the vmalloc side we then separate the bad case from the normal vmalloc
case and call tlb_do_page_fault_0 if warranted.  This slows us down a
bit, but has the benefit of yielding deterministic behavior.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/tlbex.c |   99 +++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 61374b2..8c8c6dd 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -31,6 +31,16 @@
 #include <asm/war.h>
 #include <asm/uasm.h>
 
+/*
+ * TLB load/store/modify handlers.
+ *
+ * Only the fastpath gets synthesized at runtime, the slowpath for
+ * do_page_fault remains normal asm.
+ */
+extern void tlb_do_page_fault_0(void);
+extern void tlb_do_page_fault_1(void);
+
+
 static inline int r45k_bvahwbug(void)
 {
 	/* XXX: We should probe for the presence of this bug, but we don't. */
@@ -83,6 +93,7 @@ enum label_id {
 	label_nopage_tlbm,
 	label_smp_pgtable_change,
 	label_r3000_write_probe_fail,
+	label_large_segbits_fault,
 #ifdef CONFIG_HUGETLB_PAGE
 	label_tlb_huge_update,
 #endif
@@ -101,6 +112,7 @@ UASM_L_LA(_nopage_tlbs)
 UASM_L_LA(_nopage_tlbm)
 UASM_L_LA(_smp_pgtable_change)
 UASM_L_LA(_r3000_write_probe_fail)
+UASM_L_LA(_large_segbits_fault)
 #ifdef CONFIG_HUGETLB_PAGE
 UASM_L_LA(_tlb_huge_update)
 #endif
@@ -157,6 +169,8 @@ static u32 tlb_handler[128] __cpuinitdata;
 static struct uasm_label labels[128] __cpuinitdata;
 static struct uasm_reloc relocs[128] __cpuinitdata;
 
+static int check_for_high_segbits __cpuinitdata;
+
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 /*
  * CONFIG_MIPS_PGD_C0_CONTEXT implies 64 bit and lack of pgd_current,
@@ -532,7 +546,24 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	 * The vmalloc handling is not in the hotpath.
 	 */
 	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
-	uasm_il_bltz(p, r, tmp, label_vmalloc);
+
+	if (check_for_high_segbits) {
+		/*
+		 * The kernel currently implicitely assumes that the
+		 * MIPS SEGBITS parameter for the processor is
+		 * (PGDIR_SHIFT+PGDIR_BITS) or less, and will never
+		 * allocate virtual addresses outside the maximum
+		 * range for SEGBITS = (PGDIR_SHIFT+PGDIR_BITS). But
+		 * that doesn't prevent user code from accessing the
+		 * higher xuseg addresses.  Here, we make sure that
+		 * everything but the lower xuseg addresses goes down
+		 * the module_alloc/vmalloc path.
+		 */
+		uasm_i_dsrl_safe(p, ptr, tmp, PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
+		uasm_il_bnez(p, r, ptr, label_vmalloc);
+	} else {
+		uasm_il_bltz(p, r, tmp, label_vmalloc);
+	}
 	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
 
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
@@ -583,28 +614,64 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 #endif
 }
 
+enum vmalloc64_mode {not_refill, refill};
 /*
  * BVADDR is the faulting address, PTR is scratch.
  * PTR will hold the pgd for vmalloc.
  */
 static void __cpuinit
 build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
-			unsigned int bvaddr, unsigned int ptr)
+			unsigned int bvaddr, unsigned int ptr,
+			enum vmalloc64_mode mode)
 {
 	long swpd = (long)swapper_pg_dir;
+	int single_insn_swpd;
+	int did_vmalloc_branch = 0;
+
+	single_insn_swpd = uasm_in_compat_space_p(swpd) && !uasm_rel_lo(swpd);
 
 	uasm_l_vmalloc(l, *p);
 
-	if (uasm_in_compat_space_p(swpd) && !uasm_rel_lo(swpd)) {
-		uasm_il_b(p, r, label_vmalloc_done);
-		uasm_i_lui(p, ptr, uasm_rel_hi(swpd));
-	} else {
-		UASM_i_LA_mostly(p, ptr, swpd);
-		uasm_il_b(p, r, label_vmalloc_done);
-		if (uasm_in_compat_space_p(swpd))
-			uasm_i_addiu(p, ptr, ptr, uasm_rel_lo(swpd));
-		else
-			uasm_i_daddiu(p, ptr, ptr, uasm_rel_lo(swpd));
+	if (mode == refill && check_for_high_segbits) {
+		if (single_insn_swpd) {
+			uasm_il_bltz(p, r, bvaddr, label_vmalloc_done);
+			uasm_i_lui(p, ptr, uasm_rel_hi(swpd));
+			did_vmalloc_branch = 1;
+			/* fall through */
+		} else {
+			uasm_il_bgez(p, r, bvaddr, label_large_segbits_fault);
+		}
+	}
+	if (!did_vmalloc_branch) {
+		if (uasm_in_compat_space_p(swpd) && !uasm_rel_lo(swpd)) {
+			uasm_il_b(p, r, label_vmalloc_done);
+			uasm_i_lui(p, ptr, uasm_rel_hi(swpd));
+		} else {
+			UASM_i_LA_mostly(p, ptr, swpd);
+			uasm_il_b(p, r, label_vmalloc_done);
+			if (uasm_in_compat_space_p(swpd))
+				uasm_i_addiu(p, ptr, ptr, uasm_rel_lo(swpd));
+			else
+				uasm_i_daddiu(p, ptr, ptr, uasm_rel_lo(swpd));
+		}
+	}
+	if (mode == refill && check_for_high_segbits) {
+		uasm_l_large_segbits_fault(l, *p);
+		/*
+		 * We get here if we are an xsseg address, or if we are
+		 * an xuseg address above (PGDIR_SHIFT+PGDIR_BITS) boundary.
+		 *
+		 * Ignoring xsseg (assume disabled so would generate
+		 * (address errors?), the only remaining possibility
+		 * is the upper xuseg addresses.  On processors with
+		 * TLB_SEGBITS <= PGDIR_SHIFT+PGDIR_BITS, these
+		 * addresses would have taken an address error. We try
+		 * to mimic that here by taking a load/istream page
+		 * fault.
+		 */
+		UASM_i_LA(p, ptr, (unsigned long)tlb_do_page_fault_0);
+		uasm_i_jr(p, ptr);
+		uasm_i_nop(p);
 	}
 }
 
@@ -823,7 +890,7 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 #endif
 
 #ifdef CONFIG_64BIT
-	build_get_pgd_vmalloc64(&p, &l, &r, K0, K1);
+	build_get_pgd_vmalloc64(&p, &l, &r, K0, K1, refill);
 #endif
 
 	/*
@@ -1300,7 +1367,7 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
 	uasm_i_eret(p); /* return from trap */
 
 #ifdef CONFIG_64BIT
-	build_get_pgd_vmalloc64(p, l, r, tmp, ptr);
+	build_get_pgd_vmalloc64(p, l, r, tmp, ptr, not_refill);
 #endif
 }
 
@@ -1524,6 +1591,10 @@ void __cpuinit build_tlb_refill_handler(void)
 	 */
 	static int run_once = 0;
 
+#ifdef CONFIG_64BIT
+	check_for_high_segbits = current_cpu_data.vmbits > (PGDIR_SHIFT + PGD_ORDER + PAGE_SHIFT - 3);
+#endif
+
 	switch (current_cpu_type()) {
 	case CPU_R2000:
 	case CPU_R3000:
-- 
1.6.6.1
