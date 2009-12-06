Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Dec 2009 08:06:21 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:38190 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492227AbZLFHF1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Dec 2009 08:05:27 +0100
Received: by mail-pz0-f197.google.com with SMTP id 35so3285699pzk.22
        for <multiple recipients>; Sat, 05 Dec 2009 23:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=iXdsk6nDQF2cuKR6mFuFayPQMRX+rg+n+fBSTHXgP7Q=;
        b=reEVBQkCwz1arN6nWqhUCEb2wsqjkt22qX7yN+U2q4KVl3avqvKpRiacjGBooSdXUm
         zgY1N01d3bB0W9dDHj2yKpS5KhUiJWqIY3xoN6m4hCzerGUCIaRTklYqPqkfTped8o6c
         MLucUuSpJYL6OrWK7uwGdcUFZEoseUA9Msszg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ulqa1+zmA1sJa27CSiTxH8BfpJlTOsGTlqzT8xWQaI+8sbnUmvbIYxxbD1lKTYoPqv
         DzcsTmcGVSzcYUteA7/QuLWF0vA4EZ5/LuMlGvfCZwWldHTY2GFUeKc1iWYFQFiN8Wop
         GHMJfGI3U3IFhFKoXYiIjb9PFFQSi7QnYLBu8=
Received: by 10.114.23.4 with SMTP id 4mr8353932waw.28.1260083126732;
        Sat, 05 Dec 2009 23:05:26 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm3974972pzk.5.2009.12.05.23.05.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 23:05:26 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v8 4/8] Loongson: YeeLoong: add battery driver
Date:   Sun,  6 Dec 2009 15:01:44 +0800
Message-Id: <57ed2090c7f1a1a9c0e31d457617c7473b9e29ad.1260082252.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <3c77f3891e73e189cceef7155dc9cb6503084a4b.1260082252.git.wuzhangjin@gmail.com>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
 <d6bb11d33fe01abd6de945117ce647af73841f00.1260082252.git.wuzhangjin@gmail.com>
 <5a8742a71e96ba40bee34fb37478cc8339e76530.1260082252.git.wuzhangjin@gmail.com>
 <3c77f3891e73e189cceef7155dc9cb6503084a4b.1260082252.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1260082252.git.wuzhangjin@gmail.com>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds APM emulated Battery Driver, it provides standard
interface(/proc/apm) for user-space applications(e.g. kpowersave,
gnome-power-manager) to manage the battery.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/mips/Kconfig           |    2 +
 drivers/platform/mips/yeeloong_laptop.c |  108 ++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index c1ba03d..965933b 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -18,6 +18,8 @@ config LEMOTE_YEELOONG2F
 	tristate "Lemote YeeLoong Laptop"
 	depends on LEMOTE_MACH2F
 	select BACKLIGHT_CLASS_DEVICE
+	select SYS_SUPPORTS_APM_EMULATION
+	select APM_EMULATION
 	help
 	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
 	  compatible to FuLoong2F mini PC, but it has an extra Embedded
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index f04a7e2..0d9f2a6 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -2,7 +2,7 @@
  * Driver for YeeLoong laptop extras
  *
  *  Copyright (C) 2009 Lemote Inc.
- *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *  Author: Wu Zhangjin <wuzj@lemote.com>, Liu Junliang <liujl@lemote.com>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/backlight.h>	/* for backlight subdriver */
 #include <linux/fb.h>
+#include <linux/apm-emulation.h>/* for battery subdriver */
 
 #include <ec_kb3310b.h>
 
@@ -85,6 +86,106 @@ static void yeeloong_backlight_exit(void)
 	}
 }
 
+/* battery subdriver */
+
+static void get_fixed_battery_info(void)
+{
+	int design_cap, full_charged_cap, design_vol, vendor, cell_count;
+
+	design_cap = (ec_read(REG_BAT_DESIGN_CAP_HIGH) << 8)
+	    | ec_read(REG_BAT_DESIGN_CAP_LOW);
+	full_charged_cap = (ec_read(REG_BAT_FULLCHG_CAP_HIGH) << 8)
+	    | ec_read(REG_BAT_FULLCHG_CAP_LOW);
+	design_vol = (ec_read(REG_BAT_DESIGN_VOL_HIGH) << 8)
+	    | ec_read(REG_BAT_DESIGN_VOL_LOW);
+	vendor = ec_read(REG_BAT_VENDOR);
+	cell_count = ec_read(REG_BAT_CELL_COUNT);
+
+	if (vendor != 0) {
+		pr_info("battery vendor(%s), cells count(%d), "
+		       "with designed capacity(%d),designed voltage(%d),"
+		       " full charged capacity(%d)\n",
+		       (vendor ==
+			FLAG_BAT_VENDOR_SANYO) ? "SANYO" : "SIMPLO",
+		       (cell_count == FLAG_BAT_CELL_3S1P) ? 3 : 6,
+		       design_cap, design_vol,
+		       full_charged_cap);
+	}
+}
+
+#define APM_CRITICAL		5
+
+static void get_power_status(struct apm_power_info *info)
+{
+	unsigned char bat_status;
+
+	info->battery_status = APM_BATTERY_STATUS_UNKNOWN;
+	info->battery_flag = APM_BATTERY_FLAG_UNKNOWN;
+	info->units = APM_UNITS_MINS;
+
+	info->battery_life = (ec_read(REG_BAT_RELATIVE_CAP_HIGH) << 8) |
+		(ec_read(REG_BAT_RELATIVE_CAP_LOW));
+
+	info->ac_line_status = (ec_read(REG_BAT_POWER) & BIT_BAT_POWER_ACIN) ?
+		APM_AC_ONLINE : APM_AC_OFFLINE;
+
+	bat_status = ec_read(REG_BAT_STATUS);
+
+	if (!(bat_status & BIT_BAT_STATUS_IN)) {
+		/* no battery inserted */
+		info->battery_status = APM_BATTERY_STATUS_NOT_PRESENT;
+		info->battery_flag = APM_BATTERY_FLAG_NOT_PRESENT;
+		info->time = 0x00;
+		return;
+	}
+
+	/* adapter inserted */
+	if (info->ac_line_status == APM_AC_ONLINE) {
+		if (!(bat_status & BIT_BAT_STATUS_FULL)) {
+			/* battery is not fully charged */
+			info->battery_status = APM_BATTERY_STATUS_CHARGING;
+			info->battery_flag = APM_BATTERY_FLAG_CHARGING;
+		} else {
+			/* battery is fully charged */
+			info->battery_status = APM_BATTERY_STATUS_HIGH;
+			info->battery_flag = APM_BATTERY_FLAG_HIGH;
+			info->battery_life = 100;
+		}
+	} else {
+		/* battery is too low */
+		if (bat_status & BIT_BAT_STATUS_LOW) {
+			info->battery_status = APM_BATTERY_STATUS_LOW;
+			info->battery_flag = APM_BATTERY_FLAG_LOW;
+			if (info->battery_life <= APM_CRITICAL) {
+				/* we should power off the system now */
+				info->battery_status =
+					APM_BATTERY_STATUS_CRITICAL;
+				info->battery_flag = APM_BATTERY_FLAG_CRITICAL;
+			}
+		} else {
+			/* assume the battery is high enough. */
+			info->battery_status = APM_BATTERY_STATUS_HIGH;
+			info->battery_flag = APM_BATTERY_FLAG_HIGH;
+		}
+	}
+	info->time = ((info->battery_life - 3) * 54 + 142) / 60;
+}
+
+static int yeeloong_battery_init(void)
+{
+	get_fixed_battery_info();
+
+	apm_get_power_status = get_power_status;
+
+	return 0;
+}
+
+static void yeeloong_battery_exit(void)
+{
+	if (apm_get_power_status == get_power_status)
+		apm_get_power_status = NULL;
+}
+
 static struct platform_device_id platform_device_ids[] = {
 	{
 		.name = "yeeloong_laptop",
@@ -122,11 +223,14 @@ static int __init yeeloong_init(void)
 		return ret;
 	}
 
+	yeeloong_battery_init();
+
 	return 0;
 }
 
 static void __exit yeeloong_exit(void)
 {
+	yeeloong_battery_exit();
 	yeeloong_backlight_exit();
 	platform_driver_unregister(&platform_driver);
 
@@ -136,6 +240,6 @@ static void __exit yeeloong_exit(void)
 module_init(yeeloong_init);
 module_exit(yeeloong_exit);
 
-MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>");
+MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>; Liu Junliang <liujl@lemote.com>");
 MODULE_DESCRIPTION("YeeLoong laptop driver");
 MODULE_LICENSE("GPL");
-- 
1.6.2.1
