Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 14:24:15 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.236]:25703 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022414AbXICNXv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Sep 2007 14:23:51 +0100
Received: by nz-out-0506.google.com with SMTP id n1so709133nzf
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2007 06:23:49 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tzEX6qyTUKYi1xflhAoySmcppBWk5ysowznt4wS8IJLSppdRP4456YoQT6f7sCehGbw2zmrXQ3A9c6xgxSTWEC+B5IIenkLoy+zABhtH8fAaWSwXfZOhTkZXI7Ydc45K6y1GvpFcJXFj0j8sKx2EMCq5PRuhkesCwX9x2Nx3/yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=moWHEt4n/wZd8fHBExf3Va3dBZd7OvonAeVn32+/BB7eUOIp6OFaBGlCcErbEg20xUre8tW51Wu1p6ynzuUuL9eWSM50c0Uz3r6oyx7qCrbzB5xYicGW9Rb9erkHD1sfpB8VuOreUgRP9F2VABO1fTnM31qKYkfWAS+38glqa44=
Received: by 10.114.209.1 with SMTP id h1mr5628wag.1188825828309;
        Mon, 03 Sep 2007 06:23:48 -0700 (PDT)
Received: by 10.115.111.13 with HTTP; Mon, 3 Sep 2007 06:23:48 -0700 (PDT)
Message-ID: <40101cc30709030623u610a7752lc98c62a9afb85639@mail.gmail.com>
Date:	Mon, 3 Sep 2007 15:23:48 +0200
From:	"Matteo Croce" <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 3/7] AR7: gpio char device
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Char device to access GPIO pins

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Nicolas Thill <nico@openwrt.org>

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index b391776..b98aedf 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -928,6 +928,15 @@ config MWAVE
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
index d68ddbe..804319e 100644
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
index 0000000..a5245da
--- /dev/null
+++ b/drivers/char/ar7_gpio.c
@@ -0,0 +1,161 @@
+/*
+ * linux/drivers/char/ar7_gpio.c
+ *
+ * Copyright (C) 2007 OpenWrt.org
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
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
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
+static int ar7_gpio_major = 0;
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
+			gpio_direction_output(pin);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return len;
+}
+
+static ssize_t ar7_gpio_read(struct file *file, char __user * buf,
+	size_t len, loff_t * ppos)
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
