Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 23:43:26 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:49880 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903778Ab2GXVki (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 23:40:38 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1StmqG-0003yS-Sd; Tue, 24 Jul 2012 16:40:32 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v3] MIPS: Add support for the M14KEc core.
Date:   Tue, 24 Jul 2012 16:40:28 -0500
Message-Id: <1343166028-1861-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.11.1
X-archive-position: 33979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu-features.h | 3 +++
 arch/mips/include/asm/cpu.h          | 4 +++-
 arch/mips/include/asm/mipsregs.h     | 1 +
 arch/mips/kernel/cpu-probe.c         | 7 +++++++
 arch/mips/mm/c-r4k.c                 | 1 +
 arch/mips/mm/tlbex.c                 | 1 +
 arch/mips/oprofile/common.c          | 1 +
 arch/mips/oprofile/op_model_mipsxx.c | 4 ++++
 8 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 2daf1c5..98bee29 100644
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
index ad3caba..559bd12 100644
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
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index ac36bb9..ba3d53d 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -591,6 +591,7 @@
 #define MIPS_CONF3_LPA		(_ULCAST_(1) <<  7)
 #define MIPS_CONF3_DSP		(_ULCAST_(1) << 10)
 #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
+#define MIPS_CONF3_ISA		(_ULCAST_(3) << 14)
 
 #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
 #define MIPS_CONF4_MMUEXTDEF	(_ULCAST_(3) << 14)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 78644e8..f3f42d7 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -200,6 +200,7 @@ void __init check_wait(void)
 		break;
 
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
@@ -742,6 +743,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->ases |= MIPS_ASE_MIPSMT;
 	if (config3 & MIPS_CONF3_ULRI)
 		c->options |= MIPS_CPU_ULRI;
+	if (config3 & MIPS_CONF3_ISA)
+		c->options |= MIPS_CPU_MICROMIPS;
 
 	return config3 & MIPS_CONF_M;
 }
@@ -839,6 +842,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
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
index 71a4935..cb7d242 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1082,6 +1082,7 @@ static void __cpuinit probe_pcache(void)
 		}
 		/* fall through */
 	case CPU_M14KC:
+	case CPU_M14KEC:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 196641a..1566297 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -510,6 +510,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
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
index 52da646..a86cc41 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -326,6 +326,10 @@ static int __init mipsxx_init(void)
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
1.7.11.1
