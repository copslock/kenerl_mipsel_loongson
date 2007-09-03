Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 14:25:16 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.180]:64979 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022423AbXICNYt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Sep 2007 14:24:49 +0100
Received: by wa-out-1112.google.com with SMTP id m16so1815553waf
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2007 06:24:33 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jvH7feeZLItMhcRZey9DT6V8PnCOZ8j8hxB46PjoW+qONAILAeOjDiIYG8UIlXQvzreq4w03YoTTw8UOxMmxvPynP26fyiPtq5EiMGzSwJaBQ63PAyMIyVGmPuUC07Y72POakiJlmctjh8y6ealo0WSuoJvTHCEupp5Z1K6xpoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=o3/ogmOxKmqqz3I+wiiStQ3PGqOtesebbBeURx3q/5cjf0eeCyehK2uSYB++C96uG/glIzb9v8XIDiMZzu2AV6OpCcfMZJVWDS73IVmvAFhZdDKqZwEa/ZFm3ISU3UKMVGQpGg1JANCyDLZsnylaw4+TkrqcIQSMq7GI7qRMgrg=
Received: by 10.114.196.1 with SMTP id t1mr3088173waf.1188825873084;
        Mon, 03 Sep 2007 06:24:33 -0700 (PDT)
Received: by 10.115.111.13 with HTTP; Mon, 3 Sep 2007 06:24:32 -0700 (PDT)
Message-ID: <40101cc30709030624l691e6c3dn9bb886d5e2aee01d@mail.gmail.com>
Date:	Mon, 3 Sep 2007 15:24:32 +0200
From:	"Matteo Croce" <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 4/7] AR7: leds driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Support for the leds in front of the board usually used to show power
status, network traffic, connected eth devices etc.

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Nicolas Thill <nico@openwrt.org>

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 4468cb3..b1c7a32 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -18,6 +18,12 @@ config LEDS_CLASS

 comment "LED drivers"

+config LEDS_AR7
+	tristate "LED Support for the TI AR7"
+	depends LEDS_CLASS && AR7
+	help
+	  This option enables support for the LEDs on TI AR7.
+
 config LEDS_CORGI
 	tristate "LED Support for the Sharp SL-C7x0 series"
 	depends on LEDS_CLASS && PXA_SHARP_C7xx
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index f8995c9..6d78192 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_LEDS_CLASS)		+= led-class.o
 obj-$(CONFIG_LEDS_TRIGGERS)		+= led-triggers.o

 # LED Platform Drivers
+obj-$(CONFIG_LEDS_AR7)			+= leds-ar7.o
 obj-$(CONFIG_LEDS_CORGI)		+= leds-corgi.o
 obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locomo.o
 obj-$(CONFIG_LEDS_SPITZ)		+= leds-spitz.o
diff --git a/drivers/leds/leds-ar7.c b/drivers/leds/leds-ar7.c
new file mode 100644
index 0000000..85533de
--- /dev/null
+++ b/drivers/leds/leds-ar7.c
@@ -0,0 +1,132 @@
+/*
+ * linux/drivers/leds/leds-ar7.c
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
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <asm/io.h>
+#include <gpio.h>
+
+#define DRVNAME "ar7-leds"
+#define LONGNAME "TI AR7 LEDs driver"
+#define AR7_GPIO_BIT_STATUS_LED 8
+
+MODULE_AUTHOR("Nicolas Thill <nico@openwrt.org>");
+MODULE_DESCRIPTION(LONGNAME);
+MODULE_LICENSE("GPL");
+
+static void ar7_status_led_set(struct led_classdev *pled,
+		enum led_brightness value)
+{
+	gpio_set_value(AR7_GPIO_BIT_STATUS_LED, value ? 0 : 1);
+}
+
+static struct led_classdev ar7_status_led = {
+	.name		= "ar7:status",
+	.brightness_set	= ar7_status_led_set,
+};
+
+#ifdef CONFIG_PM
+static int ar7_leds_suspend(struct platform_device *dev,
+		pm_message_t state)
+{
+	led_classdev_suspend(&ar7_status_led);
+	return 0;
+}
+
+static int ar7_leds_resume(struct platform_device *dev)
+{
+	led_classdev_resume(&ar7_status_led);
+	return 0;
+}
+#else /* CONFIG_PM */
+#define ar7_leds_suspend NULL
+#define ar7_leds_resume NULL
+#endif /* CONFIG_PM */
+
+static int ar7_leds_probe(struct platform_device *pdev)
+{
+	int rc;
+
+	rc = led_classdev_register(&pdev->dev, &ar7_status_led);
+	if (rc < 0 )
+		goto out;
+
+	ar7_gpio_enable(AR7_GPIO_BIT_STATUS_LED);
+	gpio_direction_output(AR7_GPIO_BIT_STATUS_LED);
+
+out:
+	return rc;
+}
+
+static int ar7_leds_remove(struct platform_device *pdev)
+{
+	led_classdev_unregister(&ar7_status_led);
+
+	return 0;
+}
+
+static struct platform_device *ar7_leds_device;
+
+static struct platform_driver ar7_leds_driver = {
+	.probe		= ar7_leds_probe,
+	.remove		= ar7_leds_remove,
+	.suspend	= ar7_leds_suspend,
+	.resume		= ar7_leds_resume,
+	.driver		= {
+		.name		= DRVNAME,
+	},
+};
+
+static int __init ar7_leds_init(void)
+{
+	int rc;
+
+	ar7_leds_device = platform_device_alloc(DRVNAME, -1);
+	if (!ar7_leds_device)
+		return -ENOMEM;
+
+	rc = platform_device_add(ar7_leds_device);
+	if (rc < 0)
+		goto out_put;
+
+	rc = platform_driver_register(&ar7_leds_driver);
+	if (rc < 0)
+		goto out_put;
+
+	goto out;
+
+out_put:
+	platform_device_put(ar7_leds_device);
+out:
+	return rc;
+}
+
+static void __exit ar7_leds_exit(void)
+{
+	platform_driver_unregister(&ar7_leds_driver);
+	platform_device_unregister(ar7_leds_device);
+}
+
+module_init(ar7_leds_init);
+module_exit(ar7_leds_exit);
