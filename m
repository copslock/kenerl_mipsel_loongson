Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 10:27:26 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:23082 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022057AbXIUJ1S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 10:27:18 +0100
Received: by mo.po.2iij.net (mo30) id l8L9RE6S092553; Fri, 21 Sep 2007 18:27:14 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l8L9RDKl026272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Sep 2007 18:27:13 +0900
Message-Id: <200709210927.l8L9RDKl026272@po-mbox301.hop.2iij.net>
Date:	Fri, 21 Sep 2007 18:23:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Richard Purdie <rpurdie@rpsys.net>
Cc:	yoichi_yuasa@tripeaks.co.jp, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH take2][3/5] led: update Cobalt Qube series front LED support
References: <20070921182026.f2adbd6a.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Update Cobalt Qube series front LED support.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/drivers/leds/leds-cobalt-qube.c mips/drivers/leds/leds-cobalt-qube.c
--- mips-orig/drivers/leds/leds-cobalt-qube.c	2007-09-21 10:51:06.957260500 +0900
+++ mips/drivers/leds/leds-cobalt-qube.c	2007-09-21 13:06:43.331506750 +0900
@@ -3,40 +3,99 @@
  *
  * Control the Cobalt Qube series front LED
  */
-
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/leds.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/leds.h>
-#include <asm/mach-cobalt/cobalt.h>
 
-static void cobalt_led_set(struct led_classdev *led_cdev, enum led_brightness brightness)
+#define LED_FRONT_LEFT	0x01
+#define LED_FRONT_RIGHT	0x02
+
+static void __iomem *led_port;
+static u8 led_value;
+
+static void qube_front_led_set(struct led_classdev *led_cdev,
+                               enum led_brightness brightness)
 {
 	if (brightness)
-		COBALT_LED_PORT = COBALT_LED_BAR_LEFT | COBALT_LED_BAR_RIGHT;
+		led_value = LED_FRONT_LEFT | LED_FRONT_RIGHT;
 	else
-		COBALT_LED_PORT = 0;
+		led_value = ~(LED_FRONT_LEFT | LED_FRONT_RIGHT);
+	writeb(led_value, led_port);
+}
+
+static struct led_classdev qube_front_led = {
+	.name			= "qube-front",
+	.brightness		= LED_FULL,
+	.brightness_set		= qube_front_led_set,
+	.default_trigger	= "ide-disk",
+};
+
+static int __devinit cobalt_qube_led_probe(struct platform_device *pdev)
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
+	led_value = LED_FRONT_LEFT | LED_FRONT_RIGHT;
+	writeb(led_value, led_port);
+
+	retval = led_classdev_register(&pdev->dev, &qube_front_led);
+	if (retval)
+		goto err_iounmap;
+
+	return 0;
+
+err_iounmap:
+	iounmap(led_port);
+	led_port = NULL;
+
+	return retval;
+}
+
+static int __devexit cobalt_qube_led_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&qube_front_led);
+
+	if (led_port) {
+		iounmap(led_port);
+		led_port = NULL;
+	}
+
+	return 0;
 }
 
-static struct led_classdev cobalt_led = {
-       .name = "cobalt-front-led",
-       .brightness_set = cobalt_led_set,
-       .default_trigger = "ide-disk",
+static struct platform_driver cobalt_qube_led_driver = {
+	.probe	= cobalt_qube_led_probe,
+	.remove	= __devexit_p(cobalt_qube_led_remove),
+	.driver	= {
+		.name	= "cobalt-qube-leds",
+		.owner	= THIS_MODULE,
+	},
 };
 
-static int __init cobalt_led_init(void)
+static int __init cobalt_qube_led_init(void)
 {
-	return led_classdev_register(NULL, &cobalt_led);
+	return platform_driver_register(&cobalt_qube_led_driver);
 }
 
-static void __exit cobalt_led_exit(void)
+static void __exit cobalt_qube_led_exit(void)
 {
-	led_classdev_unregister(&cobalt_led);
+	platform_driver_unregister(&cobalt_qube_led_driver);
 }
 
-module_init(cobalt_led_init);
-module_exit(cobalt_led_exit);
+module_init(cobalt_qube_led_init);
+module_exit(cobalt_qube_led_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Front LED support for Cobalt Qube series");
