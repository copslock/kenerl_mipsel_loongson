Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:29:48 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:12229 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24139441AbYLUI0b (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:31 +0000
Received: (qmail 3975 invoked from network); 21 Dec 2008 09:24:59 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:59 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 10/14] Alchemy: RTC counter clocksource / clockevent support.
Date:	Sun, 21 Dec 2008 09:26:23 +0100
Message-Id: <cc0520393daa157516ae4f2cc6a69bc7b60a2a39.1229846414.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <45ced0b4c4d707995c92fc9c56bb71e2d383b3f2.1229846414.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
 <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
 <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
 <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net>
 <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
 <ad6889e72585d9fa5bedeb080d6d78d91c9e23c9.1229846414.git.mano@roarinelk.homelinux.net>
 <f701f25036ff0e654e2bad646e0103b32cb83d34.1229846414.git.mano@roarinelk.homelinux.net>
 <45ced0b4c4d707995c92fc9c56bb71e2d383b3f2.1229846414.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Add support for the 32 kHz counter1 (RTC) as clocksource / clockevent
device.  As a nice side effect, this also enables use of the 'wait'
instruction for runtime idle power savings.

If the counters aren't enabled/working properly, fall back on the
cp0 counter clock code.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/Kconfig        |    4 +-
 arch/mips/alchemy/common/power.c |   16 ++-
 arch/mips/alchemy/common/setup.c |    6 -
 arch/mips/alchemy/common/time.c  |  292 ++++++++++++++++----------------------
 arch/mips/kernel/cpu-probe.c     |    6 +-
 5 files changed, 143 insertions(+), 181 deletions(-)

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 4397d94..7f8ef13 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -128,8 +128,8 @@ config SOC_AU1200
 config SOC_AU1X00
 	bool
 	select 64BIT_PHYS_ADDR
-	select CEVT_R4K
-	select CSRC_R4K
+	select CEVT_R4K_LIB
+	select CSRC_R4K_LIB
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index 33a3cdb..997dd56 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -85,7 +85,11 @@ static unsigned int	sleep_static_memctlr[4][3];
 #define SLEEP_TEST_TIMEOUT 1
 #ifdef	SLEEP_TEST_TIMEOUT
 static int sleep_ticks;
-void wakeup_counter0_set(int ticks);
+static void wakeup_counter0_set(int ticks)
+{
+	au_writel(au_readl(SYS_TOYREAD) + ticks, SYS_TOYMATCH2);
+	au_sync();
+}
 #endif
 
 static void save_core_regs(void)
@@ -183,7 +187,6 @@ static void restore_core_regs(void)
 	}
 
 	restore_au1xxx_intctl();
-	wakeup_counter0_adjust();
 }
 
 unsigned long suspend_mode;
@@ -411,6 +414,15 @@ static struct ctl_table pm_dir_table[] = {
  */
 static int __init pm_init(void)
 {
+	/* init TOY to tick at 1Hz. No need to wait for access bits
+	 * since there's plenty of time between here and the first
+	 * suspend cycle.
+	 */
+	if (au_readl(SYS_TOYTRIM) != 32767) {
+		au_writel(32767, SYS_TOYTRIM);
+		au_sync();
+	}
+
 	register_sysctl_table(pm_dir_table);
 	return 0;
 }
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 4d42be8..8ad453a 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -63,12 +63,6 @@ void __init plat_mem_setup(void)
 	ioport_resource.end = IOPORT_RESOURCE_END;
 	iomem_resource.start = IOMEM_RESOURCE_START;
 	iomem_resource.end = IOMEM_RESOURCE_END;
-
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_E0S);
-	au_writel(SYS_CNTRL_E0 | SYS_CNTRL_EN0, SYS_COUNTER_CNTRL);
-	au_sync();
-	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T0S);
-	au_writel(0, SYS_TOYTRIM);
 }
 
 #if defined(CONFIG_64BIT_PHYS_ADDR)
diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 1518570..57f0aec 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -1,5 +1,7 @@
 /*
+ * Copyright (C) 2008 Manuel Lauss <mano@roarinelk.homelinux.net>
  *
+ * Previous incarnations were:
  * Copyright (C) 2001, 2006, 2008 MontaVista Software, <source@mvista.com>
  * Copied and modified Carsten Langgaard's time.c
  *
@@ -23,131 +25,27 @@
  *
  * ########################################################################
  *
- * Setting up the clock on the MIPS boards.
- *
- * We provide the clock interrupt processing and the timer offset compute
- * functions.  If CONFIG_PM is selected, we also ensure the 32KHz timer is
- * available.  -- Dan
+ * Clocksource/event using the 32.768kHz-clocked Counter1 ('RTC' in the
+ * databooks).  Firmware/Board init code must enable the counters in the
+ * counter control register, otherwise the CP0 counter clocksource/event
+ * will be installed instead (and use of 'wait' instruction is prohibited).
  */
 
-#include <linux/types.h>
-#include <linux/init.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
 #include <linux/spinlock.h>
 
-#include <asm/mipsregs.h>
 #include <asm/time.h>
 #include <asm/mach-au1x00/au1000.h>
 
-static int no_au1xxx_32khz;
-extern int allow_au1k_wait; /* default off for CP0 Counter */
+/* 32kHz clock enabled and detected */
+#define CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
 
-#ifdef CONFIG_PM
-#if HZ < 100 || HZ > 1000
-#error "unsupported HZ value! Must be in [100,1000]"
-#endif
-#define MATCH20_INC (328 * 100 / HZ) /* magic number 328 is for HZ=100... */
-static unsigned long last_pc0, last_match20;
-#endif
+extern int allow_au1k_wait; /* default off for CP0 Counter */
 
 static DEFINE_SPINLOCK(time_lock);
 
-unsigned long wtimer;
-
-#ifdef CONFIG_PM
-static irqreturn_t counter0_irq(int irq, void *dev_id)
-{
-	unsigned long pc0;
-	int time_elapsed;
-	static int jiffie_drift;
-
-	if (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20) {
-		/* should never happen! */
-		printk(KERN_WARNING "counter 0 w status error\n");
-		return IRQ_NONE;
-	}
-
-	pc0 = au_readl(SYS_TOYREAD);
-	if (pc0 < last_match20)
-		/* counter overflowed */
-		time_elapsed = (0xffffffff - last_match20) + pc0;
-	else
-		time_elapsed = pc0 - last_match20;
-
-	while (time_elapsed > 0) {
-		do_timer(1);
-#ifndef CONFIG_SMP
-		update_process_times(user_mode(get_irq_regs()));
-#endif
-		time_elapsed -= MATCH20_INC;
-		last_match20 += MATCH20_INC;
-		jiffie_drift++;
-	}
-
-	last_pc0 = pc0;
-	au_writel(last_match20 + MATCH20_INC, SYS_TOYMATCH2);
-	au_sync();
-
-	/*
-	 * Our counter ticks at 10.009765625 ms/tick, we we're running
-	 * almost 10 uS too slow per tick.
-	 */
-
-	if (jiffie_drift >= 999) {
-		jiffie_drift -= 999;
-		do_timer(1); /* increment jiffies by one */
-#ifndef CONFIG_SMP
-		update_process_times(user_mode(get_irq_regs()));
-#endif
-	}
-
-	return IRQ_HANDLED;
-}
-
-struct irqaction counter0_action = {
-	.handler	= counter0_irq,
-	.flags		= IRQF_DISABLED,
-	.name		= "alchemy-toy",
-	.dev_id		= NULL,
-};
-
-/* When we wakeup from sleep, we have to "catch up" on all of the
- * timer ticks we have missed.
- */
-void wakeup_counter0_adjust(void)
-{
-	unsigned long pc0;
-	int time_elapsed;
-
-	pc0 = au_readl(SYS_TOYREAD);
-	if (pc0 < last_match20)
-		/* counter overflowed */
-		time_elapsed = (0xffffffff - last_match20) + pc0;
-	else
-		time_elapsed = pc0 - last_match20;
-
-	while (time_elapsed > 0) {
-		time_elapsed -= MATCH20_INC;
-		last_match20 += MATCH20_INC;
-	}
-
-	last_pc0 = pc0;
-	au_writel(last_match20 + MATCH20_INC, SYS_TOYMATCH2);
-	au_sync();
-
-}
-
-/* This is just for debugging to set the timer for a sleep delay. */
-void wakeup_counter0_set(int ticks)
-{
-	unsigned long pc0;
-
-	pc0 = au_readl(SYS_TOYREAD);
-	last_pc0 = pc0;
-	au_writel(last_match20 + (MATCH20_INC * ticks), SYS_TOYMATCH2);
-	au_sync();
-}
-#endif
-
 /*
  * I haven't found anyone that doesn't use a 12 MHz source clock,
  * but just in case.....
@@ -162,37 +60,15 @@ void wakeup_counter0_set(int ticks)
  * this advertised speed will introduce error and sometimes not work
  * properly.  This function is futher convoluted to still allow configurations
  * to do that in case they have really, really old silicon with a
- * write-only PLL register, that we need the 32 KHz when power management
- * "wait" is enabled, and we need to detect if the 32 KHz isn't present
- * but requested......got it? :-)		-- Dan
+ * write-only PLL register.			-- Dan
  */
 unsigned long calc_clock(void)
 {
 	unsigned long cpu_speed;
 	unsigned long flags;
-	unsigned long counter;
 
 	spin_lock_irqsave(&time_lock, flags);
 
-	/* Power management cares if we don't have a 32 KHz counter. */
-	no_au1xxx_32khz = 0;
-	counter = au_readl(SYS_COUNTER_CNTRL);
-	if (counter & SYS_CNTRL_E0) {
-		int trim_divide = 16;
-
-		au_writel(counter | SYS_CNTRL_EN1, SYS_COUNTER_CNTRL);
-
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S);
-		/* RTC now ticks at 32.768/16 kHz */
-		au_writel(trim_divide - 1, SYS_RTCTRIM);
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S);
-
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S);
-		au_writel(0, SYS_TOYWRITE);
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S);
-	} else
-		no_au1xxx_32khz = 1;
-
 	/*
 	 * On early Au1000, sys_cpupll was write-only. Since these
 	 * silicon versions of Au1000 are not sold by AMD, we don't bend
@@ -215,8 +91,65 @@ unsigned long calc_clock(void)
 	return cpu_speed;
 }
 
+static cycle_t au1x_counter1_read(void)
+{
+	return au_readl(SYS_RTCREAD);
+}
+
+static struct clocksource au1x_counter1_clocksource = {
+	.name		= "alchemy-counter1",
+	.read		= au1x_counter1_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.rating		= 100,
+};
+
+static int au1x_rtcmatch2_set_next_event(unsigned long delta,
+					 struct clock_event_device *cd)
+{
+	delta += au_readl(SYS_RTCREAD);
+	/* wait for register access */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M21)
+		;
+	au_writel(delta, SYS_RTCMATCH2);
+	au_sync();
+
+	return 0;
+}
+
+static void au1x_rtcmatch2_set_mode(enum clock_event_mode mode,
+				    struct clock_event_device *cd)
+{
+}
+
+static irqreturn_t au1x_rtcmatch2_irq(int irq, void *dev_id)
+{
+	struct clock_event_device *cd = dev_id;
+	cd->event_handler(cd);
+	return IRQ_HANDLED;
+}
+
+static struct clock_event_device au1x_rtcmatch2_clockdev = {
+	.name		= "rtcmatch2",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 100,
+	.irq		= AU1000_RTC_MATCH2_INT,
+	.set_next_event	= au1x_rtcmatch2_set_next_event,
+	.set_mode	= au1x_rtcmatch2_set_mode,
+	.cpumask	= CPU_MASK_ALL,
+};
+
+static struct irqaction au1x_rtcmatch2_irqaction = {
+	.handler	= au1x_rtcmatch2_irq,
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.name		= "timer",
+	.dev_id		= &au1x_rtcmatch2_clockdev,
+};
+
 void __init plat_time_init(void)
 {
+	struct clock_event_device *cd = &au1x_rtcmatch2_clockdev;
+	unsigned long t;
 	unsigned int est_freq = calc_clock();
 
 	est_freq += 5000;    /* round */
@@ -225,41 +158,62 @@ void __init plat_time_init(void)
 	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
 	set_au1x00_speed(est_freq);
 
-#ifdef CONFIG_PM
-	/*
-	 * setup counter 0, since it keeps ticking after a
-	 * 'wait' instruction has been executed. The CP0 timer and
-	 * counter 1 do NOT continue running after 'wait'
-	 *
-	 * It's too early to call request_irq() here, so we handle
-	 * counter 0 interrupt as a special irq and it doesn't show
-	 * up under /proc/interrupts.
-	 *
-	 * Check to ensure we really have a 32 KHz oscillator before
-	 * we do this.
+	/* Check if firmware (YAMON, ...) has enabled 32kHz and clock
+	 * has been detected.  If so install the rtcmatch2 clocksource,
+	 * otherwise don't bother.  Note that both bits being set is by
+	 * no means a definite guarantee that the counters actually work
+	 * (the 32S bit seems to be stuck set to 1 once a single clock-
+	 * edge is detected, hence the timeouts).
 	 */
-	if (no_au1xxx_32khz)
-		printk(KERN_WARNING "WARNING: no 32KHz clock found.\n");
-	else {
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S);
-		au_writel(0, SYS_TOYWRITE);
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S);
+	if (CNTR_OK != (au_readl(SYS_COUNTER_CNTRL) & CNTR_OK))
+		goto cntr_err;
 
-		au_writel(au_readl(SYS_WAKEMSK) | (1 << 8), SYS_WAKEMSK);
-		au_writel(~0, SYS_WAKESRC);
-		au_sync();
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
+	/*
+	 * setup counter 1 (RTC) to tick at full speed
+	 */
+	t = 0xffffff;
+	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S) && t--)
+		asm volatile ("nop");
+	if (!t)
+		goto cntr_err;
 
-		/* Setup match20 to interrupt once every HZ */
-		last_pc0 = last_match20 = au_readl(SYS_TOYREAD);
-		au_writel(last_match20 + MATCH20_INC, SYS_TOYMATCH2);
-		au_sync();
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
-		setup_irq(AU1000_TOY_MATCH2_INT, &counter0_action);
+	au_writel(0, SYS_RTCTRIM);	/* 32.768 kHz */
+	au_sync();
 
-		/* We can use the real 'wait' instruction. */
-		allow_au1k_wait = 1;
-	}
+	t = 0xffffff;
+	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && t--)
+		asm volatile ("nop");
+	if (!t)
+		goto cntr_err;
+	au_writel(0, SYS_RTCWRITE);
+	au_sync();
 
-#endif
+	t = 0xffffff;
+	while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S) && t--)
+		asm volatile ("nop");
+	if (!t)
+		goto cntr_err;
+
+	/* register counter1 clocksource and event device */
+	clocksource_set_clock(&au1x_counter1_clocksource, 32768);
+	clocksource_register(&au1x_counter1_clocksource);
+
+	cd->shift = 32;
+	cd->mult = div_sc(32768, NSEC_PER_SEC, cd->shift);
+	cd->max_delta_ns = clockevent_delta2ns(0xffffffff, cd);
+	cd->min_delta_ns = clockevent_delta2ns(8, cd);	/* ~0.25ms */
+	clockevents_register_device(cd);
+	setup_irq(AU1000_RTC_MATCH2_INT, &au1x_rtcmatch2_irqaction);
+
+	printk(KERN_INFO "Alchemy clocksource installed\n");
+
+	/* can now use 'wait' */
+	allow_au1k_wait = 1;
+	return;
+
+cntr_err:
+	/* counters unusable, use C0 counter */
+	r4k_clockevent_init();
+	init_r4k_clocksource();
+	allow_au1k_wait = 0;
 }
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c9207b5..bf41ca7 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -96,6 +96,9 @@ int allow_au1k_wait;
 
 static void au1k_wait(void)
 {
+	if (!allow_au1k_wait)
+		return;
+
 	/* using the wait instruction makes CP0 counter unusable */
 	__asm__("	.set	mips3			\n"
 		"	cache	0x14, 0(%0)		\n"
@@ -185,8 +188,7 @@ void __init check_wait(void)
 	case CPU_AU1200:
 	case CPU_AU1210:
 	case CPU_AU1250:
-		if (allow_au1k_wait)
-			cpu_wait = au1k_wait;
+		cpu_wait = au1k_wait;
 		break;
 	case CPU_20KC:
 		/*
-- 
1.6.0.4
