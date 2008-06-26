Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2008 20:39:26 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:56200 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28576455AbYFZTjU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jun 2008 20:39:20 +0100
Received: (qmail 21814 invoked by uid 1000); 26 Jun 2008 21:39:18 +0200
Date:	Thu, 26 Jun 2008 21:39:18 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH v2 4/8] Alchemy: RTC counter clocksource / clockevent
	support.
Message-ID: <20080626193918.GE21604@roarinelk.homelinux.net>
References: <20080626193643.GA21604@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080626193643.GA21604@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <mano@roarinelk.homelinux.net>

Add support for the 32 kHz counter1 (RTC) as clocksource / clockevent
device to enable use of the 'wait' instruction.
If the 32kHz clock supply is unstable/stopped during init, the CP0 counter
clocksource/event will be used instead.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/Kconfig        |    4 +-
 arch/mips/au1000/common/power.c |   15 ++-
 arch/mips/au1000/common/setup.c |    6 -
 arch/mips/au1000/common/time.c  |  313 ++++++++++++++++++---------------------
 4 files changed, 156 insertions(+), 182 deletions(-)

diff --git a/arch/mips/au1000/Kconfig b/arch/mips/au1000/Kconfig
index 1fe97cc..c689cd6 100644
--- a/arch/mips/au1000/Kconfig
+++ b/arch/mips/au1000/Kconfig
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
diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index 2166b9e..0aa9522 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -87,7 +87,11 @@ static unsigned int	sleep_static_memctlr[4][3];
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
@@ -185,7 +189,6 @@ static void restore_core_regs(void)
 	}
 
 	restore_au1xxx_intctl();
-	wakeup_counter0_adjust();
 }
 
 unsigned long suspend_mode;
@@ -410,6 +413,14 @@ static struct ctl_table pm_dir_table[] = {
  */
 static int __init pm_init(void)
 {
+	/* init TOY to tick at 1Hz. No need to wait for access bits
+	 * since there's plenty of time between here and the first
+	 * suspend cycle.
+	 */
+	au_writel(32767, SYS_TOYTRIM);
+	au_writel(0, SYS_TOYWRITE);
+	au_sync();
+
 	register_sysctl_table(pm_dir_table);
 	return 0;
 }
diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index aa74846..398d665 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -90,12 +90,6 @@ void __init plat_mem_setup(void)
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
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index 1518570..e37aca7 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -23,131 +23,29 @@
  *
  * ########################################################################
  *
- * Setting up the clock on the MIPS boards.
+ * Clocksource/event using the Au1000 counter1.
+ * Compared to the C0 timer, the Au1000 counters make for a very lousy
+ * clocksource and hrtimers are definitely unusable with them; but they
+ * enable the use of the 'wait' instructions for some power-savings
+ * during idle times.  Counter1 is used because unlike counter 0 (TOY)
+ * it doesn't continue counting during sleep/hibernate, which is perfectly
+ * acceptable.
  *
- * We provide the clock interrupt processing and the timer offset compute
- * functions.  If CONFIG_PM is selected, we also ensure the 32KHz timer is
- * available.  -- Dan
+ * CP0 counter clocksource will be used if no 32kHz source is available.
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
 extern int allow_au1k_wait; /* default off for CP0 Counter */
 
-#ifdef CONFIG_PM
-#if HZ < 100 || HZ > 1000
-#error "unsupported HZ value! Must be in [100,1000]"
-#endif
-#define MATCH20_INC (328 * 100 / HZ) /* magic number 328 is for HZ=100... */
-static unsigned long last_pc0, last_match20;
-#endif
-
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
@@ -215,6 +91,130 @@ unsigned long calc_clock(void)
 	return cpu_speed;
 }
 
+static cycle_t au1x_counter1_read(void)
+{
+	return au_readl(SYS_RTCREAD);
+}
+
+static struct clocksource au1x_counter1_clocksource = {
+	.name		= "au1000-counter1",
+	.read		= au1x_counter1_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int au1x_rtcmatch2_set_next_event(unsigned long delta,
+					 struct clock_event_device *cd)
+{
+	au_writel(au_readl(SYS_RTCREAD) + delta, SYS_RTCMATCH2);
+	au_sync();
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
+static struct clock_event_device au1x_ced_rtcmatch2 = {
+	.name		= "rtcmatch2",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 100,
+	.irq		= AU1000_RTC_MATCH2_INT,
+	.set_next_event	= au1x_rtcmatch2_set_next_event,
+	.set_mode	= au1x_rtcmatch2_set_mode,
+	.cpumask	= CPU_MASK_ALL,
+};
+
+struct irqaction au1x_rtcmatch2_action = {
+	.handler	= au1x_rtcmatch2_irq,
+	.flags		= IRQF_DISABLED,
+	.name		= "rtcmatch2",
+	.dev_id		= &au1x_ced_rtcmatch2,
+};
+
+static void au1x_rtcmatch2_clockevent_init(void)
+{
+	struct clock_event_device *cd = &au1x_ced_rtcmatch2;
+
+	cd->mult	= div_sc(32768, NSEC_PER_SEC, 32);
+	cd->shift	= 32;
+	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
+
+	/* 0x140 -- boots AND BogoMIPS detection is pretty accurate too */
+	cd->min_delta_ns = clockevent_delta2ns(0x140, cd);
+	clockevents_register_device(cd);
+	setup_irq(AU1000_RTC_MATCH2_INT, &au1x_rtcmatch2_action);
+}
+
+/* Initialize Au1xxx counter1 (aka RTC) as clocksource/event device.
+ * NOTE: don't touch the counter0 (TOY) since we don't need it.
+ * Board code can do whatever it wants with it.
+ */
+static int au1x_counter1_init(void)
+{
+	unsigned long i;
+
+	/* enable 32kHz input */
+	i = au_readl(SYS_COUNTER_CNTRL);
+	au_writel(i | SYS_CNTRL_E0, SYS_COUNTER_CNTRL);
+	au_sync();
+
+	/* wait a bit for 32S flag (clock detected) to appear */
+	for (i = 0x00ffffff; i; i--) {
+		if ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_32S))
+			break;
+	}
+	if (!i)
+		goto out_err;
+
+	/*
+	 * setup counter 1 (RTC) to tick at full speed
+	 */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S)
+		asm volatile ("nop");
+	au_writel(0, SYS_RTCTRIM);	/* 32.768 kHz */
+	au_sync();
+	/* don't wait for RTCTRIM write confirmation, this may take a loooong
+	 * time, up to 5 seconds(!!).  It doesn't hurt though because it is
+	 * zero anyway after power-up and after reset because we set it here.
+	 */
+
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S)
+		asm volatile ("nop");
+	au_writel(0, SYS_RTCWRITE);
+	au_sync();
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S)
+		asm volatile ("nop");
+
+	/*
+	 * register RTC clockevent device and clocksource.
+	 */
+	au1x_rtcmatch2_clockevent_init();
+
+	au1x_counter1_clocksource.rating = 100;
+	clocksource_set_clock(&au1x_counter1_clocksource, 32768);
+	clocksource_register(&au1x_counter1_clocksource);
+	printk(KERN_INFO "Au1000 COUNTER1 (RTC) clocksource installed\n");
+
+	/* can now use 'wait' */
+	allow_au1k_wait = 1;
+
+	return 0;
+
+out_err:
+	au_writel(0, SYS_COUNTER_CNTRL);
+	au_sync();
+	return -ENXIO;
+}
+
 void __init plat_time_init(void)
 {
 	unsigned int est_freq = calc_clock();
@@ -225,41 +225,10 @@ void __init plat_time_init(void)
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
-	 */
-	if (no_au1xxx_32khz)
-		printk(KERN_WARNING "WARNING: no 32KHz clock found.\n");
-	else {
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S);
-		au_writel(0, SYS_TOYWRITE);
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S);
-
-		au_writel(au_readl(SYS_WAKEMSK) | (1 << 8), SYS_WAKEMSK);
-		au_writel(~0, SYS_WAKESRC);
-		au_sync();
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
-
-		/* Setup match20 to interrupt once every HZ */
-		last_pc0 = last_match20 = au_readl(SYS_TOYREAD);
-		au_writel(last_match20 + MATCH20_INC, SYS_TOYMATCH2);
-		au_sync();
-		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
-		setup_irq(AU1000_TOY_MATCH2_INT, &counter0_action);
-
-		/* We can use the real 'wait' instruction. */
-		allow_au1k_wait = 1;
+	if (au1x_counter1_init()) {
+		/* 32kHz is unusable -- install CP0 counter instead */
+		r4k_clockevent_init();
+		init_r4k_clocksource();
+		allow_au1k_wait = 0;
 	}
-
-#endif
 }
-- 
1.5.5.4
