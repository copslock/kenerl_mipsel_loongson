Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 16:09:53 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43649 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824772Ab2LGPJvzSP63 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Dec 2012 16:09:51 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qB7F9m8C027574;
        Fri, 7 Dec 2012 16:09:48 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qB7F9kTD027573;
        Fri, 7 Dec 2012 16:09:46 +0100
Date:   Fri, 7 Dec 2012 16:09:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Reduce code size for MIPS32R2 platforms.
Message-ID: <20121207150946.GA27226@linux-mips.org>
References: <1354857289-28828-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354857289-28828-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Dec 06, 2012 at 11:14:49PM -0600, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> If the CPU type is selected to be a MIPS32R2 core, we surround
> some code with #ifdef's to reduce the kernel binary size.
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

Yes, and a dozen more ifdefs would be needed to handle other places
where things could be optimized for a particular CPU type.  Best add
more random ifdefs across the tree to handle MIPS32R1 and MIPS64R2 and
of course Zumbitsu 8000 processors.

Below is a half-baked test version of a patch that I have in my git tree
since you first posted your patch.  For a Cavium kernel this shaves off
around 6kB.

Obviously this patch relies on a halfway modern compiler's optimization
capabilities.

  Ralf

 arch/mips/cavium-octeon/csrc-octeon.c              |   1 +
 arch/mips/include/asm/cpu-features.h               |   4 -
 arch/mips/include/asm/cpu-type.h                   | 119 +++++++++++++++++++++
 .../include/asm/mach-ip22/cpu-feature-overrides.h  |   2 +
 .../include/asm/mach-ip27/cpu-feature-overrides.h  |   2 +
 .../include/asm/mach-ip28/cpu-feature-overrides.h  |   2 +
 arch/mips/kernel/cpu-probe.c                       |   5 +-
 arch/mips/kernel/time.c                            |   1 +
 arch/mips/kernel/traps.c                           |   1 +
 arch/mips/mm/c-octeon.c                            |   6 +-
 arch/mips/mm/dma-default.c                         |   1 +
 arch/mips/mm/page.c                                |   1 +
 arch/mips/mm/tlb-r4k.c                             |   1 +
 arch/mips/mm/tlbex.c                               |   1 +
 14 files changed, 139 insertions(+), 8 deletions(-)

diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index ce6483a..3bbe8d6 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -12,6 +12,7 @@
 #include <linux/smp.h>
 
 #include <asm/cpu-info.h>
+#include <asm/cpu-type.h>
 #include <asm/time.h>
 
 #include <asm/octeon/octeon.h>
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index ca400f7..33a54c1 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -13,10 +13,6 @@
 #include <asm/cpu-info.h>
 #include <cpu-feature-overrides.h>
 
-#ifndef current_cpu_type
-#define current_cpu_type()      current_cpu_data.cputype
-#endif
-
 /*
  * SMP assumption: Options of CPU 0 are a superset of all processors.
  * This is true for all known MIPS systems.
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
new file mode 100644
index 0000000..0d0afa4
--- /dev/null
+++ b/arch/mips/include/asm/cpu-type.h
@@ -0,0 +1,119 @@
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
+#ifdef CONFIG_SYS_HAS_CPU_LOONGSON2E
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_LOONGSON2F
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_MIPS32_R1
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_MIPS32_R2
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_MIPS64_R1
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_MIPS64_R2
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R3000
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_TX39XX
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_VR41XX
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R4300
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R4X00
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_TX49XX
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R5000
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R5432
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R5500
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R6000
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_NEVADA
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R8000
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_R10000
+	case CPU_R10000:
+	case CPU_R12000:
+#endif
+#ifdef CONFIG_SYS_HAS_CPU_RM7000
+	case CPU_RM7000:
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
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_BMIPS4350
+#endif
+
+#ifdef CONFIG_SYS_HAS_CPU_BMIPS4380
+#endif
+
+#ifdef SYS_HAS_CPU_BMIPS5000
+#endif
+
+#ifdef SYS_HAS_CPU_XLR
+#endif
+
+		break;
+	default:
+		unreachable();
+	}
+
+	return cpu_type;
+}
+
+#endif /* __ASM_CPU_TYPE_H */
diff --git a/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
index 9c87351..7b23f44 100644
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
index 7d3112b..53bcb73 100644
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
index 9a53b32..0fb7cb5 100644
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
index 8ea65c5..1bc2d80 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -20,6 +20,7 @@
 
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/cpu-type.h>
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
 #include <asm/watch.h>
@@ -159,7 +160,7 @@ void __init check_wait(void)
 		return;
 	}
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_R3081:
 	case CPU_R3081E:
 		cpu_wait = r3081_wait;
@@ -252,7 +253,7 @@ static inline void check_errata(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_34K:
 		/*
 		 * Erratum "RPS May Cause Incorrect Instruction Execution"
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 99d73b7..abd127e 100644
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
index 9260986..4c58568 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -37,6 +37,7 @@
 #include <asm/break.h>
 #include <asm/cop2.h>
 #include <asm/cpu.h>
+#include <asm/cpu-type.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 #include <asm/fpu_emulator.h>
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 44e69e7..e774176 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -18,6 +18,7 @@
 #include <asm/bootinfo.h>
 #include <asm/cacheops.h>
 #include <asm/cpu-features.h>
+#include <asm/cpu-type.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/r4kcache.h>
@@ -184,9 +185,10 @@ static void __cpuinit probe_octeon(void)
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
@@ -197,7 +199,7 @@ static void __cpuinit probe_octeon(void)
 			c->icache.sets * c->icache.ways * c->icache.linesz;
 		c->icache.waybit = ffs(icache_size / c->icache.ways) - 1;
 		c->dcache.linesz = 128;
-		if (c->cputype == CPU_CAVIUM_OCTEON_PLUS)
+		if (cputype == CPU_CAVIUM_OCTEON_PLUS)
 			c->dcache.sets = 2; /* CN5XXX has two Dcache sets */
 		else
 			c->dcache.sets = 1; /* CN3XXX has one Dcache set */
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 3fab204..72df1e4 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 
 #include <asm/cache.h>
+#include <asm/cpu-type.h>
 #include <asm/io.h>
 
 #include <dma-coherence.h>
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 98f530e..a37db2f 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -18,6 +18,7 @@
 
 #include <asm/bugs.h>
 #include <asm/cacheops.h>
+#include <asm/cpu-type.h>
 #include <asm/inst.h>
 #include <asm/io.h>
 #include <asm/page.h>
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index d2572cb..ac6a90a 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -15,6 +15,7 @@
 #include <linux/hugetlb.h>
 
 #include <asm/cpu.h>
+#include <asm/cpu-type.h>
 #include <asm/bootinfo.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 03eb0ef..a89e523 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -30,6 +30,7 @@
 #include <linux/cache.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cpu-type.h>
 #include <asm/pgtable.h>
 #include <asm/war.h>
 #include <asm/uasm.h>
