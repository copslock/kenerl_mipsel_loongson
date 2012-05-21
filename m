Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 17:58:56 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55507 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903564Ab2EUP6v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 17:58:51 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SWV0O-0003TM-Qx; Mon, 21 May 2012 10:58:44 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v3,08/10] MIPS: MIPS32R2 optimisations for pipeline stalls and code size.
Date:   Mon, 21 May 2012 10:58:40 -0500
Message-Id: <1337615920-30445-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33404
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
to use 'ehb' instruction to avoid pipeline stalls. Utilise the
'ins' and 'ext' MIPS32R2 instructions to reduce the size of
exception handlers.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/mm/tlbex.c |   40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 897b727..de7fe58 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -340,6 +340,7 @@ static void __cpuinit build_restore_work_registers(u32 **p)
  */
 extern unsigned long pgd_current[];
 
+# ifndef CONFIG_CPU_MIPS32_R2
 /*
  * The R3000 TLB handler is simple.
  */
@@ -379,6 +380,7 @@ static void __cpuinit build_r3000_tlb_refill_handler(void)
 
 	dump_handler((u32 *)ebase, 32);
 }
+# endif /* !CONFIG_CPU_MIPS32_R2 */
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
 
 /*
@@ -449,8 +451,20 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	}
 
 	if (cpu_has_mips_r2) {
-		if (cpu_has_mips_r2_exec_hazard)
+		/*
+		 * The architecture spec says an ehb is required here,
+		 * but a number of cores do not have the hazard and
+		 * using an ehb causes an expensive pipeline stall.
+		 */
+		switch (current_cpu_type()) {
+		case CPU_M14KC:
+		case CPU_74K:
+			break;
+
+		default:
 			uasm_i_ehb(p);
+			break;
+		}
 		tlbw(p);
 		return;
 	}
@@ -910,7 +924,7 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 #else
 	/*
 	 * smp_processor_id() << 3 is stored in CONTEXT.
-         */
+	 */
 	uasm_i_mfc0(p, ptr, C0_CONTEXT);
 	UASM_i_LA_mostly(p, tmp, pgdc);
 	uasm_i_srl(p, ptr, ptr, 23);
@@ -921,6 +935,13 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 #endif
 	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
 	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
+
+	if (cpu_has_mips_r2) {
+		uasm_i_ext(p, tmp, tmp, PGDIR_SHIFT, (32 - PGDIR_SHIFT));
+		uasm_i_ins(p, ptr, tmp, PGD_T_LOG2, (32 - PGDIR_SHIFT));
+		return;
+	}
+
 	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
 	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
 	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
@@ -956,6 +977,15 @@ static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
 
 static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 {
+	if (cpu_has_mips_r2) {
+		/* PTE ptr offset is obtained from BadVAddr */
+		UASM_i_MFC0(p, tmp, C0_BADVADDR);
+		UASM_i_LW(p, ptr, 0, ptr);
+		uasm_i_ext(p, tmp, tmp, PAGE_SHIFT+1, PGDIR_SHIFT-PAGE_SHIFT-1);
+		uasm_i_ins(p, ptr, tmp, PTE_T_LOG2+1, PGDIR_SHIFT-PAGE_SHIFT-1);
+		return;
+	}
+
 	/*
 	 * Bug workaround for the Nevada. It seems as if under certain
 	 * circumstances the move from cp0_context might produce a
@@ -1632,7 +1662,7 @@ build_pte_modifiable(u32 **p, struct uasm_reloc **r,
 	}
 }
 
-#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+#if !defined(CONFIG_MIPS_PGD_C0_CONTEXT) && !defined(CONFIG_CPU_MIPS32_R2)
 
 
 /*
@@ -1786,7 +1816,7 @@ static void __cpuinit build_r3000_tlb_modify_handler(void)
 
 	dump_handler(handle_tlbm, ARRAY_SIZE(handle_tlbm));
 }
-#endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
+#endif /* !CONFIG_MIPS_PGD_C0_CONTEXT && !CONFIG_CPU_MIPS32_R2 */
 
 /*
  * R4000 style TLB load/store/modify handlers.
@@ -2103,6 +2133,7 @@ void __cpuinit build_tlb_refill_handler(void)
 #endif
 
 	switch (current_cpu_type()) {
+#ifndef CONFIG_CPU_MIPS32_R2
 	case CPU_R2000:
 	case CPU_R3000:
 	case CPU_R3000A:
@@ -2132,6 +2163,7 @@ void __cpuinit build_tlb_refill_handler(void)
 		panic("No R8000 TLB refill handler yet");
 		break;
 
+#endif /* !CONFIG_CPU_MIPS32_R2 */
 	default:
 		if (!run_once) {
 			scratch_reg = allocate_kscratch();
-- 
1.7.10
