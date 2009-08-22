Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Aug 2009 18:11:07 +0200 (CEST)
Received: from mail-fx0-f220.google.com ([209.85.220.220]:41544 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493203AbZHVQKN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Aug 2009 18:10:13 +0200
Received: by fxm20 with SMTP id 20so1096675fxm.0
        for <multiple recipients>; Sat, 22 Aug 2009 09:10:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/zAOceF2CpoUiKgYKFCSg1sbjW3FS0pXuv3sYKxonqM=;
        b=p2Abu4z5xAWuLRyDxD2am2U8qyGMPv49l31qCGbWCDyg9hkekekoo/D7+6PNutetlg
         63gvUUZCoKtqi5nIjeFYtH2Qd1zEAIVpMQLyT4JLz/PQRHdHfjh1QZqJ4JkoldO/RJYg
         +ZWbb4vKsgI4SKOHJDpjfzGE9HPss1l0GU5D4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ht8KXbL5jlUWEKFpLvNKlPZdMKzi6o7kVxKRSNeRSwzMCZWA0AyrdeCy0l4myYqg5p
         rCczVsPRPGPBGXuIZ/a+/esX8zKfOGmXdDLTmQ4BAEbVbp1+8rPn/Audz4gCutQW0WIP
         NodOSsRRyh7nIhK6KzgLdHUJr8SkXMnIr+Zng=
Received: by 10.223.161.205 with SMTP id s13mr1598628fax.27.1250957407643;
        Sat, 22 Aug 2009 09:10:07 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id f31sm4121507fkf.38.2009.08.22.09.10.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 Aug 2009 09:10:07 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/2] Alchemy: timer: support multiple SYS_BASE addresses
Date:	Sat, 22 Aug 2009 18:10:01 +0200
Message-Id: <1250957401-14447-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1250957401-14447-2-git-send-email-manuel.lauss@gmail.com>
References: <1250957401-14447-1-git-send-email-manuel.lauss@gmail.com>
 <1250957401-14447-2-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

The Au1300 has SYS_BASE moved to another bus which has the base address
of all timer-related bits changed.  Add support for runtime detection
of proper timer base address and irq.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/time.c            |  137 ++++++++++++++++++++--------
 arch/mips/alchemy/devboards/pm.c           |   58 +++++++-----
 arch/mips/include/asm/mach-au1x00/au1000.h |   32 +++++--
 3 files changed, 157 insertions(+), 70 deletions(-)

diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 9fc0d44..5ae771e 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -43,28 +43,47 @@
 /* 32kHz clock enabled and detected */
 #define CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
 
+struct alchemy_clocksource {
+	struct clocksource cs;
+	void __iomem *sys_base;
+};
+
+struct alchemy_clkevdev {
+	struct clock_event_device cd;
+	void __iomem *sys_base;
+};
+
 static cycle_t au1x_counter1_read(struct clocksource *cs)
 {
-	return au_readl(SYS_RTCREAD);
+	struct alchemy_clocksource *acs =
+		container_of(cs, struct alchemy_clocksource, cs);
+
+	return __raw_readl(acs->sys_base + SYS_RTCREAD_OFS);
 }
 
-static struct clocksource au1x_counter1_clocksource = {
-	.name		= "alchemy-counter1",
-	.read		= au1x_counter1_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-	.rating		= 100,
+static struct alchemy_clocksource au1x_counter1_clocksource = {
+	.cs = {
+		.name		= "alchemy-counter1",
+		.read		= au1x_counter1_read,
+		.mask		= CLOCKSOURCE_MASK(32),
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+		.rating		= 100,
+	},
 };
 
 static int au1x_rtcmatch2_set_next_event(unsigned long delta,
-					 struct clock_event_device *cd)
+					 struct clock_event_device *ced)
 {
-	delta += au_readl(SYS_RTCREAD);
+	struct alchemy_clkevdev *aced =
+		container_of(ced, struct alchemy_clkevdev, cd);
+	void __iomem *b = aced->sys_base;
+
+	delta += __raw_readl(b + SYS_RTCREAD_OFS);
 	/* wait for register access */
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M21)
+	while (__raw_readl(b + SYS_COUNTER_CNTRL_OFS) & SYS_CNTRL_M21)
 		;
-	au_writel(delta, SYS_RTCMATCH2);
-	au_sync();
+	__raw_writel(delta, b + SYS_RTCMATCH2_OFS);
+	mmiowb();
 
 	return 0;
 }
@@ -81,28 +100,33 @@ static irqreturn_t au1x_rtcmatch2_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct clock_event_device au1x_rtcmatch2_clockdev = {
-	.name		= "rtcmatch2",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
-	.rating		= 100,
-	.irq		= AU1000_RTC_MATCH2_INT,
-	.set_next_event	= au1x_rtcmatch2_set_next_event,
-	.set_mode	= au1x_rtcmatch2_set_mode,
-	.cpumask	= CPU_MASK_ALL_PTR,
+
+static struct alchemy_clkevdev au1x_rtcmatch2_clockdev = {
+	.cd = {
+		.name		= "rtcmatch2",
+		.features	= CLOCK_EVT_FEAT_ONESHOT,
+		.rating		= 100,
+		.set_next_event	= au1x_rtcmatch2_set_next_event,
+		.set_mode	= au1x_rtcmatch2_set_mode,
+		.cpumask	= CPU_MASK_ALL_PTR,
+	},
 };
 
 static struct irqaction au1x_rtcmatch2_irqaction = {
 	.handler	= au1x_rtcmatch2_irq,
 	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.name		= "timer",
-	.dev_id		= &au1x_rtcmatch2_clockdev,
+	.dev_id		= &au1x_rtcmatch2_clockdev.cd,
 };
 
-void __init plat_time_init(void)
+static int __init alchemy_time_init(void __iomem *sys_base, int cntr_irq)
 {
-	struct clock_event_device *cd = &au1x_rtcmatch2_clockdev;
+	struct clock_event_device *cd = &au1x_rtcmatch2_clockdev.cd;
 	unsigned long t;
 
+	au1x_counter1_clocksource.sys_base = sys_base;
+	au1x_rtcmatch2_clockdev.sys_base = sys_base;
+
 	/* Check if firmware (YAMON, ...) has enabled 32kHz and clock
 	 * has been detected.  If so install the rtcmatch2 clocksource,
 	 * otherwise don't bother.  Note that both bits being set is by
@@ -110,51 +134,55 @@ void __init plat_time_init(void)
 	 * (the 32S bit seems to be stuck set to 1 once a single clock-
 	 * edge is detected, hence the timeouts).
 	 */
-	if (CNTR_OK != (au_readl(SYS_COUNTER_CNTRL) & CNTR_OK))
-		goto cntr_err;
+	if (CNTR_OK != (__raw_readl(sys_base + SYS_COUNTER_CNTRL_OFS) & CNTR_OK))
+		return -ENODEV;
 
 	/*
 	 * setup counter 1 (RTC) to tick at full speed
 	 */
 	t = 0xffffff;
-	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S) && --t)
+	while ((__raw_readl(sys_base + SYS_COUNTER_CNTRL_OFS) & SYS_CNTRL_T1S) && --t)
 		asm volatile ("nop");
 	if (!t)
-		goto cntr_err;
+		return -ENODEV;
 
-	au_writel(0, SYS_RTCTRIM);	/* 32.768 kHz */
-	au_sync();
+	__raw_writel(0, sys_base + SYS_RTCTRIM_OFS);	/* 32.768 kHz */
+	mmiowb();
 
 	t = 0xffffff;
-	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && --t)
+	while ((__raw_readl(sys_base + SYS_COUNTER_CNTRL_OFS) & SYS_CNTRL_C1S) && --t)
 		asm volatile ("nop");
 	if (!t)
-		goto cntr_err;
-	au_writel(0, SYS_RTCWRITE);
-	au_sync();
+		return -ENODEV;
+
+	__raw_writel(0, sys_base + SYS_RTCWRITE_OFS);
+	mmiowb();
 
 	t = 0xffffff;
-	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && --t)
+	while ((__raw_readl(sys_base + SYS_COUNTER_CNTRL_OFS) & SYS_CNTRL_C1S) && --t)
 		asm volatile ("nop");
 	if (!t)
-		goto cntr_err;
+		return -ENODEV;
 
 	/* register counter1 clocksource and event device */
-	clocksource_set_clock(&au1x_counter1_clocksource, 32768);
-	clocksource_register(&au1x_counter1_clocksource);
+	clocksource_set_clock(&au1x_counter1_clocksource.cs, 32768);
+	clocksource_register(&au1x_counter1_clocksource.cs);
 
+	cd->irq = cntr_irq;
 	cd->shift = 32;
 	cd->mult = div_sc(32768, NSEC_PER_SEC, cd->shift);
 	cd->max_delta_ns = clockevent_delta2ns(0xffffffff, cd);
 	cd->min_delta_ns = clockevent_delta2ns(8, cd);	/* ~0.25ms */
 	clockevents_register_device(cd);
-	setup_irq(AU1000_RTC_MATCH2_INT, &au1x_rtcmatch2_irqaction);
+	setup_irq(cntr_irq, &au1x_rtcmatch2_irqaction);
 
 	printk(KERN_INFO "Alchemy clocksource installed\n");
 
-	return;
+	return 0;
+}
 
-cntr_err:
+static void alchemy_use_c0_cntr(void)
+{
 	/* MIPS kernel assigns 'au1k_wait' to 'cpu_wait' before this
 	 * function is called.  Because the Alchemy counters are unusable
 	 * the C0 timekeeping code is installed and use of the 'wait'
@@ -165,3 +193,32 @@ cntr_err:
 	r4k_clockevent_init();
 	init_r4k_clocksource();
 }
+
+void __init plat_time_init(void)
+{
+	void __iomem *io = NULL;
+	int irq, ret;
+
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1100:
+	case ALCHEMY_CPU_AU1550:
+	case ALCHEMY_CPU_AU1200:
+		io = (void __iomem *)KSEG1ADDR(SYS_PHYS_ADDR);
+		irq = AU1000_RTC_MATCH2_INT;
+		break;
+/*	case ALCHEMY_CPU_AU1300:
+		io = (void __iomem *)KSEG1ADDR(AU1300_SYS_PHYS_ADDR);
+		irq = AU1300_RTC_MATCH2_INT;
+		break;
+*/
+	default:
+		goto c0cntr;
+	}
+
+	ret = alchemy_time_init(io, irq);
+	if (ret)
+c0cntr:
+		alchemy_use_c0_cntr();
+}
diff --git a/arch/mips/alchemy/devboards/pm.c b/arch/mips/alchemy/devboards/pm.c
index 632f986..06b4bfb 100644
--- a/arch/mips/alchemy/devboards/pm.c
+++ b/arch/mips/alchemy/devboards/pm.c
@@ -23,6 +23,7 @@
 static unsigned long db1x_pm_sleep_secs;
 static unsigned long db1x_pm_wakemsk;
 static unsigned long db1x_pm_last_wakesrc;
+static void __iomem *sys_base;
 
 static int db1x_pm_enter(suspend_state_t state)
 {
@@ -30,23 +31,24 @@ static int db1x_pm_enter(suspend_state_t state)
 	alchemy_gpio1_input_enable();
 
 	/* clear and setup wake cause and source */
-	au_writel(0, SYS_WAKEMSK);
-	au_sync();
-	au_writel(0, SYS_WAKESRC);
-	au_sync();
+	__raw_writel(0, sys_base + SYS_WAKEMSK_OFS);
+	mmiowb();
+	__raw_writel(0, sys_base + SYS_WAKESRC_OFS);
+	mmiowb();
 
-	au_writel(db1x_pm_wakemsk, SYS_WAKEMSK);
-	au_sync();
+	__raw_writel(db1x_pm_wakemsk, sys_base + SYS_WAKEMSK_OFS);
+	mmiowb();
 
 	/* setup 1Hz-timer-based wakeup: wait for reg access */
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20)
+	while (__raw_readl(sys_base + SYS_COUNTER_CNTRL_OFS) & SYS_CNTRL_M20)
 		asm volatile ("nop");
 
-	au_writel(au_readl(SYS_TOYREAD) + db1x_pm_sleep_secs, SYS_TOYMATCH2);
-	au_sync();
+	__raw_writel(__raw_readl(sys_base + SYS_TOYREAD_OFS) + db1x_pm_sleep_secs,
+			sys_base + SYS_TOYMATCH2_OFS);
+	mmiowb();
 
 	/* wait for value to really hit the register */
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20)
+	while (__raw_readl(sys_base + SYS_COUNTER_CNTRL_OFS) & SYS_CNTRL_M20)
 		asm volatile ("nop");
 
 	/* ...and now the sandman can come! */
@@ -70,12 +72,12 @@ static void db1x_pm_end(void)
 	/* read and store wakeup source, the clear the register. To
 	 * be able to clear it, WAKEMSK must be cleared first.
 	 */
-	db1x_pm_last_wakesrc = au_readl(SYS_WAKESRC);
-
-	au_writel(0, SYS_WAKEMSK);
-	au_writel(0, SYS_WAKESRC);
-	au_sync();
+	db1x_pm_last_wakesrc = __raw_readl(sys_base + SYS_WAKESRC_OFS);
 
+	__raw_writel(0, sys_base + SYS_WAKEMSK_OFS);
+	mmiowb();
+	__raw_writel(0, sys_base + SYS_WAKESRC_OFS);
+	mmiowb();
 }
 
 static struct platform_suspend_ops db1x_pm_ops = {
@@ -206,21 +208,31 @@ static struct attribute_group db1x_pmattr_group = {
  */
 static int __init pm_init(void)
 {
+	switch (alchemy_get_cputype()) {
+	case ALCHEMY_CPU_AU1000:
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1100:
+	case ALCHEMY_CPU_AU1550:
+	case ALCHEMY_CPU_AU1200:
+		sys_base = (void __iomem *)KSEG1ADDR(SYS_PHYS_ADDR);
+		break;
+	}
+
 	/* init TOY to tick at 1Hz if not already done. No need to wait
 	 * for confirmation since there's plenty of time from here to
 	 * the next suspend cycle.
 	 */
-	if (au_readl(SYS_TOYTRIM) != 32767) {
-		au_writel(32767, SYS_TOYTRIM);
-		au_sync();
+	if (__raw_readl(sys_base + SYS_TOYTRIM_OFS) != 32767) {
+		__raw_writel(32767, sys_base + SYS_TOYTRIM_OFS);
+		mmiowb();
 	}
 
-	db1x_pm_last_wakesrc = au_readl(SYS_WAKESRC);
+	db1x_pm_last_wakesrc = __raw_readl(sys_base + SYS_WAKESRC_OFS);
 
-	au_writel(0, SYS_WAKESRC);
-	au_sync();
-	au_writel(0, SYS_WAKEMSK);
-	au_sync();
+	__raw_writel(0, sys_base + SYS_WAKEMSK_OFS);
+	mmiowb();
+	__raw_writel(0, sys_base + SYS_WAKESRC_OFS);
+	mmiowb();
 
 	suspend_set_ops(&db1x_pm_ops);
 
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 85713f8..6aa0bab 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1020,7 +1020,8 @@ enum soc_au1200_ints {
 
 /* Programmable Counters 0 and 1 */
 #define SYS_BASE		0xB1900000
-#define SYS_COUNTER_CNTRL	(SYS_BASE + 0x14)
+#define SYS_COUNTER_CNTRL_OFS	0x14
+#define SYS_COUNTER_CNTRL	(SYS_BASE + SYS_COUNTER_CNTRL_OFS)
 #  define SYS_CNTRL_E1S 	(1 << 23)
 #  define SYS_CNTRL_T1S 	(1 << 20)
 #  define SYS_CNTRL_M21 	(1 << 19)
@@ -1049,13 +1050,20 @@ enum soc_au1200_ints {
 #define SYS_TOYMATCH2		(SYS_BASE + 0x10)
 #define SYS_TOYREAD		(SYS_BASE + 0x40)
 
+#define SYS_TOYTRIM_OFS		0
+#define SYS_TOYWRITE_OFS	4
+#define SYS_TOYMATCH0_OFS	8
+#define SYS_TOYMATCH1_OFS	0xC
+#define SYS_TOYMATCH2_OFS	0x10
+#define SYS_TOYREAD_OFS		0x40
+
 /* Programmable Counter 1 Registers */
-#define SYS_RTCTRIM		(SYS_BASE + 0x44)
-#define SYS_RTCWRITE		(SYS_BASE + 0x48)
-#define SYS_RTCMATCH0		(SYS_BASE + 0x4C)
-#define SYS_RTCMATCH1		(SYS_BASE + 0x50)
-#define SYS_RTCMATCH2		(SYS_BASE + 0x54)
-#define SYS_RTCREAD		(SYS_BASE + 0x58)
+#define SYS_RTCTRIM_OFS		0x44
+#define SYS_RTCWRITE_OFS	0x48
+#define SYS_RTCMATCH0_OFS	0x4C
+#define SYS_RTCMATCH1_OFS	0x50
+#define SYS_RTCMATCH2_OFS	0x54
+#define SYS_RTCREAD_OFS		0x58
 
 /* I2S Controller */
 #define I2S_DATA		0xB1000000
@@ -1594,6 +1602,16 @@ enum soc_au1200_ints {
 #define SYS_SLPPWR		0xB1900078
 #define SYS_SLEEP		0xB190007C
 
+#define SYS_SCRATCH0_OFS	0x18
+#define SYS_SCRATCH1_OFS	0x1C
+#define SYS_WAKEMSK_OFS		0x34
+#define SYS_ENDIAN_OFS		0x38
+#define SYS_POWERCTRL_OFS	0x3C
+#define SYS_WAKESRC_OFS		0x5C
+#define SYS_SLPPWR_OFS		0x78
+#define SYS_SLEEP_OFS		0x7C
+
+
 #define SYS_WAKEMSK_D2		(1 << 9)
 #define SYS_WAKEMSK_M2		(1 << 8)
 #define SYS_WAKEMSK_GPIO(x)	(1 << (x))
-- 
1.6.4
