Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 21:11:29 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:38283 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20038825AbYFXULZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 21:11:25 +0100
Received: (qmail 2935 invoked by uid 1000); 24 Jun 2008 22:11:24 +0200
Date:	Tue, 24 Jun 2008 22:11:24 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [RFC PATCH 4/7] Alchemy: TOY counter clocksource / clockevent
	support.
Message-ID: <20080624201124.GE2463@roarinelk.homelinux.net>
References: <20080624200810.GA2463@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080624200810.GA2463@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <mano@roarinelk.homelinux.net>

Add support for the TOY (32kHz) counter as clocksource / clockevent
device to enable use of the 'wait' instruction.
If the 32kHz clock supply is unstable/stopped during init, the CP0 counter
clocksource/event will be used instead.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/Kconfig        |    4 +-
 arch/mips/au1000/common/power.c |    7 +-
 arch/mips/au1000/common/setup.c |    6 -
 arch/mips/au1000/common/time.c  |  333 +++++++++++++++++++--------------------
 4 files changed, 170 insertions(+), 180 deletions(-)

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
index 2166b9e..751b4b3 100644
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
diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index 0d78f50..66f4fd6 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -93,12 +93,6 @@ void __init plat_mem_setup(void)
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
index 1518570..b6c7833 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
@@ -23,131 +23,29 @@
  *
  * ########################################################################
  *
- * Setting up the clock on the MIPS boards.
+ * Clocksource/event using the Au1000 TOY counter.
+ * compared to the C0 timer, the TOY is a very lousy clocksource and
+ * hrtimers are definitely unusable with it.  But it enables the use
+ * of the 'wait' instructions for some power-savings during idle times.
  *
- * We provide the clock interrupt processing and the timer offset compute
- * functions.  If CONFIG_PM is selected, we also ensure the 32KHz timer is
- * available.  -- Dan
+ * If the TOY is unusable, the CP0 counter will be installed instead,
+ * and use of 'wait' prohibited.
  */
 
-#include <linux/types.h>
+#include <linux/clocksource.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #include <asm/mipsregs.h>
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
@@ -206,60 +82,177 @@ unsigned long calc_clock(void)
 #endif
 	else
 		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
+
 	/* On Alchemy CPU:counter ratio is 1:1 */
 	mips_hpt_frequency = cpu_speed;
 	/* Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16) */
 	set_au1x00_uart_baud_base(cpu_speed / (2 * ((int)(au_readl(SYS_POWERCTRL)
 							  & 0x03) + 2) * 16));
+
 	spin_unlock_irqrestore(&time_lock, flags);
+
 	return cpu_speed;
 }
 
+/* Test and initialize TOY/RTC counters.  It is assumed bootloader
+ * and/or platform init code have already configured the 32kHz input
+ * sources for each (GPIO or dedicated crystal input).
+ */
+static int au1x_init_toy(void)
+{
+	unsigned long i, j;
+
+	/* enable 32kHz input */
+	i = au_readl(SYS_COUNTER_CNTRL);
+	au_writel(i | SYS_CNTRL_E0, SYS_COUNTER_CNTRL);
+	au_sync();
+
+	/* wait a bit for clock to stabilize throughout TOY unit */
+	for (j = 0x000fffff; j; j--)
+		asm volatile ("nop");
+
+	/* check 32S flag: clock detected? */
+	if (!(au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_32S))
+		goto out_err;
+
+	/* The 32S bit is unrealiable -- it stays set even when clock
+	 * is stopped.  Instead, read the TOY counter, it _should_ not
+	 * increased without some sort of clock.
+	 */
+	i = au_readl(SYS_TOYREAD);
+	for (j = 0x7ffff; j; j--)
+		asm volatile ("nop");
+	j = au_readl(SYS_TOYREAD);
+	if (i == j)
+		goto out_err;
+
+	/* setup counter 0 (TOY) */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T0S)
+		asm volatile ("nop");
+	au_writel(0, SYS_TOYTRIM);	/* keep ticking at 32kHz */
+	au_sync();
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T0S)
+		asm volatile ("nop");
+
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
+		asm volatile ("nop");
+	au_writel(0, SYS_TOYWRITE);
+	au_sync();
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
+		asm volatile ("nop");
+
+	/* setup counter 1 (RTC) too */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S)
+		asm volatile ("nop");
+	/* RTC now ticks at 32.768/16 kHz */
+	au_writel(15, SYS_RTCTRIM);
+	au_sync();
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T1S)
+		asm volatile ("nop");
+
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S)
+		asm volatile ("nop");
+	au_writel(0, SYS_RTCWRITE);
+	au_sync();
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S)
+		asm volatile ("nop");
+
+	return 0;
+
+out_err:
+	/* no fun in TOY land */
+	au_writel(i & ~SYS_CNTRL_E0, SYS_COUNTER_CNTRL);
+	au_sync();
+	return -ENXIO;
+}
+
+static cycle_t au1x_toy_read(void)
+{
+	return au_readl(SYS_TOYREAD);
+}
+
+static struct clocksource clocksource_toy = {
+	.name		= "Au1000-TOY",
+	.read		= au1x_toy_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static int toymatch2_set_next_event(unsigned long delta,
+				struct clock_event_device *cd)
+{
+	au_writel(au_readl(SYS_TOYREAD) + delta, SYS_TOYMATCH2);
+	au_sync();
+	return 0;
+}
+
+static void toymatch2_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *cd)
+{
+}
+
+static irqreturn_t toymatch2_irq(int irq, void *dev_id)
+{
+	struct clock_event_device *cd = dev_id;
+	cd->event_handler(cd);
+	return IRQ_HANDLED;
+}
+
+static struct clock_event_device ced_toy_match2 = {
+	.name		= "Au1000-TOY2",
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 100,
+	.irq		= AU1000_TOY_MATCH2_INT,
+	.set_next_event	= toymatch2_set_next_event,
+	.set_mode	= toymatch2_set_mode,
+	.cpumask	= CPU_MASK_ALL,
+};
+
+struct irqaction toymatch2_action = {
+	.handler	= toymatch2_irq,
+	.flags		= IRQF_DISABLED,
+	.name		= "toymatch2",
+	.dev_id		= &ced_toy_match2,
+};
+
+static void toymatch2_clockevent_init(void)
+{
+	struct clock_event_device *cd = &ced_toy_match2;
+
+	cd->mult	= div_sc(32768, NSEC_PER_SEC, 32);
+	cd->shift	= 32;
+	cd->max_delta_ns = clockevent_delta2ns(0x7fffffff, cd);
+
+	/* 0x140 -- boots AND BogoMIPS detection is pretty accurate too */
+	cd->min_delta_ns = clockevent_delta2ns(0x140, cd);
+	clockevents_register_device(cd);
+	setup_irq(AU1000_TOY_MATCH2_INT, &toymatch2_action);
+}
+
 void __init plat_time_init(void)
 {
 	unsigned int est_freq = calc_clock();
 
 	est_freq += 5000;    /* round */
-	est_freq -= est_freq%10000;
+	est_freq -= est_freq % 10000;
 	printk(KERN_INFO "(PRId %08x) @ %u.%02u MHz\n", read_c0_prid(),
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
+	if (au1x_init_toy()) {
+		r4k_clockevent_init();
+		init_r4k_clocksource();
+
+		/* 'wait' stops the CP0 counter */
+		allow_au1k_wait = 0;
+	} else {
+		toymatch2_clockevent_init();
+
+		clocksource_toy.rating = 100;
+		clocksource_set_clock(&clocksource_toy, 32768);
+		clocksource_register(&clocksource_toy);
+		printk(KERN_INFO "Au1000 TOY clocksource installed\n");
+
 		allow_au1k_wait = 1;
 	}
-
-#endif
 }
-- 
1.5.5.4
