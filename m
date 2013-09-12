From: Ralf Baechle <ralf@linux-mips.org>
Date: Thu, 12 Sep 2013 12:46:39 +0200
Subject: [PATCH] MIPS: Optimize current_cpu_type() for better code.
Message-ID: <20130912104639.PbV_S4rV9uZOxZyzaQU_ZYjI15M2hklk-u800YtEE4Y@z>

 o Move current_cpu_type() to a separate header file
 o #ifdefing on supported CPU types lets modern GCC know that certain
   code in callers may be discarded ideally turning current_cpu_type() into
   a function returning a constant.
 o Use current_cpu_type() rather than direct access to struct cpuinfo_mips.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/cavium-octeon/csrc-octeon.c              |   1 +
 arch/mips/dec/prom/init.c                          |   1 +
 arch/mips/include/asm/cpu-features.h               |   6 -
 arch/mips/include/asm/cpu-type.h                   | 203 +++++++++++++++++++++
 .../include/asm/mach-ip22/cpu-feature-overrides.h  |   2 +
 .../include/asm/mach-ip27/cpu-feature-overrides.h  |   2 +
 .../include/asm/mach-ip28/cpu-feature-overrides.h  |   2 +
 arch/mips/kernel/cpu-probe.c                       |   3 +-
 arch/mips/kernel/idle.c                            |   3 +-
 arch/mips/kernel/time.c                            |   1 +
 arch/mips/kernel/traps.c                           |   3 +-
 arch/mips/mm/c-octeon.c                            |   6 +-
 arch/mips/mm/c-r4k.c                               |  14 +-
 arch/mips/mm/dma-default.c                         |   1 +
 arch/mips/mm/page.c                                |   1 +
 arch/mips/mm/sc-mips.c                             |   2 +-
 arch/mips/mm/tlb-r4k.c                             |   1 +
 arch/mips/mm/tlbex.c                               |   1 +
 arch/mips/oprofile/common.c                        |   1 +
 19 files changed, 235 insertions(+), 19 deletions(-)

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
diff --git a/arch/mips/dec/prom/init.c b/arch/mips/dec/prom/init.c
index ab16904..468f665 100644
--- a/arch/mips/dec/prom/init.c
+++ b/arch/mips/dec/prom/init.c
@@ -13,6 +13,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
+#include <asm/cpu-type.h>
 #include <asm/processor.h>
 
 #include <asm/dec/prom.h>
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index fa44f3e..51680d1 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -13,12 +13,6 @@
 #include <asm/cpu-info.h>
 #include <cpu-feature-overrides.h>
 
-#ifndef current_cpu_type
-#define current_cpu_type()	current_cpu_data.cputype
-#endif
-
-#define boot_cpu_type()		cpu_data[0].cputype
-
 /*
  * SMP assumption: Options of CPU 0 are a superset of all processors.
  * This is true for all known MIPS systems.
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
new file mode 100644
index 0000000..4a402cc
--- /dev/null
+++ b/arch/mips/include/asm/cpu-type.h
@@ -0,0 +1,203 @@
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
+#include <linux/smp.h>
+#include <linux/compiler.h>
+
+static inline int __pure __get_cpu_type(const int cpu_type)
+{
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
+	case CPU_BMIPS3300:
+	case CPU_BMIPS4350:
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
+#ifdef CONFIG_SYS_HAS_CPU_BMIPS4380
+	case CPU_BMIPS4380:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_BMIPS5000
+	case CPU_BMIPS5000:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_XLP
+	case CPU_XLP:
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_XLR
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
+static inline int __pure current_cpu_type(void)
+{
+	const int cpu_type = current_cpu_data.cputype;
+
+	return __get_cpu_type(cpu_type);
+}
+
+static inline int __pure boot_cpu_type(void)
+{
+	const int cpu_type = cpu_data[0].cputype;
+
+	return __get_cpu_type(cpu_type);
+}
+
+#endif /* __ASM_CPU_TYPE_H */
diff --git a/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
index f4caacd..1bcb642 100644
--- a/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
@@ -8,6 +8,8 @@
 #ifndef __ASM_MACH_IP22_CPU_FEATURE_OVERRIDES_H
 #define __ASM_MACH_IP22_CPU_FEATURE_OVERRIDES_H
 
+#include <asm/cpu.h>
+
 /*
  * IP22 with a variety of processors so we can't use defaults for everything.
  */
diff --git a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
index 1d2b6ff..d6111aa 100644
--- a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
@@ -8,6 +8,8 @@
 #ifndef __ASM_MACH_IP27_CPU_FEATURE_OVERRIDES_H
 #define __ASM_MACH_IP27_CPU_FEATURE_OVERRIDES_H
 
+#include <asm/cpu.h>
+
 /*
  * IP27 only comes with R10000 family processors all using the same config
  */
diff --git a/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
index 65e9c85..4cec06d 100644
--- a/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
@@ -9,6 +9,8 @@
 #ifndef __ASM_MACH_IP28_CPU_FEATURE_OVERRIDES_H
 #define __ASM_MACH_IP28_CPU_FEATURE_OVERRIDES_H
 
+#include <asm/cpu.h>
+
 /*
  * IP28 only comes with R10000 family processors all using the same config
  */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 4c6167a..902b0d7 100644
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
index aec3408..524841f 100644
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
index a0bcdbb..9e5f275 100644
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
@@ -186,9 +187,10 @@ static void probe_octeon(void)
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
@@ -199,7 +201,7 @@ static void probe_octeon(void)
 			c->icache.sets * c->icache.ways * c->icache.linesz;
 		c->icache.waybit = ffs(icache_size / c->icache.ways) - 1;
 		c->dcache.linesz = 128;
-		if (c->cputype == CPU_CAVIUM_OCTEON_PLUS)
+		if (cputype == CPU_CAVIUM_OCTEON_PLUS)
 			c->dcache.sets = 2; /* CN5XXX has two Dcache sets */
 		else
 			c->dcache.sets = 1; /* CN3XXX has one Dcache set */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index f749f68..3ff2f74 100644
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
@@ -809,7 +810,7 @@ static void probe_pcache(void)
 	unsigned long config1;
 	unsigned int lsize;
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_R4600:			/* QED style two way caches? */
 	case CPU_R4700:
 	case CPU_R5000:
@@ -1045,7 +1046,7 @@ static void probe_pcache(void)
 	 * normally they'd suffer from aliases but magic in the hardware deals
 	 * with that for us so we don't need to take care ourselves.
 	 */
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_20KC:
 	case CPU_25KF:
 	case CPU_SB1:
@@ -1065,7 +1066,7 @@ static void probe_pcache(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
-		if (c->cputype == CPU_74K)
+		if (current_cpu_type() == CPU_74K)
 			alias_74k_erratum(c);
 		if ((read_c0_config7() & (1 << 16))) {
 			/* effectively physically indexed dcache,
@@ -1078,7 +1079,7 @@ static void probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
 	}
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_20KC:
 		/*
 		 * Some older 20Kc chips doesn't have the 'VI' bit in
@@ -1207,7 +1208,7 @@ static void setup_scache(void)
 	 * processors don't have a S-cache that would be relevant to the
 	 * Linux memory management.
 	 */
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_R4000SC:
 	case CPU_R4000MC:
 	case CPU_R4400SC:
@@ -1384,9 +1385,8 @@ static void r4k_cache_error_setup(void)
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
index 2f26835..16edf0a 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 
 #include <asm/cache.h>
+#include <asm/cpu-type.h>
 #include <asm/io.h>
 
 #include <dma-coherence.h>
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 218c210..cbd81d1 100644
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
index 5d01392..35de7c7 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -71,7 +71,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	unsigned int tmp;
 
 	/* Check the bypass bit (L2B) */
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 00b26a6..bb3a5f64 100644
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
index 556cb48..69cfbaa 100644
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
index 5e54247..4d1736f 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -12,6 +12,7 @@
 #include <linux/oprofile.h>
 #include <linux/smp.h>
 #include <asm/cpu-info.h>
+#include <asm/cpu-type.h>
 
 #include "op_impl.h"
 
