Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Dec 2009 08:07:31 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:34471 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492284AbZLFHFk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Dec 2009 08:05:40 +0100
Received: by mail-pw0-f45.google.com with SMTP id 18so1914974pwi.24
        for <multiple recipients>; Sat, 05 Dec 2009 23:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=82CXq8jmLCVoDOkS96QDaJ2mshjn/0z00WIYBjYskO4=;
        b=uvkQogPl0iFVv+PNQx+ITQl5724w9v+DNGi2W4s56nof2xWr36WD1I8eQyOTivIVb5
         jBcVMJXf7zNZ6kOmA0t3UmIQgFPOj3ipLIZRxCTyHBq2vyDOHRuvBpmecg/bR026MNhh
         qq8vB5nqr2zQIcP/pMAJcSdkHLVh2AA972VU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bi4awd2MhVnsYmYo6yd9qlBT8YhqIUn+QoRLRIZ1AxXpmNatGgZTSdxPHO9OYXbghp
         EvXEZhrSTPD+tWsDkdq4TolDrZ2lIYKmN+PtwZKP9ksQqp4/ufvUKxFMeD70V7onrOw4
         XfRcWH7R8vZkqQQPdFYqyAK35et9oesmoWIaU=
Received: by 10.114.54.34 with SMTP id c34mr8278491waa.47.1260083139142;
        Sat, 05 Dec 2009 23:05:39 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm3974972pzk.5.2009.12.05.23.05.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 23:05:38 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v8 6/8] Loongson: YeeLoong: add video output driver
Date:   Sun,  6 Dec 2009 15:01:46 +0800
Message-Id: <a9309478df85d80c970bfc1632c1cc0147596c1c.1260082252.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
 <d6bb11d33fe01abd6de945117ce647af73841f00.1260082252.git.wuzhangjin@gmail.com>
 <5a8742a71e96ba40bee34fb37478cc8339e76530.1260082252.git.wuzhangjin@gmail.com>
 <3c77f3891e73e189cceef7155dc9cb6503084a4b.1260082252.git.wuzhangjin@gmail.com>
 <57ed2090c7f1a1a9c0e31d457617c7473b9e29ad.1260082252.git.wuzhangjin@gmail.com>
 <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1260082252.git.wuzhangjin@gmail.com>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds Video Output Driver, it provides standard
interface(/sys/class/video_output) to turn on/off the video output of
LCD, CRT.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/mips/Kconfig           |    1 +
 drivers/platform/mips/yeeloong_laptop.c |  139 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index 352594c..e2dbe28 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -21,6 +21,7 @@ config LEMOTE_YEELOONG2F
 	select SYS_SUPPORTS_APM_EMULATION
 	select APM_EMULATION
 	select HWMON
+	select VIDEO_OUTPUT_CONTROL
 	help
 	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
 	  compatible to FuLoong2F mini PC, but it has an extra Embedded
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 78ddfad..180dbb1 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -16,6 +16,7 @@
 #include <linux/apm-emulation.h>/* for battery subdriver */
 #include <linux/hwmon.h>	/* for hwmon subdriver */
 #include <linux/hwmon-sysfs.h>
+#include <linux/video_output.h>	/* for video output subdriver */
 
 #include <ec_kb3310b.h>
 
@@ -384,6 +385,136 @@ static void yeeloong_hwmon_exit(void)
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
@@ -430,11 +561,19 @@ static int __init yeeloong_init(void)
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
 	yeeloong_battery_exit();
 	yeeloong_backlight_exit();
-- 
1.6.2.1
