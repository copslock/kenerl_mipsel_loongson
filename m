Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 17:04:18 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.251]:59637 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20022059AbXITQEK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 17:04:10 +0100
Received: by an-out-0708.google.com with SMTP id d26so84612and
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2007 09:03:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=Bzs/+31Gk64WvYKmSgZRQt/lPfCXZ3H0fUTwifupWT8=;
        b=UMirm0UdB1L9bCtJIgH2mfdhi92BV9imArsS8AjxvEruzjDMb+nK+CFviYypXxJXBcweNasavgAFV3T1bDVDvncH6g/jvJe3/Yec4sHhdw4q++kLL7719VGA7bywowvJ0/ngGFTOY+5mMpo2C8thEsWhjH25d0e4f+HW2xtdqL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=VbKPldzgiripRkAuccN32zvW/jZEcAR+ZHh0gsGhX72iJrRzX6w5P92JG8nE0jMUy4aWqd5/vidLq4xmM6wxj8Y6NiT9yf7oonBA+jP+T+9LRY2hB52lNQ3JkDblNrH6krQ7aLnR7xNa8v1aFpJ+fFCvDXVn7YK7LxRIBW2othk=
Received: by 10.100.189.17 with SMTP id m17mr3097214anf.1190304231253;
        Thu, 20 Sep 2007 09:03:51 -0700 (PDT)
Received: from ?192.168.0.3? ( [87.6.117.29])
        by mx.google.com with ESMTPS id 3sm1456147hsw.2007.09.20.09.03.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2007 09:03:50 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][4/7] AR7: leds driver
Date:	Thu, 20 Sep 2007 18:03:42 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <200709201728.10866.technoboy85@gmail.com>
In-Reply-To: <200709201728.10866.technoboy85@gmail.com>
Cc:	rpurdie@rpsys.net, Nicolas Thill <nico@openwrt.org>,
	Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200709201803.42734.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Support for the leds in front of the board usually used to show power
status, network traffic, connected eth devices etc.
Will convert it to use leds-gpio when 2.6.23 will out.


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
index 0000000..cf0afec
--- /dev/null
+++ b/drivers/leds/leds-ar7.c
@@ -0,0 +1,130 @@
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
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <linux/io.h>
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
+	if (rc < 0)
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
