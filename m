Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2007 21:13:19 +0000 (GMT)
Received: from smtp-ext.int-evry.fr ([157.159.11.17]:28083 "EHLO
	smtp-ext.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20039624AbXCBVKm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Mar 2007 21:10:42 +0000
Received: from mini.int.alphacore.net (florian.maisel.int-evry.fr [157.159.41.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id CE33B8D1693
	for <linux-mips@linux-mips.org>; Fri,  2 Mar 2007 22:09:54 +0100 (CET)
From:	Florian Fainelli <florian.fainelli@int-evry.fr>
To:	linux-mips@linux-mips.org
Subject: [PATCH 7/7] MTX1 LED driver
Date:	Fri, 2 Mar 2007 22:08:11 +0100
User-Agent: KMail/1.9.6
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7IJ6FRy2+eWtR+j"
Message-Id: <200703022208.11940.florian.fainelli@int-evry.fr>
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--Boundary-00=_7IJ6FRy2+eWtR+j
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds support for controlling the LEDS on the MTX-1 board. It 
registers the power(green) and status(red) LEDs.

Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>
-- 

--Boundary-00=_7IJ6FRy2+eWtR+j
Content-Type: text/plain;
  charset="us-ascii";
  name="011-mtx1_leds.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="011-mtx1_leds.patch"

diff -urN linux-2.6.19.2/drivers/leds/Kconfig linux-2.6.19.2.new/drivers/leds/Kconfig
--- linux-2.6.19.2/drivers/leds/Kconfig	2007-01-10 20:10:37.000000000 +0100
+++ linux-2.6.19.2.new/drivers/leds/Kconfig	2007-03-02 13:50:28.000000000 +0100
@@ -76,6 +76,13 @@
 	  This option enables support for the Soekris net4801 and net4826 error
 	  LED.
 
+config LEDS_MTX1
+	tristate "LED Support for MTX-1 boards"
+	depends on LEDS_CLASS && MIPS_MTX1
+	help
+	  This option enables support for the MTX-1 power and status LED.
+
+
 comment "LED Triggers"
 
 config LEDS_TRIGGERS
diff -urN linux-2.6.19.2/drivers/leds/Makefile linux-2.6.19.2.new/drivers/leds/Makefile
--- linux-2.6.19.2/drivers/leds/Makefile	2007-01-10 20:10:37.000000000 +0100
+++ linux-2.6.19.2.new/drivers/leds/Makefile	2007-03-02 13:49:35.000000000 +0100
@@ -13,6 +13,7 @@
 obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
 obj-$(CONFIG_LEDS_AMS_DELTA)		+= leds-ams-delta.o
 obj-$(CONFIG_LEDS_NET48XX)		+= leds-net48xx.o
+obj-$(CONFIG_LEDS_MTX1)			+= leds-mtx1.o
 
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
diff -urN linux-2.6.19.2/drivers/leds/leds-mtx1.c linux-2.6.19.2.new/drivers/leds/leds-mtx1.c
--- linux-2.6.19.2/drivers/leds/leds-mtx1.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19.2.new/drivers/leds/leds-mtx1.c	2007-03-02 13:49:08.000000000 +0100
@@ -0,0 +1,116 @@
+/*
+ * LED driver for MTX-1 boards
+ *
+ * Copyright 2007 Florian Fainelli <florian@openwrt.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <asm/mach-au1x00/au1000.h>
+
+static struct platform_device *pdev;
+
+static void mtx1_green_led_set(struct led_classdev *led_cdev, enum led_brightness brightness)
+{
+	/* The power LED cannot be controlled the same way as for the Status LED */
+	if (brightness) {
+        	au_writel( 0x18000800, GPIO2_OUTPUT );
+	} else {
+		au_writel( 0x18000000, GPIO2_OUTPUT);
+	}
+}
+
+static void mtx1_red_led_set(struct led_classdev *led_cdev, enum led_brightness brightness)
+{
+	/* We store GPIO address (originally address - 200) in the "flags" field*/
+	unsigned long pinmask = 1 << led_cdev->flags; 
+	if (brightness) {
+		au_writel((pinmask << 16) | pinmask, GPIO2_OUTPUT); 
+	} else { 
+		au_writel((pinmask << 16) | 0, GPIO2_OUTPUT);
+	}
+}
+
+static struct led_classdev mtx1_green_led = {
+	.name = "mtx1:green",
+	.brightness_set = mtx1_green_led_set,
+};
+
+static struct led_classdev mtx1_red_led = {
+	.name = "mtx1:red",
+	.flags = 12,
+	.brightness_set = mtx1_red_led_set,
+	.default_trigger = "ide-disk",
+};
+
+static int mtx1_leds_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = led_classdev_register(&pdev->dev, &mtx1_green_led);
+	if (ret < 0)
+		goto out;
+
+	ret = led_classdev_register(&pdev->dev, &mtx1_red_led);
+	if (ret < 0)
+		led_classdev_unregister(&mtx1_green_led);
+
+out:
+	return ret;
+}
+
+static int mtx1_leds_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&mtx1_green_led);
+	led_classdev_unregister(&mtx1_red_led);
+	return 0;
+}
+
+static struct platform_driver mtx1_leds_driver = {
+	.probe = mtx1_leds_probe,
+	.remove = mtx1_leds_remove,
+	.driver = {
+		.name = "mtx1-leds",
+	}
+};
+
+static int __init mtx1_leds_init(void)
+{
+	int ret;
+
+        ret = platform_driver_register(&mtx1_leds_driver);
+        if (ret < 0)
+                goto out;
+
+        pdev = platform_device_register_simple("mtx1-leds", -1, NULL, 0);
+        if (IS_ERR(pdev)) {
+                ret = PTR_ERR(pdev);
+                platform_driver_unregister(&mtx1_leds_driver);
+                goto out;
+        }
+
+out:
+        return ret;
+
+}
+		
+static void __exit mtx1_leds_exit(void)
+{
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&mtx1_leds_driver);
+}
+
+module_init(mtx1_leds_init);
+module_exit(mtx1_leds_exit);
+		
+MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
+MODULE_DESCRIPTION("MTX-1 LED driver");
+MODULE_LICENSE("GPL");

--Boundary-00=_7IJ6FRy2+eWtR+j--
