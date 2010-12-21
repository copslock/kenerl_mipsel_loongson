Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2010 23:20:20 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12581 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491118Ab0LUWT0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Dec 2010 23:19:26 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d1128190000>; Tue, 21 Dec 2010 14:20:09 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 21 Dec 2010 14:20:46 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 21 Dec 2010 14:20:46 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBLMJLP9011467;
        Tue, 21 Dec 2010 14:19:21 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBLMJLen011466;
        Tue, 21 Dec 2010 14:19:21 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v2 3/3] MIPS: Use C0_KScratch (if present) to hold PGD pointer.
Date:   Tue, 21 Dec 2010 14:19:11 -0800
Message-Id: <1292969951-11418-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1292969951-11418-1-git-send-email-ddaney@caviumnetworks.com>
References: <1292969951-11418-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 21 Dec 2010 22:20:46.0816 (UTC) FILETIME=[50B37600:01CBA15D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Decide at runtime to use either Context or KScratch to hold the PGD
pointer.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/mmu_context.h |    8 +--
 arch/mips/kernel/traps.c            |    2 +-
 arch/mips/mm/tlbex.c                |  116 ++++++++++++++++++++++++++++++++---
 3 files changed, 108 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index d959273..73c0d45 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -29,13 +29,7 @@
 #define TLBMISS_HANDLER_SETUP_PGD(pgd)				\
 	tlbmiss_handler_setup_pgd((unsigned long)(pgd))
 
-static inline void tlbmiss_handler_setup_pgd(unsigned long pgd)
-{
-	/* Check for swapper_pg_dir and convert to physical address. */
-	if ((pgd & CKSEG3) == CKSEG0)
-		pgd = CPHYSADDR(pgd);
-	write_c0_context(pgd << 11);
-}
+extern void tlbmiss_handler_setup_pgd(unsigned long pgd);
 
 #define TLBMISS_HANDLER_SETUP()						\
 	do {								\
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e971043..71350f7 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1592,7 +1592,6 @@ void __cpuinit per_cpu_trap_init(void)
 #endif /* CONFIG_MIPS_MT_SMTC */
 
 	cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
-	TLBMISS_HANDLER_SETUP();
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
@@ -1614,6 +1613,7 @@ void __cpuinit per_cpu_trap_init(void)
 		write_c0_wired(0);
 	}
 #endif /* CONFIG_MIPS_MT_SMTC */
+	TLBMISS_HANDLER_SETUP();
 }
 
 /* Install CPU exception handler */
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 93816f3..0bb4c3b 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -26,8 +26,10 @@
 #include <linux/smp.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/cache.h>
 
-#include <asm/mmu_context.h>
+#include <asm/cacheflush.h>
+#include <asm/pgtable.h>
 #include <asm/war.h>
 #include <asm/uasm.h>
 
@@ -173,11 +175,38 @@ static struct uasm_reloc relocs[128] __cpuinitdata;
 static int check_for_high_segbits __cpuinitdata;
 #endif
 
-#ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+
+static unsigned int kscratch_used_mask __cpuinitdata;
+
+static int __cpuinit allocate_kscratch(void)
+{
+	int r;
+	unsigned int a = cpu_data[0].kscratch_mask & ~kscratch_used_mask;
+
+	r = ffs(a);
+
+	if (r == 0)
+		return -1;
+
+	r--; /* make it zero based */
+
+	kscratch_used_mask |= (1 << r);
+
+	return r;
+}
+
+static int pgd_reg __cpuinitdata;
+
+#else /* !CONFIG_MIPS_PGD_C0_CONTEXT*/
 /*
  * CONFIG_MIPS_PGD_C0_CONTEXT implies 64 bit and lack of pgd_current,
  * we cannot do r3000 under these circumstances.
+ *
+ * Declare pgd_current here instead of including mmu_context.h to avoid type
+ * conflicts for tlbmiss_handler_setup_pgd
  */
+extern unsigned long pgd_current[];
 
 /*
  * The R3000 TLB handler is simple.
@@ -573,13 +602,22 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
 	/* No uasm_i_nop needed here, since the next insn doesn't touch TMP. */
 
 #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
-	/*
-	 * &pgd << 11 stored in CONTEXT [23..63].
-	 */
-	UASM_i_MFC0(p, ptr, C0_CONTEXT);
-	uasm_i_dins(p, ptr, 0, 0, 23); /* Clear lower 23 bits of context. */
-	uasm_i_ori(p, ptr, ptr, 0x540); /* 1 0  1 0 1  << 6  xkphys cached */
-	uasm_i_drotr(p, ptr, ptr, 11);
+	if (pgd_reg != -1) {
+		/* pgd is in pgd_reg */
+		UASM_i_MFC0(p, ptr, 31, pgd_reg);
+	} else {
+		/*
+		 * &pgd << 11 stored in CONTEXT [23..63].
+		 */
+		UASM_i_MFC0(p, ptr, C0_CONTEXT);
+
+		/* Clear lower 23 bits of context. */
+		uasm_i_dins(p, ptr, 0, 0, 23);
+
+		/* 1 0  1 0 1  << 6  xkphys cached */
+		uasm_i_ori(p, ptr, ptr, 0x540);
+		uasm_i_drotr(p, ptr, ptr, 11);
+	}
 #elif defined(CONFIG_SMP)
 # ifdef  CONFIG_MIPS_MT_SMTC
 	/*
@@ -1014,6 +1052,55 @@ static void __cpuinit build_r4000_tlb_refill_handler(void)
 u32 handle_tlbl[FASTPATH_SIZE] __cacheline_aligned;
 u32 handle_tlbs[FASTPATH_SIZE] __cacheline_aligned;
 u32 handle_tlbm[FASTPATH_SIZE] __cacheline_aligned;
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+u32 tlbmiss_handler_setup_pgd[16] __cacheline_aligned;
+
+static void __cpuinit build_r4000_setup_pgd(void)
+{
+	const int a0 = 4;
+	const int a1 = 5;
+	u32 *p = tlbmiss_handler_setup_pgd;
+	struct uasm_label *l = labels;
+	struct uasm_reloc *r = relocs;
+
+	memset(tlbmiss_handler_setup_pgd, 0, sizeof(tlbmiss_handler_setup_pgd));
+	memset(labels, 0, sizeof(labels));
+	memset(relocs, 0, sizeof(relocs));
+
+	pgd_reg = allocate_kscratch();
+
+	if (pgd_reg == -1) {
+		/* PGD << 11 in c0_Context */
+		/*
+		 * If it is a ckseg0 address, convert to a physical
+		 * address.  Shifting right by 29 and adding 4 will
+		 * result in zero for these addresses.
+		 *
+		 */
+		UASM_i_SRA(&p, a1, a0, 29);
+		UASM_i_ADDIU(&p, a1, a1, 4);
+		uasm_il_bnez(&p, &r, a1, label_tlbl_goaround1);
+		uasm_i_nop(&p);
+		uasm_i_dinsm(&p, a0, 0, 29, 64 - 29);
+		uasm_l_tlbl_goaround1(&l, p);
+		UASM_i_SLL(&p, a0, a0, 11);
+		uasm_i_jr(&p, 31);
+		UASM_i_MTC0(&p, a0, C0_CONTEXT);
+	} else {
+		/* PGD in c0_KScratch */
+		uasm_i_jr(&p, 31);
+		UASM_i_MTC0(&p, a0, 31, pgd_reg);
+	}
+	if (p - tlbmiss_handler_setup_pgd > ARRAY_SIZE(tlbmiss_handler_setup_pgd))
+		panic("tlbmiss_handler_setup_pgd space exceeded");
+	uasm_resolve_relocs(relocs, labels);
+	pr_debug("Wrote tlbmiss_handler_setup_pgd (%u instructions).\n",
+		 (unsigned int)(p - tlbmiss_handler_setup_pgd));
+
+	dump_handler(tlbmiss_handler_setup_pgd,
+		     ARRAY_SIZE(tlbmiss_handler_setup_pgd));
+}
+#endif
 
 static void __cpuinit
 iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
@@ -1161,6 +1248,8 @@ build_pte_modifiable(u32 **p, struct uasm_reloc **r,
 }
 
 #ifndef CONFIG_MIPS_PGD_C0_CONTEXT
+
+
 /*
  * R3000 style TLB load/store/modify handlers.
  */
@@ -1623,13 +1712,16 @@ void __cpuinit build_tlb_refill_handler(void)
 		break;
 
 	default:
-		build_r4000_tlb_refill_handler();
 		if (!run_once) {
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+			build_r4000_setup_pgd();
+#endif
 			build_r4000_tlb_load_handler();
 			build_r4000_tlb_store_handler();
 			build_r4000_tlb_modify_handler();
 			run_once++;
 		}
+		build_r4000_tlb_refill_handler();
 	}
 }
 
@@ -1641,4 +1733,8 @@ void __cpuinit flush_tlb_handlers(void)
 			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
 	local_flush_icache_range((unsigned long)handle_tlbm,
 			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
+#ifdef CONFIG_MIPS_PGD_C0_CONTEXT
+	local_flush_icache_range((unsigned long)tlbmiss_handler_setup_pgd,
+			   (unsigned long)tlbmiss_handler_setup_pgd + sizeof(handle_tlbm));
+#endif
 }
-- 
1.7.2.3
