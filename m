Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 23:08:15 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:31880 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133463AbWDEWID (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 23:08:03 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FRGJ3-0004Ik-BR
	for linux-mips@linux-mips.org; Thu, 06 Apr 2006 00:16:54 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FRGLd-00051T-OX
	for linux-mips@linux-mips.org; Thu, 06 Apr 2006 00:19:33 +0200
Date:	Thu, 6 Apr 2006 00:19:33 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Linux MIPS <linux-mips@linux-mips.org>
Message-ID: <20060405221933.GN7029@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="q7oacCJraRPxsh4K"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] sysfs interface for Au1xxx power management
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--q7oacCJraRPxsh4K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

here a patch to support new sysfs interface for Au1xxx's power
management. Now we can put the system into sleeping mode by using:

   hostname:~# echo mem > /sys/power/state 

The patch keeps also the file "/proc/sys/pm/freq" from the old
interface.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--q7oacCJraRPxsh4K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pm-sysfs

--- /home/develop/embedded/mipsel/linux/linux-mips.git/arch/mips/au1000/common/power.c	2006-03-31 16:57:26.000000000 +0200
+++ arch/mips/au1000/common/power.c	2006-04-06 00:08:59.000000000 +0200
@@ -1,6 +1,11 @@
 /*
  * BRIEF MODULE DESCRIPTION
- *	Au1000 Power Management routines.
+ *	Au1xxx Power Management routines (sysfs and procfs interfaces).
+ *
+ * Copyright 2006 Rodolfo Giometti <giometti@linux.it>
+ *
+ * Based on some previous version's functions, so I report below the previous
+ * copyright message:
  *
  * Copyright 2001 MontaVista Software Inc.
  * Author: MontaVista Software, Inc.
@@ -32,7 +37,6 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pm.h>
-#include <linux/pm_legacy.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/jiffies.h>
@@ -43,18 +47,17 @@
 #include <asm/system.h>
 #include <asm/cacheflush.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/power.h>
 
-#ifdef CONFIG_PM
+static unsigned long cpu_freq;
 
-#define DEBUG 1
+//#define DEBUG 1
 #ifdef DEBUG
 #  define DPRINTK(fmt, args...)	printk("%s: " fmt, __FUNCTION__ , ## args)
 #else
 #  define DPRINTK(fmt, args...)
 #endif
 
-static void au1000_calibrate_delay(void);
-
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
 extern unsigned long get_au1x00_uart_baud_base(void);
@@ -64,9 +67,9 @@
 extern void local_enable_irq(unsigned int irq_nr);
 
 /* Quick acpi hack. This will have to change! */
-#define	CTL_ACPI 9999
-#define	ACPI_S1_SLP_TYP 19
-#define	ACPI_SLEEP 21
+#define	CTL_ACPI	9999
+#define	ACPI_S1_SLP_TYP	19
+#define	ACPI_SLEEP	21
 
 
 static DEFINE_SPINLOCK(pm_lock);
@@ -83,6 +86,7 @@
 static uint	sleep_aux_pll_cntrl;
 static uint	sleep_cpu_pll_cntrl;
 static uint	sleep_pin_function;
+static uint	sleep_gpio2_enable;
 static uint	sleep_uart0_inten;
 static uint	sleep_uart0_fifoctl;
 static uint	sleep_uart0_linectl;
@@ -92,16 +96,45 @@
 static uint	sleep_usbdev_enable;
 static uint	sleep_static_memctlr[4][3];
 
-/* Define this to cause the value you write to /proc/sys/pm/sleep to
- * set the TOY timer for the amount of time you want to sleep.
- * This is done mainly for testing, but may be useful in other cases.
- * The value is number of 32KHz ticks to sleep.
- */
-#define SLEEP_TEST_TIMEOUT 1
-#ifdef SLEEP_TEST_TIMEOUT
-static	int	sleep_ticks;
-void wakeup_counter0_set(int ticks);
-#endif
+/* This is the number of bits of precision for the loops_per_jiffy.  Each
+   bit takes on average 1.5/HZ seconds.  This (like the original) is a little
+   better than 1% */
+#define LPS_PREC 8
+
+static void au1000_calibrate_delay(void)
+{
+	unsigned long ticks, loopbit;
+	int lps_precision = LPS_PREC;
+
+	loops_per_jiffy = (1 << 12);
+
+	while (loops_per_jiffy <<= 1) {
+		/* wait for "start of" clock tick */
+		ticks = jiffies;
+		while (ticks == jiffies)
+			/* nothing */ ;
+		/* Go .. */
+		ticks = jiffies;
+		__delay(loops_per_jiffy);
+		ticks = jiffies - ticks;
+		if (ticks)
+			break;
+	}
+
+/* Do a binary approximation to get loops_per_jiffy set to equal one clock
+   (up to lps_precision bits) */
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
 
 static void
 save_core_regs(void)
@@ -147,6 +180,7 @@
 	sleep_cpu_pll_cntrl = au_readl(SYS_CPUPLL);
 
 	sleep_pin_function = au_readl(SYS_PINFUNC);
+	sleep_gpio2_enable = au_readl(GPIO2_ENABLE);
 
 	/* Save the static memory controller configuration.
 	*/
@@ -173,6 +207,7 @@
 	au_writel(sleep_aux_pll_cntrl, SYS_AUXPLL); au_sync();
 	au_writel(sleep_cpu_pll_cntrl, SYS_CPUPLL); au_sync();
 	au_writel(sleep_pin_function, SYS_PINFUNC); au_sync();
+	au_writel(sleep_gpio2_enable, GPIO2_ENABLE); au_sync();
 
 	/* Restore the static memory controller configuration.
 	*/
@@ -206,47 +241,48 @@
 	wakeup_counter0_adjust();
 }
 
-unsigned long suspend_mode;
-
-void wakeup_from_suspend(void)
-{
-	suspend_mode = 0;
-}
+void wakeup_counter0_set(int ticks);
+int (*board_before_sleep)(void);
+void (*board_after_sleep)(int reason);
 
-int au_sleep(void)
+int au_sleep(int reason, int force)
 {
+	int ticks = 0;
 	unsigned long wakeup, flags;
-	extern	void	save_and_sleep(void);
+	int board_reason = 0;
 
-	spin_lock_irqsave(&pm_lock,flags);
+	/* We need to configure the GPIO or timer interrupts that will bring
+	 * us out of sleep, so we use the specific board wake up source
+	 * (if present) */
+	if (board_before_sleep)
+		board_reason = board_before_sleep();
+	if (!force)
+		reason = board_reason;
+
+	spin_lock_irqsave(&pm_lock, flags);
 
 	save_core_regs();
 
 	flush_cache_all();
 
-	/** The code below is all system dependent and we should probably
-	 ** have a function call out of here to set this up.  You need
-	 ** to configure the GPIO or timer interrupts that will bring
-	 ** you out of sleep.
-	 ** For testing, the TOY counter wakeup is useful.
-	 **/
-
-#if 0
-	au_writel(au_readl(SYS_PINSTATERD) & ~(1 << 11), SYS_PINSTATERD);
-
-	/* gpio 6 can cause a wake up event */
-	wakeup = au_readl(SYS_WAKEMSK);
-	wakeup &= ~(1 << 8);	/* turn off match20 wakeup */
-	wakeup |= 1 << 6;	/* turn on gpio 6 wakeup   */
-#else
-	/* For testing, allow match20 to wake us up.
-	*/
-#ifdef SLEEP_TEST_TIMEOUT
-	wakeup_counter0_set(sleep_ticks);
-#endif
-	wakeup = 1 << 8;	/* turn on match20 wakeup   */
-	wakeup = 0;
-#endif
+	if (reason == 0)		/* machine_halt() */
+		wakeup = 0;
+	else if (reason < 0) {		/* TOY wake up */
+		ticks = -reason*HZ;
+		wakeup_counter0_set(ticks);
+		wakeup = 1<<8;		/* turn on match20 as wake up */
+	}
+	else {				/* GPIO[0-7] wake up */
+		/* FIXME: this setting for GPIO[6] should be into specific
+		 *        boards setup... */
+		/* We force pin GPIO[6]/SMROMCKE as gpio6 */
+		au_writel(au_readl(SYS_PINSTATERD)&~(1<<11), SYS_PINSTATERD);
+
+		wakeup = reason&0x0ff;	/* turn on selected gpio as wake up */
+	}
+	printk(KERN_DEBUG "%s - reason %x force %x wakeup %lx ticks %x\n",
+	       __FUNCTION__, reason, force, wakeup, ticks);
+
 	au_writel(1, SYS_WAKESRC);	/* clear cause */
 	au_sync();
 	au_writel(wakeup, SYS_WAKEMSK);
@@ -254,102 +290,52 @@
 
 	save_and_sleep();
 
-	/* after a wakeup, the cpu vectors back to 0x1fc00000 so
+	/* after a wake up, the cpu vectors back to 0x1fc00000 so
 	 * it's up to the boot code to get us back here.
 	 */
 	restore_core_regs();
-	spin_unlock_irqrestore(&pm_lock, flags);
-	return 0;
-}
-
-static int pm_do_sleep(ctl_table * ctl, int write, struct file *file,
-		       void __user *buffer, size_t * len, loff_t *ppos)
-{
-	int retval = 0;
-#ifdef SLEEP_TEST_TIMEOUT
-#define TMPBUFLEN2 16
-	char buf[TMPBUFLEN2], *p;
-#endif
-
-	if (!write) {
-		*len = 0;
-	} else {
-#ifdef SLEEP_TEST_TIMEOUT
-		if (*len > TMPBUFLEN2 - 1) {
-			return -EFAULT;
-		}
-		if (copy_from_user(buf, buffer, *len)) {
-			return -EFAULT;
-		}
-		buf[*len] = 0;
-		p = buf;
-		sleep_ticks = simple_strtoul(p, &p, 0);
-#endif
-		retval = pm_send_all(PM_SUSPEND, (void *) 2);
-
-		if (retval)
-			return retval;
-
-		au_sleep();
-		retval = pm_send_all(PM_RESUME, (void *) 0);
-	}
-	return retval;
-}
 
-static int pm_do_suspend(ctl_table * ctl, int write, struct file *file,
-			 void __user *buffer, size_t * len, loff_t *ppos)
-{
-	int retval = 0;
+	spin_unlock_irqrestore(&pm_lock, flags);
 
-	if (!write) {
-		*len = 0;
-	} else {
-		retval = pm_send_all(PM_SUSPEND, (void *) 2);
-		if (retval)
-			return retval;
-		suspend_mode = 1;
+	/* Get wake up source */
+	reason = au_readl(SYS_WAKESRC)>>18;
+	if (reason&(1<<8))		/* Wake up thanks to TOY */
+		reason = -ticks*HZ;
+
+	/* Call specific board routine */
+	if (board_after_sleep)
+		board_after_sleep(reason);
 
-		retval = pm_send_all(PM_RESUME, (void *) 0);
-	}
-	return retval;
+	return 0;
 }
 
-
-static int pm_do_freq(ctl_table * ctl, int write, struct file *file,
+static int au1xxx_pm_do_freq(ctl_table * ctl, int write, struct file *file,
 		      void __user *buffer, size_t * len, loff_t *ppos)
 {
 	int retval = 0, i;
-	unsigned long val, pll;
-#define TMPBUFLEN 64
-#define MAX_CPU_FREQ 396
-	char buf[TMPBUFLEN], *p;
+	unsigned long *valp = (unsigned long *) ctl->data;
+	unsigned long pll;
 	unsigned long flags, intc0_mask, intc1_mask;
 	unsigned long old_baud_base, old_cpu_freq, baud_rate, old_clk,
 	    old_refresh;
 	unsigned long new_baud_base, new_cpu_freq, new_clk, new_refresh;
 
 	spin_lock_irqsave(&pm_lock, flags);
-	if (!write) {
+
+	if (!write)
 		*len = 0;
-	} else {
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
+
+	retval = proc_dointvec(ctl, write, file, buffer, len, ppos);
+
+#define MAX_CPU_FREQ 396
+	if (write) {
+		/* Check the new frequency */
+		if (*valp > MAX_CPU_FREQ) {
 			spin_unlock_irqrestore(&pm_lock, flags);
 			return -EFAULT;
 		}
 
-		pll = val / 12;
+		pll = *valp / 12;
 		if ((pll > 33) || (pll < 7)) {	/* 396 MHz max, 84 MHz min */
 			/* revisit this for higher speed cpus */
 			spin_unlock_irqrestore(&pm_lock, flags);
@@ -424,72 +410,66 @@
 	return retval;
 }
 
+/*
+ * Called after processes are frozen, but before we shut down devices.
+ */
+int au1xxx_pm_prepare(suspend_state_t state)
+{
+	DPRINTK("state = %d\n", state);
+	return 0;
+}
 
-static struct ctl_table pm_table[] = {
-	{ACPI_S1_SLP_TYP, "suspend", NULL, 0, 0600, NULL, &pm_do_suspend},
-	{ACPI_SLEEP, "sleep", NULL, 0, 0600, NULL, &pm_do_sleep},
-	{CTL_ACPI, "freq", NULL, 0, 0600, NULL, &pm_do_freq},
-	{0}
-};
-
-static struct ctl_table pm_dir_table[] = {
-	{CTL_ACPI, "pm", NULL, 0, 0555, pm_table},
-	{0}
-};
+/*
+ * Called after down devices.
+ */
+int au1xxx_pm_enter(suspend_state_t state)
+{
+	DPRINTK("state = %d\n", state);
+	return au_sleep(1<<6 /* GPIO 6 */, 1);
+	/* return au_sleep(-3, 1); */ /* wake up after 3 seconds */
+}
 
 /*
- * Initialize power interface
+ * Called after devices are re-setup, but before processes are thawed.
  */
-static int __init pm_init(void)
+int au1xxx_pm_finish(suspend_state_t state)
 {
-	register_sysctl_table(pm_dir_table, 1);
+	DPRINTK("state = %d\n", state);
 	return 0;
 }
 
-__initcall(pm_init);
-
+/*
+ * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
+ */
+static struct pm_ops au1xxx_pm_ops = {
+	.pm_disk_mode	= PM_DISK_FIRMWARE,
+	.prepare	= au1xxx_pm_prepare,
+	.enter		= au1xxx_pm_enter,
+	.finish		= au1xxx_pm_finish,
+};
 
 /*
- * This is right out of init/main.c
+ * Set up the old "/proc/sys/pm" interface.
  */
+static struct ctl_table au1xxx_pm_table[] = {
+	{ CTL_ACPI, "freq", &cpu_freq, sizeof(int), 0600, NULL, &au1xxx_pm_do_freq },
+	{ 0 },
+};
 
-/* This is the number of bits of precision for the loops_per_jiffy.  Each
-   bit takes on average 1.5/HZ seconds.  This (like the original) is a little
-   better than 1% */
-#define LPS_PREC 8
+static struct ctl_table pm_dir_table[] = {
+	{ CTL_ACPI, "pm", NULL, 0, 0555, au1xxx_pm_table },
+	{ 0 },
+};
 
-static void au1000_calibrate_delay(void)
+static int __init au1xxx_pm_init(void)
 {
-	unsigned long ticks, loopbit;
-	int lps_precision = LPS_PREC;
-
-	loops_per_jiffy = (1 << 12);
+	/* The new interface */
+	pm_set_ops(&au1xxx_pm_ops);
 
-	while (loops_per_jiffy <<= 1) {
-		/* wait for "start of" clock tick */
-		ticks = jiffies;
-		while (ticks == jiffies)
-			/* nothing */ ;
-		/* Go .. */
-		ticks = jiffies;
-		__delay(loops_per_jiffy);
-		ticks = jiffies - ticks;
-		if (ticks)
-			break;
-	}
+	/* The old interface */
+	register_sysctl_table(pm_dir_table, 1);
 
-/* Do a binary approximation to get loops_per_jiffy set to equal one clock
-   (up to lps_precision bits) */
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
+	return 0;
 }
-#endif				/* CONFIG_PM */
+
+device_initcall(au1xxx_pm_init);

--q7oacCJraRPxsh4K--
