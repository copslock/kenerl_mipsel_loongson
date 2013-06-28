Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 23:15:24 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55941 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824790Ab3F1VPUFytth (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Jun 2013 23:15:20 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1Usg0d-00083O-Uq; Fri, 28 Jun 2013 16:15:11 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W . Rozycki" <macro@linux-mips.org>
Subject: [PATCH] MIPS: Reduce kernel binary size.
Date:   Fri, 28 Jun 2013 16:15:07 -0500
Message-Id: <1372454107-7784-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37211
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

From: Ralf Baechle <ralf@linux-mips.org>

Original idea from <http://patchwork.linux-mips.org/patch/4701/>.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/cavium-octeon/csrc-octeon.c |    1 +
 arch/mips/include/asm/cpu-features.h  |    4 -
 arch/mips/include/asm/cpu-type.h      |  196 +++++++++++++++++++++++++++++++++
 arch/mips/kernel/cpu-probe.c          |    3 +-
 arch/mips/kernel/idle.c               |    3 +-
 arch/mips/kernel/time.c               |    1 +
 arch/mips/kernel/traps.c              |    3 +-
 arch/mips/mm/c-octeon.c               |    6 +-
 arch/mips/mm/c-r4k.c                  |   14 +--
 arch/mips/mm/dma-default.c            |    8 ++
 arch/mips/mm/page.c                   |    1 +
 arch/mips/mm/sc-mips.c                |    3 +-
 arch/mips/mm/tlb-r4k.c                |    1 +
 arch/mips/mm/tlbex.c                  |    1 +
 arch/mips/oprofile/common.c           |    1 +
 arch/mips/oprofile/op_model_mipsxx.c  |    1 +
 16 files changed, 230 insertions(+), 17 deletions(-)
 create mode 100644 arch/mips/include/asm/cpu-type.h

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index 0219395..b752c4e 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -12,6 +12,7 @@
 #include <linux/smp.h>
 
 #include <asm/cpu-info.h>
+#include <asm/cpu-type.h>
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 1dc0860..51680d1 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -13,10 +13,6 @@
 #include <asm/cpu-info.h>
 #include <cpu-feature-overrides.h>
 
-#ifndef current_cpu_type
-#define current_cpu_type()	current_cpu_data.cputype
-#endif
-
 /*
  * SMP assumption: Options of CPU 0 are a superset of all processors.
  * This is true for all known MIPS systems.
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
new file mode 100644
index 0000000..143610e
--- /dev/null
+++ b/arch/mips/include/asm/cpu-type.h
@@ -0,0 +1,196 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 2004 Ralf Baechle
+ * Copyright (C) 2004  Maciej W. Rozycki
+ */
+#ifndef __ASM_CPU_TYPE_H
+#define __ASM_CPU_TYPE_H
+
+#include <linux/compiler.h>
+
+static inline int __pure current_cpu_type(void)
+{
+	const int cpu_type = current_cpu_data.cputype;
+
+	switch (cpu_type) {
+#if defined(CONFIG_SYS_HAS_CPU_LOONGSON2E) || \
+    defined(CONFIG_SYS_HAS_CPU_LOONGSON2F)
+	case CPU_LOONGSON2:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
+	case CPU_LOONGSON1:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_MIPS32_R1
+	case CPU_4KC:
+	case CPU_ALCHEMY:
+	case CPU_PR4450:
+	case CPU_BMIPS32:
+	case CPU_JZRISC:
+#endif
+
+#if defined(CONFIG_SYS_HAS_CPU_MIPS32_R1) || \
+    defined(CONFIG_SYS_HAS_CPU_MIPS32_R2)
+	case CPU_4KEC:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_MIPS32_R2
+	case CPU_4KSC:
+	case CPU_24K:
+	case CPU_34K:
+	case CPU_1004K:
+	case CPU_74K:
+	case CPU_M14KC:
+	case CPU_M14KEC:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_MIPS64_R1
+	case CPU_5KC:
+	case CPU_5KE:
+	case CPU_20KC:
+	case CPU_25KF:
+	case CPU_SB1:
+	case CPU_SB1A:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_MIPS64_R2
+	/*
+	 * All MIPS64 R2 processors have their own special symbols.  That is,
+	 * there currently is no pure R2 core
+	 */
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R3000
+	case CPU_R2000:
+	case CPU_R3000:
+	case CPU_R3000A:
+	case CPU_R3041:
+	case CPU_R3051:
+	case CPU_R3052:
+	case CPU_R3081:
+	case CPU_R3081E:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_TX39XX
+	case CPU_TX3912:
+	case CPU_TX3922:
+	case CPU_TX3927:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_VR41XX
+	case CPU_VR41XX:
+	case CPU_VR4111:
+	case CPU_VR4121:
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+	case CPU_VR4181:
+	case CPU_VR4181A:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R4300
+	case CPU_R4300:
+	case CPU_R4310:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R4X00
+	case CPU_R4000PC:
+	case CPU_R4000SC:
+	case CPU_R4000MC:
+	case CPU_R4200:
+	case CPU_R4400PC:
+	case CPU_R4400SC:
+	case CPU_R4400MC:
+	case CPU_R4600:
+	case CPU_R4700:
+	case CPU_R4640:
+	case CPU_R4650:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_TX49XX
+	case CPU_TX49XX:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R5000
+	case CPU_R5000:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R5432
+	case CPU_R5432:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R5500
+	case CPU_R5500:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R6000
+	case CPU_R6000:
+	case CPU_R6000A:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_NEVADA
+	case CPU_NEVADA:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R8000
+	case CPU_R8000:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R10000
+	case CPU_R10000:
+	case CPU_R12000:
+	case CPU_R14000:
+#endif
+#ifdef CONFIG_SYS_HAS_CPU_RM7000
+	case CPU_RM7000:
+	case CPU_SR71000:
+#endif
+#ifdef CONFIG_SYS_HAS_CPU_RM9000
+	case CPU_RM9000:
+#endif
+#ifdef CONFIG_SYS_HAS_CPU_SB1
+	case CPU_SB1:
+	case CPU_SB1A:
+#endif
+#ifdef CONFIG_SYS_HAS_CPU_CAVIUM_OCTEON
+	case CPU_CAVIUM_OCTEON:
+	case CPU_CAVIUM_OCTEON_PLUS:
+	case CPU_CAVIUM_OCTEON2:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_BMIPS3300
+	case CPU_BMIPS3300:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_BMIPS4350
+	case CPU_BMIPS4350:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_BMIPS4380
+	case CPU_BMIPS4380:
+#endif
+
+#ifdef SYS_HAS_CPU_BMIPS5000
+	case CPU_BMIPS5000:
+#endif
+
+#ifdef SYS_HAS_CPU_XLP
+	case CPU_XLP:
+#endif
+
+#ifdef SYS_HAS_CPU_XLR
+	case CPU_XLR:
+#endif
+		break;
+	default:
+		unreachable();
+	}
+
+	return cpu_type;
+}
+
+#endif /* __ASM_CPU_TYPE_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c7b1b3c..271ef30 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -20,6 +20,7 @@
 
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/cpu-type.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
 #include <asm/watch.h>
@@ -55,7 +56,7 @@ static inline void check_errata(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_34K:
 		/*
 		 * Erratum "RPS May Cause Incorrect Instruction Execution"
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 0c655de..c768138 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <asm/cpu.h>
 #include <asm/cpu-info.h>
+#include <asm/cpu-type.h>
 #include <asm/idle.h>
 #include <asm/mipsregs.h>
 
@@ -136,7 +137,7 @@ void __init check_wait(void)
 		return;
 	}
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_R3081:
 	case CPU_R3081E:
 		cpu_wait = r3081_wait;
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 9d686bf..175ec51 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -24,6 +24,7 @@
 #include <linux/export.h>
 
 #include <asm/cpu-features.h>
+#include <asm/cpu-type.h>
 #include <asm/div64.h>
 #include <asm/smtc_ipi.h>
 #include <asm/time.h>
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 0903d70..2034dd8 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -39,6 +39,7 @@
 #include <asm/break.h>
 #include <asm/cop2.h>
 #include <asm/cpu.h>
+#include <asm/cpu-type.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
@@ -622,7 +623,7 @@ static int simulate_rdhwr(struct pt_regs *regs, int rd, int rt)
 		regs->regs[rt] = read_c0_count();
 		return 0;
 	case 3:		/* Count register resolution */
-		switch (current_cpu_data.cputype) {
+		switch (current_cpu_type()) {
 		case CPU_20KC:
 		case CPU_25KF:
 			regs->regs[rt] = 1;
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 8557fb5..e84d56e 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -19,6 +19,7 @@
 #include <asm/bootinfo.h>
 #include <asm/cacheops.h>
 #include <asm/cpu-features.h>
+#include <asm/cpu-type.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/r4kcache.h>
@@ -186,9 +187,10 @@ static void __cpuinit probe_octeon(void)
 	unsigned long dcache_size;
 	unsigned int config1;
 	struct cpuinfo_mips *c = &current_cpu_data;
+	int cputype = current_cpu_type();
 
 	config1 = read_c0_config1();
-	switch (c->cputype) {
+	switch (cputype) {
 	case CPU_CAVIUM_OCTEON:
 	case CPU_CAVIUM_OCTEON_PLUS:
 		c->icache.linesz = 2 << ((config1 >> 19) & 7);
@@ -199,7 +201,7 @@ static void __cpuinit probe_octeon(void)
 			c->icache.sets * c->icache.ways * c->icache.linesz;
 		c->icache.waybit = ffs(icache_size / c->icache.ways) - 1;
 		c->dcache.linesz = 128;
-		if (c->cputype == CPU_CAVIUM_OCTEON_PLUS)
+		if (cputype == CPU_CAVIUM_OCTEON_PLUS)
 			c->dcache.sets = 2; /* CN5XXX has two Dcache sets */
 		else
 			c->dcache.sets = 1; /* CN3XXX has one Dcache set */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 21813be..73d58cc 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -24,6 +24,7 @@
 #include <asm/cacheops.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
+#include <asm/cpu-type.h>
 #include <asm/io.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -809,7 +810,7 @@ static void __cpuinit probe_pcache(void)
 	unsigned long config1;
 	unsigned int lsize;
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_R4600:			/* QED style two way caches? */
 	case CPU_R4700:
 	case CPU_R5000:
@@ -1045,7 +1046,7 @@ static void __cpuinit probe_pcache(void)
 	 * normally they'd suffer from aliases but magic in the hardware deals
 	 * with that for us so we don't need to take care ourselves.
 	 */
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_20KC:
 	case CPU_25KF:
 	case CPU_SB1:
@@ -1065,7 +1066,7 @@ static void __cpuinit probe_pcache(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
-		if (c->cputype == CPU_74K)
+		if (current_cpu_type() == CPU_74K)
 			alias_74k_erratum(c);
 		if ((read_c0_config7() & (1 << 16))) {
 			/* effectively physically indexed dcache,
@@ -1078,7 +1079,7 @@ static void __cpuinit probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
 	}
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_20KC:
 		/*
 		 * Some older 20Kc chips doesn't have the 'VI' bit in
@@ -1207,7 +1208,7 @@ static void __cpuinit setup_scache(void)
 	 * processors don't have a S-cache that would be relevant to the
 	 * Linux memory management.
 	 */
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_R4000SC:
 	case CPU_R4000MC:
 	case CPU_R4400SC:
@@ -1384,9 +1385,8 @@ static void __cpuinit r4k_cache_error_setup(void)
 {
 	extern char __weak except_vec2_generic;
 	extern char __weak except_vec2_sb1;
-	struct cpuinfo_mips *c = &current_cpu_data;
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_SB1:
 	case CPU_SB1A:
 		set_uncached_handler(0x100, &except_vec2_sb1, 0x80);
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index aaccf1c..42b90af 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 
 #include <asm/cache.h>
+#include <asm/cpu-type.h>
 #include <asm/io.h>
 
 #include <dma-coherence.h>
@@ -55,12 +56,19 @@ static inline struct page *dma_addr_to_page(struct device *dev,
  * coherent.
  */
 
+#ifdef CONFIG_SYS_HAS_CPU_R10000
 static inline int cpu_is_noncoherent_r10000(struct device *dev)
 {
 	return !plat_device_is_coherent(dev) &&
 	       (current_cpu_type() == CPU_R10000 ||
 	       current_cpu_type() == CPU_R12000);
 }
+#else
+static inline int cpu_is_noncoherent_r10000(struct device *dev)
+{
+	return 0;
+}
+#endif
 
 static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
 {
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 2c0bd58..518dde8 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -18,6 +18,7 @@
 
 #include <asm/bugs.h>
 #include <asm/cacheops.h>
+#include <asm/cpu-type.h>
 #include <asm/inst.h>
 #include <asm/io.h>
 #include <asm/page.h>
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index df96da7..535f115 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -8,6 +8,7 @@
 
 #include <asm/mipsregs.h>
 #include <asm/bcache.h>
+#include <asm/cpu-type.h>
 #include <asm/cacheops.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -71,7 +72,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	unsigned int tmp;
 
 	/* Check the bypass bit (L2B) */
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index c643de4..19968204889 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 
 #include <asm/cpu.h>
+#include <asm/cpu-type.h>
 #include <asm/bootinfo.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 9ab0f90..b6eab56 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -30,6 +30,7 @@
 #include <linux/cache.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cpu-type.h>
 #include <asm/pgtable.h>
 #include <asm/war.h>
 #include <asm/uasm.h>
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index af763e8..e47fe37 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -12,6 +12,7 @@
 #include <linux/oprofile.h>
 #include <linux/smp.h>
 #include <asm/cpu-info.h>
+#include <asm/cpu-type.h>
 
 #include "op_impl.h"
 
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index e4b1140..daabe1e 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -10,6 +10,7 @@
 #include <linux/oprofile.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <asm/cpu-type.h>
 #include <asm/irq_regs.h>
 
 #include "op_impl.h"
-- 
1.7.9.5
