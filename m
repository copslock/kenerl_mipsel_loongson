Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2007 16:31:05 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.246]:18049 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20025788AbXIFPa4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Sep 2007 16:30:56 +0100
Received: by an-out-0708.google.com with SMTP id d26so29984and
        for <linux-mips@linux-mips.org>; Thu, 06 Sep 2007 08:30:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:x-spam-checker-version:x-spam-status:delivered-to:received:received:received:received-spf:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        bh=5oCDb8/fNzMwy/7Atwbyu2RdaphxeYqEVsmZ8iFr138=;
        b=WgfUr1UM6jdmCJ0T1CDkT7vJhlHkN7y+33xctRf5lrit8wNK0ZIQ5+kxu8NNoVQg3lOWeDykjgao5PAcs27LBGuv8gvffRQAGTR2J76XrPq+RMWHRSuPxR+CvpePwbQoxgfv/0fe1GOPoz3ebPx6d3uwx2oP86BPTiCBkh92Ovo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:x-spam-checker-version:x-spam-status:delivered-to:received-spf:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        b=Qktmhx6hl44hZFOxUtK12dNgD1sp+CXyY/e0yZxl2popO0NczARcje2YlhXTxTydq4mef9PJOWqOennTRVvbYNy07cgQ412XMQP/FsG6TyKarLnO6yVzcnXfHAvDADlVFPRC7haHqSXTUGazwBvQHMTahCAC3x+A3vl3KXSUFM0=
Received: by 10.100.94.3 with SMTP id r3mr696280anb.1189092636747;
        Thu, 06 Sep 2007 08:30:36 -0700 (PDT)
Received: from raver.cocorico ( [87.7.34.46])
        by mx.google.com with ESMTPS id h13sm7753175wxd.2007.09.06.08.30.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2007 08:30:35 -0700 (PDT)
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
Subject: [PATCH][MIPS][4/7] AR7: leds driver
Date:	Thu, 6 Sep 2007 17:30:31 +0200
User-Agent: KMail/1.9.7
References: <200708201704.11529.technoboy85@gmail.com>
In-Reply-To: <200708201704.11529.technoboy85@gmail.com>
MIME-Version: 1.0
Message-Id: <200709061730.31600.technoboy85@gmail.com>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel (inscrit sur la liste blanche),
	SpamAssassin (pas en cache, score=-1.467, requis 4.01,
	autolearn=not spam, AWL 1.00, BAYES_00 -2.60, FORGED_RCVD_HELO 0.14)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Content-Disposition: inline
Cc:	rpurdie@rpsys.net, Nicolas Thill <nico@openwrt.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16404
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
