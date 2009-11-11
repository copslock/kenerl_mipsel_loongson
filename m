Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 08:10:50 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:58653 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492369AbZKKHK0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 08:10:26 +0100
Received: by pzk32 with SMTP id 32so599025pzk.21
        for <multiple recipients>; Tue, 10 Nov 2009 23:10:18 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=PTXJteJKX6aJOGzkRXjc6hM1pdRDOpPiGegMG7E6MAQ=;
        b=XbulU7ESLPy7e7C39YoTfIBgEMSoNJ9aBldtLswJYYNIdjZXZgvnh/ydCcERFpFnVu
         M4KbSslKTM/wIA+4pOkzzpKiWwsOcDqpyI0/35t0X4Z7uNuq9rh167BrjhATGQBN0LRb
         e2bLOSODfhqFCFQDsAz3udU7YgBVxK6okSHkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ho28pomS1f3PRA/5AJ4+A8XEpJ+LtY6i2Q+Xxf4EBdl7+aT6wZD5900+iNLPO5q4ky
         EdPeuihA5OrGWeAjLEOERW0UKcpaBqZ8VVq9faWt1YFiD+rOio/WCZT51Pr8PJf/hXgT
         n8C8WF5JAIrOgcg8MFyA/7QSE2XQl/YONonJk=
Received: by 10.115.101.1 with SMTP id d1mr2496080wam.40.1257923418141;
        Tue, 10 Nov 2009 23:10:18 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm830254pzk.7.2009.11.10.23.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 23:10:17 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>, yanh@lemote.com,
	huhb@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 1/3] [loongson] lemote-2f: add cs5536 MFGPT timer support
Date:	Wed, 11 Nov 2009 15:09:57 +0800
Message-Id: <de82733902e9549883b840f082a67b9edaa32c45.1257923011.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257923011.git.wuzhangjin@gmail.com>
References: <cover.1257923011.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257923011.git.wuzhangjin@gmail.com>
References: <cover.1257923011.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

When Oprofile is used, it's better not to use the MIPS Timer, but use an
external timer, in Lemote loongson2f family machines, there is a cs5536
mfgpt timer, this patch add support for it.

And also, this external timer is also needed by the next Cpufreq support,
'Cause the frequency of the MIPS Timer is half of the cpu frequency, if
we use it with Cpufreq support, the sytem time will become not accuracy.

And we export the mfgpt0 counter disable/enable operations for the
coming suspend support to suspend/resume the timer.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../asm/mach-loongson/cs5536/cs5536_mfgpt.h        |   35 +++
 arch/mips/loongson/Kconfig                         |   11 +-
 arch/mips/loongson/common/cs5536/Makefile          |    5 +
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c    |  217 ++++++++++++++++++++
 arch/mips/loongson/common/time.c                   |    3 +
 5 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c

diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
new file mode 100644
index 0000000..8d45945
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
@@ -0,0 +1,35 @@
+/*
+ * cs5536 mfgpt header file
+ */
+
+#ifndef _CS5536_MFGPT_H
+#define _CS5536_MFGPT_H
+
+#include <cs5536/cs5536.h>
+#include <cs5536/cs5536_pci.h>
+
+#ifdef CONFIG_CS5536_MFGPT
+extern void setup_mfgpt_timer(void);
+extern void disable_mfgpt0_counter(void);
+extern void enable_mfgpt0_counter(void);
+#else
+static inline void __maybe_unused setup_mfgpt0_timer(void)
+{
+}
+static inline void __maybe_unused disable_mfgpt0_counter(void)
+{
+}
+static inline void __maybe_unused enable_mfgpt0_counter(void)
+{
+}
+#endif
+
+#define MFGPT_TICK_RATE 14318000
+#define COMPARE  ((MFGPT_TICK_RATE + HZ/2) / HZ)
+
+#define MFGPT_BASE	mfgpt_base
+#define MFGPT0_CMP2	(MFGPT_BASE + 2)
+#define MFGPT0_CNT	(MFGPT_BASE + 4)
+#define MFGPT0_SETUP	(MFGPT_BASE + 6)
+
+#endif /*!_CS5536_MFGPT_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 029360f..648c47d 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -34,10 +34,10 @@ config LEMOTE_MACH2F
 	select ARCH_SPARSEMEM_ENABLE
 	select BOARD_SCACHE
 	select BOOT_ELF32
-	select CEVT_R4K
+	select CEVT_R4K if !CS5536_MFGPT
 	select CPU_HAS_WB
 	select CS5536
-	select CSRC_R4K
+	select CSRC_R4K if !CS5536_MFGPT
 	select DMA_NONCOHERENT
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
@@ -62,6 +62,13 @@ endchoice
 config CS5536
 	bool
 
+config CS5536_MFGPT
+	bool "Using cs5536's MFGPT as system clock"
+	depends on CS5536
+	help
+	  This is needed when cpufreq or oprofile is enabled in Lemote Loongson2F
+	  family machines
+
 config LOONGSON_SUSPEND
 	bool
 	default y
diff --git a/arch/mips/loongson/common/cs5536/Makefile b/arch/mips/loongson/common/cs5536/Makefile
index 31657ee..510d4cd 100644
--- a/arch/mips/loongson/common/cs5536/Makefile
+++ b/arch/mips/loongson/common/cs5536/Makefile
@@ -5,4 +5,9 @@
 obj-$(CONFIG_CS5536) += cs5536_pci.o cs5536_ide.o cs5536_acc.o cs5536_ohci.o \
 			cs5536_isa.o cs5536_ehci.o
 
+#
+# Enable cs5536 mfgpt Timer
+#
+obj-$(CONFIG_CS5536_MFGPT) += cs5536_mfgpt.o
+
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
new file mode 100644
index 0000000..2c963c7
--- /dev/null
+++ b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
@@ -0,0 +1,217 @@
+/*
+ * CS5536 General timer functions
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Yanhua, yanh@lemote.com
+ *
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu zhangjin, wuzj@lemote.com
+ *
+ * Reference: AMD Geode(TM) CS5536 Companion Device Data Book
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+
+#include <asm/time.h>
+
+#include <cs5536/cs5536_mfgpt.h>
+
+DEFINE_SPINLOCK(mfgpt_lock);
+EXPORT_SYMBOL(mfgpt_lock);
+
+static u32 mfgpt_base;
+
+/*
+ * Initialize the MFGPT timer.
+ *
+ * This is also called after resume to bring the MFGPT into operation again.
+ */
+
+/* disable counter */
+void disable_mfgpt0_counter(void)
+{
+	outw(inw(MFGPT0_SETUP) & 0x7fff, MFGPT0_SETUP);
+}
+EXPORT_SYMBOL(disable_mfgpt0_counter);
+
+/* enable counter, comparator2 to event mode, 14.318MHz clock */
+void enable_mfgpt0_counter(void)
+{
+	outw(0xe310, MFGPT0_SETUP);
+}
+EXPORT_SYMBOL(enable_mfgpt0_counter);
+
+static void init_mfgpt_timer(enum clock_event_mode mode,
+			     struct clock_event_device *evt)
+{
+	spin_lock(&mfgpt_lock);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		outw(COMPARE, MFGPT0_CMP2);	/* set comparator2 */
+		outw(0, MFGPT0_CNT);	/* set counter to 0 */
+		enable_mfgpt0_counter();
+		break;
+
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
+		    evt->mode == CLOCK_EVT_MODE_ONESHOT)
+			disable_mfgpt0_counter();
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* The oneshot mode have very high deviation, Not use it! */
+		break;
+
+	case CLOCK_EVT_MODE_RESUME:
+		/* Nothing to do here */
+		break;
+	}
+	spin_unlock(&mfgpt_lock);
+}
+
+static struct clock_event_device mfgpt_clockevent = {
+	.name = "mfgpt",
+	.features = CLOCK_EVT_FEAT_PERIODIC,
+	.set_mode = init_mfgpt_timer,
+	.irq = CS5536_MFGPT_INTR,
+};
+
+static irqreturn_t timer_interrupt(int irq, void *dev_id)
+{
+	u32 basehi;
+
+	/*
+	 * get MFGPT base address
+	 *
+	 * NOTE: do not remove me, it's need for the value of mfgpt_base is
+	 * variable
+	 */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &basehi, &mfgpt_base);
+
+	/* ack */
+	outw(inw(MFGPT0_SETUP) | 0x4000, MFGPT0_SETUP);
+
+	mfgpt_clockevent.event_handler(&mfgpt_clockevent);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction irq5 = {
+	.handler = timer_interrupt,
+	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
+	.name = "timer"
+};
+
+/*
+ * Initialize the conversion factor and the min/max deltas of the clock event
+ * structure and register the clock event source with the framework.
+ */
+void __init setup_mfgpt_timer(void)
+{
+	u32 basehi;
+	struct clock_event_device *cd = &mfgpt_clockevent;
+	unsigned int cpu = smp_processor_id();
+
+	cd->cpumask = cpumask_of(cpu);
+	clockevent_set_clock(cd, MFGPT_TICK_RATE);
+	cd->max_delta_ns = clockevent_delta2ns(0xffff, cd);
+	cd->min_delta_ns = clockevent_delta2ns(0xf, cd);
+
+	/* Enable MFGPT0 Comparator 2 Output to the Interrupt Mapper */
+	_wrmsr(DIVIL_MSR_REG(MFGPT_IRQ), 0, 0x100);
+
+	/* Enable Interrupt Gate 5 */
+	_wrmsr(DIVIL_MSR_REG(PIC_ZSEL_LOW), 0, 0x50000);
+
+	/* get MFGPT base address */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &basehi, &mfgpt_base);
+
+	clockevents_register_device(cd);
+
+	setup_irq(CS5536_MFGPT_INTR, &irq5);
+}
+
+/*
+ * Since the MFGPT overflows every tick, its not very useful
+ * to just read by itself. So use jiffies to emulate a free
+ * running counter:
+ */
+static cycle_t mfgpt_read(struct clocksource *cs)
+{
+	unsigned long flags;
+	int count;
+	u32 jifs;
+	static int old_count;
+	static u32 old_jifs;
+
+	spin_lock_irqsave(&mfgpt_lock, flags);
+	/*
+	 * Although our caller may have the read side of xtime_lock,
+	 * this is now a seqlock, and we are cheating in this routine
+	 * by having side effects on state that we cannot undo if
+	 * there is a collision on the seqlock and our caller has to
+	 * retry.  (Namely, old_jifs and old_count.)  So we must treat
+	 * jiffies as volatile despite the lock.  We read jiffies
+	 * before latching the timer count to guarantee that although
+	 * the jiffies value might be older than the count (that is,
+	 * the counter may underflow between the last point where
+	 * jiffies was incremented and the point where we latch the
+	 * count), it cannot be newer.
+	 */
+	jifs = jiffies;
+	/* read the count */
+	count = inw(MFGPT0_CNT);
+
+	/*
+	 * It's possible for count to appear to go the wrong way for this
+	 * reason:
+	 *
+	 *  The timer counter underflows, but we haven't handled the resulting
+	 *  interrupt and incremented jiffies yet.
+	 *
+	 * Previous attempts to handle these cases intelligently were buggy, so
+	 * we just do the simple thing now.
+	 */
+	if (count < old_count && jifs == old_jifs)
+		count = old_count;
+
+	old_count = count;
+	old_jifs = jifs;
+
+	spin_unlock_irqrestore(&mfgpt_lock, flags);
+
+	return (cycle_t) (jifs * COMPARE) + count;
+}
+
+static struct clocksource clocksource_mfgpt = {
+	.name = "mfgpt",
+	.rating = 120, /* Functional for real use, but not desired */
+	.read = mfgpt_read,
+	.mask = CLOCKSOURCE_MASK(32),
+	.mult = 0,
+	.shift = 22,
+};
+
+int __init init_mfgpt_clocksource(void)
+{
+	if (num_possible_cpus() > 1)	/* MFGPT does not scale! */
+		return 0;
+
+	clocksource_mfgpt.mult = clocksource_hz2mult(MFGPT_TICK_RATE, 22);
+	return clocksource_register(&clocksource_mfgpt);
+}
+
+arch_initcall(init_mfgpt_clocksource);
diff --git a/arch/mips/loongson/common/time.c b/arch/mips/loongson/common/time.c
index 6e08c82..c871b2e 100644
--- a/arch/mips/loongson/common/time.c
+++ b/arch/mips/loongson/common/time.c
@@ -14,11 +14,14 @@
 #include <asm/time.h>
 
 #include <loongson.h>
+#include <cs5536/cs5536_mfgpt.h>
 
 void __init plat_time_init(void)
 {
 	/* setup mips r4k timer */
 	mips_hpt_frequency = cpu_clock_freq / 2;
+
+	setup_mfgpt_timer();
 }
 
 void read_persistent_clock(struct timespec *ts)
-- 
1.6.2.1
