Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:09:47 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:52374 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492288AbZLALJo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 12:09:44 +0100
Received: by pwi15 with SMTP id 15so2583234pwi.24
        for <multiple recipients>; Tue, 01 Dec 2009 03:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ByK8nyh0phks6Og6iMumiJyZ7TQGZbpyr9HDGlbaDqw=;
        b=oJ5l2UuOlHJJRljuiyQsd+yU1qKVV++rczQlPx53K/Z+5BHrqpkAZ9rXfxyGU5DOJA
         zj6EPGn7sO0QZWjkDKTMm98HoX7bIzx1QXDb/meUDCMwuZ4Zvdr+60kwKhSJ6y+QYysA
         y86cig/OT+M8MuiIZIiHabs2VHstq/dXPG+/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wviGJwG5zKNXx2a3eSUU10Uap2t446ZxuFUnotMqeBQqW+OcSve+mcdxevyGuohMN9
         TIJgPwh2PwO7hyhhTphyQP1PA5Z6yA/wqDOVLQ2mqNB5JFTvDpUqR/OVjgNSYtYTPhz3
         pmKDcIbp0NOdbaDfSr+celxCLHxZOmAmSPf6g=
Received: by 10.115.100.20 with SMTP id c20mr10575628wam.160.1259665776194;
        Tue, 01 Dec 2009 03:09:36 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm3605579pzk.6.2009.12.01.03.09.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 03:09:35 -0800 (PST)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Stephen Rothwell <sfr@linuxcare.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6 4/8] Loongson: YeeLoong: add battery driver
Date:   Tue,  1 Dec 2009 19:09:19 +0800
Message-Id: <6a81bc182b684f94ebcffc562ee98fa7db759826.1259664573.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259660040.git.wuzhangjin@gmail.com>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1259664573.git.wuzhangjin@gmail.com>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds APM_EMULATION based Battery Driver, which provides
standard interface for user-space applications to manage the battery.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 ++
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
 .../lemote-2f/yeeloong_laptop/yl_battery.c         |  127 ++++++++++++++++++++
 3 files changed, 137 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_battery.c

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index 02d36d8..2401ed6 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -1,6 +1,7 @@
 menuconfig LEMOTE_YEELOONG2F
 	bool "Lemote YeeLoong Laptop"
 	depends on LEMOTE_MACH2F
+	select SYS_SUPPORTS_APM_EMULATION
 	default y
 	help
 	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
@@ -19,4 +20,12 @@ config YEELOONG_BACKLIGHT
 	  interface for user-space applications to control the brightness of
 	  the backlight.
 
+config YEELOONG_BATTERY
+	tristate "Battery Driver"
+	depends on APM_EMULATION
+	default y
+	help
+	  This option adds APM emulated Battery Driver, which provides standard
+	  interface for user-space applications to manage the battery.
+
 endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
index 6c3d3dc..31e2145 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -3,3 +3,4 @@
 obj-y += ec_kb3310b.o
 
 obj-$(CONFIG_YEELOONG_BACKLIGHT) += yl_backlight.o
+obj-$(CONFIG_YEELOONG_BATTERY) += yl_battery.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_battery.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_battery.c
new file mode 100644
index 0000000..2a94292
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_battery.c
@@ -0,0 +1,127 @@
+/*
+ * YeeLoong Battery Driver: APM emulated support
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Liu Junliang <liujl@lemote.com>
+ *          Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/apm-emulation.h>
+#include <linux/err.h>
+#include <linux/module.h>
+
+#include <asm/bootinfo.h>
+
+#include "ec_kb3310b.h"
+
+MODULE_AUTHOR("Liu Junliang <liujl@lemote.com>; Wu Zhangjin <wuzj@lemote.com>");
+MODULE_DESCRIPTION("YeeLoong laptop battery driver");
+MODULE_LICENSE("GPL");
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
+static int __init yeeloong_battery_init(void)
+{
+	if (mips_machtype != MACH_LEMOTE_YL2F89) {
+		pr_err("This Driver is only for YeeLoong laptop\n");
+		return -EFAULT;
+	}
+
+	get_fixed_battery_info();
+
+	apm_get_power_status = get_power_status;
+
+	return 0;
+}
+
+static void __exit yeeloong_battery_exit(void)
+{
+}
+
+module_init(yeeloong_battery_init);
+module_exit(yeeloong_battery_exit);
-- 
1.6.2.1
