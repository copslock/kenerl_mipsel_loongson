Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:31:08 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:41098 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24173231AbYLUI0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:32 +0000
Received: (qmail 3988 invoked from network); 21 Dec 2008 09:25:00 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:25:00 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 14/14] Alchemy: new userspace suspend interface for development boards.
Date:	Sun, 21 Dec 2008 09:26:27 +0100
Message-Id: <d986e8bc8b583d4838bb275234c343da866fbbce.1229846415.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <502995eadd40552a890abdf15ee194807b190096.1229846415.git.mano@roarinelk.homelinux.net>
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
 <cc0520393daa157516ae4f2cc6a69bc7b60a2a39.1229846414.git.mano@roarinelk.homelinux.net>
 <a64458ed8315e19b979f72236e0b73ed5ab2891d.1229846414.git.mano@roarinelk.homelinux.net>
 <b7b8752b8d9421eb381c93f945d6c0f53b2f74cd.1229846415.git.mano@roarinelk.homelinux.net>
 <502995eadd40552a890abdf15ee194807b190096.1229846415.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Replace the current sysctl-based suspend interface with a new sysfs-
based one which also uses the Linux-2.6 suspend model.

To configure wakeup sources, a subtree for the demoboards is created
under /sys/power/db1x:

sys/
`-- power
    `-- db1x
        |-- gpio0
        |-- gpio1
        |-- gpio2
        |-- gpio3
        |-- gpio4
        |-- gpio5
        |-- gpio6
        |-- gpio7
        |-- timer
        |-- timer_timeout
        |-- wakemsk
        `-- wakesrc

The nodes 'gpio[0-7]' and 'timer' configure the GPIO0..7 and M2
bits of the SYS_WAKEMSK (wakeup source enable) register.  Writing '1'
enables a wakesource, 0 disables it.

The 'timer_timeout' node holds the timeout in seconds after which the
TOYMATCH2 event should wake the system.

The 'wakesrc' node holds the SYS_WAKESRC register after wakeup (in hex),
the 'wakemsk' node can be used to get/set the wakeup mask directly.

For example, to have the timer wake the system after 10 seconds of sleep,
the following must be done in userspace:

echo 10 > /sys/power/db1x/timer_timeout
echo 1 > /sys/power/db1x/timer
echo mem > /sys/power/sleep

This patch also removes the homebrew CPU frequency switching code.  I don't
understand how it could have ever worked reliably; it does not communicate
the clock changes to peripheral devices other than uarts.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/irq.c             |   44 ----
 arch/mips/alchemy/common/power.c           |  309 ----------------------------
 arch/mips/alchemy/devboards/Makefile       |    1 +
 arch/mips/alchemy/devboards/pm.c           |  229 ++++++++++++++++++++
 arch/mips/include/asm/mach-au1x00/au1000.h |    4 +
 5 files changed, 234 insertions(+), 353 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/pm.c

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index c543847..c88c821 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -37,8 +37,6 @@
 #include <asm/mach-pb1x00/pb1000.h>
 #endif
 
-static DEFINE_SPINLOCK(irq_lock);
-
 static int au1x_ic_settype(unsigned int irq, unsigned int flow_type);
 
 /* per-processor fixed function irqs */
@@ -611,45 +609,3 @@ void __init arch_init_irq(void)
 
 	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
 }
-
-unsigned long save_local_and_disable(int controller)
-{
-	int i;
-	unsigned long flags, mask;
-
-	spin_lock_irqsave(&irq_lock, flags);
-	if (controller) {
-		mask = au_readl(IC1_MASKSET);
-		for (i = 0; i < 32; i++)
-			au1x_ic1_mask(i + AU1000_INTC1_INT_BASE);
-	} else {
-		mask = au_readl(IC0_MASKSET);
-		for (i = 0; i < 32; i++)
-			au1x_ic0_mask(i + AU1000_INTC0_INT_BASE);
-	}
-	spin_unlock_irqrestore(&irq_lock, flags);
-
-	return mask;
-}
-
-void restore_local_and_enable(int controller, unsigned long mask)
-{
-	int i;
-	unsigned long flags, new_mask;
-
-	spin_lock_irqsave(&irq_lock, flags);
-	for (i = 0; i < 32; i++)
-		if (mask & (1 << i)) {
-			if (controller)
-				au1x_ic1_unmask(i + AU1000_INTC1_INT_BASE);
-			else
-				au1x_ic0_unmask(i + AU1000_INTC0_INT_BASE);
-		}
-
-	if (controller)
-		new_mask = au_readl(IC1_MASKSET);
-	else
-		new_mask = au_readl(IC0_MASKSET);
-
-	spin_unlock_irqrestore(&irq_lock, flags);
-}
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index f58e151..6ab7b42 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -42,18 +42,6 @@
 
 #ifdef CONFIG_PM
 
-#define DEBUG 1
-#ifdef	DEBUG
-#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "%s: " fmt, __func__, ## args)
-#else
-#define DPRINTK(fmt, args...)
-#endif
-
-extern unsigned long save_local_and_disable(int controller);
-extern void restore_local_and_enable(int controller, unsigned long mask);
-
-static DEFINE_SPINLOCK(pm_lock);
-
 /*
  * We need to save/restore a bunch of core registers that are
  * either volatile or reset to some state across a processor sleep.
@@ -74,21 +62,6 @@ static unsigned int sleep_sys_clocks[5];
 static unsigned int sleep_sys_pinfunc;
 static unsigned int sleep_static_memctlr[4][3];
 
-/*
- * Define this to cause the value you write to /proc/sys/pm/sleep to
- * set the TOY timer for the amount of time you want to sleep.
- * This is done mainly for testing, but may be useful in other cases.
- * The value is number of 32KHz ticks to sleep.
- */
-#define SLEEP_TEST_TIMEOUT 1
-#ifdef	SLEEP_TEST_TIMEOUT
-static int sleep_ticks;
-static void wakeup_counter0_set(int ticks)
-{
-	au_writel(au_readl(SYS_TOYREAD) + ticks, SYS_TOYMATCH2);
-	au_sync();
-}
-#endif
 
 static void save_core_regs(void)
 {
@@ -234,13 +207,6 @@ static void restore_core_regs(void)
 #endif
 }
 
-unsigned long suspend_mode;
-
-void wakeup_from_suspend(void)
-{
-	suspend_mode = 0;
-}
-
 void au_sleep(void)
 {
 	save_core_regs();
@@ -248,279 +214,4 @@ void au_sleep(void)
 	restore_core_regs();
 }
 
-static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
-		       void __user *buffer, size_t *len, loff_t *ppos)
-{
-	unsigned long wakeup, flags;
-	int ret;
-#ifdef SLEEP_TEST_TIMEOUT
-#define TMPBUFLEN2 16
-	char buf[TMPBUFLEN2], *p;
-#endif
-
-	spin_lock_irqsave(&pm_lock, flags);
-
-	if (!write) {
-		*len = 0;
-		ret = 0;
-		goto out_unlock;
-	};
-
-#ifdef SLEEP_TEST_TIMEOUT
-	if (*len > TMPBUFLEN2 - 1) {
-		ret = -EFAULT;
-		goto out_unlock;
-	}
-	if (copy_from_user(buf, buffer, *len)) {
-		return -EFAULT;
-		goto out_unlock;
-	}
-	buf[*len] = 0;
-	p = buf;
-	sleep_ticks = simple_strtoul(p, &p, 0);
-	wakeup_counter0_set(sleep_ticks);
-#endif
-
-	/**
-	 ** The code below is all system dependent and we should probably
-	 ** have a function call out of here to set this up.  You need
-	 ** to configure the GPIO or timer interrupts that will bring
-	 ** you out of sleep.
-	 ** For testing, the TOY counter wakeup is useful.
-	 **/
-#if 0
-	au_writel(au_readl(SYS_PINSTATERD) & ~(1 << 11), SYS_PINSTATERD);
-
-	/* GPIO 6 can cause a wake up event */
-	wakeup = au_readl(SYS_WAKEMSK);
-	wakeup &= ~(1 << 8);	/* turn off match20 wakeup */
-	wakeup |= 1 << 6;	/* turn on  GPIO  6 wakeup */
-#else
-	/* For testing, allow match20 to wake us up. */
-	wakeup = 1 << 8;	/* turn on match20 wakeup   */
-	wakeup = 0;
-#endif
-	au_writel(1, SYS_WAKESRC);	/* clear cause */
-	au_sync();
-	au_writel(wakeup, SYS_WAKEMSK);
-	au_sync();
-
-	au_sleep();
-	ret = 0;
-
-out_unlock:
-	spin_unlock_irqrestore(&pm_lock, flags);
-	return ret;
-}
-
-#if !defined(CONFIG_SOC_AU1200) && !defined(CONFIG_SOC_AU1550)
-
-/*
- * This is right out of init/main.c
- */
-
-/*
- * This is the number of bits of precision for the loops_per_jiffy.
- * Each bit takes on average 1.5/HZ seconds.  This (like the original)
- * is a little better than 1%.
- */
-#define LPS_PREC 8
-
-static void au1000_calibrate_delay(void)
-{
-	unsigned long ticks, loopbit;
-	int lps_precision = LPS_PREC;
-
-	loops_per_jiffy = 1 << 12;
-
-	while (loops_per_jiffy <<= 1) {
-		/* Wait for "start of" clock tick */
-		ticks = jiffies;
-		while (ticks == jiffies)
-			/* nothing */ ;
-		/* Go ... */
-		ticks = jiffies;
-		__delay(loops_per_jiffy);
-		ticks = jiffies - ticks;
-		if (ticks)
-			break;
-	}
-
-	/*
-	 * Do a binary approximation to get loops_per_jiffy set to be equal
-	 * one clock (up to lps_precision bits)
-	 */
-	loops_per_jiffy >>= 1;
-	loopbit = loops_per_jiffy;
-	while (lps_precision-- && (loopbit >>= 1)) {
-		loops_per_jiffy |= loopbit;
-		ticks = jiffies;
-		while (ticks == jiffies);
-		ticks = jiffies;
-		__delay(loops_per_jiffy);
-		if (jiffies != ticks)	/* longer than 1 tick */
-			loops_per_jiffy &= ~loopbit;
-	}
-}
-
-static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
-		      void __user *buffer, size_t *len, loff_t *ppos)
-{
-	int retval = 0, i;
-	unsigned long val, pll;
-#define TMPBUFLEN 64
-#define MAX_CPU_FREQ 396
-	char buf[TMPBUFLEN], *p;
-	unsigned long flags, intc0_mask, intc1_mask;
-	unsigned long old_baud_base, old_cpu_freq, old_clk, old_refresh;
-	unsigned long new_baud_base, new_cpu_freq, new_clk, new_refresh;
-	unsigned long baud_rate;
-
-	spin_lock_irqsave(&pm_lock, flags);
-	if (!write)
-		*len = 0;
-	else {
-		/* Parse the new frequency */
-		if (*len > TMPBUFLEN - 1) {
-			spin_unlock_irqrestore(&pm_lock, flags);
-			return -EFAULT;
-		}
-		if (copy_from_user(buf, buffer, *len)) {
-			spin_unlock_irqrestore(&pm_lock, flags);
-			return -EFAULT;
-		}
-		buf[*len] = 0;
-		p = buf;
-		val = simple_strtoul(p, &p, 0);
-		if (val > MAX_CPU_FREQ) {
-			spin_unlock_irqrestore(&pm_lock, flags);
-			return -EFAULT;
-		}
-
-		pll = val / 12;
-		if ((pll > 33) || (pll < 7)) {	/* 396 MHz max, 84 MHz min */
-			/* Revisit this for higher speed CPUs */
-			spin_unlock_irqrestore(&pm_lock, flags);
-			return -EFAULT;
-		}
-
-		old_baud_base = get_au1x00_uart_baud_base();
-		old_cpu_freq = get_au1x00_speed();
-
-		new_cpu_freq = pll * 12 * 1000000;
-	        new_baud_base = (new_cpu_freq / (2 * ((int)(au_readl(SYS_POWERCTRL)
-							    & 0x03) + 2) * 16));
-		set_au1x00_speed(new_cpu_freq);
-		set_au1x00_uart_baud_base(new_baud_base);
-
-		old_refresh = au_readl(MEM_SDREFCFG) & 0x1ffffff;
-		new_refresh = ((old_refresh * new_cpu_freq) / old_cpu_freq) |
-			      (au_readl(MEM_SDREFCFG) & ~0x1ffffff);
-
-		au_writel(pll, SYS_CPUPLL);
-		au_sync_delay(1);
-		au_writel(new_refresh, MEM_SDREFCFG);
-		au_sync_delay(1);
-
-		for (i = 0; i < 4; i++)
-			if (au_readl(UART_BASE + UART_MOD_CNTRL +
-				     i * 0x00100000) == 3) {
-				old_clk = au_readl(UART_BASE + UART_CLK +
-						   i * 0x00100000);
-				baud_rate = old_baud_base / old_clk;
-				/*
-				 * We won't get an exact baud rate and the error
-				 * could be significant enough that our new
-				 * calculation will result in a clock that will
-				 * give us a baud rate that's too far off from
-				 * what we really want.
-				 */
-				if (baud_rate > 100000)
-					baud_rate = 115200;
-				else if (baud_rate > 50000)
-					baud_rate = 57600;
-				else if (baud_rate > 30000)
-					baud_rate = 38400;
-				else if (baud_rate > 17000)
-					baud_rate = 19200;
-				else
-					baud_rate = 9600;
-				new_clk = new_baud_base / baud_rate;
-				au_writel(new_clk, UART_BASE + UART_CLK +
-					  i * 0x00100000);
-				au_sync_delay(10);
-			}
-	}
-
-	/*
-	 * We don't want _any_ interrupts other than match20. Otherwise our
-	 * au1000_calibrate_delay() calculation will be off, potentially a lot.
-	 */
-	intc0_mask = save_local_and_disable(0);
-	intc1_mask = save_local_and_disable(1);
-	val = 1 << (AU1000_TOY_MATCH2_INT - AU1000_INTC0_INT_BASE);
-	au_writel(val, IC0_MASKSET);	/* unmask */
-	au_writel(val, IC0_WAKESET);	/* enable wake-from-sleep */
-	au_sync();
-	spin_unlock_irqrestore(&pm_lock, flags);
-	au1000_calibrate_delay();
-	restore_local_and_enable(0, intc0_mask);
-	restore_local_and_enable(1, intc1_mask);
-
-	return retval;
-}
-#endif
-
-static struct ctl_table pm_table[] = {
-	{
-		.ctl_name	= CTL_UNNUMBERED,
-		.procname	= "sleep",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0600,
-		.proc_handler	= &pm_do_sleep
-	},
-#if !defined(CONFIG_SOC_AU1200) && !defined(CONFIG_SOC_AU1550)
-	{
-		.ctl_name	= CTL_UNNUMBERED,
-		.procname	= "freq",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0600,
-		.proc_handler	= &pm_do_freq
-	},
-#endif
-	{}
-};
-
-static struct ctl_table pm_dir_table[] = {
-	{
-		.ctl_name	= CTL_UNNUMBERED,
-		.procname	= "pm",
-		.mode		= 0555,
-		.child		= pm_table
-	},
-	{}
-};
-
-/*
- * Initialize power interface
- */
-static int __init pm_init(void)
-{
-	/* init TOY to tick at 1Hz. No need to wait for access bits
-	 * since there's plenty of time between here and the first
-	 * suspend cycle.
-	 */
-	if (au_readl(SYS_TOYTRIM) != 32767) {
-		au_writel(32767, SYS_TOYTRIM);
-		au_sync();
-	}
-
-	register_sysctl_table(pm_dir_table);
-	return 0;
-}
-
-__initcall(pm_init);
-
 #endif	/* CONFIG_PM */
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index c0eb87a..730f9f2 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y += prom.o
+obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_MIPS_PB1000)	+= pb1000/
 obj-$(CONFIG_MIPS_PB1100)	+= pb1100/
 obj-$(CONFIG_MIPS_PB1200)	+= pb1200/
diff --git a/arch/mips/alchemy/devboards/pm.c b/arch/mips/alchemy/devboards/pm.c
new file mode 100644
index 0000000..d5eb9c3
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pm.c
@@ -0,0 +1,229 @@
+/*
+ * Alchemy Development Board example suspend userspace interface.
+ *
+ * (c) 2008 Manuel Lauss <mano@roarinelk.homelinux.net>
+ */
+
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/suspend.h>
+#include <linux/sysfs.h>
+#include <asm/mach-au1x00/au1000.h>
+
+/*
+ * Generic suspend userspace interface for Alchemy development boards.
+ * This code exports a few sysfs nodes under /sys/power/db1x/ which
+ * can be used by userspace to en/disable all au1x-provided wakeup
+ * sources and configure the timeout after which the the TOYMATCH2 irq
+ * is to trigger a wakeup.
+ */
+
+
+static unsigned long db1x_pm_sleep_secs;
+static unsigned long db1x_pm_wakemsk;
+static unsigned long db1x_pm_last_wakesrc;
+
+static int db1x_pm_enter(suspend_state_t state)
+{
+	/* enable GPIO based wakeup */
+	au_writel(1, SYS_PININPUTEN);
+
+	/* clear and setup wake cause and source */
+	au_writel(0, SYS_WAKEMSK);
+	au_sync();
+	au_writel(0, SYS_WAKESRC);
+	au_sync();
+
+	au_writel(db1x_pm_wakemsk, SYS_WAKEMSK);
+	au_sync();
+
+	/* setup 1Hz-timer-based wakeup: wait for reg access */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20)
+		asm volatile ("nop");
+
+	au_writel(au_readl(SYS_TOYREAD) + db1x_pm_sleep_secs, SYS_TOYMATCH2);
+	au_sync();
+
+	/* wait for value to really hit the register */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20)
+		asm volatile ("nop");
+
+	/* ...and now the sandman can come! */
+	au_sleep();
+
+	return 0;
+}
+
+static int db1x_pm_begin(suspend_state_t state)
+{
+	if (!db1x_pm_wakemsk) {
+		printk(KERN_ERR "db1x: no wakeup source activated!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void db1x_pm_end(void)
+{
+	/* read and store wakeup source, the clear the register. To
+	 * be able to clear it, WAKEMSK must be cleared first.
+	 */
+	db1x_pm_last_wakesrc = au_readl(SYS_WAKESRC);
+
+	au_writel(0, SYS_WAKEMSK);
+	au_writel(0, SYS_WAKESRC);
+	au_sync();
+
+}
+
+static struct platform_suspend_ops db1x_pm_ops = {
+	.valid		= suspend_valid_only_mem,
+	.begin		= db1x_pm_begin,
+	.enter		= db1x_pm_enter,
+	.end		= db1x_pm_end,
+};
+
+#define ATTRCMP(x) (0 == strcmp(attr->attr.name, #x))
+
+static ssize_t db1x_pmattr_show(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				char *buf)
+{
+	int idx;
+
+	if (ATTRCMP(timer_timeout))
+		return sprintf(buf, "%lu\n", db1x_pm_sleep_secs);
+
+	else if (ATTRCMP(timer))
+		return sprintf(buf, "%u\n",
+				!!(db1x_pm_wakemsk & SYS_WAKEMSK_M2));
+
+	else if (ATTRCMP(wakesrc))
+		return sprintf(buf, "%lu\n", db1x_pm_last_wakesrc);
+
+	else if (ATTRCMP(gpio0) || ATTRCMP(gpio1) || ATTRCMP(gpio2) ||
+		 ATTRCMP(gpio3) || ATTRCMP(gpio4) || ATTRCMP(gpio5) ||
+		 ATTRCMP(gpio6) || ATTRCMP(gpio7)) {
+		idx = (attr->attr.name)[4] - '0';
+		return sprintf(buf, "%d\n",
+			!!(db1x_pm_wakemsk & SYS_WAKEMSK_GPIO(idx)));
+
+	} else if (ATTRCMP(wakemsk)) {
+		return sprintf(buf, "%08lx\n", db1x_pm_wakemsk);
+	}
+
+	return -ENOENT;
+}
+
+static ssize_t db1x_pmattr_store(struct kobject *kobj,
+				 struct kobj_attribute *attr,
+				 const char *instr,
+				 size_t bytes)
+{
+	unsigned long l;
+	int tmp;
+
+	if (ATTRCMP(timer_timeout)) {
+		tmp = strict_strtoul(instr, 0, &l);
+		if (tmp)
+			return tmp;
+
+		db1x_pm_sleep_secs = l;
+
+	} else if (ATTRCMP(timer)) {
+		if (instr[0] != '0')
+			db1x_pm_wakemsk |= SYS_WAKEMSK_M2;
+		else
+			db1x_pm_wakemsk &= ~SYS_WAKEMSK_M2;
+
+	} else if (ATTRCMP(gpio0) || ATTRCMP(gpio1) || ATTRCMP(gpio2) ||
+		   ATTRCMP(gpio3) || ATTRCMP(gpio4) || ATTRCMP(gpio5) ||
+		   ATTRCMP(gpio6) || ATTRCMP(gpio7)) {
+		tmp = (attr->attr.name)[4] - '0';
+		if (instr[0] != '0') {
+			db1x_pm_wakemsk |= SYS_WAKEMSK_GPIO(tmp);
+		} else {
+			db1x_pm_wakemsk &= ~SYS_WAKEMSK_GPIO(tmp);
+		}
+
+	} else if (ATTRCMP(wakemsk)) {
+		tmp = strict_strtoul(instr, 0, &l);
+		if (tmp)
+			return tmp;
+
+		db1x_pm_wakemsk = l & 0x0000003f;
+
+	} else
+		bytes = -ENOENT;
+
+	return bytes;
+}
+
+#define ATTR(x)							\
+	static struct kobj_attribute x##_attribute = 		\
+		__ATTR(x, 0664, db1x_pmattr_show,		\
+				db1x_pmattr_store);
+
+ATTR(gpio0)		/* GPIO-based wakeup enable */
+ATTR(gpio1)
+ATTR(gpio2)
+ATTR(gpio3)
+ATTR(gpio4)
+ATTR(gpio5)
+ATTR(gpio6)
+ATTR(gpio7)
+ATTR(timer)		/* TOYMATCH2-based wakeup enable */
+ATTR(timer_timeout)	/* timer-based wakeup timeout value, in seconds */
+ATTR(wakesrc)		/* contents of SYS_WAKESRC after last wakeup */
+ATTR(wakemsk)		/* direct access to SYS_WAKEMSK */
+
+#define ATTR_LIST(x)	& x ## _attribute.attr
+static struct attribute *db1x_pmattrs[] = {
+	ATTR_LIST(gpio0),
+	ATTR_LIST(gpio1),
+	ATTR_LIST(gpio2),
+	ATTR_LIST(gpio3),
+	ATTR_LIST(gpio4),
+	ATTR_LIST(gpio5),
+	ATTR_LIST(gpio6),
+	ATTR_LIST(gpio7),
+	ATTR_LIST(timer),
+	ATTR_LIST(timer_timeout),
+	ATTR_LIST(wakesrc),
+	ATTR_LIST(wakemsk),
+	NULL,		/* terminator */
+};
+
+static struct attribute_group db1x_pmattr_group = {
+	.name	= "db1x",
+	.attrs	= db1x_pmattrs,
+};
+
+/*
+ * Initialize suspend interface
+ */
+static int __init pm_init(void)
+{
+	/* init TOY to tick at 1Hz if not already done. No need to wait
+	 * for confirmation since there's plenty of time from here to
+	 * the next suspend cycle.
+	 */
+	if (au_readl(SYS_TOYTRIM) != 32767) {
+		au_writel(32767, SYS_TOYTRIM);
+		au_sync();
+	}
+
+	db1x_pm_last_wakesrc = au_readl(SYS_WAKESRC);
+
+	au_writel(0, SYS_WAKESRC);
+	au_sync();
+	au_writel(0, SYS_WAKEMSK);
+	au_sync();
+
+	suspend_set_ops(&db1x_pm_ops);
+
+	return sysfs_create_group(power_kobj, &db1x_pmattr_group);
+}
+
+late_initcall(pm_init);
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 515373c..62f91f5 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1560,6 +1560,10 @@ enum soc_au1200_ints {
 #define SYS_SLPPWR		0xB1900078
 #define SYS_SLEEP		0xB190007C
 
+#define SYS_WAKEMSK_D2		(1 << 9)
+#define SYS_WAKEMSK_M2		(1 << 8)
+#define SYS_WAKEMSK_GPIO(x)	(1 << (x))
+
 /* Clock Controller */
 #define SYS_FREQCTRL0		0xB1900020
 #  define SYS_FC_FRDIV2_BIT	22
-- 
1.6.0.4
