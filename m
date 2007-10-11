Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 02:02:01 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.226]:4951 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021460AbXJKBBx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 02:01:53 +0100
Received: by wx-out-0506.google.com with SMTP id h30so380839wxd
        for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 18:01:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=UrLYN2qwcSd9xJ8OLjxx1yFSkLhNRmnFS+cniSKNbUo=;
        b=IkToxRUeEg7y117Gvj8+m4ef1DlyOVN/s5qO8p6SpmBh6wqftnqM7zKI23TVQp84BWR/bPMwGese2+ODt/lvhJr0GkjAWA4LcsNWnQNU6yNBkaU3GiJ2uZhvwTMrd4ERPpwAL+nsDjsoavjT4ylzC9B9Y1UftbsrCh003YxqNcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dSj5jSj9pKvGyNW9hwI+E8a3qJi3xvMmoZAnfUExgbHWjCm4j47NkN576GUXgaKFY/KYl/ltmokGzG64SJ0Ge8ibWenwm9dy5cq4srI1uK5ltIip4gz5EHodJX6KvOzZgdrWduwV7xqNilFGGUxbjfjDWSyYP4LIDgIzZCI5Ogc=
Received: by 10.70.118.4 with SMTP id q4mr2170590wxc.1192064494717;
        Wed, 10 Oct 2007 18:01:34 -0700 (PDT)
Received: from ?192.168.0.3? ( [87.18.114.61])
        by mx.google.com with ESMTPS id h12sm1801849wxd.2007.10.10.18.01.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2007 18:01:34 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS][6/6] AR7: leds driver
Date:	Thu, 11 Oct 2007 03:01:30 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <200710110248.33028.technoboy85@gmail.com>
In-Reply-To: <200710110248.33028.technoboy85@gmail.com>
Cc:	Eugene Konev <ejka@imfi.kspu.ru>, netdev@vger.kernel.org,
	davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
	jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710110301.31223.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

The new led driver, uses leds-gpio now

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Nicolas Thill <nico@openwrt.org>

diff --git a/drivers/leds/leds-ar7.c b/drivers/leds/leds-ar7.c
new file mode 100644
index 0000000..72b958a
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
+	gpio_direction_output(AR7_GPIO_BIT_STATUS_LED, 0);
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
