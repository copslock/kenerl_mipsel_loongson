Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 17:58:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53083 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835031Ab3F0P6WY441N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Jun 2013 17:58:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5RFwHoh020253;
        Thu, 27 Jun 2013 17:58:17 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5RFwGTu020252;
        Thu, 27 Jun 2013 17:58:16 +0200
Date:   Thu, 27 Jun 2013 17:58:16 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Reduce code size for MIPS32R2 platforms.
Message-ID: <20130627155816.GF10727@linux-mips.org>
References: <1354857289-28828-1-git-send-email-sjhill@mips.com>
 <20121207150946.GA27226@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121207150946.GA27226@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37179
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

On Fri, Dec 07, 2012 at 04:09:46PM +0100, Ralf Baechle wrote:

It's a while already - but I haven't forgotten about this little optimization.

> On Thu, Dec 06, 2012 at 11:14:49PM -0600, Steven J. Hill wrote:
> 
> > From: "Steven J. Hill" <sjhill@mips.com>
> > 
> > If the CPU type is selected to be a MIPS32R2 core, we surround
> > some code with #ifdef's to reduce the kernel binary size.
> > 
> > Signed-off-by: Steven J. Hill <sjhill@mips.com>
> 
> Yes, and a dozen more ifdefs would be needed to handle other places
> where things could be optimized for a particular CPU type.  Best add
> more random ifdefs across the tree to handle MIPS32R1 and MIPS64R2 and
> of course Zumbitsu 8000 processors.
> 
> Below is a half-baked test version of a patch that I have in my git tree
> since you first posted your patch.  For a Cavium kernel this shaves off
> around 6kB.
> 
> Obviously this patch relies on a halfway modern compiler's optimization
> capabilities.

A more elegant version of the previous patch which no longer requires a
per platform implementation of current_cpu_type() results in the following
size reductions for cavium_octeon_defconfig:

   text    data     bss     dec     hex filename
5716440  513760  176944 6407144  61c3e8 vmlinux
5714712  513760  176944 6405416  61bd28 vmlinux

That's not a whole lot because cavium_octeon_defconfig still builds a
kernel with support for 3 different processors.

Using a quick hack (not in below patch) I reduced CPU support to just a
single type.  Then not only code for the other 2 variants is dropped by
the compiler but also dead code elimination can discard ifs and switches
leaving a highly customized, smaller and faster kernel.  The best of it
is that it doesn't even rely on LTO, just a decent optimizer of a per-file
compiler.  Patch for your enjoyment below.

I've done my testing with plain old boring gcc 4.7 btw.

  Ralf

 arch/mips/cavium-octeon/csrc-octeon.c              |   1 +
 arch/mips/include/asm/cpu-features.h               |   4 -
 arch/mips/include/asm/cpu-type.h                   | 196 +++++++++++++++++++++
 .../include/asm/mach-ip22/cpu-feature-overrides.h  |  25 ---
 .../include/asm/mach-ip27/cpu-feature-overrides.h  |  19 --
 .../include/asm/mach-ip28/cpu-feature-overrides.h  |  18 --
 arch/mips/kernel/cpu-probe.c                       |   3 +-
 arch/mips/kernel/idle.c                            |   3 +-
 arch/mips/kernel/time.c                            |   1 +
 arch/mips/kernel/traps.c                           |   3 +-
 arch/mips/mm/c-octeon.c                            |   6 +-
 arch/mips/mm/c-r4k.c                               |  12 +-
 arch/mips/mm/dma-default.c                         |   1 +
 arch/mips/mm/page.c                                |   1 +
 arch/mips/mm/sc-mips.c                             |   2 +-
 arch/mips/mm/tlb-r4k.c                             |   1 +
 arch/mips/mm/tlbex.c                               |   1 +
 17 files changed, 219 insertions(+), 78 deletions(-)

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
index e5ec8fc..26dd4e9 100644
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
index 0000000..4809b24
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
+	case CPU_PR4450
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
+	case CPU_M14KEC
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
diff --git a/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
index 9fd2b50..1bcb642 100644
--- a/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip22/cpu-feature-overrides.h
@@ -10,31 +10,6 @@
 
 #include <asm/cpu.h>
 
-#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 5)
-#define __current_cpu_type_unreachable() __builtin_unreachable()
-#else
-#define __current_cpu_type_unreachable() do { } while (0)
-#endif
-
-#define current_cpu_type()						\
-({									\
-	int __cpu = current_cpu_data.cputype;				\
-	switch (__cpu) {						\
-	case CPU_R4000PC:						\
-	case CPU_R4000SC:						\
-	case CPU_R4400PC:						\
-	case CPU_R4400SC:						\
-	case CPU_R4600:							\
-	case CPU_R5000:							\
-		break;							\
-	default:							\
-		__current_cpu_type_unreachable();			\
-		;							\
-	}								\
-	__cpu;								\
-})
-
-
 /*
  * IP22 with a variety of processors so we can't use defaults for everything.
  */
diff --git a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
index 8884ba4..d6111aa 100644
--- a/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h
@@ -10,25 +10,6 @@
 
 #include <asm/cpu.h>
 
-#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 5)
-#define __current_cpu_type_unreachable() __builtin_unreachable()
-#else
-#define __current_cpu_type_unreachable() do { } while (0)
-#endif
-
-#define current_cpu_type()						\
-({									\
-	int __cpu = current_cpu_data.cputype;				\
-	switch (__cpu) {						\
-	case CPU_R10000:						\
-	case CPU_R12000:						\
-		break;							\
-	default:							\
-		__current_cpu_type_unreachable();			\
-	}								\
-	__cpu;								\
-})
-
 /*
  * IP27 only comes with R10000 family processors all using the same config
  */
diff --git a/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
index c81c5d2..4cec06d 100644
--- a/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ip28/cpu-feature-overrides.h
@@ -11,24 +11,6 @@
 
 #include <asm/cpu.h>
 
-#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 5)
-#define __current_cpu_type_unreachable() __builtin_unreachable()
-#else
-#define __current_cpu_type_unreachable() do { } while (0)
-#endif
-
-#define current_cpu_type()						\
-({									\
-	int __cpu = current_cpu_data.cputype;				\
-	switch (__cpu) {						\
-	case CPU_R10000:						\
-		break;							\
-	default:							\
-		__current_cpu_type_unreachable();			\
-	}								\
-	__cpu;								\
-})
-
 /*
  * IP28 only comes with R10000 family processors all using the same config
  */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c6568bf..a1daa84 100644
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
index beba1e6..cc5ac82 100644
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
index 21813be..57d7975 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -809,7 +809,7 @@ static void __cpuinit probe_pcache(void)
 	unsigned long config1;
 	unsigned int lsize;
 
-	switch (c->cputype) {
+	switch (currnt_cpu_type()) {
 	case CPU_R4600:			/* QED style two way caches? */
 	case CPU_R4700:
 	case CPU_R5000:
@@ -1045,7 +1045,7 @@ static void __cpuinit probe_pcache(void)
 	 * normally they'd suffer from aliases but magic in the hardware deals
 	 * with that for us so we don't need to take care ourselves.
 	 */
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_20KC:
 	case CPU_25KF:
 	case CPU_SB1:
@@ -1065,7 +1065,7 @@ static void __cpuinit probe_pcache(void)
 	case CPU_34K:
 	case CPU_74K:
 	case CPU_1004K:
-		if (c->cputype == CPU_74K)
+		if (current_cpu_type() == CPU_74K)
 			alias_74k_erratum(c);
 		if ((read_c0_config7() & (1 << 16))) {
 			/* effectively physically indexed dcache,
@@ -1078,7 +1078,7 @@ static void __cpuinit probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
 	}
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_20KC:
 		/*
 		 * Some older 20Kc chips doesn't have the 'VI' bit in
@@ -1207,7 +1207,7 @@ static void __cpuinit setup_scache(void)
 	 * processors don't have a S-cache that would be relevant to the
 	 * Linux memory management.
 	 */
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_R4000SC:
 	case CPU_R4000MC:
 	case CPU_R4400SC:
@@ -1386,7 +1386,7 @@ static void __cpuinit r4k_cache_error_setup(void)
 	extern char __weak except_vec2_sb1;
 	struct cpuinfo_mips *c = &current_cpu_data;
 
-	switch (c->cputype) {
+	switch (current_cpu_type()) {
 	case CPU_SB1:
 	case CPU_SB1A:
 		set_uncached_handler(0x100, &except_vec2_sb1, 0x80);
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index caf92ec..0f45890 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 
 #include <asm/cache.h>
+#include <asm/cpu-type.h>
 #include <asm/io.h>
 
 #include <dma-coherence.h>
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 4eb8dcf..819bec8 100644
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
index df96da7..cceaaaf 100644
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
index afeef93..767e297 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -30,6 +30,7 @@
 #include <linux/cache.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cpu-type.h>
 #include <asm/pgtable.h>
 #include <asm/war.h>
 #include <asm/uasm.h>
