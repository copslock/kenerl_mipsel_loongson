Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 19:41:16 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42841 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834873Ab3FSRkqTL2KY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 19:40:46 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UpMN5-0001b5-Vq; Wed, 19 Jun 2013 12:40:40 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 2/2] Revert "MIPS: mm: Use scratch for PGD when !CONFIG_MIPS_PGD_C0_CONTEXT"
Date:   Wed, 19 Jun 2013 12:40:32 -0500
Message-Id: <1371663632-30252-3-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371663632-30252-1-git-send-email-Steven.Hill@imgtec.com>
References: <1371663632-30252-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

This reverts commit 89460ce8912200429c8ed141a01eabd226683614.

This prevents all MTI platforms and bcm63xx from booting.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mmu_context.h |    7 +-
 arch/mips/mm/tlbex.c                |  142 +++++++++++++----------------------
 2 files changed, 57 insertions(+), 92 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index fc282ef..516e6e9 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -24,6 +24,8 @@
 #endif /* SMTC */
 #include <asm-generic/mm_hooks.h>
 
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+
 #define TLBMISS_HANDLER_SETUP_PGD(pgd)					\
 do {									\
 	void (*tlbmiss_handler_setup_pgd)(unsigned long);		\
@@ -34,8 +36,6 @@ do {									\
 	tlbmiss_handler_setup_pgd((unsigned long)(pgd));		\
 } while (0)
 
-
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 #define TLBMISS_HANDLER_SETUP()						\
 	do {								\
 		TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);		\
@@ -51,6 +51,9 @@ do {									\
  */
 extern unsigned long pgd_current[];
 
+#define TLBMISS_HANDLER_SETUP_PGD(pgd) \
+	pgd_current[smp_processor_id()] = (unsigned long)(pgd)
+
 #ifdef CONFIG_32BIT
 #define TLBMISS_HANDLER_SETUP()						\
 	write_c0_context((unsigned long) smp_processor_id() << 25);	\
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 0f04692..69e1e3f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -816,11 +816,11 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	}
 	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
 
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	if (pgd_reg != -1) {
 		/* pgd is in pgd_reg */
 		UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
 	} else {
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 		/*
 		 * &pgd << 11 stored in CONTEXT [23..63].
 		 */
@@ -832,30 +832,30 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		/* 1 0	1 0 1  << 6  xkphys cached */
 		uasm_i_ori(p, ptr, ptr, 0x540);
 		uasm_i_drotr(p, ptr, ptr, 11);
+	}
 #elif defined(CONFIG_SMP)
-# ifdef CONFIG_MIPS_MT_SMTC
-		/*
-		 * SMTC uses TCBind value as "CPU" index
-		 */
-		uasm_i_mfc0(p, ptr, C0_TCBIND);
-		uasm_i_dsrl_safe(p, ptr, ptr, 19);
+# ifdef	 CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC uses TCBind value as "CPU" index
+	 */
+	uasm_i_mfc0(p, ptr, C0_TCBIND);
+	uasm_i_dsrl_safe(p, ptr, ptr, 19);
 # else
-		/*
-		 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
-		 * stored in CONTEXT.
-		 */
-		uasm_i_dmfc0(p, ptr, C0_CONTEXT);
-		uasm_i_dsrl_safe(p, ptr, ptr, 23);
+	/*
+	 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
+	 * stored in CONTEXT.
+	 */
+	uasm_i_dmfc0(p, ptr, C0_CONTEXT);
+	uasm_i_dsrl_safe(p, ptr, ptr, 23);
 # endif
-		UASM_i_LA_mostly(p, tmp, pgdc);
-		uasm_i_daddu(p, ptr, ptr, tmp);
-		uasm_i_dmfc0(p, tmp, C0_BADVADDR);
-		uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
+	UASM_i_LA_mostly(p, tmp, pgdc);
+	uasm_i_daddu(p, ptr, ptr, tmp);
+	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
+	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
 #else
-		UASM_i_LA_mostly(p, ptr, pgdc);
-		uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
+	UASM_i_LA_mostly(p, ptr, pgdc);
+	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
 #endif
-	}
 
 	uasm_l_vmalloc_done(l, *p);
 
@@ -950,37 +950,31 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 static void __maybe_unused
 build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 {
-	if (pgd_reg != -1) {
-		/* pgd is in pgd_reg */
-		uasm_i_mfc0(p, ptr, c0_kscratch(), pgd_reg);
-		uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
-	} else {
-		long pgdc = (long)pgd_current;
+	long pgdc = (long)pgd_current;
 
-		/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
+	/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
 #ifdef CONFIG_SMP
-# ifdef CONFIG_MIPS_MT_SMTC
-		/*
-		 * SMTC uses TCBind value as "CPU" index
-		 */
-		uasm_i_mfc0(p, ptr, C0_TCBIND);
-		UASM_i_LA_mostly(p, tmp, pgdc);
-		uasm_i_srl(p, ptr, ptr, 19);
-# else
-		/*
-		 * smp_processor_id() << 3 is stored in CONTEXT.
-		 */
-		uasm_i_mfc0(p, ptr, C0_CONTEXT);
-		UASM_i_LA_mostly(p, tmp, pgdc);
-		uasm_i_srl(p, ptr, ptr, 23);
-# endif
-		uasm_i_addu(p, ptr, tmp, ptr);
+#ifdef	CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC uses TCBind value as "CPU" index
+	 */
+	uasm_i_mfc0(p, ptr, C0_TCBIND);
+	UASM_i_LA_mostly(p, tmp, pgdc);
+	uasm_i_srl(p, ptr, ptr, 19);
 #else
-		UASM_i_LA_mostly(p, ptr, pgdc);
+	/*
+	 * smp_processor_id() << 3 is stored in CONTEXT.
+	 */
+	uasm_i_mfc0(p, ptr, C0_CONTEXT);
+	UASM_i_LA_mostly(p, tmp, pgdc);
+	uasm_i_srl(p, ptr, ptr, 23);
 #endif
-		uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
-		uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
-	}
+	uasm_i_addu(p, ptr, tmp, ptr);
+#else
+	UASM_i_LA_mostly(p, ptr, pgdc);
+#endif
+	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
 	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
 	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
 	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
@@ -1460,17 +1454,16 @@ static void build_r4000_tlb_refill_handler(void)
 u32 handle_tlbl[FASTPATH_SIZE] __cacheline_aligned;
 u32 handle_tlbs[FASTPATH_SIZE] __cacheline_aligned;
 u32 handle_tlbm[FASTPATH_SIZE] __cacheline_aligned;
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 u32 tlbmiss_handler_setup_pgd_array[16] __cacheline_aligned;
 
-static void build_setup_pgd(void)
+static void build_r4000_setup_pgd(void)
 {
 	const int a0 = 4;
-	const int __maybe_unused a1 = 5;
-	const int __maybe_unused a2 = 6;
+	const int a1 = 5;
 	u32 *p = tlbmiss_handler_setup_pgd_array;
-#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
-	long pgdc = (long)pgd_current;
-#endif
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
 
 	memset(tlbmiss_handler_setup_pgd_array, 0, sizeof(tlbmiss_handler_setup_pgd_array));
 	memset(labels, 0, sizeof(labels));
@@ -1478,11 +1471,7 @@ static void build_setup_pgd(void)
 
 	pgd_reg = allocate_kscratch();
 
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	if (pgd_reg == -1) {
-		struct uasm_label *l = labels;
-		struct uasm_reloc *r = relocs;
-
 		/* PGD << 11 in c0_Context */
 		/*
 		 * If it is a ckseg0 address, convert to a physical
@@ -1504,37 +1493,6 @@ static void build_setup_pgd(void)
 		uasm_i_jr(&p, 31);
 		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
 	}
-#else
-	/* Save PGD to pgd_current[smp_processor_id()] */
-#if defined(CONFIG_SMP)
-# ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC uses TCBind value as "CPU" index
-	 */
-	uasm_i_mfc0(&p, a1, C0_TCBIND);
-	UASM_i_SRL_SAFE(&p, a1, a1, 19);
-# else
-	/*
-	 * smp_processor_id() is in CONTEXT
-	 */
-	UASM_i_MFC0(&p, a1, C0_CONTEXT);
-	UASM_i_SRL_SAFE(&p, a1, a1, 23);
-# endif
-	UASM_i_LA_mostly(&p, a2, pgdc);
-	UASM_i_ADDU(&p, a2, a2, a1);
-	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
-#else
-	UASM_i_LA_mostly(&p, a2, pgdc);
-	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
-#endif /* SMP */
-	uasm_i_jr(&p, 31);
-
-	/* if pgd_reg is allocated, save PGD also to scratch register */
-	if (pgd_reg != -1)
-		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
-	else
-		uasm_i_nop(&p);
-#endif
 	if (p - tlbmiss_handler_setup_pgd_array > ARRAY_SIZE(tlbmiss_handler_setup_pgd_array))
 		panic("tlbmiss_handler_setup_pgd_array space exceeded");
 	uasm_resolve_relocs(relocs, labels);
@@ -1545,6 +1503,7 @@ static void build_setup_pgd(void)
 		     tlbmiss_handler_setup_pgd_array,
 		     ARRAY_SIZE(tlbmiss_handler_setup_pgd_array));
 }
+#endif
 
 static void
 iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
@@ -2226,7 +2185,6 @@ void build_tlb_refill_handler(void)
 		if (!run_once) {
 			if (!cpu_has_local_ebase)
 				build_r3000_tlb_refill_handler();
-			build_setup_pgd();
 			build_r3000_tlb_load_handler();
 			build_r3000_tlb_store_handler();
 			build_r3000_tlb_modify_handler();
@@ -2249,7 +2207,9 @@ void build_tlb_refill_handler(void)
 	default:
 		if (!run_once) {
 			scratch_reg = allocate_kscratch();
-			build_setup_pgd();
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+			build_r4000_setup_pgd();
+#endif
 			build_r4000_tlb_load_handler();
 			build_r4000_tlb_store_handler();
 			build_r4000_tlb_modify_handler();
@@ -2270,6 +2230,8 @@ void flush_tlb_handlers(void)
 			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
 	local_flush_icache_range((unsigned long)handle_tlbm,
 			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd_array,
 			   (unsigned long)tlbmiss_handler_setup_pgd_array + sizeof(handle_tlbm));
+#endif
 }
-- 
1.7.2.5
