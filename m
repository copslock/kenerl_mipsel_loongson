Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 13:41:59 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2821 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822995Ab3HKLjrB9py0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 13:39:47 +0200
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 04:33:19 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 04:39:28 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 04:39:28 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 7BDEEF2D72; Sun, 11
 Aug 2013 04:39:27 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 2/2] MIPS: mm: Use scratch for PGD when
 !CONFIG_MIPS_PGD_C0_CONTEXT
Date:   Sun, 11 Aug 2013 17:10:17 +0530
Message-ID: <1376221217-9335-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376221217-9335-1-git-send-email-jchandra@broadcom.com>
References: <1376221217-9335-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E19A9F51R079389872-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37525
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
MIPS_PGD_C0_CONTEXT is not configured. MIPS_PGD_C0_CONTEXT is set
for 64r2 platforms to indicate availability of Xcontext for saving
cpuid, thus freeing Context to be used for saving PGD. This option
was also tied to using a scratch register for storing PGD.

This commit will allow usage of scratch register to store the current
pgd if one can be allocated for the platform, even when
MIPS_PGD_C0_CONTEXT is not set. The cpuid will be kept in the CP0
Context register in this case.

The code to store the current pgd for the TLB miss handler is now
generated in all cases. When scratch register is available, the PGD
is also stored in the scratch register.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mmu_context.h |    6 +--
 arch/mips/mm/tlbex.c                |   88 +++++++++++++++++++++++------------
 2 files changed, 58 insertions(+), 36 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index ab8e260..e277bba 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -24,14 +24,13 @@
 #endif /* SMTC */
 #include <asm-generic/mm_hooks.h>
 
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-
 #define TLBMISS_HANDLER_SETUP_PGD(pgd)					\
 do {									\
 	extern void tlbmiss_handler_setup_pgd(unsigned long);		\
 	tlbmiss_handler_setup_pgd((unsigned long)(pgd));		\
 } while (0)
 
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 #define TLBMISS_HANDLER_SETUP()						\
 	do {								\
 		TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);		\
@@ -48,9 +47,6 @@ do {									\
  */
 extern unsigned long pgd_current[];
 
-#define TLBMISS_HANDLER_SETUP_PGD(pgd) \
-	pgd_current[smp_processor_id()] = (unsigned long)(pgd)
-
 #define TLBMISS_HANDLER_SETUP()						\
 	write_c0_context((unsigned long) smp_processor_id() <<		\
 						SMP_CPUID_REGSHIFT);	\
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 54f3270..40efded 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -796,11 +796,11 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	}
 	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
 
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	if (pgd_reg != -1) {
 		/* pgd is in pgd_reg */
 		UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
 	} else {
+#if defined(CONFIG_MIPS_PGD_C0_CONTEXT)
 		/*
 		 * &pgd << 11 stored in CONTEXT [23..63].
 		 */
@@ -812,18 +812,18 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		/* 1 0	1 0 1  << 6  xkphys cached */
 		uasm_i_ori(p, ptr, ptr, 0x540);
 		uasm_i_drotr(p, ptr, ptr, 11);
-	}
 #elif defined(CONFIG_SMP)
-	UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);
-	uasm_i_dsrl_safe(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
-	UASM_i_LA_mostly(p, tmp, pgdc);
-	uasm_i_daddu(p, ptr, ptr, tmp);
-	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
-	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
+		UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);
+		uasm_i_dsrl_safe(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
+		UASM_i_LA_mostly(p, tmp, pgdc);
+		uasm_i_daddu(p, ptr, ptr, tmp);
+		uasm_i_dmfc0(p, tmp, C0_BADVADDR);
+		uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
 #else
-	UASM_i_LA_mostly(p, ptr, pgdc);
-	uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
+		UASM_i_LA_mostly(p, ptr, pgdc);
+		uasm_i_ld(p, ptr, uasm_rel_lo(pgdc), ptr);
 #endif
+	}
 
 	uasm_l_vmalloc_done(l, *p);
 
@@ -918,19 +918,25 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 static void __maybe_unused
 build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 {
-	long pgdc = (long)pgd_current;
+	if (pgd_reg != -1) {
+		/* pgd is in pgd_reg */
+		uasm_i_mfc0(p, ptr, c0_kscratch(), pgd_reg);
+		uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
+	} else {
+		long pgdc = (long)pgd_current;
 
-	/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
+		/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
 #ifdef CONFIG_SMP
-	uasm_i_mfc0(p, ptr, SMP_CPUID_REG);
-	UASM_i_LA_mostly(p, tmp, pgdc);
-	uasm_i_srl(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
-	uasm_i_addu(p, ptr, tmp, ptr);
+		uasm_i_mfc0(p, ptr, SMP_CPUID_REG);
+		UASM_i_LA_mostly(p, tmp, pgdc);
+		uasm_i_srl(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
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
@@ -1404,28 +1410,30 @@ static void build_r4000_tlb_refill_handler(void)
 extern u32 handle_tlbl[], handle_tlbl_end[];
 extern u32 handle_tlbs[], handle_tlbs_end[];
 extern u32 handle_tlbm[], handle_tlbm_end[];
-
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 extern u32 tlbmiss_handler_setup_pgd[], tlbmiss_handler_setup_pgd_end[];
 
-static void build_r4000_setup_pgd(void)
+static void build_setup_pgd(void)
 {
 	const int a0 = 4;
-	const int a1 = 5;
+	const int __maybe_unused a1 = 5;
+	const int __maybe_unused a2 = 6;
 	u32 *p = tlbmiss_handler_setup_pgd;
 	const int tlbmiss_handler_setup_pgd_size =
 		tlbmiss_handler_setup_pgd_end - tlbmiss_handler_setup_pgd;
-	struct uasm_label *l = labels;
-	struct uasm_reloc *r = relocs;
+#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+	long pgdc = (long)pgd_current;
+#endif
 
 	memset(tlbmiss_handler_setup_pgd, 0, tlbmiss_handler_setup_pgd_size *
 					sizeof(tlbmiss_handler_setup_pgd[0]));
 	memset(labels, 0, sizeof(labels));
 	memset(relocs, 0, sizeof(relocs));
-
 	pgd_reg = allocate_kscratch();
-
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 	if (pgd_reg == -1) {
+		struct uasm_label *l = labels;
+		struct uasm_reloc *r = relocs;
+
 		/* PGD << 11 in c0_Context */
 		/*
 		 * If it is a ckseg0 address, convert to a physical
@@ -1447,6 +1455,26 @@ static void build_r4000_setup_pgd(void)
 		uasm_i_jr(&p, 31);
 		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
 	}
+#else
+#ifdef CONFIG_SMP
+	/* Save PGD to pgd_current[smp_processor_id()] */
+	UASM_i_CPUID_MFC0(&p, a1, SMP_CPUID_REG);
+	UASM_i_SRL_SAFE(&p, a1, a1, SMP_CPUID_PTRSHIFT);
+	UASM_i_LA_mostly(&p, a2, pgdc);
+	UASM_i_ADDU(&p, a2, a2, a1);
+	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
+#else
+	UASM_i_LA_mostly(&p, a2, pgdc);
+	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
+#endif /* SMP */
+	uasm_i_jr(&p, 31);
+
+	/* if pgd_reg is allocated, save PGD also to scratch register */
+	if (pgd_reg != -1)
+		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
+	else
+		uasm_i_nop(&p);
+#endif
 	if (p >= tlbmiss_handler_setup_pgd_end)
 		panic("tlbmiss_handler_setup_pgd space exceeded");
 
@@ -1457,7 +1485,6 @@ static void build_r4000_setup_pgd(void)
 	dump_handler("tlbmiss_handler", tlbmiss_handler_setup_pgd,
 					tlbmiss_handler_setup_pgd_size);
 }
-#endif
 
 static void
 iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
@@ -2185,6 +2212,7 @@ void build_tlb_refill_handler(void)
 		if (!run_once) {
 			if (!cpu_has_local_ebase)
 				build_r3000_tlb_refill_handler();
+			build_setup_pgd();
 			build_r3000_tlb_load_handler();
 			build_r3000_tlb_store_handler();
 			build_r3000_tlb_modify_handler();
@@ -2208,9 +2236,7 @@ void build_tlb_refill_handler(void)
 	default:
 		if (!run_once) {
 			scratch_reg = allocate_kscratch();
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-			build_r4000_setup_pgd();
-#endif
+			build_setup_pgd();
 			build_r4000_tlb_load_handler();
 			build_r4000_tlb_store_handler();
 			build_r4000_tlb_modify_handler();
-- 
1.7.9.5
