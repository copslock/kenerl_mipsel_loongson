Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Apr 2012 18:50:25 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36603 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904118Ab2DGQs6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Apr 2012 18:48:58 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SGYol-0004dH-Si; Sat, 07 Apr 2012 11:48:51 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 03/10] MIPS: Add support for the M14K core.
Date:   Sat,  7 Apr 2012 11:48:28 -0500
Message-Id: <1333817315-30091-4-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333817315-30091-1-git-send-email-sjhill@mips.com>
References: <1333817315-30091-1-git-send-email-sjhill@mips.com>
X-archive-position: 32881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

This patch depends on the 1074K core support patch being
applied first.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu.h          |    5 +++--
 arch/mips/kernel/cpu-probe.c         |   10 +++++++++-
 arch/mips/mm/c-r4k.c                 |    1 +
 arch/mips/mm/tlbex.c                 |    4 +++-
 arch/mips/oprofile/common.c          |    1 +
 arch/mips/oprofile/op_model_mipsxx.c |    4 ++++
 6 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index ddd8b4a..00e5adf 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -95,6 +95,7 @@
 #define PRID_IMP_74K		0x9700
 #define PRID_IMP_1004K		0x9900
 #define PRID_IMP_1074K		0x9a00
+#define PRID_IMP_14K		0x9c00
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
@@ -261,7 +262,7 @@ enum cpu_type_enum {
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
 	CPU_ALCHEMY, CPU_PR4450, CPU_BMIPS32, CPU_BMIPS3300, CPU_BMIPS4350,
-	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_1074K,
+	CPU_BMIPS4380, CPU_BMIPS5000, CPU_JZRISC, CPU_1074K, CPU_14K,
 
 	/*
 	 * MIPS64 class processors
@@ -289,7 +290,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_ISA_M64R2	0x00000100
 
 #define MIPS_CPU_ISA_32BIT (MIPS_CPU_ISA_I | MIPS_CPU_ISA_II | \
-	MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 )
+	MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2)
 #define MIPS_CPU_ISA_64BIT (MIPS_CPU_ISA_III | MIPS_CPU_ISA_IV | \
 	MIPS_CPU_ISA_V | MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cb1e2e9..0fccb8c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -4,7 +4,7 @@
  * Copyright (C) xxxx  the Anonymous
  * Copyright (C) 1994 - 2006 Ralf Baechle
  * Copyright (C) 2003, 2004  Maciej W. Rozycki
- * Copyright (C) 2001, 2004  MIPS Inc.
+ * Copyright (C) 2001, 2004, 2011  MIPS Technologies, Inc.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -22,6 +22,7 @@
 #include <asm/cpu.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
+#include <asm/system.h>
 #include <asm/watch.h>
 #include <asm/elf.h>
 #include <asm/spram.h>
@@ -199,6 +200,7 @@ void __init check_wait(void)
 		cpu_wait = rm7k_wait_irqoff;
 		break;
 
+	case CPU_14K:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
@@ -743,6 +745,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 	        c->ases |= MIPS_ASE_MIPSMT;
 	if (config3 & MIPS_CONF3_ULRI)
 		c->options |= MIPS_CPU_ULRI;
+	if (config3 & MIPS_CONF3_CTXTC)
+		c->options |= MIPS_CPU_CTXTC;
 
 	return config3 & MIPS_CONF_M;
 }
@@ -832,6 +836,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_74K;
 		__cpu_name[cpu] = "MIPS 74Kc";
 		break;
+	case PRID_IMP_14K:
+		c->cputype = CPU_14K;
+		__cpu_name[cpu] = "MIPS 14Kc";
+		break;
 	case PRID_IMP_1004K:
 		c->cputype = CPU_1004K;
 		__cpu_name[cpu] = "MIPS 1004Kc";
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index efcf385..9cd86fa 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1073,6 +1073,7 @@ static void __cpuinit probe_pcache(void)
 		/* fall through */
 bypass1074:
 		;
+	case CPU_14K:
 	case CPU_24K:
 	case CPU_34K:
 	case CPU_1004K:
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 0bc485b..a034229b 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -8,7 +8,8 @@
  * Copyright (C) 2004, 2005, 2006, 2008  Thiemo Seufer
  * Copyright (C) 2005, 2007, 2008, 2009  Maciej W. Rozycki
  * Copyright (C) 2006  Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 2008, 2009 Cavium Networks, Inc.
+ * Copyright (C) 2008, 2009  Cavium Networks, Inc.
+ * Copyright (C) 2011  MIPS Technologies, Inc.
  *
  * ... and the days got worse and worse and now you see
  * I've gone completly out of my mind.
@@ -494,6 +495,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R14000:
 	case CPU_4KC:
 	case CPU_4KEC:
+	case CPU_14K:
 	case CPU_SB1:
 	case CPU_SB1A:
 	case CPU_4KSC:
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 846faf7..b2e850e 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -78,6 +78,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 
 	switch (current_cpu_type()) {
 	case CPU_5KC:
+	case CPU_14K:
 	case CPU_20KC:
 	case CPU_24K:
 	case CPU_25KF:
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index 13487a9..fdf3ce5 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -317,6 +317,10 @@ static int __init mipsxx_init(void)
 
 	op_model_mipsxx_ops.num_counters = counters;
 	switch (current_cpu_type()) {
+	case CPU_14K:
+		op_model_mipsxx_ops.cpu_type = "mips/14K";
+		break;
+
 	case CPU_20KC:
 		op_model_mipsxx_ops.cpu_type = "mips/20K";
 		break;
-- 
1.7.9.6
