Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 14:36:37 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:51570 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492813AbZK1Nge (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Nov 2009 14:36:34 +0100
Received: by pzk35 with SMTP id 35so1644114pzk.22
        for <multiple recipients>; Sat, 28 Nov 2009 05:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5/W6/10FT3ZMl5PxOaxB/EXIfQlUl5lq6OclECG+eYw=;
        b=ny4wr6Om7KN7KlXzMKYsRQnPszbNM1ZZccC8fBuhb9K4SM9xdZjo/7cnBlXDd1hpQT
         JJcruA3NgcPzCuw5lrw0bnM0rBurS/jLEkAYT0R1iWBMDjjxHOfgdrOU6PXYZ0Dcs7fX
         jRsOOJ1l3xVTXdAYcKzPtkx9WqYv/e377W0o0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=owPZIbzudyKbj6Xv3xzI1aNdchYg3DqmyTEtkatRl4zlqVTif+tQdFPyL0zF0UOAmt
         ABLvNHO/6D3mmqYQdJw0FfVKPUjCtWfGvyJHgXIDaVSiL5O00sqC9f7jdQStqB+sTMBm
         iYkDLxmlYB69vduy5fRfduKGgUKBXLm7hstwM=
Received: by 10.115.103.7 with SMTP id f7mr3933897wam.1.1259415387370;
        Sat, 28 Nov 2009 05:36:27 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1931003pxi.8.2009.11.28.05.36.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 05:36:26 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, Richard Purdie <rpurdie@rpsys.net>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v5 3/8] Loongson: YeeLoong: add backlight driver
Date:   Sat, 28 Nov 2009 21:36:05 +0800
Message-Id: <23a22d9d675a53c962500ee88db7f6cd2192e8db.1259414649.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds YeeLoong Backlight Driver, which provides standard
interface for user-space applications to control the brightness of the
backlight.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 ++-
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    2 +
 .../loongson/lemote-2f/yeeloong_laptop/backlight.c |   93 ++++++++++++++++++++
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    1 +
 4 files changed, 104 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/backlight.c

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index d6df9b7..02d36d8 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -10,6 +10,13 @@ menuconfig LEMOTE_YEELOONG2F
 
 if LEMOTE_YEELOONG2F
 
-
+config YEELOONG_BACKLIGHT
+	tristate "Backlight Driver"
+	select BACKLIGHT_CLASS_DEVICE
+	default y
+	help
+	  This option adds YeeLoong Backlight Driver, which provides standard
+	  interface for user-space applications to control the brightness of
+	  the backlight.
 
 endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
index 90c4ce5..8ad1e9d 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -1,3 +1,5 @@
 # YeeLoong Specific
 
 obj-y += ec_kb3310b.o
+
+obj-$(CONFIG_YEELOONG_BACKLIGHT) += backlight.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/backlight.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/backlight.c
new file mode 100644
index 0000000..481d2ca
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/backlight.c
@@ -0,0 +1,93 @@
+/*
+ * YeeLoong Backlight Driver
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/backlight.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+
+#include <asm/bootinfo.h>
+
+#include "ec_kb3310b.h"
+
+MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>");
+MODULE_DESCRIPTION("YeeLoong laptop backlight driver");
+MODULE_LICENSE("GPL");
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
+	current_level = ec_read(REG_DISPLAY_BRIGHTNESS);
+	if ((old_level == current_level) && (old_level != level))
+		ec_write(REG_DISPLAY_BRIGHTNESS, level);
+	old_level = level;
+
+	return 0;
+}
+
+static int yeeloong_get_brightness(struct backlight_device *bd)
+{
+	return (int)ec_read(REG_DISPLAY_BRIGHTNESS);
+}
+
+static struct backlight_ops backlight_ops = {
+	.get_brightness = yeeloong_get_brightness,
+	.update_status = yeeloong_set_brightness,
+};
+
+static struct backlight_device *yeeloong_backlight_dev;
+
+static int __init yeeloong_backlight_init(void)
+{
+	int ret;
+
+	if (mips_machtype != MACH_LEMOTE_YL2F89) {
+		pr_err("This Driver is only for YeeLoong laptop\n");
+		return -EFAULT;
+	}
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
+static void __exit yeeloong_backlight_exit(void)
+{
+	if (yeeloong_backlight_dev) {
+		backlight_device_unregister(yeeloong_backlight_dev);
+		yeeloong_backlight_dev = NULL;
+	}
+}
+
+module_init(yeeloong_backlight_init);
+module_exit(yeeloong_backlight_exit);
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
index 762d888..0e3b5ad 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
@@ -23,6 +23,7 @@ typedef int (*sci_handler) (int status);
 extern sci_handler yeeloong_report_lid_status;
 
 #define SCI_IRQ_NUM 0x0A
+#define MAX_BRIGHTNESS 8
 
 /*
  * The following registers are determined by the EC index configuration.
-- 
1.6.2.1
