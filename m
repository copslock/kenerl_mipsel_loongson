Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 14:43:14 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:53300 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492978AbZK1NnH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Nov 2009 14:43:07 +0100
Received: by pwi15 with SMTP id 15so1452435pwi.24
        for <multiple recipients>; Sat, 28 Nov 2009 05:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tjbpFNOKGtCBuTEDvFjXthlRx66FD4fnjAJ4VDi8PD8=;
        b=rDmAFNdUyd8QPDDxNOGF9auYLBhfUToafgdWRC5DcNBBzrO1CJW8/w10kS39bs+a9q
         jWXtmmjNnPDV2Xd8jfv4o7RXEmlbm6zM2Pih3qxOAbWjoTs9KLr8X7ZrSEJpzzKnYFQV
         iA9ZTPYfZJoj5i9Dw8H297rJ2njGWjYH+LOMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=adg+jgiREztjaD5qXLnXgABtIrP94EwndFe67MqPLgaRxPTtxECVymj3h34nAIAMKb
         60NZMDk/mcf/FScb+GQeBvFzYMjPLzu6aHxsVa/7uiTyHo+AqUfC/7SbwLejkjtJ43i3
         XGuwekDGAwZo1aC5VPbqppGowpXK+uZc7Q7YE=
Received: by 10.115.117.4 with SMTP id u4mr3922593wam.43.1259415779946;
        Sat, 28 Nov 2009 05:42:59 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1921165pxi.11.2009.11.28.05.42.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 05:42:59 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, Pavel Machek <pavel@ucw.cz>,
        linux-pm@lists.linux-foundation.org,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v5 7/8] Loongson: YeeLoong: add suspend driver
Date:   Sat, 28 Nov 2009 21:42:39 +0800
Message-Id: <f758058af5e45ec98bdc849e7762f32d795177e1.1259414649.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds Suspend Driver, which will suspend the YeeLoong Platform
specific devices.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 ++
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
 .../loongson/lemote-2f/yeeloong_laptop/suspend.c   |  141 ++++++++++++++++++++
 3 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/suspend.c

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index c4398ff..49d63c5 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -45,4 +45,13 @@ config YEELOONG_VO
 	  This option adds Video Output Driver, which provides standard
 	  interface to turn on/off the video output of LCD, CRT.
 
+config YEELOONG_SUSPEND
+	tristate "Suspend Driver"
+	depends on YEELOONG_HWMON && YEELOONG_VO
+	select SUSPEND
+	default y
+	help
+	  This option adds Suspend Driver, which will suspend the YeeLoong
+	  Platform specific devices.
+
 endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
index 104670f..cfe736f 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_YEELOONG_BACKLIGHT) += backlight.o
 obj-$(CONFIG_YEELOONG_BATTERY) += battery.o
 obj-$(CONFIG_YEELOONG_HWMON) += hwmon.o
 obj-$(CONFIG_YEELOONG_VO) += video_output.o
+obj-$(CONFIG_YEELOONG_SUSPEND) += suspend.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/suspend.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/suspend.c
new file mode 100644
index 0000000..8202971
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/suspend.c
@@ -0,0 +1,141 @@
+/*
+ * YeeLoong Platform Specific Suspend Driver
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/platform_device.h>
+
+#include <asm/bootinfo.h>
+
+#include "ec_kb3310b.h"
+
+MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>");
+MODULE_DESCRIPTION("YeeLoong laptop suspend driver");
+MODULE_LICENSE("GPL");
+
+static struct platform_device *yeeloong_pdev;
+
+static void usb_ports_set(int status)
+{
+	status = !!status;
+
+	ec_write(REG_USB0_FLAG, status);
+	ec_write(REG_USB1_FLAG, status);
+	ec_write(REG_USB2_FLAG, status);
+}
+
+static int yeeloong_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	pr_info("yeeloong specific suspend\n");
+
+	/* Turn off LCD */
+	lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	/* Turn off CRT */
+	crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+	/* Poweroff three usb ports */
+	usb_ports_set(BIT_USB_FLAG_OFF);
+	/* Minimize the speed of FAN */
+	set_fan_pwm_enable(BIT_FAN_MANUAL);
+	set_fan_pwm(1);
+
+	return 0;
+}
+
+static int yeeloong_resume(struct platform_device *pdev)
+{
+	pr_info("yeeloong specific resume\n");
+
+	/* Resume the status of lcd & crt */
+	lcd_vo_set(BIT_DISPLAY_LCD_ON);
+	crt_vo_set(BIT_CRT_DETECT_PLUG);
+
+	/* Poweron three usb ports */
+	usb_ports_set(BIT_USB_FLAG_ON);
+
+	/* Resume fan to auto mode */
+	set_fan_pwm_enable(BIT_FAN_AUTO);
+
+	return 0;
+}
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		   .name = "yeeloong-laptop",
+		   .owner = THIS_MODULE,
+		   },
+	.suspend = yeeloong_suspend,
+	.resume = yeeloong_resume,
+};
+
+static ssize_t yeeloong_pdev_name_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "yeeloong laptop\n");
+}
+
+static struct device_attribute dev_attr_yeeloong_pdev_name =
+__ATTR(name, S_IRUGO, yeeloong_pdev_name_show, NULL);
+
+static int __init yeeloong_suspend_init(void)
+{
+	int ret;
+
+	if (mips_machtype != MACH_LEMOTE_YL2F89) {
+		pr_err("This Driver is only for YeeLoong laptop\n");
+		return -EFAULT;
+	}
+
+	/* Register platform stuff */
+	ret = platform_driver_register(&platform_driver);
+	if (ret)
+		return ret;
+
+	yeeloong_pdev = platform_device_alloc("yeeloong-laptop", -1);
+	if (!yeeloong_pdev) {
+		ret = -ENOMEM;
+		platform_driver_unregister(&platform_driver);
+		return ret;
+	}
+
+	ret = platform_device_add(yeeloong_pdev);
+	if (ret) {
+		platform_device_put(yeeloong_pdev);
+		return ret;
+	}
+
+	if (IS_ERR(yeeloong_pdev)) {
+		ret = PTR_ERR(yeeloong_pdev);
+		yeeloong_pdev = NULL;
+		pr_err("Fail to register platform device\n");
+		return ret;
+	}
+
+	ret = device_create_file(&yeeloong_pdev->dev,
+				 &dev_attr_yeeloong_pdev_name);
+	if (ret) {
+		pr_err("Fail to create sysfs device attributes\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit yeeloong_suspend_exit(void)
+{
+	if (yeeloong_pdev) {
+		platform_device_unregister(yeeloong_pdev);
+		yeeloong_pdev = NULL;
+		platform_driver_unregister(&platform_driver);
+	}
+}
+
+module_init(yeeloong_suspend_init);
+module_exit(yeeloong_suspend_exit);
-- 
1.6.2.1
