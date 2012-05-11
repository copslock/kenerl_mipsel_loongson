Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 06:26:23 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:33962 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903543Ab2EKE0R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 06:26:17 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SShQh-0001hm-Gd; Thu, 10 May 2012 23:26:11 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v2,08/10] MIPS: MIPS32R2 optimisations for pipeline stalls and code size.
Date:   Thu, 10 May 2012 23:26:07 -0500
Message-Id: <1336710367-29368-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

If the CPU type is selected as MIPS32R2, then we can surround
some code with #ifdef's to reduce the binary size. Detect when
to use 'ehb' instruction to avoid pipeline stalls.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mm/tlbex.c |   39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 7b12f27..7b84001 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -74,10 +74,12 @@ static inline int __maybe_unused bcm1250_m3_war(void)
 	return BCM1250_M3_WAR;
 }
 
+#ifndef CONFIG_CPU_MIPS32_R2
 static inline int __maybe_unused r10000_llsc_war(void)
 {
 	return R10000_LLSC_WAR;
 }
+#endif
 
 static int use_bbit_insns(void)
 {
@@ -340,6 +342,7 @@ static void __cpuinit build_restore_work_registers(u32 **p)
  */
 extern unsigned long pgd_current[];
 
+# ifndef CONFIG_CPU_MIPS32_R2
 /*
  * The R3000 TLB handler is simple.
  */
@@ -379,6 +382,7 @@ static void __cpuinit build_r3000_tlb_refill_handler(void)
 
 	dump_handler((u32 *)ebase, 32);
 }
+# endif /* !CONFIG_CPU_MIPS32_R2 */
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
 
 /*
@@ -449,8 +453,22 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	}
 
 	if (cpu_has_mips_r2) {
-		if (cpu_has_mips_r2_exec_hazard)
-			uasm_i_ehb(p);
+		/*
+		 * The architecture spec says an ehb is required here,
+		 * but a number of cores do not have the hazard and
+		 * using an ehb causes an expensive pipeline stall.
+		 */
+		if (cpu_has_mips_r2_exec_hazard) {
+			switch (current_cpu_type()) {
+			case CPU_M14KC:
+			case CPU_74K:
+				break;
+
+			default:
+				uasm_i_ehb(p);
+				break;
+			}
+		}
 		tlbw(p);
 		return;
 	}
@@ -910,7 +928,7 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 #else
 	/*
 	 * smp_processor_id() << 3 is stored in CONTEXT.
-         */
+	 */
 	uasm_i_mfc0(p, ptr, C0_CONTEXT);
 	UASM_i_LA_mostly(p, tmp, pgdc);
 	uasm_i_srl(p, ptr, ptr, 23);
@@ -921,13 +939,13 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 #endif
 	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
 	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
-#ifdef CONFIG_32BIT
+
 	if (cpu_has_mips32r2) {
 		uasm_i_ext(p, tmp, tmp, PGDIR_SHIFT, (32 - PGDIR_SHIFT));
 		uasm_i_ins(p, ptr, tmp, PGD_T_LOG2, (32 - PGDIR_SHIFT));
 		return;
 	}
-#endif
+
 	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
 	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
 	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
@@ -963,7 +981,6 @@ static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
 
 static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 {
-#ifdef CONFIG_32BIT
 	if (cpu_has_mips32r2) {
 		/* For MIPS32R2, PTE ptr offset is obtained from BadVAddr */
 		UASM_i_MFC0(p, tmp, C0_BADVADDR);
@@ -972,7 +989,7 @@ static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr
 		uasm_i_ins(p, ptr, tmp, PTE_T_LOG2+1, PGDIR_SHIFT-PAGE_SHIFT-1);
 		return;
 	}
-#endif
+
 	/*
 	 * Bug workaround for the Nevada. It seems as if under certain
 	 * circumstances the move from cp0_context might produce a
@@ -1513,9 +1530,11 @@ iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
 # endif
 		UASM_i_SC(p, pte, 0, ptr);
 
+#ifndef CONFIG_CPU_MIPS32_R2
 	if (r10000_llsc_war())
 		uasm_il_beqzl(p, r, pte, label_smp_pgtable_change);
 	else
+#endif
 		uasm_il_beqz(p, r, pte, label_smp_pgtable_change);
 
 # ifdef CONFIG_64BIT_PHYS_ADDR
@@ -1649,7 +1668,7 @@ build_pte_modifiable(u32 **p, struct uasm_reloc **r,
 	}
 }
 
-#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+#if !defined(CONFIG_MIPS_PGD_C0_CONTEXT) && !defined(CONFIG_CPU_MIPS32_R2)
 
 
 /*
@@ -1803,7 +1822,7 @@ static void __cpuinit build_r3000_tlb_modify_handler(void)
 
 	dump_handler(handle_tlbm, ARRAY_SIZE(handle_tlbm));
 }
-#endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
+#endif /* !CONFIG_MIPS_PGD_C0_CONTEXT && !CONFIG_CPU_MIPS32_R2 */
 
 /*
  * R4000 style TLB load/store/modify handlers.
@@ -2120,6 +2139,7 @@ void __cpuinit build_tlb_refill_handler(void)
 #endif
 
 	switch (current_cpu_type()) {
+#ifndef CONFIG_CPU_MIPS32_R2
 	case CPU_R2000:
 	case CPU_R3000:
 	case CPU_R3000A:
@@ -2149,6 +2169,7 @@ void __cpuinit build_tlb_refill_handler(void)
 		panic("No R8000 TLB refill handler yet");
 		break;
 
+#endif /* !CONFIG_CPU_MIPS32_R2 */
 	default:
 		if (!run_once) {
 			scratch_reg = allocate_kscratch();
-- 
1.7.10
