Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 07:35:03 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:34195 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903543Ab2EKFe5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 07:34:57 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SSiV8-0001pG-JR; Fri, 11 May 2012 00:34:50 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH v3,3/9] MIPS: Add support for the M14KE core.
Date:   Fri, 11 May 2012 00:34:45 -0500
Message-Id: <1336714485-31600-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This patch depends on the M14K core support patch being
applied first.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu-features.h |    3 +++
 arch/mips/include/asm/cpu.h          |    4 +++-
 arch/mips/kernel/cpu-probe.c         |   10 ++++++++++
 arch/mips/mm/c-r4k.c                 |    1 +
 arch/mips/mm/page.c                  |   26 +++++++++++++++-----------
 arch/mips/mm/tlbex.c                 |    2 ++
 arch/mips/oprofile/common.c          |    1 +
 arch/mips/oprofile/op_model_mipsxx.c |    4 ++++
 8 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 556afa2..3b50744 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -98,6 +98,9 @@
 #ifndef kernel_uses_smartmips_rixi
 #define kernel_uses_smartmips_rixi 0
 #endif
+#ifndef cpu_has_mmips
+#define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
+#endif
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index fc937ef..0a619f8 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -96,6 +96,7 @@
 #define PRID_IMP_1004K		0x9900
 #define PRID_IMP_1074K		0x9a00
 #define PRID_IMP_M14KC		0x9c00
+#define PRID_IMP_M14KEC		0x9e00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -262,7 +263,7 @@ enum cpu_type_enum {
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
-	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_M14KC,
+	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_M14KC, CPU_M14KEC,
 
 	/*
 	 * MIPS64 class processors
@@ -319,6 +320,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_VINT		0x00080000 /* CPU supports MIPSR2 vectored interrupts */
 #define MIPS_CPU_VEIC		0x00100000 /* CPU supports MIPSR2 external interrupt controller mode */
 #define MIPS_CPU_ULRI		0x00200000 /* CPU has ULRI feature */
+#define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 33c59e9..e5f0b27 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -200,6 +200,7 @@ void __init check_wait(void)
 		break;
 
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
@@ -743,6 +744,11 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->ases |= MIPS_ASE_MIPSMT;
 	if (config3 & MIPS_CONF3_ULRI)
 		c->options |= MIPS_CPU_ULRI;
+	if (config3 & MIPS_CONF3_ISA)
+		c->options |= MIPS_CPU_MICROMIPS;
+#ifdef CONFIG_CPU_MICROMIPS
+	write_c0_config3(read_c0_config3() | MIPS_CONF3_ISA_OE);
+#endif
 
 	return config3 & MIPS_CONF_M;
 }
@@ -836,6 +842,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_M14KC;
 		__cpu_name[cpu] = "MIPS M14Kc";
 		break;
+	case PRID_IMP_M14KEC:
+		c->cputype = CPU_M14KEC;
+		__cpu_name[cpu] = "MIPS M14KEc";
+		break;
 	case PRID_IMP_1004K:
 		c->cputype = CPU_1004K;
 		__cpu_name[cpu] = "MIPS 1004Kc";
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 52b4dfd..6401cee 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1070,6 +1070,7 @@ static void __cpuinit probe_pcache(void)
 		}
 		/* fall through */
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index cc0b626..34f71b3 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2003, 04, 05 Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2007  Maciej W. Rozycki
  * Copyright (C) 2008  Thiemo Seufer
+ * Copyright (C) 2011, 2012  MIPS Technologies, Inc.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -79,17 +80,12 @@ static struct uasm_reloc __cpuinitdata relocs[5];
  * R4600 v2.0:				0x060 bytes
  * With prefetching, 16 word strides	0x120 bytes
  */
-
-static u32 clear_page_array[0x120 / 4];
+static u32 clear_page_array[CLEAR_PAGE_ARRAY_SIZE / 4];
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
 void clear_page_cpu(void *page) __attribute__((alias("clear_page_array")));
-#else
-void clear_page(void *page) __attribute__((alias("clear_page_array")));
 #endif
 
-EXPORT_SYMBOL(clear_page);
-
 /*
  * Maximum sizes:
  *
@@ -98,17 +94,13 @@ EXPORT_SYMBOL(clear_page);
  * R4600 v2.0:				0x07c bytes
  * With prefetching, 16 word strides	0x540 bytes
  */
-static u32 copy_page_array[0x540 / 4];
+static u32 copy_page_array[COPY_PAGE_ARRAY_SIZE / 4];
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
 void
 copy_page_cpu(void *to, void *from) __attribute__((alias("copy_page_array")));
-#else
-void copy_page(void *to, void *from) __attribute__((alias("copy_page_array")));
 #endif
 
-EXPORT_SYMBOL(copy_page);
-
 
 static int pref_bias_clear_store __cpuinitdata;
 static int pref_bias_copy_load __cpuinitdata;
@@ -368,6 +360,12 @@ void __cpuinit build_clear_page(void)
 	for (i = 0; i < (buf - clear_page_array); i++)
 		pr_debug("\t.word 0x%08x\n", clear_page_array[i]);
 	pr_debug("\t.set pop\n");
+#ifdef CONFIG_CPU_MICROMIPS
+	buf = (u32 *)(((u8 *)clear_page) - 1);
+#else
+	buf = (u32 *)clear_page;
+#endif
+	memcpy(buf, clear_page_array, CLEAR_PAGE_ARRAY_SIZE);
 }
 
 static void __cpuinit build_copy_load(u32 **buf, int reg, int off)
@@ -607,6 +605,12 @@ void __cpuinit build_copy_page(void)
 	for (i = 0; i < (buf - copy_page_array); i++)
 		pr_debug("\t.word 0x%08x\n", copy_page_array[i]);
 	pr_debug("\t.set pop\n");
+#ifdef CONFIG_CPU_MICROMIPS
+	buf = (u32 *)(((u8 *)copy_page) - 1);
+#else
+	buf = (u32 *)copy_page;
+#endif
+	memcpy(buf, copy_page_array, COPY_PAGE_ARRAY_SIZE);
 }
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 7b84001..100971f 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -461,6 +461,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		if (cpu_has_mips_r2_exec_hazard) {
 			switch (current_cpu_type()) {
 			case CPU_M14KC:
+			case CPU_M14KEC:
 			case CPU_74K:
 				break;
 
@@ -514,6 +515,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_4KC:
 	case CPU_4KEC:
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_SB1:
 	case CPU_SB1A:
 	case CPU_4KSC:
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index b6e3782..ccf629a 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -79,6 +79,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	switch (current_cpu_type()) {
 	case CPU_5KC:
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_20KC:
 	case CPU_24K:
 	case CPU_25KF:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 4c1e21b..a86e93e 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -321,6 +321,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/M14Kc";
 		break;
 
+	case CPU_M14KEC:
+		op_model_mipsxx_ops.cpu_type = "mips/M14KEc";
+		break;
+
 	case CPU_20KC:
 		op_model_mipsxx_ops.cpu_type = "mips/20K";
 		break;
-- 
1.7.10
