Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 15:17:31 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:47541 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494196AbZLHOQf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 15:16:35 +0100
Received: by mail-px0-f176.google.com with SMTP id 6so4090402pxi.0
        for <multiple recipients>; Tue, 08 Dec 2009 06:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=98C3ZgXwlkFjaRCwUIJy9wrLHylzok1hdiAhXCzdMGw=;
        b=pvGSDhikkJNRZ8zMqZsc/umDdx46dAG5NNXiac5MCIbWePrz/FX2m4KCVYflxQ7Z+U
         PHtI0tNM3Uhk9cDHFtdClGnqBoMrmlsAbO5+VsaKIc8+6AtmZhNKomGUF6oqbk8Tbyez
         WT1FQtOJWF0G4LKM73eWF+4mcTu5Y26NjxSeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BNa0/DUA5lb+R6GsEzei8XMaeyJ/GWVZrnVTjYmvINghsUlxQzl4tHSiaAzELCcZfL
         2/GvotVN1Zd5KiCN/99/Uh4dB+iuZJxIxr0Y1eeWhTQh9v8WY+ubV8wuozNRX79nn+yj
         ObP0XjrmxyZRP4/j/Bx5vo7TbyO4oEf0UMoHI=
Received: by 10.114.237.18 with SMTP id k18mr15428642wah.63.1260281794692;
        Tue, 08 Dec 2009 06:16:34 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm6030062pzk.2.2009.12.08.06.16.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 06:16:34 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     akpm@linux-foundation.org, Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v9 3/8] Loongson: YeeLoong: add backlight driver
Date:   Tue,  8 Dec 2009 22:15:51 +0800
Message-Id: <4d821efaecc3dee0b9124119507a694e81572437.1260281599.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <7676d8397e593dbec0d40e24429b7ccbcecfa588.1260281599.git.wuzhangjin@gmail.com>
References: <cover.1260254344.git.wuzhangjin@gmail.com>
 <39d232e3f8359e9c11bad7536f0162444401ec94.1260281599.git.wuzhangjin@gmail.com>
 <7676d8397e593dbec0d40e24429b7ccbcecfa588.1260281599.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1260281599.git.wuzhangjin@gmail.com>
References: <cover.1260281599.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds YeeLoong Backlight Driver, it provides standard
interface(/sys/class/backlight/) for user-space applications(e.g.
kpowersave, gnome-power-manager) to control the brightness of the
backlight.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/mips/Kconfig           |    1 +
 drivers/platform/mips/yeeloong_laptop.c |   81 +++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index 5ac5215..c1ba03d 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -17,6 +17,7 @@ if MIPS_PLATFORM_DEVICES
 config LEMOTE_YEELOONG2F
 	tristate "Lemote YeeLoong Laptop"
 	depends on LEMOTE_MACH2F
+	select BACKLIGHT_CLASS_DEVICE
 	help
 	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
 	  compatible to FuLoong2F mini PC, but it has an extra Embedded
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 85fc7ed..be674c5 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -11,6 +11,79 @@
 
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/backlight.h>	/* for backlight subdriver */
+#include <linux/fb.h>
+
+#include <ec_kb3310b.h>
+
+/* backlight subdriver */
+#define MAX_BRIGHTNESS	8
+
+static int yeeloong_set_brightness(struct backlight_device *bd)
+{
+	unsigned int level, current_level;
+	static unsigned int old_level;
+
+	level = (bd->props.fb_blank == FB_BLANK_UNBLANK &&
+		 bd->props.power == FB_BLANK_UNBLANK) ?
+	    bd->props.brightness : 0;
+
+	if (level > MAX_BRIGHTNESS)
+		level = MAX_BRIGHTNESS;
+	else if (level < 0)
+		level = 0;
+
+	/* Avoid to modify the brightness when EC is tuning it */
+	if (old_level != level) {
+		current_level = ec_read(REG_DISPLAY_BRIGHTNESS);
+		if (old_level == current_level)
+			ec_write(REG_DISPLAY_BRIGHTNESS, level);
+		old_level = level;
+	}
+
+	return 0;
+}
+
+static int yeeloong_get_brightness(struct backlight_device *bd)
+{
+	return ec_read(REG_DISPLAY_BRIGHTNESS);
+}
+
+static struct backlight_ops backlight_ops = {
+	.get_brightness = yeeloong_get_brightness,
+	.update_status = yeeloong_set_brightness,
+};
+
+static struct backlight_device *yeeloong_backlight_dev;
+
+static int yeeloong_backlight_init(void)
+{
+	int ret;
+
+	yeeloong_backlight_dev = backlight_device_register("backlight0", NULL,
+			NULL, &backlight_ops);
+
+	if (IS_ERR(yeeloong_backlight_dev)) {
+		ret = PTR_ERR(yeeloong_backlight_dev);
+		yeeloong_backlight_dev = NULL;
+		return ret;
+	}
+
+	yeeloong_backlight_dev->props.max_brightness = MAX_BRIGHTNESS;
+	yeeloong_backlight_dev->props.brightness =
+		yeeloong_get_brightness(yeeloong_backlight_dev);
+	backlight_update_status(yeeloong_backlight_dev);
+
+	return 0;
+}
+
+static void yeeloong_backlight_exit(void)
+{
+	if (yeeloong_backlight_dev) {
+		backlight_device_unregister(yeeloong_backlight_dev);
+		yeeloong_backlight_dev = NULL;
+	}
+}
 
 static struct platform_device_id platform_device_ids[] = {
 	{
@@ -42,11 +115,19 @@ static int __init yeeloong_init(void)
 		return ret;
 	}
 
+	ret = yeeloong_backlight_init();
+	if (ret) {
+		pr_err("Fail to register yeeloong backlight driver.\n");
+		yeeloong_backlight_exit();
+		return ret;
+	}
+
 	return 0;
 }
 
 static void __exit yeeloong_exit(void)
 {
+	yeeloong_backlight_exit();
 	platform_driver_unregister(&platform_driver);
 
 	pr_info("Unload YeeLoong Platform Specific Driver.\n");
-- 
1.6.2.1
