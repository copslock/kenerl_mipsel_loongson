Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 09:51:53 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:24887 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022987AbXI0Ivp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Sep 2007 09:51:45 +0100
Received: by mo.po.2iij.net (mo30) id l8R8pfYW032863; Thu, 27 Sep 2007 17:51:41 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l8R8pdjw012181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 27 Sep 2007 17:51:40 +0900
Date:	Thu, 27 Sep 2007 17:51:05 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Richard Purdie <rpurdie@rpsys.net>
Cc:	yoichi_yuasa@tripeaks.co.jp, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] led: add Cobalt Raq series LEDs support
Message-Id: <20070927175105.cf0ccb10.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Add Cobalt Raq series LEDs support.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X leds/Documentation/dontdiff leds-orig/drivers/leds/Kconfig leds/drivers/leds/Kconfig
--- leds-orig/drivers/leds/Kconfig	2007-09-27 14:49:12.873471250 +0900
+++ leds/drivers/leds/Kconfig	2007-09-27 14:49:12.557451500 +0900
@@ -93,6 +93,13 @@ config LEDS_COBALT_QUBE
 	help
 	  This option enables support for the front LED on Cobalt Qube series
 
+config LEDS_COBALT_RAQ
+	bool "LED Support for the Cobalt Raq series"
+	depends on LEDS_CLASS && MIPS_COBALT
+	select LEDS_TRIGGERS
+	help
+	  This option enables support for the Cobalt Raq series LEDs.
+
 config LEDS_GPIO
 	tristate "LED Support for GPIO connected LEDs"
 	depends on LEDS_CLASS && GENERIC_GPIO
diff -pruN -X leds/Documentation/dontdiff leds-orig/drivers/leds/Makefile leds/drivers/leds/Makefile
--- leds-orig/drivers/leds/Makefile	2007-09-27 14:49:13.005479500 +0900
+++ leds/drivers/leds/Makefile	2007-09-27 14:49:12.557451500 +0900
@@ -16,6 +16,7 @@ obj-$(CONFIG_LEDS_NET48XX)		+= leds-net4
 obj-$(CONFIG_LEDS_WRAP)			+= leds-wrap.o
 obj-$(CONFIG_LEDS_H1940)		+= leds-h1940.o
 obj-$(CONFIG_LEDS_COBALT_QUBE)		+= leds-cobalt-qube.o
+obj-$(CONFIG_LEDS_COBALT_RAQ)		+= leds-cobalt-raq.o
 obj-$(CONFIG_LEDS_GPIO)			+= leds-gpio.o
 
 # LED Triggers
diff -pruN -X leds/Documentation/dontdiff leds-orig/drivers/leds/leds-cobalt-raq.c leds/drivers/leds/leds-cobalt-raq.c
--- leds-orig/drivers/leds/leds-cobalt-raq.c	1970-01-01 09:00:00.000000000 +0900
+++ leds/drivers/leds/leds-cobalt-raq.c	2007-09-27 14:49:12.557451500 +0900
@@ -0,0 +1,138 @@
+/*
+ *  LEDs driver for the Cobalt Raq series.
+ *
+ *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define LED_WEB		0x04
+#define LED_POWER_OFF	0x08
+
+static void __iomem *led_port;
+static u8 led_value;
+static DEFINE_SPINLOCK(led_value_lock);
+
+static void raq_web_led_set(struct led_classdev *led_cdev,
+                            enum led_brightness brightness)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&led_value_lock, flags);
+
+	if (brightness)
+		led_value |= LED_WEB;
+	else
+		led_value &= ~LED_WEB;
+	writeb(led_value, led_port);
+
+	spin_unlock_irqrestore(&led_value_lock, flags);
+}
+
+static struct led_classdev raq_web_led = {
+	.name		= "raq-web",
+	.brightness_set	= raq_web_led_set,
+};
+
+static void raq_power_off_led_set(struct led_classdev *led_cdev,
+                                  enum led_brightness brightness)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&led_value_lock, flags);
+
+	if (brightness)
+		led_value |= LED_POWER_OFF;
+	else
+		led_value &= ~LED_POWER_OFF;
+	writeb(led_value, led_port);
+
+	spin_unlock_irqrestore(&led_value_lock, flags);
+}
+
+static struct led_classdev raq_power_off_led = {
+	.name			= "raq-power-off",
+	.brightness_set		= raq_power_off_led_set,
+	.default_trigger	= "power-off",
+};
+
+static int __devinit cobalt_raq_led_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int retval;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EBUSY;
+
+	led_port = ioremap(res->start, res->end - res->start + 1);
+	if (!led_port)
+		return -ENOMEM;
+
+	retval = led_classdev_register(&pdev->dev, &raq_power_off_led);
+	if (retval)
+		goto err_iounmap;
+
+	retval = led_classdev_register(&pdev->dev, &raq_web_led);
+	if (retval)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	led_classdev_unregister(&raq_power_off_led);
+
+err_iounmap:
+	iounmap(led_port);
+	led_port = NULL;
+
+	return retval;
+}
+
+static int __devexit cobalt_raq_led_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&raq_power_off_led);
+	led_classdev_unregister(&raq_web_led);
+
+	if (led_port) {
+		iounmap(led_port);
+		led_port = NULL;
+	}
+
+	return 0;
+}
+
+static struct platform_driver cobalt_raq_led_driver = {
+	.probe	= cobalt_raq_led_probe,
+	.remove	= __devexit_p(cobalt_raq_led_remove),
+	.driver = {
+		.name	= "cobalt-raq-leds",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init cobalt_raq_led_init(void)
+{
+	return platform_driver_register(&cobalt_raq_led_driver);
+}
+
+module_init(cobalt_raq_led_init);
