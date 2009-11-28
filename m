Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 14:41:32 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:51229 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492978AbZK1Nl2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Nov 2009 14:41:28 +0100
Received: by pzk35 with SMTP id 35so1645680pzk.22
        for <multiple recipients>; Sat, 28 Nov 2009 05:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mActox4o6TPYnsdGWVFLbiboCOw6Lbz7DnVzvl07/rE=;
        b=To6IDsd+Oxog7P50s1durVSZU4BSTfsRMGThgaEsqHEcHZprgMLYI1/55KrqZwqHZz
         VbF1Un2tOUdUMO5xRxoc16/NxJx8xB4ewqDSKVHaroS4IF3YSvnS+x5n0470nMAs5GKC
         YM2vPEYmDjZYTV9tEeeFQX+BV3QPUk5aDW3b4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rlXsKlPkPVjmHzCygLqsi6BafAfwWI+TZtqe4J82q3koAe7K02KiCAaulrobkCnDev
         SLmfom/jl0CphD+VFVp7Sf2V5TamY8kKw23BhcfDjzJ8y2snMi3X5teSlaq4LjytwfVl
         Sd4euzCnoA+cGoC79IaZkwy6qy9pZt1NhbH9s=
Received: by 10.115.134.40 with SMTP id l40mr3949588wan.41.1259415682069;
        Sat, 28 Nov 2009 05:41:22 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm1919893pxi.15.2009.11.28.05.41.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 05:41:21 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, luming.yu@intel.com,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v5 6/8] Loongson: YeeLoong: add video output driver
Date:   Sat, 28 Nov 2009 21:41:11 +0800
Message-Id: <dc116705b7d610d48b7d77ebd6365c5f05ad8ab7.1259414649.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25189
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
 .../lemote-2f/yeeloong_laptop/video_output.c       |  164 ++++++++++++++++++++
 4 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/video_output.c

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index 56cb584..c4398ff 100644
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
index 73277a8..104670f 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -5,3 +5,4 @@ obj-y += ec_kb3310b.o
 obj-$(CONFIG_YEELOONG_BACKLIGHT) += backlight.o
 obj-$(CONFIG_YEELOONG_BATTERY) += battery.o
 obj-$(CONFIG_YEELOONG_HWMON) += hwmon.o
+obj-$(CONFIG_YEELOONG_VO) += video_output.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
index 674a543..3d08792 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
@@ -25,6 +25,9 @@ extern sci_handler yeeloong_report_lid_status;
 extern void set_fan_pwm(int value);
 extern void set_fan_pwm_enable(int manual);
 
+extern void lcd_vo_set(int status);
+extern void crt_vo_set(int status);
+
 #define SCI_IRQ_NUM 0x0A
 #define MAX_BRIGHTNESS 8
 
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/video_output.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/video_output.c
new file mode 100644
index 0000000..e8b2f9a
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/video_output.c
@@ -0,0 +1,164 @@
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
+	unsigned long status = od->request_state;
+	int value;
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
+	unsigned long status = od->request_state;
+	int value;
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
+struct output_device *lcd_output_dev, *crt_output_dev;
+
+void lcd_vo_set(int status)
+{
+	lcd_output_dev->request_state = status;
+	lcd_video_output_set(lcd_output_dev);
+}
+EXPORT_SYMBOL(lcd_vo_set);
+
+void crt_vo_set(int status)
+{
+	crt_output_dev->request_state = status;
+	crt_video_output_set(crt_output_dev);
+}
+EXPORT_SYMBOL(crt_vo_set);
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
+	lcd_vo_set(BIT_DISPLAY_LCD_ON);
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
+	crt_vo_set(BIT_CRT_DETECT_UNPLUG);
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
