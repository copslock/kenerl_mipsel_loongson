Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2005 15:17:16 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:55952 "EHLO
	zaigor.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133505AbVJNOQ4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Oct 2005 15:16:56 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1EQQMS-0003LC-00
	for <linux-mips@linux-mips.org>; Fri, 14 Oct 2005 16:16:40 +0200
Date:	Fri, 14 Oct 2005 16:16:40 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: about au_sleep for au1x00
Message-ID: <20051014141640.GS6808@enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sSWUSaCcagxd8grv"
Content-Disposition: inline
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--sSWUSaCcagxd8grv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

attached is my proposal for a new (and better? :) implementation of
au_sleep() function (patch is against vanilla MIPS 2.6.12).

My patch adds two board specific functions whose are called before and
after CPU sleeping. This can be useful to setup hardware for sleeping
and also to ask to the board which should be the wake up reason (GPIO,
TOY).

Patch also fixes data reading from files /proc/sys/pm/{sleep,freq}.

What is still obscure to me is how I can use the au_sleep() in order
to ibernate the system... or better... how I can resume form
ibarnation. In fact the system reboots correctly but it start from the
beginning! What I have to do in order to have the system restart from
ibarnation? My boot loader is u-boot 1.1.3.

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--sSWUSaCcagxd8grv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ausleep.patch"

Index: arch/mips/au1000/common/power.c
===================================================================
RCS file: /home/develop/cvs_private/linux-mips-exadron/arch/mips/au1000/common/power.c,v
retrieving revision 1.1.1.1
retrieving revision 1.4
diff -u -r1.1.1.1 -r1.4
--- a/arch/mips/au1000/common/power.c	2 Jul 2005 06:45:44 -0000	1.1.1.1
+++ b/arch/mips/au1000/common/power.c	14 Oct 2005 13:39:43 -0000	1.4
@@ -34,12 +34,18 @@
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/jiffies.h>
 
 #include <asm/string.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include <asm/cacheflush.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/power.h>
+
+static int sleep_ticks;
+static unsigned long cpu_freq;
 
 #ifdef CONFIG_PM
 
@@ -50,7 +56,7 @@
 #  define DPRINTK(fmt, args...)
 #endif
 
-static void calibrate_delay(void);
+static void au1000_calibrate_delay(void);
 
 extern void set_au1x00_speed(unsigned int new_freq);
 extern unsigned int get_au1x00_speed(void);
@@ -89,17 +95,6 @@
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
-
 static void
 save_core_regs(void)
 {
@@ -210,10 +205,23 @@
 	suspend_mode = 0;
 }
 
-int au_sleep(void)
+void wakeup_counter0_set(int ticks);
+int (*board_before_sleep)(void);
+void (*board_after_sleep)(int reason);
+
+int au_sleep(int reason, int force)
 {
+	int ticks;
 	unsigned long wakeup, flags;
-	extern	void	save_and_sleep(void);
+	int board_reason = 0;
+
+	/* We need to configure the GPIO or timer interrupts that will bring
+	 * us out of sleep, so we use the specific board wake up source
+	 * (if present) */
+	if (board_before_sleep)
+		board_reason = board_before_sleep();
+	if (!force)
+		reason = board_reason;
 
 	spin_lock_irqsave(&pm_lock,flags);
 
@@ -221,29 +229,22 @@
 
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
+		/* We force pin GPIO[6]/SMROMCKE as gpio6 */
+		au_writel(au_readl(SYS_PINSTATERD)&~(1<<11), SYS_PINSTATERD);
+
+		wakeup = reason&0x0ff;	/* turn on selected gpio as wake up */
+	}
+	printk("%s - reason %x force %x wakeup %x ticks %x\n",
+	       __FUNCTION__, reason, force, wakeup, ticks);
+
 	au_writel(1, SYS_WAKESRC);	/* clear cause */
 	au_sync();
 	au_writel(wakeup, SYS_WAKEMSK);
@@ -251,50 +252,50 @@
 
 	save_and_sleep();
 
-	/* after a wakeup, the cpu vectors back to 0x1fc00000 so
+	/* after a wake up, the cpu vectors back to 0x1fc00000 so
 	 * it's up to the boot code to get us back here.
 	 */
 	restore_core_regs();
+
 	spin_unlock_irqrestore(&pm_lock, flags);
+
+	/* Get wake up source */
+	reason = au_readl(SYS_WAKESRC)>>18;
+	if (reason&(1<<8))		/* Wake up thanks to TOY */
+		reason = -ticks*HZ;
+
+	/* Call specific board routine */
+	if (board_after_sleep)
+		board_after_sleep(reason);
+
 	return 0;
 }
 
-static int pm_do_sleep(ctl_table * ctl, int write, struct file *file,
-		       void *buffer, size_t * len)
+static int pm_do_sleep(ctl_table *ctl, int write, struct file *file,
+		       void __user *buffer, size_t *len, loff_t *ppos)
 {
 	int retval = 0;
-#ifdef SLEEP_TEST_TIMEOUT
-#define TMPBUFLEN2 16
-	char buf[TMPBUFLEN2], *p;
-#endif
+	int *valp = (int *) ctl->data;
 
-	if (!write) {
+	if (!write)
 		*len = 0;
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
 
+	retval = proc_dointvec(ctl, write, file, buffer, len, ppos);
+
+	if (write) {
+		retval = pm_send_all(PM_SUSPEND, (void *) 2);
 		if (retval)
 			return retval;
 
-		au_sleep();
+		au_sleep(*valp > 0 ? -*valp : 0, 1);
+
 		retval = pm_send_all(PM_RESUME, (void *) 0);
 	}
 	return retval;
 }
 
 static int pm_do_suspend(ctl_table * ctl, int write, struct file *file,
-			 void *buffer, size_t * len)
+			 void __user *buffer, size_t * len, loff_t *ppos)
 {
 	int retval = 0;
 
@@ -313,40 +314,32 @@
 
 
 static int pm_do_freq(ctl_table * ctl, int write, struct file *file,
-		      void *buffer, size_t * len)
+		      void __user *buffer, size_t * len, loff_t *ppos)
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
@@ -408,14 +401,14 @@
 
 
 	/* We don't want _any_ interrupts other than
-	 * match20. Otherwise our calibrate_delay()
+	 * match20. Otherwise our au1000_calibrate_delay()
 	 * calculation will be off, potentially a lot.
 	 */
 	intc0_mask = save_local_and_disable(0);
 	intc1_mask = save_local_and_disable(1);
 	local_enable_irq(AU1000_TOY_MATCH2_INT);
 	spin_unlock_irqrestore(&pm_lock, flags);
-	calibrate_delay();
+	au1000_calibrate_delay();
 	restore_local_and_enable(0, intc0_mask);
 	restore_local_and_enable(1, intc1_mask);
 	return retval;
@@ -424,8 +417,8 @@
 
 static struct ctl_table pm_table[] = {
 	{ACPI_S1_SLP_TYP, "suspend", NULL, 0, 0600, NULL, &pm_do_suspend},
-	{ACPI_SLEEP, "sleep", NULL, 0, 0600, NULL, &pm_do_sleep},
-	{CTL_ACPI, "freq", NULL, 0, 0600, NULL, &pm_do_freq},
+	{ACPI_SLEEP, "sleep", &sleep_ticks, sizeof(int), 0600, NULL, &pm_do_sleep},
+	{CTL_ACPI, "freq", &cpu_freq, sizeof(int), 0600, NULL, &pm_do_freq},
 	{0}
 };
 
@@ -455,7 +448,7 @@
    better than 1% */
 #define LPS_PREC 8
 
-static void calibrate_delay(void)
+static void au1000_calibrate_delay(void)
 {
 	unsigned long ticks, loopbit;
 	int lps_precision = LPS_PREC;
Index: arch/mips/au1000/common/reset.c
===================================================================
RCS file: /home/develop/cvs_private/linux-mips-exadron/arch/mips/au1000/common/reset.c,v
retrieving revision 1.1.1.1
retrieving revision 1.3
diff -u -r1.1.1.1 -r1.3
--- a/arch/mips/au1000/common/reset.c	2 Jul 2005 06:45:44 -0000	1.1.1.1
+++ b/arch/mips/au1000/common/reset.c	14 Oct 2005 13:40:27 -0000	1.3
@@ -36,8 +36,8 @@
 #include <asm/reboot.h>
 #include <asm/system.h>
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/power.h>
 
-extern int au_sleep(void);
 extern void (*flush_cache_all)(void);
 
 void au1000_restart(char *command)
@@ -176,7 +176,7 @@
 	au_writel((1 << 26) | (1 << 10), GPIO2_OUTPUT);
 #endif
 #ifdef CONFIG_PM
-	au_sleep();
+	au_sleep(0, 0);
 
 	/* should not get here */
 	printk(KERN_ERR "Unable to put cpu in sleep mode\n");
Index: include/asm-mips/mach-au1x00/power.h
===================================================================
RCS file: include/asm-mips/mach-au1x00/power.h
diff -N include/asm-mips/mach-au1x00/power.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ b/include/asm-mips/mach-au1x00/power.h	14 Oct 2005 13:41:29 -0000	1.2
@@ -0,0 +1,61 @@
+/*
+ *
+ * BRIEF MODULE DESCRIPTION
+ *	Include file for power management of Alchemy Semiconductor's
+ *	Au1k CPU.
+ *
+ * Copyright 2005 Rodolfo Giometti <giometti@linux.it>
+ * Author: Rodolfo Giometti <giometti@linux.it>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _AU1X00_POWER_H_
+#define _AU1X00_POWER_H_
+
+/* Save CPU state and go to sleep */
+extern void save_and_sleep(void);
+
+/* Do system settings before sleeping.
+ *
+ * If "reason" 
+ *    > 0  then we use GPIO[0-7] as wakeup source according to
+ *         bits set to "1" (ex. reason==5 set up as wake up sorces
+ *         GPIOs 0 and 2).
+ *    < 0  then we use "-reason" as sleeping seconds before wakeup.
+ *    == 0 then we consider machine_halt().
+ *
+ * If "force" != 0 then the "reason" value cannot be changed by
+ * function board_before_sleep() */
+extern int au_sleep(int reason, int force);
+
+/* These functions are called by au_sleep() before, and after,
+ * sleeping mode.
+ *
+ * These functions are defaulted to NULL and can remain so.
+ *
+ * Function "board_before_sleep()" returns an interger (called "reason")
+ * and function "board_after_sleep" takes "reason" as argument. Such
+ * parameter point the cause of sleeping mode as defined for au_sleep(). */
+extern int (*board_before_sleep)(void);
+extern void (*board_after_sleep)(int reason);
+
+#endif  /* _AU1X00_POWER_H_ */

--sSWUSaCcagxd8grv--
