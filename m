Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:23:38 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:39509 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492282Ab0AaMW0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:22:26 +0100
Received: by pxi11 with SMTP id 11so3141197pxi.22
        for <multiple recipients>; Sun, 31 Jan 2010 04:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=N81jYZZYxLv16TJ3n/ESJrmDCSG9c5srekBXhYQzs18=;
        b=McA3wmxz0OAxRcl1d+xTjm0Nty6AG0mkf2v9NIzdTNFHVG6FQMqMCBJv1ksyGR5HIV
         kApJpa1begBlBURxXhmCaBHqoqbTi4TggsBW3Grw4JDbFTujVmH+sRwkZ7+9j57B88ql
         e9nwmFaGrFd8Wbx05b3PpkR6lrcfGENdhk2oA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vxnC1h57W03YDXDB0r4jMSLJR/yF0s1jMmhaDRu5PxRZ9B8RmBdZi5jDTbCJh6h5oj
         6bZXvBzm/VRqvyNLwD4sKmdMcGvb1/ZPFlUbq/jVOhN+/QTUW/7RZkiiDhchcHqkehCC
         jKD2FMrvBcM5let32fWcHy63iydcHdtK9a9iQ=
Received: by 10.142.1.21 with SMTP id 21mr2180740wfa.86.1264940537382;
        Sun, 31 Jan 2010 04:22:17 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3552209pzk.3.2010.01.31.04.22.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:22:16 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: [PATCH v11 3/9] Loongson: YeeLoong: add backlight driver
Date:   Sun, 31 Jan 2010 20:15:49 +0800
Message-Id: <edfa13e4c6c10f97ba984f0fa5b65404a9468cec.1264940063.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <b1305e7c601d017d8c612c985cc20bb1003620f4.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
 <b25d80b0d15f92b93fa3cb70c97c39cfb0d79c16.1264940063.git.wuzhangjin@gmail.com>
 <b1305e7c601d017d8c612c985cc20bb1003620f4.1264940063.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
X-archive-position: 25780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19719

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
index 09f606c..31fbb49 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -10,6 +10,79 @@
 
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
@@ -41,11 +114,19 @@ static int __init yeeloong_init(void)
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
1.6.6
