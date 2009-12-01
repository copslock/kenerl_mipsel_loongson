Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:11:06 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:60881 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491817AbZLALLD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 12:11:03 +0100
Received: by pwi15 with SMTP id 15so2583971pwi.24
        for <multiple recipients>; Tue, 01 Dec 2009 03:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=QOrgfpkj+uau3pjdWgZsPX8WvOPoz1E05WimBvtYCbY=;
        b=A9kCizc/ciP0eJblihTCs4LN0dSvwMNTYoAHfV0Syabbtr9EYNIbLSw1lZxZT5BAcR
         /xAphCODekwFbFgWnBxoSgHwVKdcDh+UXThf8/QHv4TYefuNyr1+8DLZbQ3MXfdibmix
         oQtPUyjV8qVy3pgbODcPdtihkRnkwHVULD39Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WtN8K7tUS/pSfyfGBr0zwM38q5t2S8pkXnmDsycw53sXs3jxwIB0iFFda4HIkOEDBI
         M7+Pa/yhyP8Kr1DmmooKearJ/3EAXuzeBWGO4ghMBvsjSn4aKA8ON/MfqMKYRIF/XI7l
         ZLP4FXMsA0EpEQJ8mdMEW5pLy1F6iNqR8Yx4s=
Received: by 10.114.214.18 with SMTP id m18mr10578932wag.133.1259665855377;
        Tue, 01 Dec 2009 03:10:55 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1604pzk.1.2009.12.01.03.10.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 03:10:54 -0800 (PST)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com, luming.yu@intel.com,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6 6/8] Loongson: YeeLoong: add video output driver
Date:   Tue,  1 Dec 2009 19:10:38 +0800
Message-Id: <6447f36c749f513c3717c3bffdf21cbd8f416312.1259664573.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259660040.git.wuzhangjin@gmail.com>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1259664573.git.wuzhangjin@gmail.com>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds Video Output Driver, which provides standard interface
to turn on/off the video output of LCD, CRT.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    8 +
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    3 +
 .../loongson/lemote-2f/yeeloong_laptop/yl_vo.c     |  168 ++++++++++++++++++++
 4 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_vo.c

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index d13e1ab..7cf6071 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -37,4 +37,12 @@ config YEELOONG_HWMON
 	  interface for lm-sensors to monitor the temperatures of CPU and
 	  battery, the PWM of fan, the current, voltage of battery.
 
+config YEELOONG_VO
+	tristate "Video Output Driver"
+	select VIDEO_OUTPUT_CONTROL
+	default y
+	help
+	  This option adds Video Output Driver, which provides standard
+	  interface to turn on/off the video output of LCD, CRT.
+
 endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
index b38fb2a..aa01140 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -5,3 +5,4 @@ obj-y += ec_kb3310b.o
 obj-$(CONFIG_YEELOONG_BACKLIGHT) += yl_backlight.o
 obj-$(CONFIG_YEELOONG_BATTERY) += yl_battery.o
 obj-$(CONFIG_YEELOONG_HWMON) += yl_hwmon.o
+obj-$(CONFIG_YEELOONG_VO) += yl_vo.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
index 0e3b5ad..9d06ad8 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
@@ -22,6 +22,9 @@ extern int ec_get_event_num(void);
 typedef int (*sci_handler) (int status);
 extern sci_handler yeeloong_report_lid_status;
 
+extern void yeeloong_lcd_vo_set(int status);
+extern void yeeloong_crt_vo_set(int status);
+
 #define SCI_IRQ_NUM 0x0A
 #define MAX_BRIGHTNESS 8
 
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_vo.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_vo.c
new file mode 100644
index 0000000..db19a25
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_vo.c
@@ -0,0 +1,168 @@
+/*
+ * YeeLoong Video Output Driver
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
+#include <linux/video_output.h>
+
+#include <asm/bootinfo.h>
+
+#include "ec_kb3310b.h"
+
+MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>");
+MODULE_DESCRIPTION("YeeLoong laptop video output driver");
+MODULE_LICENSE("GPL");
+
+static int lcd_video_output_get(struct output_device *od)
+{
+	return ec_read(REG_DISPLAY_LCD);
+}
+
+static int lcd_video_output_set(struct output_device *od)
+{
+	int value;
+	unsigned long status;
+
+	status = !!od->request_state;
+
+	if (status == BIT_DISPLAY_LCD_ON) {
+		/* Turn on LCD */
+		outb(0x31, 0x3c4);
+		value = inb(0x3c5);
+		value = (value & 0xf8) | 0x03;
+		outb(0x31, 0x3c4);
+		outb(value, 0x3c5);
+		/* Turn on backlight */
+		ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_ON);
+	} else {
+		/* Turn off backlight */
+		ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_OFF);
+		/* Turn off LCD */
+		outb(0x31, 0x3c4);
+		value = inb(0x3c5);
+		value = (value & 0xf8) | 0x02;
+		outb(0x31, 0x3c4);
+		outb(value, 0x3c5);
+	}
+
+	return 0;
+}
+
+static struct output_properties lcd_output_properties = {
+	.set_state = lcd_video_output_set,
+	.get_status = lcd_video_output_get,
+};
+
+static int crt_video_output_get(struct output_device *od)
+{
+	return ec_read(REG_CRT_DETECT);
+}
+
+static int crt_video_output_set(struct output_device *od)
+{
+	int value;
+	unsigned long status;
+
+	status = !!od->request_state;
+
+	if (status == BIT_CRT_DETECT_PLUG) {
+		if (ec_read(REG_CRT_DETECT) == BIT_CRT_DETECT_PLUG) {
+			/* Turn on CRT */
+			outb(0x21, 0x3c4);
+			value = inb(0x3c5);
+			value &= ~(1 << 7);
+			outb(0x21, 0x3c4);
+			outb(value, 0x3c5);
+		}
+	} else {
+		/* Turn off CRT */
+		outb(0x21, 0x3c4);
+		value = inb(0x3c5);
+		value |= (1 << 7);
+		outb(0x21, 0x3c4);
+		outb(value, 0x3c5);
+	}
+
+	return 0;
+}
+
+static struct output_properties crt_output_properties = {
+	.set_state = crt_video_output_set,
+	.get_status = crt_video_output_get,
+};
+
+static struct output_device *lcd_output_dev, *crt_output_dev;
+
+void yeeloong_lcd_vo_set(int status)
+{
+	lcd_output_dev->request_state = status;
+	lcd_video_output_set(lcd_output_dev);
+}
+EXPORT_SYMBOL(yeeloong_lcd_vo_set);
+
+void yeeloong_crt_vo_set(int status)
+{
+	crt_output_dev->request_state = status;
+	crt_video_output_set(crt_output_dev);
+}
+EXPORT_SYMBOL(yeeloong_crt_vo_set);
+
+static int __init yeeloong_vo_init(void)
+{
+	int ret;
+
+	if (mips_machtype != MACH_LEMOTE_YL2F89) {
+		pr_err("This Driver is only for YeeLoong laptop\n");
+		return -EFAULT;
+	}
+
+
+	/* Register video output device: lcd, crt */
+	lcd_output_dev = video_output_register("LCD", NULL, NULL,
+			&lcd_output_properties);
+
+	if (IS_ERR(lcd_output_dev)) {
+		ret = PTR_ERR(lcd_output_dev);
+		lcd_output_dev = NULL;
+		return ret;
+	}
+	/* Ensure LCD is on by default */
+	yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+
+	crt_output_dev = video_output_register("CRT", NULL, NULL,
+			&crt_output_properties);
+
+	if (IS_ERR(crt_output_dev)) {
+		ret = PTR_ERR(crt_output_dev);
+		crt_output_dev = NULL;
+		return ret;
+	}
+
+	/* Turn off CRT by default, and will be enabled when the CRT
+	 * connectting event reported by SCI */
+	yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+
+	return 0;
+}
+
+static void __exit yeeloong_vo_exit(void)
+{
+	if (lcd_output_dev) {
+		video_output_unregister(lcd_output_dev);
+		lcd_output_dev = NULL;
+	}
+	if (crt_output_dev) {
+		video_output_unregister(crt_output_dev);
+		crt_output_dev = NULL;
+	}
+}
+
+module_init(yeeloong_vo_init);
+module_exit(yeeloong_vo_exit);
-- 
1.6.2.1
