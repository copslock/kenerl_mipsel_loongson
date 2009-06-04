Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:12:05 +0100 (WEST)
Received: from mail-px0-f186.google.com ([209.85.216.186]:49590 "EHLO
	mail-px0-f186.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022629AbZFDNKk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:10:40 +0100
Received: by mail-px0-f186.google.com with SMTP id 16so751437pxi.22
        for <multiple recipients>; Thu, 04 Jun 2009 06:10:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4uDzX5y7x+mNa1AJ8aiI/k7paul8DwI0DVnefhMFrXc=;
        b=gl9MUuoo6fAwJt4N4tPFMkTiE5J4Vv1fpk9dV4w0wn1ESNEVNhh2iwG0N333X8S1ve
         66jHj4QNvk5O9axp4t98LyjRGQihgOhw50vvyhZletzwGW17bTzpFNeUFdumFaso47y2
         ViGfGbv0md6PYrUH3+d2ZDXe+J0/BQpxYz0fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uSn9u3GTFeFydnFA8uiytO+rcywmEgPn5JoTvACyKVH3Hu9Dh7OtLYyLheli6uXzsP
         HdgIXjA9oBckuYpoIxIQxtcmy+tS1nxgnXMwImXBUcwlVlsZZsVtp3LN1PFrZ1WMMSrP
         sUS+tBXVKCX2kQyTugdudRNng1UWX/26PWWNo=
Received: by 10.114.211.17 with SMTP id j17mr3381387wag.225.1244121038681;
        Thu, 04 Jun 2009 06:10:38 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id l30sm2507405waf.35.2009.06.04.06.10.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 06:10:37 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [loongson-PATCH-v3 22/25] CS5536 MFGPT as system clock source support
Date:	Thu,  4 Jun 2009 21:10:25 +0800
Message-Id: <a21e962e33fb56a6ca51d70b311363fe6cb6053f.1244120575.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120575.git.wuzj@lemote.com>
References: <cover.1244120575.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

The cpu count timer should not be used if oprofile and cpufreq are
enabled. Instead, the CS5536's mfgpt is a proper timer alternative.

Reviewed-by: John Stultz <johnstul@us.ibm.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Yan Hua <yanh@lemote.com>
---
 .../asm/mach-loongson/cs5536/cs5536_mfgpt.h        |   26 ++
 arch/mips/loongson/Kconfig                         |   15 +-
 arch/mips/loongson/common/cs5536/Makefile          |    5 +
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c    |  257 ++++++++++++++++++++
 arch/mips/loongson/common/time.c                   |    7 +
 5 files changed, 306 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
 create mode 100644 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c

diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
new file mode 100644
index 0000000..92808ce
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
@@ -0,0 +1,26 @@
+/*
+ * cs5536 mfgpt header file
+ */
+
+#ifndef _CS5536_MFGPT_H
+#define _CS5536_MFGPT_H
+
+#include <cs5536/cs5536.h>
+
+extern void setup_mfgpt_timer(void);
+
+#if 1
+#define MFGPT_TICK_RATE 14318000
+#else
+#define MFGPT_TICK_RATE (14318180 / 8)
+#endif
+#define COMPARE  ((MFGPT_TICK_RATE + HZ/2) / HZ)
+
+#define	CS5536_MFGPT_INTR	5
+
+#define MFGPT_BASE	mfgpt_base
+#define MFGPT0_CMP2	(MFGPT_BASE + 2)
+#define MFGPT0_CNT	(MFGPT_BASE + 4)
+#define MFGPT0_SETUP	(MFGPT_BASE + 6)
+
+#endif /*!_CS5536_MFGPT_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 3d582cb..c2ff73a 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -32,8 +32,8 @@ config LEMOTE_FULOONG2E
 config LEMOTE_FULOONG2F
 	bool "Lemote Fuloong(2f) mini-PC"
 	select ARCH_SPARSEMEM_ENABLE
-	select CEVT_R4K
-	select CSRC_R4K
+	select CEVT_R4K if !CS5536_MFGPT
+	select CSRC_R4K if !CS5536_MFGPT
 	select SYS_HAS_CPU_LOONGSON2F
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
@@ -62,8 +62,8 @@ config LEMOTE_FULOONG2F
 config LEMOTE_YEELOONG2F
 	bool "Lemote Yeeloong(2f) mini Notebook"
 	select ARCH_SPARSEMEM_ENABLE
-	select CEVT_R4K
-	select CSRC_R4K
+	select CEVT_R4K if !CS5536_MFGPT
+	select CSRC_R4K if !CS5536_MFGPT
 	select SYS_HAS_CPU_LOONGSON2F
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
@@ -115,6 +115,13 @@ config CS5536_UDC
 config SYS_HAS_MACH_PROM_INIT_CMDLINE
 	bool
 
+config CS5536_MFGPT
+	bool "Using cs5536's MFGPT as system clock"
+	depends on CS5536
+	help
+	  This is needed if cpufreq and oprofile is enabled in Loongson2(F)
+	  machines
+
 config UCA_SIZE
 	hex "Uncache Accelerated Region size"
 	depends on CPU_LOONGSON2F
diff --git a/arch/mips/loongson/common/cs5536/Makefile b/arch/mips/loongson/common/cs5536/Makefile
index 09bc177..6fd6dd0 100644
--- a/arch/mips/loongson/common/cs5536/Makefile
+++ b/arch/mips/loongson/common/cs5536/Makefile
@@ -17,4 +17,9 @@ obj-$(CONFIG_CS5536_NOR_FLASH) += cs5536_flash.o
 obj-$(CONFIG_CS5536_OTG) += cs5536_otg.o
 obj-$(CONFIG_CS5536_UDC) += cs5536_udc.o
 
+#
+# Enable cs5536 mfgpt Timer
+#
+obj-$(CONFIG_CS5536_MFGPT) += cs5536_mfgpt.o
+
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
new file mode 100644
index 0000000..1192844
--- /dev/null
+++ b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
@@ -0,0 +1,257 @@
+/*
+ * CS5536 General timer functions
+ *
+ * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
+ * Author: Yanhua, yanh@lemote.com
+ *
+ * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Author: Wu zhangjin, wuzj@lemote.com
+ *
+ * Reference: 'AMD Geode(TM) CS5536 Companion Device Data Book'
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
+/* setup register bit fields:
+ * 15: counter enable
+ * 14: compare2 output status, write 1 to clear when in event mode
+ * 13: compare1 output status
+ * 12: setup(ro)
+ * 11: stop enable, stop on sleep
+ * 10: external enable
+ * 9:8 compare2 mode; 00: disable, 01: compare on equal; 10: compare on GE,
+ * 	11 event: GE + irq
+ * 7:6 compare1 mode
+ * 5:  reverse enable, bit reverse of the counter
+ * 4:  clock select. 0: 32KHz, 1: 14.318MHz
+ * 3:0 counter prescaler scale factor.
+ * 	select the input clock divide-by value. 2^n
+ * bit 11:0 is write once
+ */
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
+		/* enable counter, comparator2 to event mode, 14.318MHz clock */
+		outw(0xe310, MFGPT0_SETUP);
+		break;
+
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+		if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
+		    evt->mode == CLOCK_EVT_MODE_ONESHOT) {
+			/* disable counter */
+			outw(inw(MFGPT0_SETUP) & 0x7fff, MFGPT0_SETUP);
+		}
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* One shot setup */
+		outw(0xe300, MFGPT0_SETUP);
+		break;
+
+	case CLOCK_EVT_MODE_RESUME:
+		/* Nothing to do here */
+		break;
+	}
+	spin_unlock(&mfgpt_lock);
+}
+
+/*
+ * Program the next event in oneshot mode
+ *
+ * Delta is given in MFGPT ticks
+ */
+static int mfgpt_next_event(unsigned long delta, struct clock_event_device *evt)
+{
+	spin_lock(&mfgpt_lock);
+	outw(delta & 0xffff, MFGPT0_CMP2);	/* set comparator2 */
+	outw(0, MFGPT0_CNT);	/* set counter to 0 */
+	spin_unlock(&mfgpt_lock);
+
+	return 0;
+}
+
+static struct clock_event_device mfgpt_clockevent = {
+	.name = "mfgpt",
+	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_MODE_ONESHOT,
+	.set_mode = init_mfgpt_timer,
+	.set_next_event = mfgpt_next_event,
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
+	_rdmsr(CS5536_DIVIL_MSR_BASE + DIVIL_LBAR_MFGPT, &basehi, &mfgpt_base);
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
+	.flags = IRQF_DISABLED | IRQF_NOBALANCING,
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
+	_wrmsr(CS5536_DIVIL_MSR_BASE + MFGPT_IRQ, 0, 0x100);
+
+	/* Enable Interrupt Gate 5 */
+	_wrmsr(CS5536_DIVIL_MSR_BASE + PIC_ZSEL_LOW, 0, 0x50000);
+
+	/* get MFGPT base address */
+	_rdmsr(CS5536_DIVIL_MSR_BASE + DIVIL_LBAR_MFGPT, &basehi, &mfgpt_base);
+
+	irq5.mask = cpumask_of_cpu(cpu);
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
+	/* latch the counter */
+	outw(inw(MFGPT0_SETUP) | 0x0200, MFGPT0_SETUP);
+	/* read the latched count */
+	count = inw(MFGPT0_CNT);
+	/* restart the counter */
+	outw(inw(MFGPT0_SETUP) & 0xfdff, MFGPT0_SETUP);
+
+	/* reset the latch if count > max + 1 */
+	if (count > COMPARE) {
+		/* set comparator2 */
+		outw(COMPARE, MFGPT0_CMP2);
+		/* set counter to 0 */
+		outw(0, MFGPT0_CNT);
+		/* enable counter, comparator2 to event mode, 14.318MHz clock */
+		outw(0xe310, MFGPT0_SETUP);
+
+		count = COMPARE - 1;
+	}
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
+	if (count > old_count && jifs == old_jifs)
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
index 231f0c2..deec242 100644
--- a/arch/mips/loongson/common/time.c
+++ b/arch/mips/loongson/common/time.c
@@ -14,6 +14,9 @@
 #include <asm/time.h>
 
 #include <loongson.h>
+#ifdef CONFIG_CS5536_MFGPT
+#include <cs5536/cs5536_mfgpt.h>
+#endif
 
 unsigned long read_persistent_clock(void)
 {
@@ -24,4 +27,8 @@ void __init plat_time_init(void)
 {
 	/* setup mips r4k timer */
 	mips_hpt_frequency = cpu_clock_freq / 2;
+
+#ifdef CONFIG_CS5536_MFGPT
+	setup_mfgpt_timer();
+#endif
 }
-- 
1.6.0.4
