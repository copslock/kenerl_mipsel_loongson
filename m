Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 21:12:55 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:7656 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20038834AbYFXUMw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 21:12:52 +0100
Received: (qmail 2957 invoked by uid 1000); 24 Jun 2008 22:12:51 +0200
Date:	Tue, 24 Jun 2008 22:12:51 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [RFC PATCH 6/7] Alchemy: PM: split sysctl code from more useful
	code.
Message-ID: <20080624201251.GG2463@roarinelk.homelinux.net>
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
X-archive-position: 19622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

From: Manuel Lauss <mano@roarinelk.homelinux.net>

Split the custom Alchemy pm sysctl code away from the more
useful parts (the actual suspend/resume work code).

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/platform.c |  295 ++++++++++++++++++++++++++++++++++-
 arch/mips/au1000/common/power.c    |  306 +-----------------------------------
 2 files changed, 296 insertions(+), 305 deletions(-)

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index a147c2d..bf3bcbf 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -18,8 +18,13 @@
 
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
-#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pm.h>
+#include <linux/pm_legacy.h>
+#include <linux/spinlock.h>
+#include <linux/sysctl.h>
 
+#include <asm/uaccess.h>
 #include <asm/mach-au1x00/au1xxx.h>
 
 #define PORT(_base, _irq)				\
@@ -321,3 +326,291 @@ static int __init au1xxx_platform_init(void)
 }
 
 arch_initcall(au1xxx_platform_init);
+
+
+/*********************************************************************/
+
+
+#ifdef CONFIG_PM
+
+static DEFINE_SPINLOCK(pm_lock);
+
+extern unsigned long save_local_and_disable(int controller);
+extern void restore_local_and_enable(int controller, unsigned long mask);
+extern void local_enable_irq(unsigned int irq_nr);
+extern void au_sleep(void);
+
+/*
+ * Define this to cause the value you write to /proc/sys/pm/sleep to
+ * set the TOY timer for the amount of time you want to sleep.
+ * This is done mainly for testing, but may be useful in other cases.
+ * The value is number of 32KHz ticks to sleep.
+ */
+#define SLEEP_TEST_TIMEOUT 1
+#ifdef	SLEEP_TEST_TIMEOUT
+static int sleep_ticks;
+static void wakeup_counter0_set(int ticks)
+{
+	au_writel(au_readl(SYS_TOYREAD) + ticks, SYS_TOYMATCH2);
+	au_sync();
+}
+#endif
+
+static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
+		       void __user *buffer, size_t *len, loff_t *ppos)
+{
+	unsigned long wakeup, flags;
+#ifdef SLEEP_TEST_TIMEOUT
+#define TMPBUFLEN2 16
+	char buf[TMPBUFLEN2], *p;
+#endif
+
+	spin_lock_irqsave(&pm_lock, flags);
+
+	if (!write) {
+		*len = 0;
+		spin_unlock_irqrestore(&pm_lock, flags);
+		return 0;
+	}
+
+#ifdef SLEEP_TEST_TIMEOUT
+	if (*len > TMPBUFLEN2 - 1)
+		return -EFAULT;
+	if (copy_from_user(buf, buffer, *len))
+		return -EFAULT;
+	buf[*len] = 0;
+	p = buf;
+	sleep_ticks = simple_strtoul(p, &p, 0);
+#endif
+
+	/**
+	 ** The code below is all system dependent and we should probably
+	 ** have a function call out of here to set this up.  You need
+	 ** to configure the GPIO or timer interrupts that will bring
+	 ** you out of sleep.
+	 ** For testing, the TOY counter wakeup is useful.
+	 **/
+#if 0
+	au_writel(au_readl(SYS_PINSTATERD) & ~(1 << 11), SYS_PINSTATERD);
+
+	/* GPIO 6 can cause a wake up event */
+	wakeup = au_readl(SYS_WAKEMSK);
+	wakeup &= ~(1 << 8);	/* turn off match20 wakeup */
+	wakeup |= 1 << 6;	/* turn on  GPIO  6 wakeup */
+#else
+	/* For testing, allow match20 to wake us up. */
+#ifdef SLEEP_TEST_TIMEOUT
+	wakeup_counter0_set(sleep_ticks);
+#endif
+	wakeup = 1 << 8;	/* turn on match20 wakeup   */
+	wakeup = 0;
+#endif
+	au_writel(1, SYS_WAKESRC);	/* clear cause */
+	au_sync();
+	au_writel(wakeup, SYS_WAKEMSK);
+	au_sync();
+
+	au_sleep();
+
+	spin_unlock_irqrestore(&pm_lock, flags);
+
+	return 0;
+}
+
+/*
+ * This is the number of bits of precision for the loops_per_jiffy.
+ * Each bit takes on average 1.5/HZ seconds.  This (like the original)
+ * is a little better than 1%.
+ */
+#define LPS_PREC 8
+
+static void au1000_calibrate_delay(void)
+{
+	unsigned long ticks, loopbit;
+	int lps_precision = LPS_PREC;
+
+	loops_per_jiffy = 1 << 12;
+
+	while (loops_per_jiffy <<= 1) {
+		/* Wait for "start of" clock tick */
+		ticks = jiffies;
+		while (ticks == jiffies)
+			/* nothing */ ;
+		/* Go ... */
+		ticks = jiffies;
+		__delay(loops_per_jiffy);
+		ticks = jiffies - ticks;
+		if (ticks)
+			break;
+	}
+
+	/*
+	 * Do a binary approximation to get loops_per_jiffy set to be equal
+	 * one clock (up to lps_precision bits)
+	 */
+	loops_per_jiffy >>= 1;
+	loopbit = loops_per_jiffy;
+	while (lps_precision-- && (loopbit >>= 1)) {
+		loops_per_jiffy |= loopbit;
+		ticks = jiffies;
+		while (ticks == jiffies);
+		ticks = jiffies;
+		__delay(loops_per_jiffy);
+		if (jiffies != ticks)	/* longer than 1 tick */
+			loops_per_jiffy &= ~loopbit;
+	}
+}
+
+static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
+		      void __user *buffer, size_t *len, loff_t *ppos)
+{
+	int retval = 0, i;
+	unsigned long val, pll;
+#define TMPBUFLEN 64
+#define MAX_CPU_FREQ 396
+	char buf[TMPBUFLEN], *p;
+	unsigned long flags, intc0_mask, intc1_mask;
+	unsigned long old_baud_base, old_cpu_freq, old_clk, old_refresh;
+	unsigned long new_baud_base, new_cpu_freq, new_clk, new_refresh;
+	unsigned long baud_rate;
+
+	spin_lock_irqsave(&pm_lock, flags);
+	if (!write)
+		*len = 0;
+	else {
+		/* Parse the new frequency */
+		if (*len > TMPBUFLEN - 1) {
+			spin_unlock_irqrestore(&pm_lock, flags);
+			return -EFAULT;
+		}
+		if (copy_from_user(buf, buffer, *len)) {
+			spin_unlock_irqrestore(&pm_lock, flags);
+			return -EFAULT;
+		}
+		buf[*len] = 0;
+		p = buf;
+		val = simple_strtoul(p, &p, 0);
+		if (val > MAX_CPU_FREQ) {
+			spin_unlock_irqrestore(&pm_lock, flags);
+			return -EFAULT;
+		}
+
+		pll = val / 12;
+		if ((pll > 33) || (pll < 7)) {	/* 396 MHz max, 84 MHz min */
+			/* Revisit this for higher speed CPUs */
+			spin_unlock_irqrestore(&pm_lock, flags);
+			return -EFAULT;
+		}
+
+		old_baud_base = get_au1x00_uart_baud_base();
+		old_cpu_freq = get_au1x00_speed();
+
+		new_cpu_freq = pll * 12 * 1000000;
+	        new_baud_base = (new_cpu_freq / (2 * ((int)(au_readl(SYS_POWERCTRL)
+							    & 0x03) + 2) * 16));
+		set_au1x00_speed(new_cpu_freq);
+		set_au1x00_uart_baud_base(new_baud_base);
+
+		old_refresh = au_readl(MEM_SDREFCFG) & 0x1ffffff;
+		new_refresh = ((old_refresh * new_cpu_freq) / old_cpu_freq) |
+			      (au_readl(MEM_SDREFCFG) & ~0x1ffffff);
+
+		au_writel(pll, SYS_CPUPLL);
+		au_sync_delay(1);
+		au_writel(new_refresh, MEM_SDREFCFG);
+		au_sync_delay(1);
+
+		for (i = 0; i < 4; i++)
+			if (au_readl(UART_BASE + UART_MOD_CNTRL +
+				     i * 0x00100000) == 3) {
+				old_clk = au_readl(UART_BASE + UART_CLK +
+						   i * 0x00100000);
+				baud_rate = old_baud_base / old_clk;
+				/*
+				 * We won't get an exact baud rate and the error
+				 * could be significant enough that our new
+				 * calculation will result in a clock that will
+				 * give us a baud rate that's too far off from
+				 * what we really want.
+				 */
+				if (baud_rate > 100000)
+					baud_rate = 115200;
+				else if (baud_rate > 50000)
+					baud_rate = 57600;
+				else if (baud_rate > 30000)
+					baud_rate = 38400;
+				else if (baud_rate > 17000)
+					baud_rate = 19200;
+				else
+					baud_rate = 9600;
+				new_clk = new_baud_base / baud_rate;
+				au_writel(new_clk, UART_BASE + UART_CLK +
+					  i * 0x00100000);
+				au_sync_delay(10);
+			}
+	}
+
+	/*
+	 * We don't want _any_ interrupts other than match20. Otherwise our
+	 * au1000_calibrate_delay() calculation will be off, potentially a lot.
+	 */
+	intc0_mask = save_local_and_disable(0);
+	intc1_mask = save_local_and_disable(1);
+	local_enable_irq(AU1000_TOY_MATCH2_INT);
+	spin_unlock_irqrestore(&pm_lock, flags);
+	au1000_calibrate_delay();
+	restore_local_and_enable(0, intc0_mask);
+	restore_local_and_enable(1, intc1_mask);
+
+	return retval;
+}
+
+
+static struct ctl_table pm_table[] = {
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "sleep",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0600,
+		.proc_handler	= &pm_do_sleep
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "freq",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0600,
+		.proc_handler	= &pm_do_freq
+	},
+	{}
+};
+
+static struct ctl_table pm_dir_table[] = {
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "pm",
+		.mode		= 0555,
+		.child		= pm_table
+	},
+	{}
+};
+
+/*
+ * Initialize power interface
+ */
+static int __init pm_init(void)
+{
+	au_writel(0, SYS_WAKESRC);
+	au_sync();
+	au_writel(0, SYS_WAKEMSK);
+	au_sync();
+
+	register_sysctl_table(pm_dir_table);
+
+	return 0;
+}
+
+__initcall(pm_init);
+
+#endif	/* CONFIG_PM */
diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index 751b4b3..7feb21a 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -30,31 +30,12 @@
  */
 
 #include <linux/init.h>
-#include <linux/pm.h>
-#include <linux/pm_legacy.h>
-#include <linux/sysctl.h>
-#include <linux/jiffies.h>
-
-#include <asm/uaccess.h>
 #include <asm/cacheflush.h>
 #include <asm/mach-au1x00/au1000.h>
 
 #ifdef CONFIG_PM
 
-#define DEBUG 1
-#ifdef	DEBUG
-#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "%s: " fmt, __func__, ## args)
-#else
-#define DPRINTK(fmt, args...)
-#endif
-
-static void au1000_calibrate_delay(void);
-
-extern unsigned long save_local_and_disable(int controller);
-extern void restore_local_and_enable(int controller, unsigned long mask);
-extern void local_enable_irq(unsigned int irq_nr);
-
-static DEFINE_SPINLOCK(pm_lock);
+extern void save_and_sleep(void);
 
 /*
  * We need to save/restore a bunch of core registers that are
@@ -78,22 +59,6 @@ static unsigned int	sleep_usbhost_enable;
 static unsigned int	sleep_usbdev_enable;
 static unsigned int	sleep_static_memctlr[4][3];
 
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
-
 static void save_core_regs(void)
 {
 	extern void save_au1xxx_intctl(void);
@@ -191,279 +156,12 @@ static void restore_core_regs(void)
 	restore_au1xxx_intctl();
 }
 
-unsigned long suspend_mode;
-
-void wakeup_from_suspend(void)
+void au_sleep(void)
 {
-	suspend_mode = 0;
-}
-
-int au_sleep(void)
-{
-	unsigned long wakeup, flags;
-	extern void save_and_sleep(void);
-
-	spin_lock_irqsave(&pm_lock, flags);
-
 	save_core_regs();
-
 	flush_cache_all();
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
-#ifdef SLEEP_TEST_TIMEOUT
-	wakeup_counter0_set(sleep_ticks);
-#endif
-	wakeup = 1 << 8;	/* turn on match20 wakeup   */
-	wakeup = 0;
-#endif
-	au_writel(1, SYS_WAKESRC);	/* clear cause */
-	au_sync();
-	au_writel(wakeup, SYS_WAKEMSK);
-	au_sync();
-
 	save_and_sleep();
-
-	/*
-	 * After a wakeup, the cpu vectors back to 0x1fc00000, so
-	 * it's up to the boot code to get us back here.
-	 */
 	restore_core_regs();
-	spin_unlock_irqrestore(&pm_lock, flags);
-	return 0;
 }
 
-static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
-		       void __user *buffer, size_t *len, loff_t *ppos)
-{
-#ifdef SLEEP_TEST_TIMEOUT
-#define TMPBUFLEN2 16
-	char buf[TMPBUFLEN2], *p;
-#endif
-
-	if (!write)
-		*len = 0;
-	else {
-#ifdef SLEEP_TEST_TIMEOUT
-		if (*len > TMPBUFLEN2 - 1)
-			return -EFAULT;
-		if (copy_from_user(buf, buffer, *len))
-			return -EFAULT;
-		buf[*len] = 0;
-		p = buf;
-		sleep_ticks = simple_strtoul(p, &p, 0);
 #endif
-
-		au_sleep();
-	}
-	return 0;
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
-	local_enable_irq(AU1000_TOY_MATCH2_INT);
-	spin_unlock_irqrestore(&pm_lock, flags);
-	au1000_calibrate_delay();
-	restore_local_and_enable(0, intc0_mask);
-	restore_local_and_enable(1, intc1_mask);
-
-	return retval;
-}
-
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
-	{
-		.ctl_name	= CTL_UNNUMBERED,
-		.procname	= "freq",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0600,
-		.proc_handler	= &pm_do_freq
-	},
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
-	register_sysctl_table(pm_dir_table);
-	return 0;
-}
-
-__initcall(pm_init);
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
-#endif	/* CONFIG_PM */
-- 
1.5.5.4
