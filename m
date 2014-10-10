Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 05:41:35 +0200 (CEST)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:40102 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010261AbaJJDkhjfn0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 05:40:37 +0200
Received: by mail-pa0-f48.google.com with SMTP id eu11so897719pac.7
        for <multiple recipients>; Thu, 09 Oct 2014 20:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VC4NJGf1vgP7i+lrJ+uR4D5bhMszNJ1+HtFlfyGzUfM=;
        b=MnPQJzm7841X5FGQY+0hDB8swNKydvRctCsBK8bqpQCkGQVLyzQV83LESpTeXMUI/u
         EXBQ8bm1ZsqqqEo9Re/6z08EsF06W+fsCnOF0tsQt62I7LEpFUGMC4HGwUhqafr2bpRC
         jKNmE+N2Z7zdUtReSg3c5tYvqyohTmIrrIZpszrclFGKN5a6vX1+VP3zSR28RI1ZwNhG
         dXGNUDiUt/OmSWkKQMdHmlfvyQXsWPSZSJDDfZ4Y4kzMps1aC3TwMJFpYv1KxAh6TPAG
         /wvpRFF8VoQkPSP5E2mWuFl6PdepfnFRZl6GqP26QLj0nLHef+oGvX+lAc7zDRd3kwIR
         WI2Q==
X-Received: by 10.68.197.65 with SMTP id is1mr2165820pbc.125.1412912431571;
        Thu, 09 Oct 2014 20:40:31 -0700 (PDT)
Received: from localhost.localdomain ([171.213.62.98])
        by mx.google.com with ESMTPSA id sa6sm1563051pbb.29.2014.10.09.20.40.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Oct 2014 20:40:30 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 4/6] MIPS: Loongson1B: Add a clockevent/clocksource using PWM Timer
Date:   Fri, 10 Oct 2014 11:40:02 +0800
Message-Id: <1412912402-6002-5-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412912402-6002-1-git-send-email-keguang.zhang@gmail.com>
References: <1412912402-6002-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

This patch add a clockevent/clocksource using PWM Timer for Loongson1B,
which is based on earlier work by Tang, Haifeng.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/loongson1/Kconfig         |  41 ++++++-
 arch/mips/loongson1/common/Makefile |   2 +-
 arch/mips/loongson1/common/clock.c  |  28 -----
 arch/mips/loongson1/common/time.c   | 226 ++++++++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+), 31 deletions(-)
 delete mode 100644 arch/mips/loongson1/common/clock.c
 create mode 100644 arch/mips/loongson1/common/time.c

diff --git a/arch/mips/loongson1/Kconfig b/arch/mips/loongson1/Kconfig
index 4ed9744..a2b796e 100644
--- a/arch/mips/loongson1/Kconfig
+++ b/arch/mips/loongson1/Kconfig
@@ -5,8 +5,8 @@ choice
 
 config LOONGSON1_LS1B
 	bool "Loongson LS1B board"
-	select CEVT_R4K
-	select CSRC_R4K
+	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
+	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
 	select SYS_HAS_CPU_LOONGSON1B
 	select DMA_NONCOHERENT
 	select BOOT_ELF32
@@ -21,4 +21,41 @@ config LOONGSON1_LS1B
 
 endchoice
 
+menuconfig CEVT_CSRC_LS1X
+	bool "Use PWM Timer for clockevent/clocksource"
+	select MIPS_EXTERNAL_TIMER
+	depends on CPU_LOONGSON1
+	help
+	  This option changes the default clockevent/clocksource to PWM Timer,
+	  and is required by Loongson1 CPUFreq support.
+
+	  If unsure, say N.
+
+choice
+	prompt  "Select clockevent/clocksource"
+	depends on CEVT_CSRC_LS1X
+	default TIMER_USE_PWM0
+
+config TIMER_USE_PWM0
+	bool "Use PWM Timer 0"
+	help
+	  Use PWM Timer 0 as the default clockevent/clocksourcer.
+
+config TIMER_USE_PWM1
+	bool "Use PWM Timer 1"
+	help
+	  Use PWM Timer 1 as the default clockevent/clocksourcer.
+
+config TIMER_USE_PWM2
+	bool "Use PWM Timer 2"
+	help
+	  Use PWM Timer 2 as the default clockevent/clocksourcer.
+
+config TIMER_USE_PWM3
+	bool "Use PWM Timer 3"
+	help
+	  Use PWM Timer 3 as the default clockevent/clocksourcer.
+
+endchoice
+
 endif # MACH_LOONGSON1
diff --git a/arch/mips/loongson1/common/Makefile b/arch/mips/loongson1/common/Makefile
index b279770..723b4ce 100644
--- a/arch/mips/loongson1/common/Makefile
+++ b/arch/mips/loongson1/common/Makefile
@@ -2,4 +2,4 @@
 # Makefile for common code of loongson1 based machines.
 #
 
-obj-y	+= clock.o irq.o platform.o prom.o reset.o setup.o
+obj-y	+= time.o irq.o platform.o prom.o reset.o setup.o
diff --git a/arch/mips/loongson1/common/clock.c b/arch/mips/loongson1/common/clock.c
deleted file mode 100644
index b4437f1..0000000
--- a/arch/mips/loongson1/common/clock.c
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This program is free software; you can redistribute	it and/or modify it
- * under  the terms of	the GNU General	 Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <asm/time.h>
-#include <platform.h>
-
-void __init plat_time_init(void)
-{
-	struct clk *clk;
-
-	/* Initialize LS1X clocks */
-	ls1x_clk_init();
-
-	/* setup mips r4k timer */
-	clk = clk_get(NULL, "cpu");
-	if (IS_ERR(clk))
-		panic("unable to get cpu clock, err=%ld", PTR_ERR(clk));
-
-	mips_hpt_frequency = clk_get_rate(clk) / 2;
-}
diff --git a/arch/mips/loongson1/common/time.c b/arch/mips/loongson1/common/time.c
new file mode 100644
index 0000000..df0f850
--- /dev/null
+++ b/arch/mips/loongson1/common/time.c
@@ -0,0 +1,226 @@
+/*
+ * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <asm/time.h>
+
+#include <loongson1.h>
+#include <platform.h>
+
+#ifdef CONFIG_CEVT_CSRC_LS1X
+
+#if defined(CONFIG_TIMER_USE_PWM1)
+#define LS1X_TIMER_BASE	LS1X_PWM1_BASE
+#define LS1X_TIMER_IRQ	LS1X_PWM1_IRQ
+
+#elif defined(CONFIG_TIMER_USE_PWM2)
+#define LS1X_TIMER_BASE	LS1X_PWM2_BASE
+#define LS1X_TIMER_IRQ	LS1X_PWM2_IRQ
+
+#elif defined(CONFIG_TIMER_USE_PWM3)
+#define LS1X_TIMER_BASE	LS1X_PWM3_BASE
+#define LS1X_TIMER_IRQ	LS1X_PWM3_IRQ
+
+#else
+#define LS1X_TIMER_BASE	LS1X_PWM0_BASE
+#define LS1X_TIMER_IRQ	LS1X_PWM0_IRQ
+#endif
+
+DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
+
+static void __iomem *timer_base;
+static uint32_t ls1x_jiffies_per_tick;
+
+static inline void ls1x_pwmtimer_set_period(uint32_t period)
+{
+	__raw_writel(period, timer_base + PWM_HRC);
+	__raw_writel(period, timer_base + PWM_LRC);
+}
+
+static inline void ls1x_pwmtimer_restart(void)
+{
+	__raw_writel(0x0, timer_base + PWM_CNT);
+	__raw_writel(INT_EN | CNT_EN, timer_base + PWM_CTRL);
+}
+
+void __init ls1x_pwmtimer_init(void)
+{
+	timer_base = ioremap(LS1X_TIMER_BASE, 0xf);
+	if (!timer_base)
+		panic("Failed to remap timer registers");
+
+	ls1x_jiffies_per_tick = DIV_ROUND_CLOSEST(mips_hpt_frequency, HZ);
+
+	ls1x_pwmtimer_set_period(ls1x_jiffies_per_tick);
+	ls1x_pwmtimer_restart();
+}
+
+static cycle_t ls1x_clocksource_read(struct clocksource *cs)
+{
+	unsigned long flags;
+	int count;
+	u32 jifs;
+	static int old_count;
+	static u32 old_jifs;
+
+	raw_spin_lock_irqsave(&ls1x_timer_lock, flags);
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
+	count = __raw_readl(timer_base + PWM_CNT);
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
+	raw_spin_unlock_irqrestore(&ls1x_timer_lock, flags);
+
+	return (cycle_t) (jifs * ls1x_jiffies_per_tick) + count;
+}
+
+static struct clocksource ls1x_clocksource = {
+	.name		= "ls1x-pwmtimer",
+	.read		= ls1x_clocksource_read,
+	.mask		= CLOCKSOURCE_MASK(24),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static irqreturn_t ls1x_clockevent_isr(int irq, void *devid)
+{
+	struct clock_event_device *cd = devid;
+
+	ls1x_pwmtimer_restart();
+	cd->event_handler(cd);
+
+	return IRQ_HANDLED;
+}
+
+static void ls1x_clockevent_set_mode(enum clock_event_mode mode,
+				     struct clock_event_device *cd)
+{
+	raw_spin_lock(&ls1x_timer_lock);
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		ls1x_pwmtimer_set_period(ls1x_jiffies_per_tick);
+		ls1x_pwmtimer_restart();
+	case CLOCK_EVT_MODE_RESUME:
+		__raw_writel(INT_EN | CNT_EN, timer_base + PWM_CTRL);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		__raw_writel(__raw_readl(timer_base + PWM_CTRL) & ~CNT_EN,
+			     timer_base + PWM_CTRL);
+		break;
+	default:
+		break;
+	}
+	raw_spin_unlock(&ls1x_timer_lock);
+}
+
+static int ls1x_clockevent_set_next(unsigned long evt,
+				    struct clock_event_device *cd)
+{
+	raw_spin_lock(&ls1x_timer_lock);
+	ls1x_pwmtimer_set_period(evt);
+	ls1x_pwmtimer_restart();
+	raw_spin_unlock(&ls1x_timer_lock);
+
+	return 0;
+}
+
+static struct clock_event_device ls1x_clockevent = {
+	.name		= "ls1x-pwmtimer",
+	.features	= CLOCK_EVT_FEAT_PERIODIC,
+	.rating		= 300,
+	.irq		= LS1X_TIMER_IRQ,
+	.set_next_event	= ls1x_clockevent_set_next,
+	.set_mode	= ls1x_clockevent_set_mode,
+};
+
+static struct irqaction ls1x_pwmtimer_irqaction = {
+	.name		= "ls1x-pwmtimer",
+	.handler	= ls1x_clockevent_isr,
+	.dev_id		= &ls1x_clockevent,
+	.flags		= IRQF_PERCPU | IRQF_TIMER,
+};
+
+static void __init ls1x_time_init(void)
+{
+	struct clock_event_device *cd = &ls1x_clockevent;
+	int ret;
+
+	if (!mips_hpt_frequency)
+		panic("Invalid timer clock rate");
+
+	ls1x_pwmtimer_init();
+
+	clockevent_set_clock(cd, mips_hpt_frequency);
+	cd->max_delta_ns = clockevent_delta2ns(0xffffff, cd);
+	cd->min_delta_ns = clockevent_delta2ns(0x000300, cd);
+	cd->cpumask = cpumask_of(smp_processor_id());
+	clockevents_register_device(cd);
+
+	ls1x_clocksource.rating = 200 + mips_hpt_frequency / 10000000;
+	ret = clocksource_register_hz(&ls1x_clocksource, mips_hpt_frequency);
+	if (ret)
+		panic(KERN_ERR "Failed to register clocksource: %d\n", ret);
+
+	setup_irq(LS1X_TIMER_IRQ, &ls1x_pwmtimer_irqaction);
+}
+#endif /* CONFIG_CEVT_CSRC_LS1X */
+
+void __init plat_time_init(void)
+{
+	struct clk *clk = NULL;
+
+	/* initialize LS1X clocks */
+	ls1x_clk_init();
+
+#ifdef CONFIG_CEVT_CSRC_LS1X
+	/* setup LS1X PWM timer */
+	clk = clk_get(NULL, "ls1x_pwmtimer");
+	if (IS_ERR(clk))
+		panic("unable to get timer clock, err=%ld", PTR_ERR(clk));
+
+	mips_hpt_frequency = clk_get_rate(clk);
+	ls1x_time_init();
+#else
+	/* setup mips r4k timer */
+	clk = clk_get(NULL, "cpu_clk");
+	if (IS_ERR(clk))
+		panic("unable to get cpu clock, err=%ld", PTR_ERR(clk));
+
+	mips_hpt_frequency = clk_get_rate(clk) / 2;
+#endif /* CONFIG_CEVT_CSRC_LS1X */
+}
-- 
1.9.1
