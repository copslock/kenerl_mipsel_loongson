Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 14:25:54 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.224]:15721 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022426AbXICNZF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Sep 2007 14:25:05 +0100
Received: by nz-out-0506.google.com with SMTP id n1so709280nzf
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2007 06:24:44 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ahrs3RHpqTihDVpGRdQsK/ziHL41ADRxxQEJOvnHF3T/+1OZIPtSydiHWJyqV04R+U1QSKCA/k99nJM8JwN9b6EKIPUEW9cnf4/nMMjHRUaFmXtV3rHHkA0Phxrfl5jGJHTFiYxdGiCyquI3E4nR2eh9iD8iby8gzaxKQBtOtA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NY/Vw1Y14pDNuII9fHEzHm0iSbZuuq6U3c8PU+qNUGsGNyGu9nMCsVFCpeTmyYPayYMFBRiDFUDKo/lp7rO387/zKiDTGjyVe0Rrn3bpNdG2Lh2xIOXPb3k2GsgvqWu8C0X6fR3VNNYGduS2z0yMqznGkyVYQqyWn/MzzBrwMZU=
Received: by 10.115.78.1 with SMTP id f1mr3071465wal.1188825882998;
        Mon, 03 Sep 2007 06:24:42 -0700 (PDT)
Received: by 10.115.111.13 with HTTP; Mon, 3 Sep 2007 06:24:42 -0700 (PDT)
Message-ID: <40101cc30709030624g4a0bfcccv6fb6abcc224917e4@mail.gmail.com>
Date:	Mon, 3 Sep 2007 15:24:42 +0200
From:	"Matteo Croce" <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 5/7] AR7: watchdog timer
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Driver for the watchdog timer. It worked with 2.4, doesn't does with 2.6.
Apart that it doesn't reboots the device it works :)

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Nicolas Thill <nico@openwrt.org>
Signed-off-by: Enrik Berkhan <Enrik.Berkhan@akk.org>
Signed-off-by: Christer Weinigel <wingel@nano-system.com>

diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
index 37bddc1..78d4940 100644
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -583,6 +583,12 @@ config SBC_EPX_C3_WATCHDOG

 # MIPS Architecture

+config AR7_WDT
+	tristate "TI AR7 Watchdog Timer"
+	depends on WATCHDOG && AR7
+	help
+	  Hardware driver for the TI AR7 Watchdog Timer.
+
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
 	depends on SGI_IP22
diff --git a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
index 389f8b1..76424f2 100644
--- a/drivers/char/watchdog/Makefile
+++ b/drivers/char/watchdog/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
 # M68KNOMMU Architecture

 # MIPS Architecture
+obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
 obj-$(CONFIG_INDYDOG) += indydog.o
 obj-$(CONFIG_WDT_MTX1)	+= mtx-1_wdt.o
 obj-$(CONFIG_WDT_RM9K_GPI) += rm9k_wdt.o
diff --git a/drivers/char/watchdog/ar7_wdt.c b/drivers/char/watchdog/ar7_wdt.c
new file mode 100644
index 0000000..50dfb5e
--- /dev/null
+++ b/drivers/char/watchdog/ar7_wdt.c
@@ -0,0 +1,345 @@
+/*
+ * linux/drivers/char/ar7_wdt.c
+ *
+ * Copyright (C) 2007 OpenWrt.org
+ * Copyright (c) 2005 Enrik Berkhan <Enrik.Berkhan@akk.org>
+ *
+ * Some code taken from:
+ * National Semiconductor SCx200 Watchdog support
+ * Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/fs.h>
+#include <linux/ioport.h>
+
+#include <asm/addrspace.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#include <asm/ar7/ar7.h>
+
+#define DRVNAME "ar7_wdt"
+#define LONGNAME "TI AR7 Watchdog Timer"
+
+MODULE_AUTHOR("Nicolas Thill <nico@openwrt.org>");
+MODULE_DESCRIPTION(LONGNAME);
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+
+static int margin = 60;
+module_param(margin, int, 0);
+MODULE_PARM_DESC(margin, "Watchdog margin in seconds");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
+
+typedef struct {
+	u32 kick_lock;
+	u32 kick;
+	u32 change_lock;
+	u32 change ;
+	u32 disable_lock;
+	u32 disable;
+	u32 prescale_lock;
+	u32 prescale;
+} ar7_wdt_t;
+
+static struct semaphore open_semaphore;
+static unsigned expect_close;
+
+/* XXX currently fixed, allows max margin ~68.72 secs */
+#define prescale_value 0xFFFF
+
+// Offset of the WDT registers
+static unsigned long ar7_regs_wdt;
+// Pointer to the remapped WDT IO space
+static ar7_wdt_t *ar7_wdt;
+static void ar7_wdt_get_regs(void)
+{
+    u16 chip_id = ar7_chip_id();
+    switch (chip_id)
+    {
+    case AR7_CHIP_7100:
+    case AR7_CHIP_7200:
+        ar7_regs_wdt = AR7_REGS_WDT;
+        break;
+    default:
+        ar7_regs_wdt = UR8_REGS_WDT;
+        break;
+    }
+}
+
+static void ar7_wdt_kick(u32 value)
+{
+	ar7_wdt->kick_lock = 0x5555;
+	if ((ar7_wdt->kick_lock & 3) == 1) {
+		ar7_wdt->kick_lock = 0xAAAA;
+		if ((ar7_wdt->kick_lock & 3) == 3) {
+			ar7_wdt->kick = value;
+			return;
+		}
+ 	}
+ 	printk(KERN_ERR DRVNAME ": failed to unlock WDT kick reg\n");
+}
+
+static void ar7_wdt_prescale(u32 value)
+{
+	ar7_wdt->prescale_lock = 0x5A5A;
+	if ((ar7_wdt->prescale_lock & 3) == 1) {
+		ar7_wdt->prescale_lock = 0xA5A5;
+		if ((ar7_wdt->prescale_lock & 3) == 3) {
+			ar7_wdt->prescale = value;
+			return;
+		}
+	}
+	printk(KERN_ERR DRVNAME ": failed to unlock WDT prescale reg\n");
+}
+
+static void ar7_wdt_change(u32 value)
+{
+	ar7_wdt->change_lock = 0x6666;
+	if ((ar7_wdt->change_lock & 3) == 1) {
+		ar7_wdt->change_lock = 0xBBBB;
+		if ((ar7_wdt->change_lock & 3) == 3) {
+			ar7_wdt->change = value;
+			return;
+		}
+	}
+	printk(KERN_ERR DRVNAME ": failed to unlock WDT change reg\n");
+}
+
+static void ar7_wdt_disable(u32 value)
+{
+	ar7_wdt->disable_lock = 0x7777;
+	if ((ar7_wdt->disable_lock & 3) == 1) {
+		ar7_wdt->disable_lock = 0xCCCC;
+		if ((ar7_wdt->disable_lock & 3) == 2) {
+			ar7_wdt->disable_lock = 0xDDDD;
+			if ((ar7_wdt->disable_lock & 3) == 3) {
+				ar7_wdt->disable = value;
+				return;
+			}
+		}
+	}
+	printk(KERN_ERR DRVNAME ": failed to unlock WDT disable reg\n");
+}
+
+static void ar7_wdt_update_margin(int new_margin)
+{
+	u32 change;
+
+	change = new_margin * (ar7_vbus_freq() / prescale_value);
+	if (change < 1) change = 1;
+	if (change > 0xFFFF) change = 0xFFFF;
+	ar7_wdt_change(change);
+	margin = change * prescale_value / ar7_vbus_freq();
+	printk(KERN_INFO DRVNAME
+	       ": timer margin %d seconds (prescale %d, change %d, freq %d)\n",
+	       margin, prescale_value, change, ar7_vbus_freq());
+}
+
+static void ar7_wdt_enable_wdt(void)
+{
+	printk(KERN_DEBUG DRVNAME ": enabling watchdog timer\n");
+	ar7_wdt_disable(1);
+	ar7_wdt_kick(1);
+}
+
+static void ar7_wdt_disable_wdt(void)
+{
+	printk(KERN_DEBUG DRVNAME ": disabling watchdog timer\n");
+	ar7_wdt_disable(0);
+}
+
+static int ar7_wdt_open(struct inode *inode, struct file *file)
+{
+	/* only allow one at a time */
+	if (down_trylock(&open_semaphore))
+		return -EBUSY;
+	ar7_wdt_enable_wdt();
+	expect_close = 0;
+
+	return 0;
+}
+
+static int ar7_wdt_release(struct inode *inode, struct file *file)
+{
+	if (!expect_close) {
+		printk(KERN_WARNING DRVNAME ": watchdog device closed unexpectedly,
will not disable the watchdog timer\n");
+	} else if (!nowayout) {
+		ar7_wdt_disable_wdt();
+	}
+        up(&open_semaphore);
+
+	return 0;
+}
+
+static int ar7_wdt_notify_sys(struct notifier_block *this,
+			      unsigned long code, void *unused)
+{
+	if (code == SYS_HALT || code == SYS_POWER_OFF)
+		if (!nowayout)
+			ar7_wdt_disable_wdt();
+
+        return NOTIFY_DONE;
+}
+
+static struct notifier_block ar7_wdt_notifier =
+{
+	.notifier_call = ar7_wdt_notify_sys
+};
+
+static ssize_t ar7_wdt_write(struct file *file, const char *data,
+			     size_t len, loff_t *ppos)
+{
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	/* check for a magic close character */
+	if (len) {
+		size_t i;
+
+		ar7_wdt_kick(1);
+
+		expect_close = 0;
+		for (i = 0; i < len; ++i) {
+			char c;
+			if (get_user(c, data+i))
+				return -EFAULT;
+			if (c == 'V')
+				expect_close = 1;
+		}
+
+	}
+	return len;
+}
+
+static int ar7_wdt_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		.identity = LONGNAME,
+		.firmware_version = 1,
+		.options = (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING),
+	};
+	int new_margin;
+	
+	switch (cmd) {
+	default:
+		return -ENOTTY;
+	case WDIOC_GETSUPPORT:
+		if(copy_to_user((struct watchdog_info *)arg, &ident,
+				sizeof(ident)))
+			return -EFAULT;
+		return 0;
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		if (put_user(0, (int *)arg))
+			return -EFAULT;
+		return 0;
+	case WDIOC_KEEPALIVE:
+		ar7_wdt_kick(1);
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if (new_margin < 1)
+			return -EINVAL;
+
+		ar7_wdt_update_margin(new_margin);
+		ar7_wdt_kick(1);
+
+	case WDIOC_GETTIMEOUT:
+		if (put_user(margin, (int *)arg))
+			return -EFAULT;
+		return 0;
+	}
+}
+
+static struct file_operations ar7_wdt_fops = {
+	.owner	 = THIS_MODULE,
+	.write   = ar7_wdt_write,
+	.ioctl   = ar7_wdt_ioctl,
+	.open    = ar7_wdt_open,
+	.release = ar7_wdt_release,
+};
+
+static struct miscdevice ar7_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name  = "watchdog",
+	.fops  = &ar7_wdt_fops,
+};
+
+static int __init ar7_wdt_init(void)
+{
+	int rc;
+
+    ar7_wdt_get_regs();
+
+	if (!request_mem_region(ar7_regs_wdt, sizeof(ar7_wdt_t), LONGNAME)) {
+		printk(KERN_WARNING DRVNAME ": watchdog I/O region busy\n");
+		return -EBUSY;
+	}
+
+	ar7_wdt = (ar7_wdt_t *)ioremap(ar7_regs_wdt, sizeof(ar7_wdt_t));
+
+	ar7_wdt_disable_wdt();
+	ar7_wdt_prescale(prescale_value);
+	ar7_wdt_update_margin(margin);
+
+	sema_init(&open_semaphore, 1);
+
+	rc = misc_register(&ar7_wdt_miscdev);
+	if (rc) {
+                printk(KERN_ERR DRVNAME ": unable to register misc device\n");
+		goto out_alloc;
+	}
+
+	rc = register_reboot_notifier(&ar7_wdt_notifier);
+        if (rc) {
+                printk(KERN_ERR DRVNAME ": unable to register reboot
notifier\n");
+		goto out_register;
+        }
+	goto out;
+
+out_register:
+	misc_deregister(&ar7_wdt_miscdev);
+out_alloc:
+	release_mem_region(ar7_regs_wdt, sizeof(ar7_wdt_t));
+out:
+	return rc;
+}
+
+static void __exit ar7_wdt_cleanup(void)
+{
+        unregister_reboot_notifier(&ar7_wdt_notifier);
+	misc_deregister(&ar7_wdt_miscdev);
+    iounmap(ar7_wdt);
+	release_mem_region(ar7_regs_wdt, sizeof(ar7_wdt_t));
+}
+
+module_init(ar7_wdt_init);
+module_exit(ar7_wdt_cleanup);
