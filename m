Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18HSVx05842
	for linux-mips-outgoing; Fri, 8 Feb 2002 09:28:31 -0800
Received: from mail.gmx.net (sproxy.gmx.de [213.165.64.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18HS5A05837
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 09:28:06 -0800
Received: (qmail 16460 invoked by uid 0); 8 Feb 2002 17:27:58 -0000
Received: from pd9e41821.dip.t-dialin.net (HELO bogon.ms20.nix) (217.228.24.33)
  by mail.gmx.net (mp011-rz3) with SMTP; 8 Feb 2002 17:27:58 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id 936B036BDC; Fri,  8 Feb 2002 18:27:11 +0100 (CET)
Date: Fri, 8 Feb 2002 18:27:11 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: ip22 watchdog timer
Message-ID: <20020208172711.GA5605@bogon.ms20.nix>
Mail-Followup-To: linux-mips@oss.sgi.com, ralf@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
attached is an updated patch for the ip22 watchdog timer. Please apply.
 -- Guido

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="indydog-2001-02-08.diff"

diff -Naur kernel-source-2.4.17.clean/Documentation/Configure.help kernel-source-2.4.17/Documentation/Configure.help
--- kernel-source-2.4.17.clean/Documentation/Configure.help	Wed Mar 26 05:57:18 2003
+++ kernel-source-2.4.17/Documentation/Configure.help	Wed Mar 26 18:50:52 2003
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
diff -Naur kernel-source-2.4.17.clean/arch/mips/config.in kernel-source-2.4.17/arch/mips/config.in
--- kernel-source-2.4.17.clean/arch/mips/config.in	Wed Mar 26 05:57:19 2003
+++ kernel-source-2.4.17/arch/mips/config.in	Wed Mar 26 19:03:33 2003
@@ -574,6 +574,11 @@
    fi
 # we always need the dummy console to make the serial console I2 happy
    define_bool CONFIG_DUMMY_CONSOLE y
+   bool 'Watchdog Timer Support'   CONFIG_WATCHDOG
+   if [ "$CONFIG_WATCHDOG" != "n" ]; then
+      bool '  Disable watchdog shutdown on close' CONFIG_WATCHDOG_NOWAYOUT
+      tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
+   fi
    endmenu
 fi
 
diff -Naur kernel-source-2.4.17.clean/arch/mips/sgi-ip22/ip22-mc.c kernel-source-2.4.17/arch/mips/sgi-ip22/ip22-mc.c
--- kernel-source-2.4.17.clean/arch/mips/sgi-ip22/ip22-mc.c	Wed Mar 26 05:57:28 2003
+++ kernel-source-2.4.17/arch/mips/sgi-ip22/ip22-mc.c	Wed Mar 26 18:38:55 2003
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
diff -Naur kernel-source-2.4.17.clean/drivers/char/Makefile kernel-source-2.4.17/drivers/char/Makefile
--- kernel-source-2.4.17.clean/drivers/char/Makefile	Wed Mar 26 05:57:32 2003
+++ kernel-source-2.4.17/drivers/char/Makefile	Wed Mar 26 18:38:47 2003
@@ -245,6 +245,7 @@
 obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
+obj-$(CONFIG_INDYDOG) += indydog.o
 
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
diff -Naur kernel-source-2.4.17.clean/drivers/char/indydog.c kernel-source-2.4.17/drivers/char/indydog.c
--- kernel-source-2.4.17.clean/drivers/char/indydog.c	Thu Jan  1 01:00:00 1970
+++ kernel-source-2.4.17/drivers/char/indydog.c	Wed Mar 26 20:33:59 2003
@@ -0,0 +1,158 @@
+/*
+ *	IndyDog	0.0.2	A Hardware Watchdog Device for SGI IP22
+ *
+ *	(c) Copyright 2001 Guido Guenther <agx@sigxcpu.org>, All Rights Reserved.
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
+static const char banner[] __initdata = KERN_INFO "Hardware Watchdog Timer for SGI IP22: 0.0.2\n";
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

--y0ulUmNC+osPPQO6--
