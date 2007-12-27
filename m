Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2007 18:25:59 +0000 (GMT)
Received: from smtp-out114.alice.it ([85.37.17.114]:14091 "EHLO
	smtp-out114.alice.it") by ftp.linux-mips.org with ESMTP
	id S20035716AbXL0SZv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Dec 2007 18:25:51 +0000
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-out114.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:25:45 +0100
Received: from FBCMCL01B03.fbc.local ([192.168.69.84]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:25:44 +0100
Received: from [192.168.0.3] ([82.55.115.235]) by FBCMCL01B03.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Dec 2007 19:25:43 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][4/6]: AR7 refresh
Date:	Thu, 27 Dec 2007 19:25:46 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <200712271919.23577.technoboy85@gmail.com>
In-Reply-To: <200712271919.23577.technoboy85@gmail.com>
Cc:	Nicolas Thill <nico@openwrt.org>,
	Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712271925.46306.technoboy85@gmail.com>
X-OriginalArrivalTime: 27 Dec 2007 18:25:44.0005 (UTC) FILETIME=[E481C750:01C848B5]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Nicolas Thill <nico@openwrt.org>

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index ef1ed5d..307b8c8 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -904,6 +904,15 @@ config MWAVE
 	  To compile this driver as a module, choose M here: the
 	  module will be called mwave.
 
+config AR7_GPIO
+	tristate "TI AR7 GPIO Support"
+	depends on AR7
+	help
+	  Give userspace access to the GPIO pins on the Texas Instruments AR7 
+	  processors.
+
+	  If compiled as a module, it will be called ar7_gpio.
+
 config SCx200_GPIO
 	tristate "NatSemi SCx200 GPIO Support"
 	depends on SCx200
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 07304d5..15b479d 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_COBALT_LCD)	+= lcd.o
 obj-$(CONFIG_PPDEV)		+= ppdev.o
 obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
 obj-$(CONFIG_NWFLASH)		+= nwflash.o
+obj-$(CONFIG_AR7_GPIO)		+= ar7_gpio.o
 obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
 obj-$(CONFIG_PC8736x_GPIO)	+= pc8736x_gpio.o
 obj-$(CONFIG_NSC_GPIO)		+= nsc_gpio.o
diff --git a/drivers/char/ar7_gpio.c b/drivers/char/ar7_gpio.c
new file mode 100644
index 0000000..16460cd
--- /dev/null
+++ b/drivers/char/ar7_gpio.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (C) 2007 Nicolas Thill <nico@openwrt.org>
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
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/cdev.h>
+#include <gpio.h>
+
+#define DRVNAME "ar7_gpio"
+#define LONGNAME "TI AR7 GPIOs Driver"
+
+MODULE_AUTHOR("Nicolas Thill <nico@openwrt.org>");
+MODULE_DESCRIPTION(LONGNAME);
+MODULE_LICENSE("GPL");
+
+static int ar7_gpio_major;
+
+static ssize_t ar7_gpio_write(struct file *file, const char __user *buf,
+	size_t len, loff_t *ppos)
+{
+	int pin = iminor(file->f_dentry->d_inode);
+	size_t i;
+
+	for (i = 0; i < len; ++i) {
+		char c;
+		if (get_user(c, buf + i))
+			return -EFAULT;
+		switch (c) {
+		case '0':
+			gpio_set_value(pin, 0);
+			break;
+		case '1':
+			gpio_set_value(pin, 1);
+			break;
+		case 'd':
+		case 'D':
+			ar7_gpio_disable(pin);
+			break;
+		case 'e':
+		case 'E':
+			ar7_gpio_enable(pin);
+			break;
+		case 'i':
+		case 'I':
+		case '<':
+			gpio_direction_input(pin);
+			break;
+		case 'o':
+		case 'O':
+		case '>':
+			gpio_direction_output(pin, 0);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return len;
+}
+
+static ssize_t ar7_gpio_read(struct file *file, char __user *buf,
+	size_t len, loff_t *ppos)
+{
+	int pin = iminor(file->f_dentry->d_inode);
+	int value;
+
+	value = gpio_get_value(pin);
+	if (put_user(value ? '1' : '0', buf))
+		return -EFAULT;
+
+	return 1;
+}
+
+static int ar7_gpio_open(struct inode *inode, struct file *file)
+{
+	int m = iminor(inode);
+
+	if (m >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	return nonseekable_open(inode, file);
+}
+
+static int ar7_gpio_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static const struct file_operations ar7_gpio_fops = {
+	.owner   = THIS_MODULE,
+	.write   = ar7_gpio_write,
+	.read    = ar7_gpio_read,
+	.open    = ar7_gpio_open,
+	.release = ar7_gpio_release,
+	.llseek  = no_llseek,
+};
+
+static struct platform_device *ar7_gpio_device;
+
+static int __init ar7_gpio_init(void)
+{
+	int rc;
+
+	ar7_gpio_device = platform_device_alloc(DRVNAME, -1);
+	if (!ar7_gpio_device)
+		return -ENOMEM;
+
+	rc = platform_device_add(ar7_gpio_device);
+	if (rc < 0)
+		goto out_put;
+
+	rc = register_chrdev(ar7_gpio_major, DRVNAME, &ar7_gpio_fops);
+	if (rc < 0)
+		goto out_put;
+
+	ar7_gpio_major = rc;
+
+	rc = 0;
+
+	goto out;
+
+out_put:
+	platform_device_put(ar7_gpio_device);
+out:
+	return rc;
+}
+
+static void __exit ar7_gpio_exit(void)
+{
+	unregister_chrdev(ar7_gpio_major, DRVNAME);
+	platform_device_unregister(ar7_gpio_device);
+}
+
+module_init(ar7_gpio_init);
+module_exit(ar7_gpio_exit);
