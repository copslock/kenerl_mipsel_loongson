Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FD6iF17278
	for linux-mips-outgoing; Fri, 15 Feb 2002 05:06:44 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FD6F917263;
	Fri, 15 Feb 2002 05:06:15 -0800
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 225F8B489; Fri, 15 Feb 2002 13:06:14 +0100 (CET)
Date: Fri, 15 Feb 2002 13:06:14 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: ip22 watchdog timer
Message-ID: <20020215130613.A301@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
References: <20020208172711.GA5605@bogon.ms20.nix> <20020215055620.A25211@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020215055620.A25211@dea.linux-mips.net>; from ralf@oss.sgi.com on Fri, Feb 15, 2002 at 05:56:20AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2002 at 05:56:20AM +0100, Ralf Baechle wrote:
> On Fri, Feb 08, 2002 at 06:27:11PM +0100, Guido Guenther wrote:
> 
> > attached is an updated patch for the ip22 watchdog timer. Please apply.
> 
> Patch doesn't apply cleanly.
Artifacts of my other IP22 patches, I moved the config stuff to the
other watchdog drivers in drivers/char/Config.in now. Applies cleanly on
fresh 2.4.17 CVS checkout.
 -- Guido

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="indydog-2002-02-15.diff"

diff --exclude=CVS -Naur linux-2.4.17.orig/Documentation/Configure.help linux-2.4.17/Documentation/Configure.help
--- linux-2.4.17.orig/Documentation/Configure.help	Sat Dec 29 06:37:46 2001
+++ linux-2.4.17/Documentation/Configure.help	Fri Feb 15 09:55:06 2002
@@ -3129,6 +3129,13 @@
   via the file /proc/rtc and its behaviour is set by various ioctls on
   /dev/rtc.
 
+Indy/I2 Hardware Watchdog
+CONFIG_INDYDOG
+  Hardwaredriver for the Indy's/I2's watchdog. This is a
+  watchdog timer that will reboot the machine after a 60 second 
+  timer expired and no process has written to /dev/watchdog during
+  that time.
+
 Support the Bell Technologies HUB6 card
 CONFIG_HUB6
   Say Y here to enable support in the dumb serial driver to support
diff --exclude=CVS -Naur linux-2.4.17.orig/arch/mips/sgi-ip22/ip22-mc.c linux-2.4.17/arch/mips/sgi-ip22/ip22-mc.c
--- linux-2.4.17.orig/arch/mips/sgi-ip22/ip22-mc.c	Tue Nov 27 16:57:11 2001
+++ linux-2.4.17/arch/mips/sgi-ip22/ip22-mc.c	Fri Feb 15 09:55:07 2002
@@ -82,6 +82,14 @@
 	 * interrupts are first enabled etc.
 	 */
 
+	/* Step 0: Make sure we turn off the watchdog in case it's
+	 *         still running (which might be the case after a
+	 *         soft reboot).
+	 */
+	tmpreg = mcmisc_regs->cpuctrl0; 
+	tmpreg &= ~SGIMC_CCTRL0_WDOG;
+	mcmisc_regs->cpuctrl0 = tmpreg;
+
 	/* Step 1: The CPU/GIO error status registers will not latch
 	 *         up a new error status until the register has been
 	 *         cleared by the cpu.  These status registers are
diff --exclude=CVS -Naur linux-2.4.17.orig/drivers/char/Config.in linux-2.4.17/drivers/char/Config.in
--- linux-2.4.17.orig/drivers/char/Config.in	Sun Dec  2 12:34:40 2001
+++ linux-2.4.17/drivers/char/Config.in	Fri Feb 15 10:00:59 2002
@@ -199,6 +199,7 @@
    tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
    tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
+   tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
 fi
 endmenu
 
diff --exclude=CVS -Naur linux-2.4.17.orig/drivers/char/Makefile linux-2.4.17/drivers/char/Makefile
--- linux-2.4.17.orig/drivers/char/Makefile	Mon Jan  7 04:33:54 2002
+++ linux-2.4.17/drivers/char/Makefile	Fri Feb 15 09:55:07 2002
@@ -245,6 +245,7 @@
 obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
+obj-$(CONFIG_INDYDOG) += indydog.o
 
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
diff --exclude=CVS -Naur linux-2.4.17.orig/drivers/char/indydog.c linux-2.4.17/drivers/char/indydog.c
--- linux-2.4.17.orig/drivers/char/indydog.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.17/drivers/char/indydog.c	Fri Feb 15 09:55:07 2002
@@ -0,0 +1,158 @@
+/*
+ *	IndyDog	0.2	A Hardware Watchdog Device for SGI IP22
+ *
+ *	(c) Copyright 2002 Guido Guenther <agx@sigxcpu.org>, All Rights Reserved.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *	
+ *	based on softdog.c by Alan Cox <alan@redhat.com>
+ */
+ 
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <asm/sgi/sgimc.h>
+
+static int indydog_alive;
+static struct sgimc_misc_ctrl *mcmisc_regs; 
+
+static void indydog_ping()
+{
+	mcmisc_regs->watchdogt = 0;
+}
+
+
+/*
+ *	Allow only one person to hold it open
+ */
+
+static int indydog_open(struct inode *inode, struct file *file)
+{
+	u32 mc_ctrl0;
+	
+	if(indydog_alive)
+		return -EBUSY;
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+	MOD_INC_USE_COUNT;
+#endif
+	/*
+	 *	Activate timer
+	 */
+	mcmisc_regs = (struct sgimc_misc_ctrl *)(KSEG1+0x1fa00000);
+
+	mc_ctrl0 = mcmisc_regs->cpuctrl0 | SGIMC_CCTRL0_WDOG;
+	mcmisc_regs->cpuctrl0 = mc_ctrl0;
+	indydog_ping();
+			
+	indydog_alive=1;
+	printk("Started watchdog timer.\n");
+	return 0;
+}
+
+static int indydog_release(struct inode *inode, struct file *file)
+{
+	/*
+	 *	Shut off the timer.
+	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
+	 */
+	 lock_kernel();
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	{
+	u32 mc_ctrl0 = mcmisc_regs->cpuctrl0; 
+	mc_ctrl0 &= ~SGIMC_CCTRL0_WDOG;
+	mcmisc_regs->cpuctrl0 = mc_ctrl0;
+	printk("Stopped watchdog timer.\n");
+	}
+#endif
+	indydog_alive=0;
+	unlock_kernel();
+	return 0;
+}
+
+static ssize_t indydog_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	/*
+	 *	Refresh the timer.
+	 */
+	if(len) {
+		indydog_ping();
+		return 1;
+	}
+	return 0;
+}
+
+static int indydog_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		identity: "Hardware Watchdog for SGI IP22",
+	};
+	switch (cmd) {
+		default:
+			return -ENOIOCTLCMD;
+		case WDIOC_GETSUPPORT:
+			if(copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
+				return -EFAULT;
+			return 0;
+		case WDIOC_GETSTATUS:
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(0,(int *)arg);
+		case WDIOC_KEEPALIVE:
+			indydog_ping();
+			return 0;
+	}
+}
+
+static struct file_operations indydog_fops = {
+	owner:		THIS_MODULE,
+	write:		indydog_write,
+	ioctl:		indydog_ioctl,
+	open:		indydog_open,
+	release:	indydog_release,
+};
+
+static struct miscdevice indydog_miscdev = {
+	minor:		WATCHDOG_MINOR,
+	name:		"watchdog",
+	fops:		&indydog_fops,
+};
+
+static const char banner[] __initdata = KERN_INFO "Hardware Watchdog Timer for SGI IP22: 0.2\n";
+
+static int __init watchdog_init(void)
+{
+	int ret;
+
+	ret = misc_register(&indydog_miscdev);
+
+	if (ret)
+		return ret;
+
+	printk(banner);
+
+	return 0;
+}
+
+static void __exit watchdog_exit(void)
+{
+	misc_deregister(&indydog_miscdev);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_exit);
+MODULE_LICENSE("GPL");

--8t9RHnE3ZwKMSgU+--
