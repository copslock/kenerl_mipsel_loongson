Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 19:41:40 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42837 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6835025Ab3FSRkqu8oEi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 19:40:46 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UpMN5-0001b5-E2; Wed, 19 Jun 2013 12:40:39 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 1/2] Revert "MIPS: Move definition of SMP processor id register to header file"
Date:   Wed, 19 Jun 2013 12:40:31 -0500
Message-Id: <1371663632-30252-2-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371663632-30252-1-git-send-email-Steven.Hill@imgtec.com>
References: <1371663632-30252-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37016
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

This reverts commit 59ff6f198e4944348547cfad905b414c05573f9a.

This prevents all MTI platforms and bcm63xx from booting.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mmu_context.h |   17 ++++++--
 arch/mips/include/asm/stackframe.h  |   24 ++++++++---
 arch/mips/include/asm/thread_info.h |   30 +-------------
 arch/mips/mm/tlbex.c                |   75 ++++++++++++++++++++++++++++++-----
 4 files changed, 96 insertions(+), 50 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index aa59e31..fc282ef 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -34,15 +34,15 @@ do {									\
 	tlbmiss_handler_setup_pgd((unsigned long)(pgd));		\
 } while (0)
 
+
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 #define TLBMISS_HANDLER_SETUP()						\
 	do {								\
 		TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);		\
-		write_c0_xcontext((unsigned long) smp_processor_id() <<	\
-						SMP_CPUID_REGSHIFT);	\
+		write_c0_xcontext((unsigned long) smp_processor_id() << 51); \
 	} while (0)
 
-#else /* !CONFIG_MIPS_PGD_C0_CONTEXT: using  pgd_current*/
+#else /* CONFIG_MIPS_PGD_C0_CONTEXT: using  pgd_current*/
 
 /*
  * For the fast tlb miss handlers, we keep a per cpu array of pointers
@@ -51,11 +51,18 @@ do {									\
  */
 extern unsigned long pgd_current[];
 
+#ifdef CONFIG_32BIT
+#define TLBMISS_HANDLER_SETUP()						\
+	write_c0_context((unsigned long) smp_processor_id() << 25);	\
+	back_to_back_c0_hazard();					\
+	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
+#endif
+#ifdef CONFIG_64BIT
 #define TLBMISS_HANDLER_SETUP()						\
-	write_c0_context((unsigned long) smp_processor_id() <<		\
-						SMP_CPUID_REGSHIFT);	\
+	write_c0_context((unsigned long) smp_processor_id() << 26);	\
 	back_to_back_c0_hazard();					\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
+#endif
 #endif /* CONFIG_MIPS_PGD_C0_CONTEXT*/
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index faefe31..a89d1b1 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -17,7 +17,6 @@
 #include <asm/asmmacro.h>
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
-#include <asm/thread_info.h>
 
 /*
  * For SMTC kernel, global IE should be left set, and interrupts
@@ -86,8 +85,21 @@
 		.endm
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_MIPS_MT_SMTC
+#define PTEBASE_SHIFT	19	/* TCBIND */
+#define CPU_ID_REG CP0_TCBIND
+#define CPU_ID_MFC0 mfc0
+#elif defined(CONFIG_MIPS_PGD_C0_CONTEXT)
+#define PTEBASE_SHIFT	48	/* XCONTEXT */
+#define CPU_ID_REG CP0_XCONTEXT
+#define CPU_ID_MFC0 MFC0
+#else
+#define PTEBASE_SHIFT	23	/* CONTEXT */
+#define CPU_ID_REG CP0_CONTEXT
+#define CPU_ID_MFC0 MFC0
+#endif
 		.macro	get_saved_sp	/* SMP variation */
-		ASM_CPUID_MFC0	k0, $SMP_CPUID_REG
+		CPU_ID_MFC0	k0, CPU_ID_REG
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
@@ -97,17 +109,17 @@
 		daddiu	k1, %hi(kernelsp)
 		dsll	k1, 16
 #endif
-		LONG_SRL	k0, SMP_CPUID_PTRSHIFT
+		LONG_SRL	k0, PTEBASE_SHIFT
 		LONG_ADDU	k1, k0
 		LONG_L	k1, %lo(kernelsp)(k1)
 		.endm
 
 		.macro	set_saved_sp stackp temp temp2
-		ASM_CPUID_MFC0	\temp, $SMP_CPUID_REG
-		LONG_SRL	\temp, SMP_CPUID_PTRSHIFT
+		CPU_ID_MFC0	\temp, CPU_ID_REG
+		LONG_SRL	\temp, PTEBASE_SHIFT
 		LONG_S	\stackp, kernelsp(\temp)
 		.endm
-#else /* !CONFIG_SMP */
+#else
 		.macro	get_saved_sp	/* Uniprocessor variation */
 #ifdef CONFIG_CPU_JUMP_WORKAROUNDS
 		/*
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index ddff267..61215a3 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -147,34 +147,6 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_ALLWORK_MASK	(_TIF_NOHZ | _TIF_WORK_MASK |		\
 				 _TIF_WORK_SYSCALL_EXIT)
 
-/*
- * We stash processor id into a COP0 register to retrieve it fast
- * at kernel exception entry.
- */
-#if defined(CONFIG_MIPS_MT_SMTC)
-#define SMP_CPUID_REG		2, 2	/* TCBIND */
-#define SMP_CPUID_PTRSHIFT	19
-#elif defined(CONFIG_MIPS_PGD_C0_CONTEXT)
-#define SMP_CPUID_REG		20, 0	/* XCONTEXT */
-#define SMP_CPUID_PTRSHIFT	48
-#else
-#define SMP_CPUID_REG		4, 0	/* CONTEXT */
-#define SMP_CPUID_PTRSHIFT	23
-#endif
-
-#ifdef CONFIG_64BIT
-#define SMP_CPUID_REGSHIFT	(SMP_CPUID_PTRSHIFT + 3)
-#else
-#define SMP_CPUID_REGSHIFT	(SMP_CPUID_PTRSHIFT + 2)
-#endif
-
-#ifdef CONFIG_MIPS_MT_SMTC
-#define ASM_CPUID_MFC0		mfc0
-#define UASM_i_CPUID_MFC0	uasm_i_mfc0
-#else
-#define ASM_CPUID_MFC0		MFC0
-#define UASM_i_CPUID_MFC0	UASM_i_MFC0
-#endif
-
 #endif /* __KERNEL__ */
+
 #endif /* _ASM_THREAD_INFO_H */
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index d9969d2..0f04692 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -337,6 +337,10 @@ static struct work_registers build_get_work_registers(u32 **p)
 {
 	struct work_registers r;
 
+	int smp_processor_id_reg;
+	int smp_processor_id_sel;
+	int smp_processor_id_shift;
+
 	if (scratch_reg >= 0) {
 		/* Save in CPU local C0_KScratch? */
 		UASM_i_MTC0(p, 1, c0_kscratch(), scratch_reg);
@@ -347,9 +351,25 @@ static struct work_registers build_get_work_registers(u32 **p)
 	}
 
 	if (num_possible_cpus() > 1) {
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+		smp_processor_id_shift = 51;
+		smp_processor_id_reg = 20; /* XContext */
+		smp_processor_id_sel = 0;
+#else
+# ifdef CONFIG_32BIT
+		smp_processor_id_shift = 25;
+		smp_processor_id_reg = 4; /* Context */
+		smp_processor_id_sel = 0;
+# endif
+# ifdef CONFIG_64BIT
+		smp_processor_id_shift = 26;
+		smp_processor_id_reg = 4; /* Context */
+		smp_processor_id_sel = 0;
+# endif
+#endif
 		/* Get smp_processor_id */
-		UASM_i_CPUID_MFC0(p, K0, SMP_CPUID_REG);
-		UASM_i_SRL_SAFE(p, K0, K0, SMP_CPUID_REGSHIFT);
+		UASM_i_MFC0(p, K0, smp_processor_id_reg, smp_processor_id_sel);
+		UASM_i_SRL_SAFE(p, K0, K0, smp_processor_id_shift);
 
 		/* handler_reg_save index in K0 */
 		UASM_i_SLL(p, K0, K0, ilog2(sizeof(struct tlb_reg_save)));
@@ -800,7 +820,7 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		/* pgd is in pgd_reg */
 		UASM_i_MFC0(p, ptr, c0_kscratch(), pgd_reg);
 	} else {
-#if defined(CONFIG_MIPS_PGD_C0_CONTEXT)
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
 		/*
 		 * &pgd << 11 stored in CONTEXT [23..63].
 		 */
@@ -813,8 +833,20 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		uasm_i_ori(p, ptr, ptr, 0x540);
 		uasm_i_drotr(p, ptr, ptr, 11);
 #elif defined(CONFIG_SMP)
-		UASM_i_CPUID_MFC0(p, ptr, SMP_CPUID_REG);
-		uasm_i_dsrl_safe(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
+# ifdef CONFIG_MIPS_MT_SMTC
+		/*
+		 * SMTC uses TCBind value as "CPU" index
+		 */
+		uasm_i_mfc0(p, ptr, C0_TCBIND);
+		uasm_i_dsrl_safe(p, ptr, ptr, 19);
+# else
+		/*
+		 * 64 bit SMP running in XKPHYS has smp_processor_id() << 3
+		 * stored in CONTEXT.
+		 */
+		uasm_i_dmfc0(p, ptr, C0_CONTEXT);
+		uasm_i_dsrl_safe(p, ptr, ptr, 23);
+# endif
 		UASM_i_LA_mostly(p, tmp, pgdc);
 		uasm_i_daddu(p, ptr, ptr, tmp);
 		uasm_i_dmfc0(p, tmp, C0_BADVADDR);
@@ -927,9 +959,21 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 
 		/* 32 bit SMP has smp_processor_id() stored in CONTEXT. */
 #ifdef CONFIG_SMP
-		uasm_i_mfc0(p, ptr, SMP_CPUID_REG);
+# ifdef CONFIG_MIPS_MT_SMTC
+		/*
+		 * SMTC uses TCBind value as "CPU" index
+		 */
+		uasm_i_mfc0(p, ptr, C0_TCBIND);
 		UASM_i_LA_mostly(p, tmp, pgdc);
-		uasm_i_srl(p, ptr, ptr, SMP_CPUID_PTRSHIFT);
+		uasm_i_srl(p, ptr, ptr, 19);
+# else
+		/*
+		 * smp_processor_id() << 3 is stored in CONTEXT.
+		 */
+		uasm_i_mfc0(p, ptr, C0_CONTEXT);
+		UASM_i_LA_mostly(p, tmp, pgdc);
+		uasm_i_srl(p, ptr, ptr, 23);
+# endif
 		uasm_i_addu(p, ptr, tmp, ptr);
 #else
 		UASM_i_LA_mostly(p, ptr, pgdc);
@@ -1461,10 +1505,21 @@ static void build_setup_pgd(void)
 		UASM_i_MTC0(&p, a0, c0_kscratch(), pgd_reg);
 	}
 #else
-#ifdef CONFIG_SMP
 	/* Save PGD to pgd_current[smp_processor_id()] */
-	UASM_i_CPUID_MFC0(&p, a1, SMP_CPUID_REG);
-	UASM_i_SRL_SAFE(&p, a1, a1, SMP_CPUID_PTRSHIFT);
+#if defined(CONFIG_SMP)
+# ifdef CONFIG_MIPS_MT_SMTC
+	/*
+	 * SMTC uses TCBind value as "CPU" index
+	 */
+	uasm_i_mfc0(&p, a1, C0_TCBIND);
+	UASM_i_SRL_SAFE(&p, a1, a1, 19);
+# else
+	/*
+	 * smp_processor_id() is in CONTEXT
+	 */
+	UASM_i_MFC0(&p, a1, C0_CONTEXT);
+	UASM_i_SRL_SAFE(&p, a1, a1, 23);
+# endif
 	UASM_i_LA_mostly(&p, a2, pgdc);
 	UASM_i_ADDU(&p, a2, a2, a1);
 	UASM_i_SW(&p, a0, uasm_rel_lo(pgdc), a2);
-- 
1.7.2.5
