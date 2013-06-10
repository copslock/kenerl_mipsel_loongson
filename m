Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:34:28 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2641 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817528Ab3FJHe0KiGYS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:34:26 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:30:37 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:34:16 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:34:15 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id AA044F2D73; Mon, 10
 Jun 2013 00:34:14 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 3/4] MIPS: mm: Use scratch for PGD when
 !CONFIG_MIPS_PGD_C0_CONTEXT
Date:   Mon, 10 Jun 2013 13:05:32 +0530
Message-ID: <1370849733-5074-4-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370849733-5074-1-git-send-email-jchandra@broadcom.com>
References: <1370849733-5074-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5F1731W33901307-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Allow usage of scratch register for current pgd even when
MIPS_PGD_C0_CONTEXT is not configured.  MIPS_PGD_C0_CONTEXT is set
for 64r2 platforms to indicate availability of Xcontext for saving
cpuid, and this was also tied to using scratch registers for PGD.

This commit will allow usage of scratch register to store the current
pgd, if one can be allocated for the platform, even in other cases
(i.e when MIPS_PGD_C0_CONTEXT is not set). The processor id will be
kept in the CP0 Context register in this case.

The code to store the current pgd for the TLB miss handler is now
generated in all cases, and if scratch register is available, the
pgd is also stored in the scratch register.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mmu_context.h |    6 +-
 arch/mips/mm/tlbex.c                |  143 ++++++++++++++++++++++-------------
 2 files changed, 92 insertions(+), 57 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 8201160..41aa181 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -24,8 +24,6 @@
 #endif /* SMTC */
 #include <asm-generic/mm_hooks.h>
 
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-
 #define TLBMISS_HANDLER_SETUP_PGD(pgd)					\
 do {									\
 	void (*tlbmiss_handler_setup_pgd)(unsigned long);		\
@@ -36,6 +34,7 @@ do {									\
 	tlbmiss_handler_setup_pgd((unsigned long)(pgd));		\
 } while (0)
 
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 #define TLBMISS_HANDLER_SETUP()						\
 	do {								\
 		TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);		\
@@ -51,9 +50,6 @@ do {									\
  */
 extern unsigned long pgd_current[];
 
-#define TLBMISS_HANDLER_SETUP_PGD(pgd) \
-	pgd_current[smp_processor_id()] = (unsigned long)(pgd)
-
 #ifdef CONFIG_32BIT
 #define TLBMISS_HANDLER_SETUP()						\
 	write_c0_context((unsigned long) smp_processor_id() << 25);	\
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 6bac544..e1aadda 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -830,11 +830,11 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	}
 	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
 
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	if (pgd_reg != -1) {
 		/* pgd is in pgd_reg */
 		UASM_i_MFC0(p, ptr, c0_kscratch, pgd_reg);
 	} else {
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 		/*
 		 * &pgd << 11 stored in CONTEXT [23..63].
 		 */
@@ -846,30 +846,32 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		/* 1 0	1 0 1  << 6  xkphys cached */
 		uasm_i_ori(p, ptr, ptr, 0x540);
 		uasm_i_drotr(p, ptr, ptr, 11);
-	}
-#elif defined(CONFIG_SMP)
-# ifdef	 CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC uses TCBind value as "CPU" index
-	 */
-	uasm_i_mfc0(p, ptr, C0_TCBIND);
-	uasm_i_dsrl_safe(p, ptr, ptr, 19);
+#else
+#if defined(CONFIG_SMP)
+# ifdef	CONFIG_MIPS_MT_SMTC
+		/*
+		 * SMTC uses TCBind value as "CPU" index
+		 */
+		uasm_i_mfc0(p, ptr, C0_TCBIND);
+		uasm_i_dsrl_safe(p, ptr, ptr, 19);
 # else
-	/*
-	 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
-	 * stored in CONTEXT.
-	 */
-	uasm_i_dmfc0(p, ptr, C0_CONTEXT);
-	uasm_i_dsrl_safe(p, ptr, ptr, 23);
+		/*
+		 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
+		 * stored in CONTEXT.
+		 */
+		uasm_i_dmfc0(p, ptr, C0_CONTEXT);
+		uasm_i_dsrl_safe(p, ptr, ptr, 23);
 # endif
-	UASM_i_LA_mostly(p, tmp, pgdc);
-	uasm_i_daddu(p, ptr, ptr, tmp);
-	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
-	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
+		UASM_i_LA_mostly(p, tmp, pgdc);
+		uasm_i_daddu(p, ptr, ptr, tmp);
+		uasm_i_dmfc0(p, tmp, C0_BADVADDR);
+		uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
 #else
-	UASM_i_LA_mostly(p, ptr, pgdc);
-	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
-#endif
+		UASM_i_LA_mostly(p, ptr, pgdc);
+		uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
+#endif /* SMP */
+#endif  /* CONFIG_MIPS_PGD_C0_CONTEXT */
+	}
 
 	uasm_l_vmalloc_done(l, *p);
 
@@ -964,31 +966,37 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 static void __cpuinit __maybe_unused
 build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 {
-	long pgdc = (long)pgd_current;
+	if (pgd_reg != -1) {
+		/* pgd is in pgd_reg */
+		uasm_i_mfc0(p, ptr, c0_kscratch, pgd_reg);
+		uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+	} else {
+		long pgdc = (long)pgd_current;
 
-	/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
+		/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
 #ifdef CONFIG_SMP
 #ifdef	CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC uses TCBind value as "CPU" index
-	 */
-	uasm_i_mfc0(p, ptr, C0_TCBIND);
-	UASM_i_LA_mostly(p, tmp, pgdc);
-	uasm_i_srl(p, ptr, ptr, 19);
+		/*
+		 * SMTC uses TCBind value as "CPU" index
+		 */
+		uasm_i_mfc0(p, ptr, C0_TCBIND);
+		UASM_i_LA_mostly(p, tmp, pgdc);
+		uasm_i_srl(p, ptr, ptr, 19);
 #else
-	/*
-	 * smp_processor_id() << 3 is stored in CONTEXT.
-	 */
-	uasm_i_mfc0(p, ptr, C0_CONTEXT);
-	UASM_i_LA_mostly(p, tmp, pgdc);
-	uasm_i_srl(p, ptr, ptr, 23);
+		/*
+		 * smp_processor_id() << 3 is stored in CONTEXT.
+		 */
+		uasm_i_mfc0(p, ptr, C0_CONTEXT);
+		UASM_i_LA_mostly(p, tmp, pgdc);
+		uasm_i_srl(p, ptr, ptr, 23);
 #endif
-	uasm_i_addu(p, ptr, tmp, ptr);
+		uasm_i_addu(p, ptr, tmp, ptr);
 #else
-	UASM_i_LA_mostly(p, ptr, pgdc);
+		UASM_i_LA_mostly(p, ptr, pgdc);
 #endif
-	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
-	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
+		uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+		uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
+	}
 	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
 	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
 	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
@@ -1469,16 +1477,17 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 u32 handle_tlbl[FASTPATH_SIZE] __cacheline_aligned;
 u32 handle_tlbs[FASTPATH_SIZE] __cacheline_aligned;
 u32 handle_tlbm[FASTPATH_SIZE] __cacheline_aligned;
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 u32 tlbmiss_handler_setup_pgd_array[16] __cacheline_aligned;
 
-static void __cpuinit build_r4000_setup_pgd(void)
+static void __cpuinit build_setup_pgd(void)
 {
 	const int a0 = 4;
-	const int a1 = 5;
+	const int __maybe_unused a1 = 5;
+	const int a2 = 6;
 	u32 *p = tlbmiss_handler_setup_pgd_array;
-	struct uasm_label *l = labels;
-	struct uasm_reloc *r = relocs;
+#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+	long pgdc = (long)pgd_current;
+#endif
 
 	memset(tlbmiss_handler_setup_pgd_array, 0, sizeof(tlbmiss_handler_setup_pgd_array));
 	memset(labels, 0, sizeof(labels));
@@ -1486,7 +1495,11 @@ static void __cpuinit build_r4000_setup_pgd(void)
 
 	pgd_reg = allocate_kscratch();
 
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	if (pgd_reg == -1) {
+		struct uasm_label *l = labels;
+		struct uasm_reloc *r = relocs;
+
 		/* PGD << 11 in c0_Context */
 		/*
 		 * If it is a ckseg0 address, convert to a physical
@@ -1508,8 +1521,38 @@ static void __cpuinit build_r4000_setup_pgd(void)
 		uasm_i_jr(&p, 31);
 		UASM_i_MTC0(&p, a0, c0_kscratch, pgd_reg);
 	}
+#else
+#if defined(CONFIG_SMP)
+# ifdef CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC uses TCBind value as "CPU" index
+	 */
+	uasm_i_mfc0(&p, a1, C0_TCBIND);
+	uasm_i_dsrl_safe(&p, a1, a1, 19);
+# else
+	/*
+	 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
+	 * stored in CONTEXT.
+	 */
+	UASM_i_MFC0(&p, a1, C0_CONTEXT);
+	uasm_i_dsrl_safe(&p, a1, a1, 23);
+# endif
+	UASM_i_LA_mostly(&p, a2, pgdc);
+	UASM_i_ADDU(&p, a2, a2, a1);
+	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
+#else
+	UASM_i_LA_mostly(&p, a2, pgdc);
+	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
+#endif /* SMP */
+	uasm_i_jr(&p, 31);
+	if (pgd_reg != -1) {
+		/* PGD also in c0_KScratch */
+		UASM_i_MTC0(&p, a0, c0_kscratch, pgd_reg);
+	} else
+		uasm_i_nop(&p);
+#endif
 	if (p - tlbmiss_handler_setup_pgd_array > ARRAY_SIZE(tlbmiss_handler_setup_pgd_array))
-		panic("tlbmiss_handler_setup_pgd_array space exceeded");
+		panic("tlbmiss_handler_setup_pgd space exceeded");
 	uasm_resolve_relocs(relocs, labels);
 	pr_debug("Wrote tlbmiss_handler_setup_pgd_array (%u instructions).\n",
 		 (unsigned int)(p - tlbmiss_handler_setup_pgd_array));
@@ -1518,7 +1561,6 @@ static void __cpuinit build_r4000_setup_pgd(void)
 		     tlbmiss_handler_setup_pgd_array,
 		     ARRAY_SIZE(tlbmiss_handler_setup_pgd_array));
 }
-#endif
 
 static void __cpuinit
 iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
@@ -2200,6 +2242,7 @@ void __cpuinit build_tlb_refill_handler(void)
 		if (!run_once) {
 			if (!cpu_has_local_ebase)
 				build_r3000_tlb_refill_handler();
+			build_setup_pgd();
 			build_r3000_tlb_load_handler();
 			build_r3000_tlb_store_handler();
 			build_r3000_tlb_modify_handler();
@@ -2223,9 +2266,7 @@ void __cpuinit build_tlb_refill_handler(void)
 		if (!run_once) {
 			c0_kscratch = kscratch_reg();
 			scratch_reg = allocate_kscratch();
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-			build_r4000_setup_pgd();
-#endif
+			build_setup_pgd();
 			build_r4000_tlb_load_handler();
 			build_r4000_tlb_store_handler();
 			build_r4000_tlb_modify_handler();
@@ -2246,8 +2287,6 @@ void __cpuinit flush_tlb_handlers(void)
 			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
 	local_flush_icache_range((unsigned long)handle_tlbm,
 			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd_array,
 			   (unsigned long)tlbmiss_handler_setup_pgd_array + sizeof(handle_tlbm));
-#endif
 }
-- 
1.7.9.5
