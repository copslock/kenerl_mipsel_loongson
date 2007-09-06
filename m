Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2007 16:28:29 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.178]:28139 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20025807AbXIFP2T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Sep 2007 16:28:19 +0100
Received: by wa-out-1112.google.com with SMTP id m16so216232waf
        for <linux-mips@linux-mips.org>; Thu, 06 Sep 2007 08:28:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:x-spam-checker-version:x-spam-status:delivered-to:received:received:received:received-spf:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        bh=H8li4jtVPjPwixjLdMvPImm1TrZ3LwWd441lp5N99Mg=;
        b=kHwApkjWoZXkr+ChjyBI81RRxEx4uhvPk8BM12vrW61GRWcDdc5g2gBbE12gx6CPz79tZeA10h6tEs0gMvwT3hA3jma7uyFzSTchPaY0NcWCfYRC0FJNysWN3zvrUUwk6TMjntG2+rq06rGvsvLUBexcliZU7kUwYufVZFtPLQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:x-spam-checker-version:x-spam-status:delivered-to:received-spf:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        b=MZDVcvEBuX80PtFfu4zMkKAZUczM/YyMLdWJoj2FYJ0z5YgxJGAFq1VsbSU4C6ZjdneNrJW0yxNMBFHXmFrKX3P9WLrXdVZfzQeG3DmTwnfWLnCHNGNwU1YlHbdtmyn6Dgi6oJwG925DoBstbpIC/G728YCM2WrgsQyrioagpGw=
Received: by 10.114.27.20 with SMTP id a20mr2598waa.1189092484540;
        Thu, 06 Sep 2007 08:28:04 -0700 (PDT)
Received: from raver.cocorico ( [87.7.34.46])
        by mx.google.com with ESMTPS id h15sm7734003wxd.2007.09.06.08.28.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2007 08:28:03 -0700 (PDT)
Received: by 10.82.154.20 with SMTP id b20cs876037bue;
        Wed, 22 Aug 2007 01:11:04 -0700 (PDT)
Received: by 10.82.112.3 with SMTP id k3mr943124buc.1187770261340;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received: from smtp1.int-evry.fr (smtp1.int-evry.fr [157.159.10.44])
        by mx.google.com with ESMTP id j9si1357887mue.2007.08.22.01.10.56;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received-SPF: neutral (google.com: 157.159.10.44 is neither permitted nor denied by best guess record for domain of florian.fainelli@telecomint.eu) client-ip=157.159.10.44;
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 122398E84F0;
	Wed, 22 Aug 2007 10:10:48 +0200 (CEST)
Received: from ibook.lan (mla78-1-82-240-16-241.fbx.proxad.net [82.240.16.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 73CFED0E336;
	Wed, 22 Aug 2007 10:10:47 +0200 (CEST)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][3/7] AR7: gpio char device
Date:	Thu, 6 Sep 2007 17:27:59 +0200
User-Agent: KMail/1.9.7
References: <200708201704.11529.technoboy85@gmail.com>
In-Reply-To: <200708201704.11529.technoboy85@gmail.com>
MIME-Version: 1.0
Message-Id: <200709061727.59732.technoboy85@gmail.com>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel (inscrit sur la liste blanche),
	SpamAssassin (pas en cache, score=-1.467, requis 4.01,
	autolearn=not spam, AWL 1.00, BAYES_00 -2.60, FORGED_RCVD_HELO 0.14)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Content-Disposition: inline
Cc:	Nicolas Thill <nico@openwrt.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16403
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
index b391776..d56cfd7 100644
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
index 0000000..940a351
--- /dev/null
+++ b/drivers/char/ar7_gpio.c
@@ -0,0 +1,159 @@
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
