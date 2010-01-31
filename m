Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:24:05 +0100 (CET)
Received: from mail-pz0-f203.google.com ([209.85.222.203]:40072 "EHLO
        mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492309Ab0AaMW0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:22:26 +0100
Received: by mail-pz0-f203.google.com with SMTP id 41so5404351pzk.0
        for <multiple recipients>; Sun, 31 Jan 2010 04:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=5IYaM9yIhqpo2bD2qBgbpKuWO6jGq1a2Pb9fo3X9iNk=;
        b=cDdQXYXGSt51P8aLaPioM6UbhahqzvhxA1SlzrIkJAOJfPxOY5wf1DtlX1I+z6FNWm
         L2FhKEETFFzvOV7vhzFcsLNmTpojUFBaZUHomimJrbNOvx1SZtCb+yYV1hf0ffRoaAEL
         cNrC0WjVPce06dfR8KFxbROhOnse/4fqXHnJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bR5HwOugWuos5hWjT6R5JIVcXdDRBC37jenK+TmNCh2BWV5KKWVkvxnCP3A9G7s0AJ
         4MhraiCxn2/9bDjjZKuCuGLLQJzD8NDA+4MKyfZolemV5xB+l+KH5VpXQg5W1NEde2GV
         dxsPBN4eXl3U/ncyOYw7qayexPrbxhamKagJU=
Received: by 10.143.20.13 with SMTP id x13mr2170531wfi.225.1264940545408;
        Sun, 31 Jan 2010 04:22:25 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3552209pzk.3.2010.01.31.04.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:22:24 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: [PATCH v11 5/9] Loongson: YeeLoong: add video output driver
Date:   Sun, 31 Jan 2010 20:15:51 +0800
Message-Id: <a3f00c700de6209c22d3e526ef6869814b1483fc.1264940063.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <d83f0e8948c0552fe26998537d984bf47ef691ae.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
 <b25d80b0d15f92b93fa3cb70c97c39cfb0d79c16.1264940063.git.wuzhangjin@gmail.com>
 <b1305e7c601d017d8c612c985cc20bb1003620f4.1264940063.git.wuzhangjin@gmail.com>
 <edfa13e4c6c10f97ba984f0fa5b65404a9468cec.1264940063.git.wuzhangjin@gmail.com>
 <d83f0e8948c0552fe26998537d984bf47ef691ae.1264940063.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
X-archive-position: 25781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19720

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds Video Output Driver, it provides standard
interface(/sys/class/video_output) to turn on/off the video output of
LCD, CRT.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/mips/Kconfig           |    1 +
 drivers/platform/mips/yeeloong_laptop.c |  139 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index d4ce744..e1285f7 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -19,6 +19,7 @@ config LEMOTE_YEELOONG2F
 	depends on LEMOTE_MACH2F
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
+	select VIDEO_OUTPUT_CONTROL
 	help
 	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
 	  compatible to FuLoong2F mini PC, but it has an extra Embedded
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 7182580..4f11bc1 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -14,6 +14,7 @@
 #include <linux/fb.h>
 #include <linux/hwmon.h>	/* for hwmon subdriver */
 #include <linux/hwmon-sysfs.h>
+#include <linux/video_output.h>	/* for video output subdriver */
 
 #include <ec_kb3310b.h>
 
@@ -321,6 +322,136 @@ static void yeeloong_hwmon_exit(void)
 	}
 }
 
+/* video output subdriver */
+
+static int lcd_video_output_get(struct output_device *od)
+{
+	return ec_read(REG_DISPLAY_LCD);
+}
+
+#define LCD	0
+#define CRT	1
+
+static void display_vo_set(int display, int on)
+{
+	int addr;
+	unsigned long value;
+
+	addr = (display == LCD) ? 0x31 : 0x21;
+
+	outb(addr, 0x3c4);
+	value = inb(0x3c5);
+
+	if (display == LCD)
+		value |= (on ? 0x03 : 0x02);
+	else {
+		if (on)
+			clear_bit(7, &value);
+		else
+			set_bit(7, &value);
+	}
+
+	outb(addr, 0x3c4);
+	outb(value, 0x3c5);
+}
+
+static int lcd_video_output_set(struct output_device *od)
+{
+	unsigned long status;
+
+	status = !!od->request_state;
+
+	display_vo_set(LCD, status);
+	ec_write(REG_BACKLIGHT_CTRL, status);
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
+	unsigned long status;
+
+	status = !!od->request_state;
+
+	if (ec_read(REG_CRT_DETECT) == BIT_CRT_DETECT_PLUG)
+		display_vo_set(CRT, status);
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
+static void yeeloong_lcd_vo_set(int status)
+{
+	lcd_output_dev->request_state = status;
+	lcd_video_output_set(lcd_output_dev);
+}
+
+static void yeeloong_crt_vo_set(int status)
+{
+	crt_output_dev->request_state = status;
+	crt_video_output_set(crt_output_dev);
+}
+
+static int yeeloong_vo_init(void)
+{
+	int ret;
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
+static void yeeloong_vo_exit(void)
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
 static struct platform_device_id platform_device_ids[] = {
 	{
 		.name = "yeeloong_laptop",
@@ -365,11 +496,19 @@ static int __init yeeloong_init(void)
 		return ret;
 	}
 
+	ret = yeeloong_vo_init();
+	if (ret) {
+		pr_err("Fail to register yeeloong video output driver.\n");
+		yeeloong_vo_exit();
+		return ret;
+	}
+
 	return 0;
 }
 
 static void __exit yeeloong_exit(void)
 {
+	yeeloong_vo_exit();
 	yeeloong_hwmon_exit();
 	yeeloong_backlight_exit();
 	platform_driver_unregister(&platform_driver);
-- 
1.6.6
