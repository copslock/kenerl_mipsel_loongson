Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:19:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1729 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493710AbZJNTSt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:18:49 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad623c50000>; Wed, 14 Oct 2009 12:17:27 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:17:02 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:17:02 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n9EJGvAU007574;
	Wed, 14 Oct 2009 12:16:57 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n9EJGvUp007573;
	Wed, 14 Oct 2009 12:16:57 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Put PGD in C0_CONTEXT for 64-bit R2 processors.
Date:	Wed, 14 Oct 2009 12:16:56 -0700
Message-Id: <1255547816-7544-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4AD62353.2080603@caviumnetworks.com>
References: <4AD62353.2080603@caviumnetworks.com>
X-OriginalArrivalTime: 14 Oct 2009 19:17:02.0101 (UTC) FILETIME=[E897B450:01CA4D02]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Processors that support the mips64r2 ISA can in four instructions
convert a shifted PGD pointer stored in the upper bits of c0_context
into a usable pointer.  By doing this we save a memory load and
associated potential cache miss in the TLB exception handlers.

Since the upper bits of c0_context were holding the CPU number, we
move this to the upper bits of c0_xcontext which doesn't have enough
bits to hold the PGD pointer, but has plenty for the CPU number.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                   |    3 +++
 arch/mips/include/asm/mmu_context.h |   29 ++++++++++++++++++++++++++++-
 arch/mips/include/asm/stackframe.h  |   20 ++++++++++----------
 arch/mips/mm/init.c                 |    2 ++
 arch/mips/mm/tlbex.c                |   28 +++++++++++++++++++++++++---
 5 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a3fceba..a4aea20 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1412,6 +1412,9 @@ config CPU_SUPPORTS_64BIT_KERNEL
 	bool
 config CPU_SUPPORTS_HUGEPAGES
 	bool
+config MIPS_PGD_C0_CONTEXT
+	bool
+	default y if 64BIT && CPU_MIPSR2
 
 #
 # Set to y for ptrace access to watch registers.
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 6083db5..145bb81 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -24,6 +24,33 @@
 #endif /* SMTC */
 #include <asm-generic/mm_hooks.h>
 
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+
+#define TLBMISS_HANDLER_SETUP_PGD(pgd)				\
+	tlbmiss_handler_setup_pgd((unsigned long)(pgd))
+
+static inline void tlbmiss_handler_setup_pgd(unsigned long pgd)
+{
+	/* Check for swapper_pg_dir and convert to physical address. */
+	if ((pgd & CKSEG3) == CKSEG0)
+		pgd = CPHYSADDR(pgd);
+	write_c0_context(pgd << 11);
+}
+
+#define TLBMISS_HANDLER_SETUP()						\
+	do {								\
+		TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);		\
+		write_c0_xcontext((unsigned long) smp_processor_id() << 51); \
+	} while (0)
+
+
+static inline unsigned long get_current_pgd(void)
+{
+	return PHYS_TO_XKSEG_CACHED((read_c0_context() >> 11) & ~0xfffUL);
+}
+
+#else /* CONFIG_MIPS_PGD_C0_CONTEXT: using  pgd_current*/
+
 /*
  * For the fast tlb miss handlers, we keep a per cpu array of pointers
  * to the current pgd for each processor. Also, the proc. id is stuffed
@@ -46,7 +73,7 @@ extern unsigned long pgd_current[];
 	back_to_back_c0_hazard();					\
 	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir)
 #endif
-
+#endif /* CONFIG_MIPS_PGD_C0_CONTEXT*/
 #if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
 
 #define ASID_INC	0x40
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 491b3ee..156d7b0 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -87,15 +87,19 @@
 #ifdef CONFIG_SMP
 #ifdef CONFIG_MIPS_MT_SMTC
 #define PTEBASE_SHIFT	19	/* TCBIND */
+#define CPU_ID_REG CP0_TCBIND
+#define CPU_ID_MFC0 mfc0
+#elif defined(CONFIG_MIPS_PGD_C0_CONTEXT)
+#define PTEBASE_SHIFT	48	/* XCONTEXT */
+#define CPU_ID_REG CP0_XCONTEXT
+#define CPU_ID_MFC0 MFC0
 #else
 #define PTEBASE_SHIFT	23	/* CONTEXT */
+#define CPU_ID_REG CP0_CONTEXT
+#define CPU_ID_MFC0 MFC0
 #endif
 		.macro	get_saved_sp	/* SMP variation */
-#ifdef CONFIG_MIPS_MT_SMTC
-		mfc0	k0, CP0_TCBIND
-#else
-		MFC0	k0, CP0_CONTEXT
-#endif
+		CPU_ID_MFC0	k0, CPU_ID_REG
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
@@ -111,11 +115,7 @@
 		.endm
 
 		.macro	set_saved_sp stackp temp temp2
-#ifdef CONFIG_MIPS_MT_SMTC
-		mfc0	\temp, CP0_TCBIND
-#else
-		MFC0	\temp, CP0_CONTEXT
-#endif
+		CPU_ID_MFC0	\temp, CPU_ID_REG
 		LONG_SRL	\temp, PTEBASE_SHIFT
 		LONG_S	\stackp, kernelsp(\temp)
 		.endm
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 8d1f4f3..9e8d003 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -462,7 +462,9 @@ void __init_refok free_initmem(void)
 			__pa_symbol(&__init_end));
 }
 
+#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 unsigned long pgd_current[NR_CPUS];
+#endif
 /*
  * On 64-bit we've got three-level pagetables with a slightly
  * different layout ...
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index ebadab1..571f92f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -160,6 +160,12 @@ static u32 tlb_handler[128] __cpuinitdata;
 static struct uasm_label labels[128] __cpuinitdata;
 static struct uasm_reloc relocs[128] __cpuinitdata;
 
+#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+/*
+ * CONFIG_MIPS_PGD_C0_CONTEXT implies 64 bit and lack of pgd_current,
+ * we cannot do r3000 under these circumstances.
+ */
+
 /*
  * The R3000 TLB handler is simple.
  */
@@ -199,6 +205,7 @@ static void __cpuinit build_r3000_tlb_refill_handler(void)
 
 	dump_handler((u32 *)ebase, 32);
 }
+#endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
 
 /*
  * The R4000 TLB handler is much more complicated. We have two
@@ -497,8 +504,9 @@ static void __cpuinit
 build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 		 unsigned int tmp, unsigned int ptr)
 {
+#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 	long pgdc = (long)pgd_current;
-
+#endif
 	/*
 	 * The vmalloc handling is not in the hotpath.
 	 */
@@ -506,7 +514,15 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	uasm_il_bltz(p, r, tmp, label_vmalloc);
 	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+	/*
+	 * &pgd << 11 stored in CONTEXT [23..63].
+	 */
+	UASM_i_MFC0(p, ptr, C0_CONTEXT);
+	uasm_i_dins(p, ptr, 0, 0, 23); /* Clear lower 23 bits of context. */
+	uasm_i_ori(p, ptr, ptr, 0x540); /* 1 0  1 0 1  << 6  xkphys cached */
+	uasm_i_drotr(p, ptr, ptr, 11);
+#elif defined(CONFIG_SMP)
 # ifdef  CONFIG_MIPS_MT_SMTC
 	/*
 	 * SMTC uses TCBind value as "CPU" index
@@ -520,7 +536,7 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	 */
 	uasm_i_dmfc0(p, ptr, C0_CONTEXT);
 	uasm_i_dsrl(p, ptr, ptr, 23);
-#endif
+# endif
 	UASM_i_LA_mostly(p, tmp, pgdc);
 	uasm_i_daddu(p, ptr, ptr, tmp);
 	uasm_i_dmfc0(p, tmp, C0_BADVADDR);
@@ -1036,6 +1052,7 @@ build_pte_modifiable(u32 **p, struct uasm_reloc **r,
 	iPTE_LW(p, pte, ptr);
 }
 
+#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 /*
  * R3000 style TLB load/store/modify handlers.
  */
@@ -1187,6 +1204,7 @@ static void __cpuinit build_r3000_tlb_modify_handler(void)
 
 	dump_handler(handle_tlbm, ARRAY_SIZE(handle_tlbm));
 }
+#endif /* CONFIG_MIPS_PGD_C0_CONTEXT */
 
 /*
  * R4000 style TLB load/store/modify handlers.
@@ -1406,6 +1424,7 @@ void __cpuinit build_tlb_refill_handler(void)
 	case CPU_TX3912:
 	case CPU_TX3922:
 	case CPU_TX3927:
+#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
 		build_r3000_tlb_refill_handler();
 		if (!run_once) {
 			build_r3000_tlb_load_handler();
@@ -1413,6 +1432,9 @@ void __cpuinit build_tlb_refill_handler(void)
 			build_r3000_tlb_modify_handler();
 			run_once++;
 		}
+#else
+		panic("No R3000 TLB refill handler");
+#endif
 		break;
 
 	case CPU_R6000:
-- 
1.6.0.6
