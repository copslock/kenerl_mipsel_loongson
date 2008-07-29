Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 18:05:50 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:19126 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20025226AbYG2RFn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jul 2008 18:05:43 +0100
Received: (qmail 9016 invoked by uid 1000); 29 Jul 2008 19:05:42 +0200
Date:	Tue, 29 Jul 2008 19:05:42 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH v4 10/10] Alchemy: new demoboard userspace suspend
	interface.
Message-ID: <20080729170542.GL8784@roarinelk.homelinux.net>
References: <20080729165853.GB8784@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080729165853.GB8784@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20042
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
        |-- uptime
        |-- wakemsk
        `-- wakesrc

The nodes 'gpio[0-7]' and 'timer' configure the GPIO0..7 and M2
bits of the SYS_WAKEMSK (wakeup source enable) register.  Writing '1'
enables a wakesource, 0 disables it.

The 'timer_timeout' node holds the timeout in seconds after which the
TOYMATCH2 event should wake the system.

The 'wakesrc' node holds the SYS_WAKESRC register after wakeup (in hex),
the 'wakemsk' node can be used to get/set the wakeup mask directly.

'uptime' gives access to the TOY counter value; it can be used for example
to track total time in seconds since last kernel boot.

For example, to have the timer wake the system after 10 seconds of sleep,
the following must be done in userspace:

echo 10 > /sys/power/db1x/timer_timeout
echo 1 > /sys/power/db1x/timer
echo mem > /sys/power/sleep

This patch also removes the homebrew CPU frequency switching code.  I don't
understand how it could have ever worked reliably; it does not communicate
the clock changes to other devices tied to BCLK and does not adjust memory
controller timings (which is not a problem when the CPU is never clocked
higher than what was set by the bootloader).

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/irq.c         |   57 +----
 arch/mips/au1000/common/platform.c    |  423 ++++++++++++++-------------------
 include/asm-mips/mach-au1x00/au1000.h |    4 +
 3 files changed, 193 insertions(+), 291 deletions(-)

diff --git a/arch/mips/au1000/common/irq.c b/arch/mips/au1000/common/irq.c
index 40c6cec..f5489c3 100644
--- a/arch/mips/au1000/common/irq.c
+++ b/arch/mips/au1000/common/irq.c
@@ -44,8 +44,6 @@
 
 void (*board_init_irq)(void) __initdata = NULL;
 
-static DEFINE_SPINLOCK(irq_lock);
-
 #ifdef CONFIG_PM
 
 /*
@@ -130,7 +128,7 @@ void restore_au1xxx_intctl(void)
 #endif /* CONFIG_PM */
 
 
-inline void local_enable_irq(unsigned int irq_nr)
+static void local_enable_irq(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
 
@@ -145,7 +143,7 @@ inline void local_enable_irq(unsigned int irq_nr)
 }
 
 
-inline void local_disable_irq(unsigned int irq_nr)
+static void local_disable_irq(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
 
@@ -160,7 +158,7 @@ inline void local_disable_irq(unsigned int irq_nr)
 }
 
 
-static inline void mask_and_ack_rise_edge_irq(unsigned int irq_nr)
+static void mask_and_ack_rise_edge_irq(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
 
@@ -175,7 +173,7 @@ static inline void mask_and_ack_rise_edge_irq(unsigned int irq_nr)
 }
 
 
-static inline void mask_and_ack_fall_edge_irq(unsigned int irq_nr)
+static void mask_and_ack_fall_edge_irq(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
 
@@ -190,7 +188,7 @@ static inline void mask_and_ack_fall_edge_irq(unsigned int irq_nr)
 }
 
 
-static inline void mask_and_ack_either_edge_irq(unsigned int irq_nr)
+static void mask_and_ack_either_edge_irq(unsigned int irq_nr)
 {
 	unsigned int bit = irq_nr - AU1000_INTC0_INT_BASE;
 
@@ -210,7 +208,7 @@ static inline void mask_and_ack_either_edge_irq(unsigned int irq_nr)
 	au_sync();
 }
 
-static inline void mask_and_ack_level_irq(unsigned int irq_nr)
+static void mask_and_ack_level_irq(unsigned int irq_nr)
 {
 	local_disable_irq(irq_nr);
 	au_sync();
@@ -235,49 +233,6 @@ static void end_irq(unsigned int irq_nr)
 #endif
 }
 
-unsigned long save_local_and_disable(int controller)
-{
-	int i;
-	unsigned long flags, mask;
-
-	spin_lock_irqsave(&irq_lock, flags);
-	if (controller) {
-		mask = au_readl(IC1_MASKSET);
-		for (i = 32; i < 64; i++)
-			local_disable_irq(i);
-	} else {
-		mask = au_readl(IC0_MASKSET);
-		for (i = 0; i < 32; i++)
-			local_disable_irq(i);
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
-				local_enable_irq(i + 32);
-			else
-				local_enable_irq(i);
-		}
-
-	if (controller)
-		new_mask = au_readl(IC1_MASKSET);
-	else
-		new_mask = au_readl(IC0_MASKSET);
-
-	spin_unlock_irqrestore(&irq_lock, flags);
-}
-
-
 static struct irq_chip rise_edge_irq_type = {
 	.name		= "Au1000 Rise Edge",
 	.ack		= mask_and_ack_rise_edge_irq,
diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index fd8f27e..01aa504 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -23,10 +23,6 @@
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/interrupt.h>
-#include <linux/pm.h>
-#include <linux/spinlock.h>
-#include <linux/sysctl.h>
-#include <linux/uaccess.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 
@@ -336,269 +332,214 @@ arch_initcall(au1xxx_platform_init);
 
 #ifdef CONFIG_PM
 
-static DEFINE_SPINLOCK(pm_lock);
+/*
+ * Generic suspend for db1x.
+ * This codes exports a few sysfs nodes under /sys/power/db1x/
+ * which can be used by userspace to en/disable certain wakeup sources
+ * and configure the timeout after which the the TOYMATCH2 irq is to
+ * trigger a wakeup.
+ */
+
+#include <linux/kobject.h>
+#include <linux/suspend.h>
+#include <linux/sysfs.h>
 
-extern unsigned long save_local_and_disable(int controller);
-extern void restore_local_and_enable(int controller, unsigned long mask);
-extern void local_enable_irq(unsigned int irq_nr);
 extern void au_sleep(void);
 
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
+static unsigned long db1x_pm_sleep_secs;
+static unsigned long db1x_pm_wakemsk;
+static unsigned long db1x_pm_last_wakesrc;
 
-static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
-		       void __user *buffer, size_t *len, loff_t *ppos)
+static int db1x_pm_enter(suspend_state_t state)
 {
-	unsigned long wakeup, flags;
-#ifdef SLEEP_TEST_TIMEOUT
-#define TMPBUFLEN2 16
-	char buf[TMPBUFLEN2], *p;
-#endif
+	/* enable GPIO based wakeup */
+	au_writel(1, SYS_PININPUTEN);
+	au_sync();
 
-	spin_lock_irqsave(&pm_lock, flags);
+	/* clear and setup wake cause and source */
+	au_writel(0, SYS_WAKEMSK);
+	au_sync();
+	au_writel(0, SYS_WAKESRC);
+	au_sync();
 
-	if (!write) {
-		*len = 0;
-		spin_unlock_irqrestore(&pm_lock, flags);
-		return 0;
-	}
+	au_writel(db1x_pm_wakemsk, SYS_WAKEMSK);
+	au_sync();
 
-#ifdef SLEEP_TEST_TIMEOUT
-	if (*len > TMPBUFLEN2 - 1)
-		return -EFAULT;
-	if (copy_from_user(buf, buffer, *len))
-		return -EFAULT;
-	buf[*len] = 0;
-	p = buf;
-	sleep_ticks = simple_strtoul(p, &p, 0);
-#endif
+	/* setup 1Hz-timer-based wakeup */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20)
+		asm volatile ("nop");
 
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
-#endif
-	au_writel(1, SYS_WAKESRC);	/* clear cause */
-	au_sync();
-	au_writel(wakeup, SYS_WAKEMSK);
+	au_writel(au_readl(SYS_TOYREAD) + db1x_pm_sleep_secs, SYS_TOYMATCH2);
 	au_sync();
 
-	au_sleep();
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20)
+		asm volatile ("nop");
 
-	spin_unlock_irqrestore(&pm_lock, flags);
+	/* ...and now the sandman can come! */
+	au_sleep();
 
 	return 0;
 }
 
-#if !defined(CONFIG_SOC_AU1200) && !defined(CONFIG_SOC_AU1550)
-/*
- * This is the number of bits of precision for the loops_per_jiffy.
- * Each bit takes on average 1.5/HZ seconds.  This (like the original)
- * is a little better than 1%.
- */
-#define LPS_PREC 8
-
-static void au1000_calibrate_delay(void)
+static int db1x_pm_begin(suspend_state_t state)
 {
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
+	if (!db1x_pm_wakemsk) {
+		printk(KERN_ERR "db1x: no wakeup source activated!\n");
+		return -EINVAL;
 	}
 
-	/*
-	 * Do a binary approximation to get loops_per_jiffy set to be equal
-	 * one clock (up to lps_precision bits)
+	return 0;
+}
+
+static void db1x_pm_end(void)
+{
+	/* read and store wakeup source, the clear the register. To
+	 * be able to clear it, WAKEMSK must be cleared first.
 	 */
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
+	db1x_pm_last_wakesrc = au_readl(SYS_WAKESRC);
+
+	au_writel(0, SYS_WAKEMSK);
+	au_writel(0, SYS_WAKESRC);
+	au_sync();
+
 }
 
-static int pm_do_freq(ctl_table *ctl, int write, struct file *file,
-		      void __user *buffer, size_t *len, loff_t *ppos)
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
 {
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
+	else if (ATTRCMP(uptime))
+		return sprintf(buf, "%lu\n",
+				(unsigned long)au_readl(SYS_TOYREAD));
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
 	}
 
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
+	return -ENOENT;
 }
-#endif
 
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
+		if (instr[0] != '0')
+			db1x_pm_wakemsk |= SYS_WAKEMSK_GPIO(tmp);
+		else
+			db1x_pm_wakemsk &= ~SYS_WAKEMSK_GPIO(tmp);
+
+	} else if (ATTRCMP(uptime)) {
+		tmp = strict_strtoul(instr, 0, &l);
+		if (tmp)
+			return tmp;
+
+		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
+			asm volatile ("nop");
+		au_writel(l, SYS_TOYWRITE);
+		au_sync();
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
+ATTR(uptime)		/* contents of SYS_TOYREAD */
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
+	ATTR_LIST(uptime),
+	ATTR_LIST(wakesrc),
+	ATTR_LIST(wakemsk),
+	NULL,		/* terminator */
 };
 
-static struct ctl_table pm_dir_table[] = {
-	{
-		.ctl_name	= CTL_UNNUMBERED,
-		.procname	= "pm",
-		.mode		= 0555,
-		.child		= pm_table
-	},
-	{}
+static struct attribute_group db1x_pmattr_group = {
+	.name	= "db1x",
+	.attrs	= db1x_pmattrs,
 };
 
 /*
@@ -614,14 +555,16 @@ static int __init pm_init(void)
 	au_writel(0, SYS_TOYWRITE);
 	au_sync();
 
+	db1x_pm_last_wakesrc = au_readl(SYS_WAKESRC);
+
 	au_writel(0, SYS_WAKESRC);
 	au_sync();
 	au_writel(0, SYS_WAKEMSK);
 	au_sync();
 
-	register_sysctl_table(pm_dir_table);
+	suspend_set_ops(&db1x_pm_ops);
 
-	return 0;
+	return sysfs_create_group(power_kobj, &db1x_pmattr_group);
 }
 
 __initcall(pm_init);
diff --git a/include/asm-mips/mach-au1x00/au1000.h b/include/asm-mips/mach-au1x00/au1000.h
index 7245960..639480e 100644
--- a/include/asm-mips/mach-au1x00/au1000.h
+++ b/include/asm-mips/mach-au1x00/au1000.h
@@ -1561,6 +1561,10 @@ enum soc_au1200_ints {
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
1.5.6.3
