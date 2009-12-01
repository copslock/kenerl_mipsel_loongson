Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:09:10 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:39152 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492281AbZLALJG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 12:09:06 +0100
Received: by pzk35 with SMTP id 35so3579171pzk.22
        for <multiple recipients>; Tue, 01 Dec 2009 03:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=gI0BYRPfzPFqYctNhNUzu32Oj0NlToiWj47GrCzZ5oI=;
        b=ipV4OPjC+skGGBnE1fCE72ExxqpVgOKlUJVtvsm/c/A01zuB6kev7DCHXBehxfGmkf
         1xw3nvTjqI1OXHBtDksHAezfqSZJ9p4UTef5DcplQpTi3STK83H14yuxbYfRSbw4Cfln
         xpZns7XtvqyDnEyuONmr+a/Lh2f29UAur0wGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CYSqJ1p9YFbClRWSNZJNBujIDeZ+NejLnw52P8+OSt8j/We6ma5SQiWTUfWixNN8BI
         GohapV98bR/rn1XJvxp4UHwHJUpDOGUZzhe1pJxKZR+DIpaZgthO1lqNS+g2yfBb3uFP
         B9nxXIcXXdEOSTMz4C2aOJzsp6x6Vsz8HKBcQ=
Received: by 10.114.252.2 with SMTP id z2mr10559799wah.156.1259665738032;
        Tue, 01 Dec 2009 03:08:58 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm478598pxi.1.2009.12.01.03.08.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 03:08:57 -0800 (PST)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Richard Purdie <rpurdie@rpsys.net>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6 3/8] Loongson: YeeLoong: add backlight driver
Date:   Tue,  1 Dec 2009 19:08:42 +0800
Message-Id: <4328ee6b15dce3cb600dddf4e7151532ddc77f17.1259664573.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259660040.git.wuzhangjin@gmail.com>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1259664573.git.wuzhangjin@gmail.com>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25226
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
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    1 +
 .../lemote-2f/yeeloong_laptop/yl_backlight.c       |   93 ++++++++++++++++++++
 4 files changed, 104 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_backlight.c

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
index 90c4ce5..6c3d3dc 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -1,3 +1,5 @@
 # YeeLoong Specific
 
 obj-y += ec_kb3310b.o
+
+obj-$(CONFIG_YEELOONG_BACKLIGHT) += yl_backlight.o
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
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_backlight.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_backlight.c
new file mode 100644
index 0000000..481d2ca
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_backlight.c
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
-- 
1.6.2.1
