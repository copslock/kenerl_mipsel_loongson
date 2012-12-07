Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 05:51:18 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60243 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816191Ab2LGEvQoY68l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 05:51:16 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgpu2-0007Jn-HG; Thu, 06 Dec 2012 22:51:10 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: Add new GIC clocksource.
Date:   Thu,  6 Dec 2012 22:51:04 -0600
Message-Id: <1354855864-28226-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35204
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

Add new clocksource that uses the counter present on the MIPS
Global Interrupt Controller.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/Kconfig                |    4 ++
 arch/mips/include/asm/gic.h      |    1 +
 arch/mips/include/asm/time.h     |    2 +-
 arch/mips/kernel/Makefile        |    1 +
 arch/mips/kernel/csrc-gic.c      |   49 ++++++++++++++++++++++
 arch/mips/mti-malta/malta-time.c |   83 +++++++++++++++++++++++---------------
 6 files changed, 106 insertions(+), 34 deletions(-)
 create mode 100644 arch/mips/kernel/csrc-gic.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 40cb646..99c3ad7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -293,6 +293,7 @@ config MIPS_MALTA
 	select BOOT_RAW
 	select CEVT_R4K
 	select CSRC_R4K
+	select CSRC_GIC
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
 	select HAVE_PCSPKR_PLATFORM
@@ -949,6 +950,9 @@ config CSRC_POWERTV
 config CSRC_R4K
 	bool
 
+config CSRC_GIC
+	bool
+
 config CSRC_SB1250
 	bool
 
diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 37620db..bbddd25 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -359,6 +359,7 @@ struct gic_shared_intr_map {
 /* Mapped interrupt to pin X, then GIC will generate the vector (X+1). */
 #define GIC_PIN_TO_VEC_OFFSET	(1)
 
+extern int gic_present;
 extern unsigned long _gic_base;
 extern unsigned int gic_irq_base;
 extern unsigned int gic_irq_flags[];
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 6be93a4..d0e3cb5 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -77,7 +77,7 @@ extern int init_r4k_clocksource(void);
 
 static inline int init_mips_clocksource(void)
 {
-#ifdef CONFIG_CSRC_R4K
+#if defined(CONFIG_CSRC_R4K) && !defined(CONFIG_CSRC_GIC)
 	return init_r4k_clocksource();
 #else
 	return 0;
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index e4260b6..99dc7f9 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_CSRC_IOASIC)	+= csrc-ioasic.o
 obj-$(CONFIG_CSRC_POWERTV)	+= csrc-powertv.o
 obj-$(CONFIG_CSRC_R4K)		+= csrc-r4k.o
 obj-$(CONFIG_CSRC_SB1250)	+= csrc-sb1250.o
+obj-$(CONFIG_CSRC_GIC)		+= csrc-gic.o
 obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
diff --git a/arch/mips/kernel/csrc-gic.c b/arch/mips/kernel/csrc-gic.c
new file mode 100644
index 0000000..5dca24b
--- /dev/null
+++ b/arch/mips/kernel/csrc-gic.c
@@ -0,0 +1,49 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
+ */
+#include <linux/clocksource.h>
+#include <linux/init.h>
+
+#include <asm/time.h>
+#include <asm/gic.h>
+
+static cycle_t gic_hpt_read(struct clocksource *cs)
+{
+	unsigned int hi, hi2, lo;
+
+	do {
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_63_32), hi);
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_31_00), lo);
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_63_32), hi2);
+	} while (hi2 != hi);
+
+	return (((cycle_t) hi) << 32) + lo;
+}
+
+static struct clocksource gic_clocksource = {
+	.name	= "GIC",
+	.read	= gic_hpt_read,
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+void __init gic_clocksource_init(unsigned int frequency)
+{
+	unsigned int config, bits;
+
+	/* Calculate the clocksource mask. */
+	GICREAD(GIC_REG(SHARED, GIC_SH_CONFIG), config);
+	bits = 32 + ((config & GIC_SH_CONFIG_COUNTBITS_MSK) >>
+		(GIC_SH_CONFIG_COUNTBITS_SHF - 2));
+
+	/* Set clocksource mask. */
+	gic_clocksource.mask = CLOCKSOURCE_MASK(bits);
+
+	/* Calculate a somewhat reasonable rating value. */
+	gic_clocksource.rating = 200 + frequency / 10000000;
+
+	clocksource_register_hz(&gic_clocksource, frequency);
+}
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 115f5bc..a144b89 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -17,7 +17,6 @@
  *
  * Setting up the clock on the MIPS boards.
  */
-
 #include <linux/types.h>
 #include <linux/i8253.h>
 #include <linux/init.h>
@@ -25,7 +24,6 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/mc146818rtc.h>
 
@@ -34,11 +32,11 @@
 #include <asm/hardirq.h>
 #include <asm/irq.h>
 #include <asm/div64.h>
-#include <asm/cpu.h>
 #include <asm/setup.h>
 #include <asm/time.h>
 #include <asm/mc146818-time.h>
 #include <asm/msc01_ic.h>
+#include <asm/gic.h>
 
 #include <asm/mips-boards/generic.h>
 #include <asm/mips-boards/prom.h>
@@ -46,6 +44,7 @@
 #include <asm/mips-boards/maltaint.h>
 
 unsigned long cpu_khz;
+int gic_frequency;
 
 static int mips_cpu_timer_irq;
 static int mips_cpu_perf_irq;
@@ -61,44 +60,50 @@ static void mips_perf_dispatch(void)
 	do_IRQ(mips_cpu_perf_irq);
 }
 
+static unsigned int freqround(unsigned int freq, unsigned int amount)
+{
+	freq += amount;
+	freq -= freq % (amount*2);
+	return freq;
+}
+
 /*
- * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
+ * Estimate CPU and GIC frequencies.
  */
-static unsigned int __init estimate_cpu_frequency(void)
+static void __init estimate_frequencies(void)
 {
-	unsigned int prid = read_c0_prid() & 0xffff00;
-	unsigned int count;
-
 	unsigned long flags;
-	unsigned int start;
+	unsigned int count, start;
+	unsigned int giccount = 0, gicstart = 0;
 
 	local_irq_save(flags);
 
-	/* Start counter exactly on falling edge of update flag */
+	/* Start counter exactly on falling edge of update flag. */
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
 
-	/* Start r4k counter. */
+	/* Initialize counters. */
 	start = read_c0_count();
+	if (gic_present)
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_31_00), gicstart);
 
-	/* Read counter exactly on falling edge of update flag */
+	/* Read counter exactly on falling edge of update flag. */
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
 	while (!(CMOS_READ(RTC_REG_A) & RTC_UIP));
 
-	count = read_c0_count() - start;
+	count = read_c0_count();
+	if (gic_present)
+		GICREAD(GIC_REG(SHARED, GIC_SH_COUNTER_31_00), giccount);
 
-	/* restore interrupts */
 	local_irq_restore(flags);
 
-	mips_hpt_frequency = count;
-	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
-	    (prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
-		count *= 2;
-
-	count += 5000;    /* round */
-	count -= count%10000;
+	count -= start;
+	if (gic_present)
+		giccount -= gicstart;
 
-	return count;
+	mips_hpt_frequency = count;
+	if (gic_present)
+		gic_frequency = giccount;
 }
 
 void read_persistent_clock(struct timespec *ts)
@@ -144,22 +149,34 @@ unsigned int __cpuinit get_c0_compare_int(void)
 
 void __init plat_time_init(void)
 {
-	unsigned int est_freq;
-
-        /* Set Data mode - binary. */
-        CMOS_WRITE(CMOS_READ(RTC_CONTROL) | RTC_DM_BINARY, RTC_CONTROL);
-
-	est_freq = estimate_cpu_frequency();
+	unsigned int prid = read_c0_prid() & 0xffff00;
+	unsigned int freq;
 
-	printk("CPU frequency %d.%02d MHz\n", est_freq/1000000,
-	       (est_freq%1000000)*100/1000000);
+	estimate_frequencies();
 
-        cpu_khz = est_freq / 1000;
+	freq = mips_hpt_frequency;
+	if ((prid != (PRID_COMP_MIPS | PRID_IMP_20KC)) &&
+	    (prid != (PRID_COMP_MIPS | PRID_IMP_25KF)))
+		freq *= 2;
+	freq = freqround(freq, 5000);
+	pr_debug("CPU frequency %d.%02d MHz\n", freq/1000000,
+	       (freq%1000000)*100/1000000);
+	cpu_khz = freq / 1000;
+
+	if (gic_present) {
+		freq = freqround(gic_frequency, 5000);
+		pr_debug("GIC frequency %d.%02d MHz\n", freq/1000000,
+		       (freq%1000000)*100/1000000);
+		gic_clocksource_init(gic_frequency);
+	} else
+		init_r4k_clocksource();
 
-	mips_scroll_message();
-#ifdef CONFIG_I8253		/* Only Malta has a PIT */
+#ifdef CONFIG_I8253
+	/* Only Malta has a PIT. */
 	setup_pit_timer();
 #endif
 
+	mips_scroll_message();
+
 	plat_perf_setup();
 }
-- 
1.7.9.5
