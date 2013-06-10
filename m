Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:36:28 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2641 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab3FJHeb14dC6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:34:31 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:30:38 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:34:17 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:34:17 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 63677F2D72; Mon, 10
 Jun 2013 00:34:16 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 4/4] MIPS: Move definition of SMP processor id register
 to header file
Date:   Mon, 10 Jun 2013 13:05:33 +0530
Message-ID: <1370849733-5074-5-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370849733-5074-1-git-send-email-jchandra@broadcom.com>
References: <1370849733-5074-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5F1431W33901315-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36779
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
 arch/mips/include/asm/mmu_context.h |   16 +++----
 arch/mips/include/asm/stackframe.h  |   23 ++++-------
 arch/mips/include/asm/thread_info.h |   33 ++++++++++++++-
 arch/mips/mm/tlbex.c                |   78 +++++++----------------------------
 4 files changed, 60 insertions(+), 90 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 41aa181..8b138cf 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -38,10 +38,11 @@ do {									\
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
@@ -50,18 +51,11 @@ do {									\
  */
 extern unsigned long pgd_current[];
 
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
index a89d1b1..e9300d4 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -17,6 +17,7 @@
 #include <asm/asmmacro.h>
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
 
 /*
  * For SMTC kernel, global IE should be left set, and interrupts
@@ -86,20 +87,12 @@
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_MIPS_MT_SMTC
-#define PTEBASE_SHIFT	19	/* TCBIND */
-#define CPU_ID_REG CP0_TCBIND
-#define CPU_ID_MFC0 mfc0
-#elif defined(CONFIG_MIPS_PGD_C0_CONTEXT)
-#define PTEBASE_SHIFT	48	/* XCONTEXT */
-#define CPU_ID_REG CP0_XCONTEXT
-#define CPU_ID_MFC0 MFC0
+#define SMP_CPUID_MFC0		mfc0
 #else
-#define PTEBASE_SHIFT	23	/* CONTEXT */
-#define CPU_ID_REG CP0_CONTEXT
-#define CPU_ID_MFC0 MFC0
+#define SMP_CPUID_MFC0		MFC0
 #endif
 		.macro	get_saved_sp	/* SMP variation */
-		CPU_ID_MFC0	k0, CPU_ID_REG
+		SMP_CPUID_MFC0	k0, SMP_CPUID_REG
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
@@ -109,17 +102,17 @@
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
+		SMP_CPUID_MFC0	\temp, SMP_CPUID_REG
+		LONG_SRL	\temp, SMP_CPUID_PTRSHIFT
 		LONG_S	\stackp, kernelsp(\temp)
 		.endm
-#else
+#else /* !CONFIG_SMP */
 		.macro	get_saved_sp	/* Uniprocessor variation */
 #ifdef CONFIG_CPU_JUMP_WORKAROUNDS
 		/*
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index 61215a3..4867447 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -147,6 +147,37 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_ALLWORK_MASK	(_TIF_NOHZ | _TIF_WORK_MASK |		\
 				 _TIF_WORK_SYSCALL_EXIT)
 
-#endif /* __KERNEL__ */
+/*
+ * We stash processor id into a COP0 register to retrieve it fast
+ * at kernel exception entry. The register and shift used for this.
+ */
+#ifdef CONFIG_MIPS_MT_SMTC
+#ifdef __ASSEMBLY__
+#define SMP_CPUID_REG		$2, 2	/* TCBIND */
+#else
+#define SMP_CPUID_REG		2, 2
+#endif
+#define SMP_CPUID_PTRSHIFT	19
+#elif defined(CONFIG_MIPS_PGD_C0_CONTEXT)
+#ifdef __ASSEMBLY__
+#define SMP_CPUID_REG		$20, 0	/* XCONTEXT */
+#else
+#define SMP_CPUID_REG		20, 0
+#endif
+#define SMP_CPUID_PTRSHIFT	48
+#else
+#ifdef __ASSEMBLY__
+#define SMP_CPUID_REG		$4, 0	/* CONTEXT */
+#else
+#define SMP_CPUID_REG		4, 0
+#endif
+#define SMP_CPUID_PTRSHIFT	23
+#endif
+#ifdef CONFIG_64BIT
+#define SMP_CPUID_REGSHIFT	(SMP_CPUID_PTRSHIFT + 3)
+#else
+#define SMP_CPUID_REGSHIFT	(SMP_CPUID_PTRSHIFT + 2)
+#endif
 
+#endif /* __KERNEL__ */
 #endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e1aadda..d057641 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -346,10 +346,6 @@ static struct work_registers __cpuinit build_get_work_registers(u32 **p)
 {
 	struct work_registers r;
 
-	int smp_processor_id_reg;
-	int smp_processor_id_sel;
-	int smp_processor_id_shift;
-
 	if (scratch_reg >= 0) {
 		/* Save in CPU local C0_KScratch? */
 		UASM_i_MTC0(p, 1, c0_kscratch, scratch_reg);
@@ -360,25 +356,9 @@ static struct work_registers __cpuinit build_get_work_registers(u32 **p)
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
+		UASM_i_MFC0(p, K0, SMP_CPUID_REG);
+		UASM_i_SRL_SAFE(p, K0, K0, SMP_CPUID_REGSHIFT);
 
 		/* handler_reg_save index in K0 */
 		UASM_i_SLL(p, K0, K0, ilog2(sizeof(struct tlb_reg_save)));
@@ -848,20 +828,12 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		uasm_i_drotr(p, ptr, ptr, 11);
 #else
 #if defined(CONFIG_SMP)
-# ifdef	CONFIG_MIPS_MT_SMTC
-		/*
-		 * SMTC uses TCBind value as "CPU" index
-		 */
-		uasm_i_mfc0(p, ptr, C0_TCBIND);
-		uasm_i_dsrl_safe(p, ptr, ptr, 19);
-# else
-		/*
-		 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
-		 * stored in CONTEXT.
-		 */
-		uasm_i_dmfc0(p, ptr, C0_CONTEXT);
-		uasm_i_dsrl_safe(p, ptr, ptr, 23);
-# endif
+#ifdef	CONFIG_MIPS_MT_SMTC
+		uasm_i_mfc0(p, ptr, SMP_CPUID_REG);
+#else
+		uasm_i_dmfc0(p, ptr, SMP_CPUID_REG);
+#endif
+		uasm_i_dsrl_safe(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
 		UASM_i_LA_mostly(p, tmp, pgdc);
 		uasm_i_daddu(p, ptr, ptr, tmp);
 		uasm_i_dmfc0(p, tmp, C0_BADVADDR);
@@ -975,21 +947,9 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 
 		/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
 #ifdef CONFIG_SMP
-#ifdef	CONFIG_MIPS_MT_SMTC
-		/*
-		 * SMTC uses TCBind value as "CPU" index
-		 */
-		uasm_i_mfc0(p, ptr, C0_TCBIND);
-		UASM_i_LA_mostly(p, tmp, pgdc);
-		uasm_i_srl(p, ptr, ptr, 19);
-#else
-		/*
-		 * smp_processor_id() << 3 is stored in CONTEXT.
-		 */
-		uasm_i_mfc0(p, ptr, C0_CONTEXT);
+		uasm_i_mfc0(p, ptr, SMP_CPUID_REG);
 		UASM_i_LA_mostly(p, tmp, pgdc);
-		uasm_i_srl(p, ptr, ptr, 23);
-#endif
+		uasm_i_srl(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
 		uasm_i_addu(p, ptr, tmp, ptr);
 #else
 		UASM_i_LA_mostly(p, ptr, pgdc);
@@ -1524,19 +1484,11 @@ static void __cpuinit build_setup_pgd(void)
 #else
 #if defined(CONFIG_SMP)
 # ifdef CONFIG_MIPS_MT_SMTC
-	/*
-	 * SMTC uses TCBind value as "CPU" index
-	 */
-	uasm_i_mfc0(&p, a1, C0_TCBIND);
-	uasm_i_dsrl_safe(&p, a1, a1, 19);
-# else
-	/*
-	 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
-	 * stored in CONTEXT.
-	 */
-	UASM_i_MFC0(&p, a1, C0_CONTEXT);
-	uasm_i_dsrl_safe(&p, a1, a1, 23);
-# endif
+	uasm_i_mfc0(&p, a1, SMP_CPUID_REG);
+#else
+	UASM_i_MFC0(&p, a1, SMP_CPUID_REG);
+#endif
+	uasm_i_dsrl_safe(&p, a1, a1, SMP_CPUID_PTRSHIFT);
 	UASM_i_LA_mostly(&p, a2, pgdc);
 	UASM_i_ADDU(&p, a2, a2, a1);
 	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
-- 
1.7.9.5
