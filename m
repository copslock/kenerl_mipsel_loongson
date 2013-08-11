Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 13:40:54 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2819 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822668Ab3HKLjqkSfLp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 13:39:46 +0200
Received: from [10.9.208.55] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 04:33:18 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 04:39:26 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 04:39:26 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id DC383F2D73; Sun, 11
 Aug 2013 04:39:25 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 1/2] MIPS: Move definition of SMP processor id register
 to header file
Date:   Sun, 11 Aug 2013 17:10:16 +0530
Message-ID: <1376221217-9335-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376221217-9335-1-git-send-email-jchandra@broadcom.com>
References: <1376221217-9335-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E19A9F41R079389869-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37524
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

The definition of the CP0 register used to save the smp processor
id is repicated in many files, move them all to thread_info.h.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mmu_context.h |   16 ++++------
 arch/mips/include/asm/stackframe.h  |   24 ++++-----------
 arch/mips/include/asm/thread_info.h |   33 ++++++++++++++++++++-
 arch/mips/mm/tlbex.c                |   56 ++++-------------------------------
 4 files changed, 49 insertions(+), 80 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 3b29079..ab8e260 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -35,10 +35,11 @@ do {									\
 #define TLBMISS_HANDLER_SETUP()						\
 	do {								\
 		TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);		\
-		write_c0_xcontext((unsigned long) smp_processor_id() << 51); \
+		write_c0_xcontext((unsigned long) smp_processor_id() <<	\
+						SMP_CPUID_REGSHIFT);	\
 	} while (0)
 
-#else /* CONFIG_MIPS_PGD_C0_CONTEXT: using  pgd_current*/
+#else /* !CONFIG_MIPS_PGD_C0_CONTEXT: using  pgd_current*/
 
 /*
  * For the fast tlb miss handlers, we keep a per cpu array of pointers
@@ -50,18 +51,11 @@ extern unsigned long pgd_current[];
 #define TLBMISS_HANDLER_SETUP_PGD(pgd) \
 	pgd_current[smp_processor_id()] = (unsigned long)(pgd)
 
-#ifdef CONFIG_32BIT
 #define TLBMISS_HANDLER_SETUP()						\
-	write_c0_context((unsigned long) smp_processor_id() << 25);	\
+	write_c0_context((unsigned long) smp_processor_id() <<		\
+						SMP_CPUID_REGSHIFT);	\
 	back_to_back_c0_hazard();					\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
-#endif
-#ifdef CONFIG_64BIT
-#define TLBMISS_HANDLER_SETUP()						\
-	write_c0_context((unsigned long) smp_processor_id() << 26);	\
-	back_to_back_c0_hazard();					\
-	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
-#endif
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT*/
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 23fc95e..4857e2c 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -17,6 +17,7 @@
 #include <asm/asmmacro.h>
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
 
 /*
  * For SMTC kernel, global IE should be left set, and interrupts
@@ -93,21 +94,8 @@
 		.endm
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_MIPS_MT_SMTC
-#define PTEBASE_SHIFT	19	/* TCBIND */
-#define CPU_ID_REG CP0_TCBIND
-#define CPU_ID_MFC0 mfc0
-#elif defined(CONFIG_MIPS_PGD_C0_CONTEXT)
-#define PTEBASE_SHIFT	48	/* XCONTEXT */
-#define CPU_ID_REG CP0_XCONTEXT
-#define CPU_ID_MFC0 MFC0
-#else
-#define PTEBASE_SHIFT	23	/* CONTEXT */
-#define CPU_ID_REG CP0_CONTEXT
-#define CPU_ID_MFC0 MFC0
-#endif
 		.macro	get_saved_sp	/* SMP variation */
-		CPU_ID_MFC0	k0, CPU_ID_REG
+		ASM_CPUID_MFC0	k0, ASM_SMP_CPUID_REG
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
@@ -117,17 +105,17 @@
 		daddiu	k1, %hi(kernelsp)
 		dsll	k1, 16
 #endif
-		LONG_SRL	k0, PTEBASE_SHIFT
+		LONG_SRL	k0, SMP_CPUID_PTRSHIFT
 		LONG_ADDU	k1, k0
 		LONG_L	k1, %lo(kernelsp)(k1)
 		.endm
 
 		.macro	set_saved_sp stackp temp temp2
-		CPU_ID_MFC0	\temp, CPU_ID_REG
-		LONG_SRL	\temp, PTEBASE_SHIFT
+		ASM_CPUID_MFC0	\temp, ASM_SMP_CPUID_REG
+		LONG_SRL	\temp, SMP_CPUID_PTRSHIFT
 		LONG_S	\stackp, kernelsp(\temp)
 		.endm
-#else
+#else /* !CONFIG_SMP */
 		.macro	get_saved_sp	/* Uniprocessor variation */
 #ifdef CONFIG_CPU_JUMP_WORKAROUNDS
 		/*
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 61215a3..e0c8cf3 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -147,6 +147,37 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_ALLWORK_MASK	(_TIF_NOHZ | _TIF_WORK_MASK |		\
 				 _TIF_WORK_SYSCALL_EXIT)
 
-#endif /* __KERNEL__ */
+/*
+ * We stash processor id into a COP0 register to retrieve it fast
+ * at kernel exception entry.
+ */
+#if defined(CONFIG_MIPS_MT_SMTC)
+#define SMP_CPUID_REG		2, 2	/* TCBIND */
+#define ASM_SMP_CPUID_REG	$2, 2
+#define SMP_CPUID_PTRSHIFT	19
+#elif defined(CONFIG_MIPS_PGD_C0_CONTEXT)
+#define SMP_CPUID_REG		20, 0	/* XCONTEXT */
+#define ASM_SMP_CPUID_REG	$20
+#define SMP_CPUID_PTRSHIFT	48
+#else
+#define SMP_CPUID_REG		4, 0	/* CONTEXT */
+#define ASM_SMP_CPUID_REG	$4
+#define SMP_CPUID_PTRSHIFT	23
+#endif
 
+#ifdef CONFIG_64BIT
+#define SMP_CPUID_REGSHIFT	(SMP_CPUID_PTRSHIFT + 3)
+#else
+#define SMP_CPUID_REGSHIFT	(SMP_CPUID_PTRSHIFT + 2)
+#endif
+
+#ifdef CONFIG_MIPS_MT_SMTC
+#define ASM_CPUID_MFC0		mfc0
+#define UASM_i_CPUID_MFC0	uasm_i_mfc0
+#else
+#define ASM_CPUID_MFC0		MFC0
+#define UASM_i_CPUID_MFC0	UASM_i_MFC0
+#endif
+
+#endif /* __KERNEL__ */
 #endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 556cb48..54f3270 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -337,10 +337,6 @@ static struct work_registers build_get_work_registers(u32 **p)
 {
 	struct work_registers r;
 
-	int smp_processor_id_reg;
-	int smp_processor_id_sel;
-	int smp_processor_id_shift;
-
 	if (scratch_reg >= 0) {
 		/* Save in CPU local C0_KScratch? */
 		UASM_i_MTC0(p, 1, c0_kscratch(), scratch_reg);
@@ -351,25 +347,9 @@ static struct work_registers build_get_work_registers(u32 **p)
 	}
 
 	if (num_possible_cpus() > 1) {
-#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-		smp_processor_id_shift = 51;
-		smp_processor_id_reg = 20; /* XContext */
-		smp_processor_id_sel = 0;
-#else
-# ifdef CONFIG_32BIT
-		smp_processor_id_shift = 25;
-		smp_processor_id_reg = 4; /* Context */
-		smp_processor_id_sel = 0;
-# endif
-# ifdef CONFIG_64BIT
-		smp_processor_id_shift = 26;
-		smp_processor_id_reg = 4; /* Context */
-		smp_processor_id_sel = 0;
-# endif
-#endif
 		/* Get smp_processor_id */
-		UASM_i_MFC0(p, K0, smp_processor_id_reg, smp_processor_id_sel);
-		UASM_i_SRL_SAFE(p, K0, K0, smp_processor_id_shift);
+		UASM_i_CPUID_MFC0(p, K0, SMP_CPUID_REG);
+		UASM_i_SRL_SAFE(p, K0, K0, SMP_CPUID_REGSHIFT);
 
 		/* handler_reg_save index in K0 */
 		UASM_i_SLL(p, K0, K0, ilog2(sizeof(struct tlb_reg_save)));
@@ -834,20 +814,8 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		uasm_i_drotr(p, ptr, ptr, 11);
 	}
 #elif defined(CONFIG_SMP)
-# ifdef	 CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC uses TCBind value as "CPU" index
-	 */
-	uasm_i_mfc0(p, ptr, C0_TCBIND);
-	uasm_i_dsrl_safe(p, ptr, ptr, 19);
-# else
-	/*
-	 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
-	 * stored in CONTEXT.
-	 */
-	uasm_i_dmfc0(p, ptr, C0_CONTEXT);
-	uasm_i_dsrl_safe(p, ptr, ptr, 23);
-# endif
+	UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);
+	uasm_i_dsrl_safe(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
 	UASM_i_LA_mostly(p, tmp, pgdc);
 	uasm_i_daddu(p, ptr, ptr, tmp);
 	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
@@ -954,21 +922,9 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 
 	/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
 #ifdef CONFIG_SMP
-#ifdef	CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC uses TCBind value as "CPU" index
-	 */
-	uasm_i_mfc0(p, ptr, C0_TCBIND);
+	uasm_i_mfc0(p, ptr, SMP_CPUID_REG);
 	UASM_i_LA_mostly(p, tmp, pgdc);
-	uasm_i_srl(p, ptr, ptr, 19);
-#else
-	/*
-	 * smp_processor_id() << 2 is stored in CONTEXT.
-	 */
-	uasm_i_mfc0(p, ptr, C0_CONTEXT);
-	UASM_i_LA_mostly(p, tmp, pgdc);
-	uasm_i_srl(p, ptr, ptr, 23);
-#endif
+	uasm_i_srl(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
 	uasm_i_addu(p, ptr, tmp, ptr);
 #else
 	UASM_i_LA_mostly(p, ptr, pgdc);
-- 
1.7.9.5
