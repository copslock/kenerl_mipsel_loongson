Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Nov 2009 14:37:51 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:45295 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492952AbZK1Nhs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Nov 2009 14:37:48 +0100
Received: by pxi6 with SMTP id 6so1958445pxi.0
        for <multiple recipients>; Sat, 28 Nov 2009 05:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=I4XYO3ufbZGMqrEqTeVSC4a4JOZrBYAVSlOPchIuXxA=;
        b=LqNe3GOy7WP0JYCnt2JPWd5S3xpP5caW4q+8i4Yt8UN+x5MRYPN9dfBNq/OREH1z3X
         /g2xMEMUqF/l3hzJ8zFCuV/mKDnNikyQ48fvvDawIpMx2q+3HnDqe90Vos/ap+Xm5A59
         PaaLdIntmHJz0FCPNNsGE+P87oee2+Lx4jkfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=S4KvRZiEN4lq+p+jht3s5Pw5xPIXH+vGPmeWtv8jvA7jAB53PzloGmFOfgnuHO0gBs
         bEPNxuf85zmWFSfVVKieEeQIQHtGaqVYfbjcJCkjI54oqCy31LQ2btios1QmgLl5JvZJ
         zUEGaoRwHtmXdb+TSg4NkInOhsPMOZuB8rxRo=
Received: by 10.115.81.21 with SMTP id i21mr3870923wal.125.1259415460196;
        Sat, 28 Nov 2009 05:37:40 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1933990pxi.10.2009.11.28.05.37.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 05:37:39 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, Jamey Hicks <jamey@crl.dec.com>,
        Stephen Rothwell <sfr@linuxcare.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v5 4/8] Loongson: YeeLoong: add battery driver
Date:   Sat, 28 Nov 2009 21:37:27 +0800
Message-Id: <19f58dc908637c2e1216b9a644dba58ebc20b73f.1259414649.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259414649.git.wuzhangjin@gmail.com>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25187
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
 .../loongson/lemote-2f/yeeloong_laptop/battery.c   |  127 ++++++++++++++++++++
 3 files changed, 137 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/battery.c

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index 02d36d8..e284c91 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -19,4 +19,13 @@ config YEELOONG_BACKLIGHT
 	  interface for user-space applications to control the brightness of
 	  the backlight.
 
+config YEELOONG_BATTERY
+	tristate "Battery Driver"
+	select SYS_SUPPORTS_APM_EMULATION
+	select APM_EMULATION
+	default y
+	help
+	  This option adds APM emulated Battery Driver, which provides standard
+	  interface for user-space applications to manage the battery.
+
 endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
index 8ad1e9d..20fe0c6 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -3,3 +3,4 @@
 obj-y += ec_kb3310b.o
 
 obj-$(CONFIG_YEELOONG_BACKLIGHT) += backlight.o
+obj-$(CONFIG_YEELOONG_BATTERY) += battery.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/battery.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/battery.c
new file mode 100644
index 0000000..2a94292
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/battery.c
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
