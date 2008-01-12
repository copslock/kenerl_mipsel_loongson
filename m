Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jan 2008 17:18:15 +0000 (GMT)
Received: from smtp-out114.alice.it ([85.37.17.114]:53767 "EHLO
	smtp-out114.alice.it") by ftp.linux-mips.org with ESMTP
	id S20032647AbYALRSG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Jan 2008 17:18:06 +0000
Received: from FBCMMO03.fbc.local ([192.168.68.197]) by smtp-out114.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 12 Jan 2008 18:18:00 +0100
Received: from FBCMCL01B04.fbc.local ([192.168.69.85]) by FBCMMO03.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 12 Jan 2008 18:17:59 +0100
Received: from [192.168.0.3] ([87.7.113.5]) by FBCMCL01B04.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 12 Jan 2008 18:17:59 +0100
From:	Matteo Croce <technoboy85@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH][MIPS]: AR7 GPIO
Date:	Sat, 12 Jan 2008 18:18:02 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org, florian@openwrt.org, nbd@openwrt.org,
	ejka@imfi.kspu.ru, nico@openwrt.org, ralf@linux-mips.org,
	akpm@linux-foundation.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200801121818.02550.technoboy85@gmail.com>
X-OriginalArrivalTime: 12 Jan 2008 17:17:59.0733 (UTC) FILETIME=[149F1650:01C8553F]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

This new patch caches addresses as suggested by Atsushi Nemoto

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Nicolas Thill <nico@openwrt.org>
Signed-off-by: Florian Fainelli <florian@openwrt.org>

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
diff --git a/include/asm-mips/ar7/gpio.h b/include/asm-mips/ar7/gpio.h
new file mode 100644
index 0000000..cc6f898
--- /dev/null
+++ b/include/asm-mips/ar7/gpio.h
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2007 Florian Fainelli <florian@openwrt.org>
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
+#ifndef __AR7_GPIO_H__
+#define __AR7_GPIO_H__
+#include <asm/ar7/ar7.h>
+
+#define AR7_GPIO_MAX 32
+
+extern int gpio_request(unsigned gpio, const char *label);
+extern void gpio_free(unsigned gpio);
+
+/* Common GPIO layer */
+static inline int gpio_get_value(unsigned gpio)
+{
+	static unsigned addr;
+
+	if (!addr) {
+		void __iomem *gpio_in = (void __iomem *)
+				KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_INPUT);
+		addr = readl(gpio_in);
+	}
+
+	return addr & (1 << gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	static void __iomem *gpio_out;
+	unsigned tmp;
+
+	if (!gpio_out)
+		gpio_out = (void __iomem *)
+				KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_OUTPUT);
+
+	tmp = readl(gpio_out) & ~(1 << gpio);
+	if (value)
+		tmp |= 1 << gpio;
+	writel(tmp, gpio_out);
+}
+
+static inline int gpio_direction_input(unsigned gpio)
+{
+	void __iomem *gpio_dir =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_DIR);
+
+	if (gpio >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	writel(readl(gpio_dir) | (1 << gpio), gpio_dir);
+
+	return 0;
+}
+
+static inline int gpio_direction_output(unsigned gpio, int value)
+{
+	void __iomem *gpio_dir =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_DIR);
+
+	if (gpio >= AR7_GPIO_MAX)
+		return -EINVAL;
+
+	gpio_set_value(gpio, value);
+	writel(readl(gpio_dir) & ~(1 << gpio), gpio_dir);
+
+	return 0;
+}
+
+static inline int gpio_to_irq(unsigned gpio)
+{
+	return -EINVAL;
+}
+
+static inline int irq_to_gpio(unsigned irq)
+{
+	return -EINVAL;
+}
+
+/* Board specific GPIO functions */
+static inline int ar7_gpio_enable(unsigned gpio)
+{
+	void __iomem *gpio_en =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_ENABLE);
+
+	writel(readl(gpio_en) | (1 << gpio), gpio_en);
+
+	return 0;
+}
+
+static inline int ar7_gpio_disable(unsigned gpio)
+{
+	void __iomem *gpio_en =
+		(void __iomem *)KSEG1ADDR(AR7_REGS_GPIO + AR7_GPIO_ENABLE);
+
+	writel(readl(gpio_en) & ~(1 << gpio), gpio_en);
+
+	return 0;
+}
+
+#include <asm-generic/gpio.h>
+
+#endif
