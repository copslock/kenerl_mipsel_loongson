Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 17:24:00 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39800 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903687Ab2DIPWZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 17:22:25 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SHGQ7-0005vf-TX; Mon, 09 Apr 2012 10:22:19 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 3/9] MIPS: Add support for the M14KE core.
Date:   Mon,  9 Apr 2012 10:21:57 -0500
Message-Id: <1333984923-445-4-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333984923-445-1-git-send-email-sjhill@mips.com>
References: <1333984923-445-1-git-send-email-sjhill@mips.com>
X-archive-position: 32895
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
 arch/mips/mm/tlbex.c                 |    2 ++
 arch/mips/oprofile/common.c          |    1 +
 arch/mips/oprofile/op_model_mipsxx.c |    4 ++++
 7 files changed, 24 insertions(+), 1 deletion(-)

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
index 00e5adf..242a401 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -96,6 +96,7 @@
 #define PRID_IMP_1004K		0x9900
 #define PRID_IMP_1074K		0x9a00
 #define PRID_IMP_14K		0x9c00
+#define PRID_IMP_14KE		0x9e00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -262,7 +263,7 @@ enum cpu_type_enum {
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
-	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_1074K, CPU_14K,
+	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_1074K, CPU_14K, CPU_14KE,
 
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
index 7d95e62..0a3e3f6 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -201,6 +201,7 @@ void __init check_wait(void)
 		break;
 
 	case CPU_14K:
+	case CPU_14KE:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
@@ -747,6 +748,11 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_ULRI;
 	if (config3 & MIPS_CONF3_CTXTC)
 		c->options |= MIPS_CPU_CTXTC;
+	if (config3 & MIPS_CONF3_ISA)
+		c->options |= MIPS_CPU_MICROMIPS;
+#ifdef CONFIG_CPU_MICROMIPS
+	write_c0_config3(read_c0_config3() | MIPS_CONF3_ISA_OE);
+#endif
 
 	return config3 & MIPS_CONF_M;
 }
@@ -840,6 +846,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_14K;
 		__cpu_name[cpu] = "MIPS 14Kc";
 		break;
+	case PRID_IMP_14KE:
+		c->cputype = CPU_14KE;
+		__cpu_name[cpu] = "MIPS 14KEc";
+		break;
 	case PRID_IMP_1004K:
 		c->cputype = CPU_1004K;
 		__cpu_name[cpu] = "MIPS 1004Kc";
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 9cd86fa..821a8bd 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1074,6 +1074,7 @@ static void __cpuinit probe_pcache(void)
 bypass1074:
 		;
 	case CPU_14K:
+	case CPU_14KE:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 87f57ae..64d631e 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -461,6 +461,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 		if (cpu_has_mips_r2_exec_hazard) {
 			switch (current_cpu_type()) {
 			case CPU_14K:
+			case CPU_14KE:
 			case CPU_74K:
 			case CPU_1074K:
 				break;
@@ -515,6 +516,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_4KC:
 	case CPU_4KEC:
 	case CPU_14K:
+	case CPU_14KE:
 	case CPU_SB1:
 	case CPU_SB1A:
 	case CPU_4KSC:
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index b2e850e..09b485c 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -79,6 +79,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	switch (current_cpu_type()) {
 	case CPU_5KC:
 	case CPU_14K:
+	case CPU_14KE:
 	case CPU_20KC:
 	case CPU_24K:
 	case CPU_25KF:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index fdf3ce5..9ee2aaf 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -321,6 +321,10 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx_ops.cpu_type = "mips/14K";
 		break;
 
+	case CPU_14KE:
+		op_model_mipsxx_ops.cpu_type = "mips/14KE";
+		break;
+
 	case CPU_20KC:
 		op_model_mipsxx_ops.cpu_type = "mips/20K";
 		break;
-- 
1.7.9.6
