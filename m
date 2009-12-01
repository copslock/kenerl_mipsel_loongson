Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:08:22 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:57134 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492281AbZLALIS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 12:08:18 +0100
Received: by pwi15 with SMTP id 15so2582441pwi.24
        for <multiple recipients>; Tue, 01 Dec 2009 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=GNM+Q001W2cN/4THSd+Xkxejs3T6m4qnuK42wQxLbrk=;
        b=UZZFneFot7h/ivnyEUxjTDCRhK5PNjJXOuSZYqdAU09q5A37q1/wHsexhh+QCizo4u
         zOmYvEWhPzAPD5QwJdqRx5y6UKH3Nl/YbNt8WP5oZ0CJWEZMieU78VsHjqA2nC/MHipa
         u76dqhe2+nlbopiWBZQPRluHtpEcAyx4zNIXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=npum3LjTWa2cwebsCwZHLMwtCVzO1nHphUiYFQ16wltuZb+LFn0Cqu3YDWqe8FHYQS
         UsekMFAqw/zuS5GLCeHdV0zvzCTEk50zxMGAQzS8IOtIX+a4t1dwNJnGtLoJpnfuqDLS
         /Ylx/zH3zywpF3SPuax1l1snP2uYcpCA/1DV8=
Received: by 10.115.98.40 with SMTP id a40mr10598259wam.97.1259665691057;
        Tue, 01 Dec 2009 03:08:11 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm482047pxi.5.2009.12.01.03.08.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 03:08:10 -0800 (PST)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6 2/8] Loongson: YeeLoong: add platform specific option
Date:   Tue,  1 Dec 2009 19:07:45 +0800
Message-Id: <e420b43bb54c33343e15cf53baf39806ba6583ae.1259664573.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259660040.git.wuzhangjin@gmail.com>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1259664573.git.wuzhangjin@gmail.com>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch add a new LEMOTE_YEELOONG2F option, a yeeloong_laptop/
directory for the coming yeeloong specific support, and for the
ec_kb3310b belongs to yeeloong, so, move it to yeeloong_laptop/ too.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/Kconfig                         |    1 +
 arch/mips/loongson/lemote-2f/Makefile              |    7 +-
 arch/mips/loongson/lemote-2f/ec_kb3310b.c          |  130 --------------
 arch/mips/loongson/lemote-2f/ec_kb3310b.h          |  188 --------------------
 arch/mips/loongson/lemote-2f/pm.c                  |    4 +-
 arch/mips/loongson/lemote-2f/reset.c               |    2 +-
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |   15 ++
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    3 +
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.c         |  126 +++++++++++++
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |  187 +++++++++++++++++++
 10 files changed, 341 insertions(+), 322 deletions(-)
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.c
 delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.c
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index a34dfcc..d440c32 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -101,5 +101,6 @@ menuconfig LOONGSON_PLATFORM_DEVICES
 if LOONGSON_PLATFORM_DEVICES
 # Put platform specific stuff here
 
+source "arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig"
 
 endif # LOONGSON_PLATFORM_DEVICES
diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index 4d84b27..0ada6c9 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -2,10 +2,15 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += irq.o reset.o ec_kb3310b.o
+obj-y += irq.o reset.o
 
 #
 # Suspend Support
 #
 
 obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
+
+#
+# Platform Drivers
+#
+obj-y += yeeloong_laptop/
diff --git a/arch/mips/loongson/lemote-2f/ec_kb3310b.c b/arch/mips/loongson/lemote-2f/ec_kb3310b.c
deleted file mode 100644
index 4d84111..0000000
--- a/arch/mips/loongson/lemote-2f/ec_kb3310b.c
+++ /dev/null
@@ -1,130 +0,0 @@
-/*
- * Basic KB3310B Embedded Controller support for the YeeLoong 2F netbook
- *
- *  Copyright (C) 2008 Lemote Inc.
- *  Author: liujl <liujl@lemote.com>, 2008-04-20
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/delay.h>
-
-#include "ec_kb3310b.h"
-
-static DEFINE_SPINLOCK(index_access_lock);
-static DEFINE_SPINLOCK(port_access_lock);
-
-unsigned char ec_read(unsigned short addr)
-{
-	unsigned char value;
-	unsigned long flags;
-
-	spin_lock_irqsave(&index_access_lock, flags);
-	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
-	outb((addr & 0x00ff), EC_IO_PORT_LOW);
-	value = inb(EC_IO_PORT_DATA);
-	spin_unlock_irqrestore(&index_access_lock, flags);
-
-	return value;
-}
-EXPORT_SYMBOL_GPL(ec_read);
-
-void ec_write(unsigned short addr, unsigned char val)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&index_access_lock, flags);
-	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
-	outb((addr & 0x00ff), EC_IO_PORT_LOW);
-	outb(val, EC_IO_PORT_DATA);
-	/*  flush the write action */
-	inb(EC_IO_PORT_DATA);
-	spin_unlock_irqrestore(&index_access_lock, flags);
-
-	return;
-}
-EXPORT_SYMBOL_GPL(ec_write);
-
-/*
- * This function is used for EC command writes and corresponding status queries.
- */
-int ec_query_seq(unsigned char cmd)
-{
-	int timeout;
-	unsigned char status;
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&port_access_lock, flags);
-
-	/* make chip goto reset mode */
-	udelay(EC_REG_DELAY);
-	outb(cmd, EC_CMD_PORT);
-	udelay(EC_REG_DELAY);
-
-	/* check if the command is received by ec */
-	timeout = EC_CMD_TIMEOUT;
-	status = inb(EC_STS_PORT);
-	while (timeout-- && (status & (1 << 1))) {
-		status = inb(EC_STS_PORT);
-		udelay(EC_REG_DELAY);
-	}
-
-	if (timeout <= 0) {
-		printk(KERN_ERR "%s: deadable error : timeout...\n", __func__);
-		ret = -EINVAL;
-	} else
-		printk(KERN_INFO
-			   "(%x/%d)ec issued command %d status : 0x%x\n",
-			   timeout, EC_CMD_TIMEOUT - timeout, cmd, status);
-
-	spin_unlock_irqrestore(&port_access_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ec_query_seq);
-
-/*
- * Send query command to EC to get the proper event number
- */
-int ec_query_event_num(void)
-{
-	return ec_query_seq(CMD_GET_EVENT_NUM);
-}
-EXPORT_SYMBOL(ec_query_event_num);
-
-/*
- * Get event number from EC
- *
- * NOTE: This routine must follow the query_event_num function in the
- * interrupt.
- */
-int ec_get_event_num(void)
-{
-	int timeout = 100;
-	unsigned char value;
-	unsigned char status;
-
-	udelay(EC_REG_DELAY);
-	status = inb(EC_STS_PORT);
-	udelay(EC_REG_DELAY);
-	while (timeout-- && !(status & (1 << 0))) {
-		status = inb(EC_STS_PORT);
-		udelay(EC_REG_DELAY);
-	}
-	if (timeout <= 0) {
-		pr_info("%s: get event number timeout.\n", __func__);
-
-		return -EINVAL;
-	}
-	value = inb(EC_DAT_PORT);
-	udelay(EC_REG_DELAY);
-
-	return value;
-}
-EXPORT_SYMBOL(ec_get_event_num);
diff --git a/arch/mips/loongson/lemote-2f/ec_kb3310b.h b/arch/mips/loongson/lemote-2f/ec_kb3310b.h
deleted file mode 100644
index 1595a21..0000000
--- a/arch/mips/loongson/lemote-2f/ec_kb3310b.h
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * KB3310B Embedded Controller
- *
- *  Copyright (C) 2008 Lemote Inc.
- *  Author: liujl <liujl@lemote.com>, 2008-03-14
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef _EC_KB3310B_H
-#define _EC_KB3310B_H
-
-extern unsigned char ec_read(unsigned short addr);
-extern void ec_write(unsigned short addr, unsigned char val);
-extern int ec_query_seq(unsigned char cmd);
-extern int ec_query_event_num(void);
-extern int ec_get_event_num(void);
-
-typedef int (*sci_handler) (int status);
-extern sci_handler yeeloong_report_lid_status;
-
-#define SCI_IRQ_NUM 0x0A
-
-/*
- * The following registers are determined by the EC index configuration.
- * 1, fill the PORT_HIGH as EC register high part.
- * 2, fill the PORT_LOW as EC register low part.
- * 3, fill the PORT_DATA as EC register write data or get the data from it.
- */
-#define	EC_IO_PORT_HIGH	0x0381
-#define	EC_IO_PORT_LOW	0x0382
-#define	EC_IO_PORT_DATA	0x0383
-
-/*
- * EC delay time is 500us for register and status access
- */
-#define	EC_REG_DELAY	500	/* unit : us */
-#define	EC_CMD_TIMEOUT	0x1000
-
-/*
- * EC access port for SCI communication
- */
-#define	EC_CMD_PORT		0x66
-#define	EC_STS_PORT		0x66
-#define	EC_DAT_PORT		0x62
-#define	CMD_INIT_IDLE_MODE	0xdd
-#define	CMD_EXIT_IDLE_MODE	0xdf
-#define	CMD_INIT_RESET_MODE	0xd8
-#define	CMD_REBOOT_SYSTEM	0x8c
-#define	CMD_GET_EVENT_NUM	0x84
-#define	CMD_PROGRAM_PIECE	0xda
-
-/* temperature & fan registers */
-#define	REG_TEMPERATURE_VALUE	0xF458
-#define	REG_FAN_AUTO_MAN_SWITCH 0xF459
-#define	BIT_FAN_AUTO		0
-#define	BIT_FAN_MANUAL		1
-#define	REG_FAN_CONTROL		0xF4D2
-#define	BIT_FAN_CONTROL_ON	(1 << 0)
-#define	BIT_FAN_CONTROL_OFF	(0 << 0)
-#define	REG_FAN_STATUS		0xF4DA
-#define	BIT_FAN_STATUS_ON	(1 << 0)
-#define	BIT_FAN_STATUS_OFF	(0 << 0)
-#define	REG_FAN_SPEED_HIGH	0xFE22
-#define	REG_FAN_SPEED_LOW	0xFE23
-#define	REG_FAN_SPEED_LEVEL	0xF4CC
-/* fan speed divider */
-#define	FAN_SPEED_DIVIDER	480000	/* (60*1000*1000/62.5/2)*/
-
-/* battery registers */
-#define	REG_BAT_DESIGN_CAP_HIGH		0xF77D
-#define	REG_BAT_DESIGN_CAP_LOW		0xF77E
-#define	REG_BAT_FULLCHG_CAP_HIGH	0xF780
-#define	REG_BAT_FULLCHG_CAP_LOW		0xF781
-#define	REG_BAT_DESIGN_VOL_HIGH		0xF782
-#define	REG_BAT_DESIGN_VOL_LOW		0xF783
-#define	REG_BAT_CURRENT_HIGH		0xF784
-#define	REG_BAT_CURRENT_LOW		0xF785
-#define	REG_BAT_VOLTAGE_HIGH		0xF786
-#define	REG_BAT_VOLTAGE_LOW		0xF787
-#define	REG_BAT_TEMPERATURE_HIGH	0xF788
-#define	REG_BAT_TEMPERATURE_LOW		0xF789
-#define	REG_BAT_RELATIVE_CAP_HIGH	0xF492
-#define	REG_BAT_RELATIVE_CAP_LOW	0xF493
-#define	REG_BAT_VENDOR			0xF4C4
-#define	FLAG_BAT_VENDOR_SANYO		0x01
-#define	FLAG_BAT_VENDOR_SIMPLO		0x02
-#define	REG_BAT_CELL_COUNT		0xF4C6
-#define	FLAG_BAT_CELL_3S1P		0x03
-#define	FLAG_BAT_CELL_3S2P		0x06
-#define	REG_BAT_CHARGE			0xF4A2
-#define	FLAG_BAT_CHARGE_DISCHARGE	0x01
-#define	FLAG_BAT_CHARGE_CHARGE		0x02
-#define	FLAG_BAT_CHARGE_ACPOWER		0x00
-#define	REG_BAT_STATUS			0xF4B0
-#define	BIT_BAT_STATUS_LOW		(1 << 5)
-#define	BIT_BAT_STATUS_DESTROY		(1 << 2)
-#define	BIT_BAT_STATUS_FULL		(1 << 1)
-#define	BIT_BAT_STATUS_IN		(1 << 0)
-#define	REG_BAT_CHARGE_STATUS		0xF4B1
-#define	BIT_BAT_CHARGE_STATUS_OVERTEMP	(1 << 2)
-#define	BIT_BAT_CHARGE_STATUS_PRECHG	(1 << 1)
-#define	REG_BAT_STATE			0xF482
-#define	BIT_BAT_STATE_CHARGING		(1 << 1)
-#define	BIT_BAT_STATE_DISCHARGING	(1 << 0)
-#define	REG_BAT_POWER			0xF440
-#define	BIT_BAT_POWER_S3		(1 << 2)
-#define	BIT_BAT_POWER_ON		(1 << 1)
-#define	BIT_BAT_POWER_ACIN		(1 << 0)
-
-/* other registers */
-/* Audio: rd/wr */
-#define	REG_AUDIO_VOLUME	0xF46C
-#define	REG_AUDIO_MUTE		0xF4E7
-#define	REG_AUDIO_BEEP		0xF4D0
-/* USB port power or not: rd/wr */
-#define	REG_USB0_FLAG		0xF461
-#define	REG_USB1_FLAG		0xF462
-#define	REG_USB2_FLAG		0xF463
-#define	BIT_USB_FLAG_ON		1
-#define	BIT_USB_FLAG_OFF	0
-/* LID */
-#define	REG_LID_DETECT		0xF4BD
-#define	BIT_LID_DETECT_ON	1
-#define	BIT_LID_DETECT_OFF	0
-/* CRT */
-#define	REG_CRT_DETECT		0xF4AD
-#define	BIT_CRT_DETECT_PLUG	1
-#define	BIT_CRT_DETECT_UNPLUG	0
-/* LCD backlight brightness adjust: 9 levels */
-#define	REG_DISPLAY_BRIGHTNESS	0xF4F5
-/* Black screen Status */
-#define	BIT_DISPLAY_LCD_ON	1
-#define	BIT_DISPLAY_LCD_OFF	0
-/* LCD backlight control: off/restore */
-#define	REG_BACKLIGHT_CTRL	0xF7BD
-#define	BIT_BACKLIGHT_ON	1
-#define	BIT_BACKLIGHT_OFF	0
-/* Reset the machine auto-clear: rd/wr */
-#define	REG_RESET		0xF4EC
-#define	BIT_RESET_ON		1
-/* Light the led: rd/wr */
-#define	REG_LED			0xF4C8
-#define	BIT_LED_RED_POWER	(1 << 0)
-#define	BIT_LED_ORANGE_POWER	(1 << 1)
-#define	BIT_LED_GREEN_CHARGE	(1 << 2)
-#define	BIT_LED_RED_CHARGE	(1 << 3)
-#define	BIT_LED_NUMLOCK		(1 << 4)
-/* Test led mode, all led on/off */
-#define	REG_LED_TEST		0xF4C2
-#define	BIT_LED_TEST_IN		1
-#define	BIT_LED_TEST_OUT	0
-/* Camera on/off */
-#define	REG_CAMERA_STATUS	0xF46A
-#define	BIT_CAMERA_STATUS_ON	1
-#define	BIT_CAMERA_STATUS_OFF	0
-#define	REG_CAMERA_CONTROL	0xF7B7
-#define	BIT_CAMERA_CONTROL_OFF	0
-#define	BIT_CAMERA_CONTROL_ON	1
-/* Wlan Status */
-#define	REG_WLAN		0xF4FA
-#define	BIT_WLAN_ON		1
-#define	BIT_WLAN_OFF		0
-#define	REG_DISPLAY_LCD		0xF79F
-
-/* SCI Event Number from EC */
-enum {
-	EVENT_LID = 0x23,	/*  LID open/close */
-	EVENT_DISPLAY_TOGGLE,	/*  Fn+F3 for display switch */
-	EVENT_SLEEP,		/*  Fn+F1 for entering sleep mode */
-	EVENT_OVERTEMP,		/*  Over-temperature happened */
-	EVENT_CRT_DETECT,	/*  CRT is connected */
-	EVENT_CAMERA,		/*  Camera on/off */
-	EVENT_USB_OC2,		/*  USB2 Over Current occurred */
-	EVENT_USB_OC0,		/*  USB0 Over Current occurred */
-	EVENT_BLACK_SCREEN,	/*  Turn on/off backlight */
-	EVENT_AUDIO_MUTE,	/*  Mute on/off */
-	EVENT_DISPLAY_BRIGHTNESS,/* LCD backlight brightness adjust */
-	EVENT_AC_BAT,		/*  AC & Battery relative issue */
-	EVENT_AUDIO_VOLUME,	/*  Volume adjust */
-	EVENT_WLAN,		/*  Wlan on/off */
-	EVENT_END
-};
-
-#endif /* !_EC_KB3310B_H */
diff --git a/arch/mips/loongson/lemote-2f/pm.c b/arch/mips/loongson/lemote-2f/pm.c
index d7af2e6..a3947aa 100644
--- a/arch/mips/loongson/lemote-2f/pm.c
+++ b/arch/mips/loongson/lemote-2f/pm.c
@@ -23,7 +23,7 @@
 #include <loongson.h>
 
 #include <cs5536/cs5536_mfgpt.h>
-#include "ec_kb3310b.h"
+#include "yeeloong_laptop/ec_kb3310b.h"
 
 #define I8042_KBD_IRQ		1
 #define I8042_CTR_KBDINT	0x01
@@ -100,7 +100,7 @@ int wakeup_loongson(void)
 	if (irq < 0)
 		return 0;
 
-	printk(KERN_INFO "%s: irq = %d\n", __func__, irq);
+	pr_info("%s: irq = %d\n", __func__, irq);
 
 	if (irq == I8042_KBD_IRQ)
 		return 1;
diff --git a/arch/mips/loongson/lemote-2f/reset.c b/arch/mips/loongson/lemote-2f/reset.c
index 51d1a60..d996a55 100644
--- a/arch/mips/loongson/lemote-2f/reset.c
+++ b/arch/mips/loongson/lemote-2f/reset.c
@@ -20,7 +20,7 @@
 #include <loongson.h>
 
 #include <cs5536/cs5536.h>
-#include "ec_kb3310b.h"
+#include "yeeloong_laptop/ec_kb3310b.h"
 
 static void reset_cpu(void)
 {
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
new file mode 100644
index 0000000..d6df9b7
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -0,0 +1,15 @@
+menuconfig LEMOTE_YEELOONG2F
+	bool "Lemote YeeLoong Laptop"
+	depends on LEMOTE_MACH2F
+	default y
+	help
+	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
+	  compatible to FuLoong2F mini PC, but it has an extra Embedded
+	  Controller(kb3310b) for battery, hotkey, backlight, temperature and
+	  fan management.
+
+if LEMOTE_YEELOONG2F
+
+
+
+endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
new file mode 100644
index 0000000..90c4ce5
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -0,0 +1,3 @@
+# YeeLoong Specific
+
+obj-y += ec_kb3310b.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.c
new file mode 100644
index 0000000..cefcc72
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.c
@@ -0,0 +1,126 @@
+/*
+ * Basic KB3310B Embedded Controller support for the YeeLoong 2F netbook
+ *
+ *  Copyright (C) 2008 Lemote Inc.
+ *  Author: liujl <liujl@lemote.com>, 2008-04-20
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+
+#include "ec_kb3310b.h"
+
+static DEFINE_SPINLOCK(index_access_lock);
+static DEFINE_SPINLOCK(port_access_lock);
+
+unsigned char ec_read(unsigned short addr)
+{
+	unsigned char value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&index_access_lock, flags);
+	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
+	outb((addr & 0x00ff), EC_IO_PORT_LOW);
+	value = inb(EC_IO_PORT_DATA);
+	spin_unlock_irqrestore(&index_access_lock, flags);
+
+	return value;
+}
+EXPORT_SYMBOL_GPL(ec_read);
+
+void ec_write(unsigned short addr, unsigned char val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&index_access_lock, flags);
+	outb((addr & 0xff00) >> 8, EC_IO_PORT_HIGH);
+	outb((addr & 0x00ff), EC_IO_PORT_LOW);
+	outb(val, EC_IO_PORT_DATA);
+	/*  flush the write action */
+	inb(EC_IO_PORT_DATA);
+	spin_unlock_irqrestore(&index_access_lock, flags);
+
+	return;
+}
+EXPORT_SYMBOL_GPL(ec_write);
+
+/*
+ * This function is used for EC command writes and corresponding status queries.
+ */
+int ec_query_seq(unsigned char cmd)
+{
+	int timeout;
+	unsigned char status;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&port_access_lock, flags);
+
+	/* make chip goto reset mode */
+	udelay(EC_REG_DELAY);
+	outb(cmd, EC_CMD_PORT);
+	udelay(EC_REG_DELAY);
+
+	/* check if the command is received by ec */
+	timeout = EC_CMD_TIMEOUT;
+	status = inb(EC_STS_PORT);
+	while (timeout-- && (status & (1 << 1))) {
+		status = inb(EC_STS_PORT);
+		udelay(EC_REG_DELAY);
+	}
+
+	if (timeout <= 0) {
+		pr_err("%s: deadable error : timeout...\n", __func__);
+		ret = -EINVAL;
+	}
+
+	spin_unlock_irqrestore(&port_access_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ec_query_seq);
+
+/*
+ * Send query command to EC to get the proper event number
+ */
+int ec_query_event_num(void)
+{
+	return ec_query_seq(CMD_GET_EVENT_NUM);
+}
+EXPORT_SYMBOL(ec_query_event_num);
+
+/*
+ * Get event number from EC
+ *
+ * NOTE: This routine must follow the query_event_num function in the
+ * interrupt.
+ */
+int ec_get_event_num(void)
+{
+	int timeout = 100;
+	unsigned char value;
+	unsigned char status;
+
+	udelay(EC_REG_DELAY);
+	status = inb(EC_STS_PORT);
+	udelay(EC_REG_DELAY);
+	while (timeout-- && !(status & (1 << 0))) {
+		status = inb(EC_STS_PORT);
+		udelay(EC_REG_DELAY);
+	}
+	if (timeout <= 0) {
+		pr_err("%s: get event number timeout.\n", __func__);
+		return -EINVAL;
+	}
+	value = inb(EC_DAT_PORT);
+	udelay(EC_REG_DELAY);
+
+	return value;
+}
+EXPORT_SYMBOL(ec_get_event_num);
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
new file mode 100644
index 0000000..762d888
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
@@ -0,0 +1,187 @@
+/*
+ * KB3310B Embedded Controller
+ *
+ *  Copyright (C) 2008 Lemote Inc.
+ *  Author: liujl <liujl@lemote.com>, 2008-03-14
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _EC_KB3310B_H
+#define _EC_KB3310B_H
+
+extern unsigned char ec_read(unsigned short addr);
+extern void ec_write(unsigned short addr, unsigned char val);
+extern int ec_query_seq(unsigned char cmd);
+extern int ec_query_event_num(void);
+extern int ec_get_event_num(void);
+
+typedef int (*sci_handler) (int status);
+extern sci_handler yeeloong_report_lid_status;
+
+#define SCI_IRQ_NUM 0x0A
+
+/*
+ * The following registers are determined by the EC index configuration.
+ * 1, fill the PORT_HIGH as EC register high part.
+ * 2, fill the PORT_LOW as EC register low part.
+ * 3, fill the PORT_DATA as EC register write data or get the data from it.
+ */
+#define	EC_IO_PORT_HIGH	0x0381
+#define	EC_IO_PORT_LOW	0x0382
+#define	EC_IO_PORT_DATA	0x0383
+
+/*
+ * EC delay time is 500us for register and status access
+ */
+#define	EC_REG_DELAY	500	/* unit : us */
+#define	EC_CMD_TIMEOUT	0x1000
+
+/*
+ * EC access port for SCI communication
+ */
+#define	EC_CMD_PORT		0x66
+#define	EC_STS_PORT		0x66
+#define	EC_DAT_PORT		0x62
+#define	CMD_INIT_IDLE_MODE	0xdd
+#define	CMD_EXIT_IDLE_MODE	0xdf
+#define	CMD_INIT_RESET_MODE	0xd8
+#define	CMD_REBOOT_SYSTEM	0x8c
+#define	CMD_GET_EVENT_NUM	0x84
+#define	CMD_PROGRAM_PIECE	0xda
+
+/* Temperature & Fan registers */
+#define	REG_TEMPERATURE_VALUE	0xF458
+#define	REG_FAN_AUTO_MAN_SWITCH 0xF459
+#define	BIT_FAN_AUTO		0
+#define	BIT_FAN_MANUAL		1
+#define	REG_FAN_CONTROL		0xF4D2
+#define	BIT_FAN_CONTROL_ON	(1 << 0)
+#define	BIT_FAN_CONTROL_OFF	(0 << 0)
+#define	REG_FAN_STATUS		0xF4DA
+#define	BIT_FAN_STATUS_ON	(1 << 0)
+#define	BIT_FAN_STATUS_OFF	(0 << 0)
+#define	REG_FAN_SPEED_HIGH	0xFE22
+#define	REG_FAN_SPEED_LOW	0xFE23
+#define	REG_FAN_SPEED_LEVEL	0xF4CC
+/* Fan speed divider */
+#define	FAN_SPEED_DIVIDER	480000	/* (60*1000*1000/62.5/2)*/
+
+/* Battery registers */
+#define	REG_BAT_DESIGN_CAP_HIGH		0xF77D
+#define	REG_BAT_DESIGN_CAP_LOW		0xF77E
+#define	REG_BAT_FULLCHG_CAP_HIGH	0xF780
+#define	REG_BAT_FULLCHG_CAP_LOW		0xF781
+#define	REG_BAT_DESIGN_VOL_HIGH		0xF782
+#define	REG_BAT_DESIGN_VOL_LOW		0xF783
+#define	REG_BAT_CURRENT_HIGH		0xF784
+#define	REG_BAT_CURRENT_LOW		0xF785
+#define	REG_BAT_VOLTAGE_HIGH		0xF786
+#define	REG_BAT_VOLTAGE_LOW		0xF787
+#define	REG_BAT_TEMPERATURE_HIGH	0xF788
+#define	REG_BAT_TEMPERATURE_LOW		0xF789
+#define	REG_BAT_RELATIVE_CAP_HIGH	0xF492
+#define	REG_BAT_RELATIVE_CAP_LOW	0xF493
+#define	REG_BAT_VENDOR			0xF4C4
+#define	FLAG_BAT_VENDOR_SANYO		0x01
+#define	FLAG_BAT_VENDOR_SIMPLO		0x02
+#define	REG_BAT_CELL_COUNT		0xF4C6
+#define	FLAG_BAT_CELL_3S1P		0x03
+#define	FLAG_BAT_CELL_3S2P		0x06
+#define	REG_BAT_CHARGE			0xF4A2
+#define	FLAG_BAT_CHARGE_DISCHARGE	0x01
+#define	FLAG_BAT_CHARGE_CHARGE		0x02
+#define	FLAG_BAT_CHARGE_ACPOWER		0x00
+#define	REG_BAT_STATUS			0xF4B0
+#define	BIT_BAT_STATUS_LOW		(1 << 5)
+#define	BIT_BAT_STATUS_DESTROY		(1 << 2)
+#define	BIT_BAT_STATUS_FULL		(1 << 1)
+#define	BIT_BAT_STATUS_IN		(1 << 0)
+#define	REG_BAT_CHARGE_STATUS		0xF4B1
+#define	BIT_BAT_CHARGE_STATUS_OVERTEMP	(1 << 2)
+#define	BIT_BAT_CHARGE_STATUS_PRECHG	(1 << 1)
+#define	REG_BAT_STATE			0xF482
+#define	BIT_BAT_STATE_CHARGING		(1 << 1)
+#define	BIT_BAT_STATE_DISCHARGING	(1 << 0)
+#define	REG_BAT_POWER			0xF440
+#define	BIT_BAT_POWER_S3		(1 << 2)
+#define	BIT_BAT_POWER_ON		(1 << 1)
+#define	BIT_BAT_POWER_ACIN		(1 << 0)
+
+/* Audio: rd/wr */
+#define	REG_AUDIO_VOLUME	0xF46C
+#define	REG_AUDIO_MUTE		0xF4E7
+#define	REG_AUDIO_BEEP		0xF4D0
+/* USB port power or not: rd/wr */
+#define	REG_USB0_FLAG		0xF461
+#define	REG_USB1_FLAG		0xF462
+#define	REG_USB2_FLAG		0xF463
+#define	BIT_USB_FLAG_ON		1
+#define	BIT_USB_FLAG_OFF	0
+/* LID */
+#define	REG_LID_DETECT		0xF4BD
+#define	BIT_LID_DETECT_ON	1
+#define	BIT_LID_DETECT_OFF	0
+/* CRT */
+#define	REG_CRT_DETECT		0xF4AD
+#define	BIT_CRT_DETECT_PLUG	1
+#define	BIT_CRT_DETECT_UNPLUG	0
+/* LCD backlight brightness adjust: 9 levels */
+#define	REG_DISPLAY_BRIGHTNESS	0xF4F5
+/* Black screen Status */
+#define	BIT_DISPLAY_LCD_ON	1
+#define	BIT_DISPLAY_LCD_OFF	0
+/* LCD backlight control: off/restore */
+#define	REG_BACKLIGHT_CTRL	0xF7BD
+#define	BIT_BACKLIGHT_ON	1
+#define	BIT_BACKLIGHT_OFF	0
+/* Reset the machine auto-clear: rd/wr */
+#define	REG_RESET		0xF4EC
+#define	BIT_RESET_ON		1
+/* Light the led: rd/wr */
+#define	REG_LED			0xF4C8
+#define	BIT_LED_RED_POWER	(1 << 0)
+#define	BIT_LED_ORANGE_POWER	(1 << 1)
+#define	BIT_LED_GREEN_CHARGE	(1 << 2)
+#define	BIT_LED_RED_CHARGE	(1 << 3)
+#define	BIT_LED_NUMLOCK		(1 << 4)
+/* Test led mode, all led on/off */
+#define	REG_LED_TEST		0xF4C2
+#define	BIT_LED_TEST_IN		1
+#define	BIT_LED_TEST_OUT	0
+/* Camera on/off */
+#define	REG_CAMERA_STATUS	0xF46A
+#define	BIT_CAMERA_STATUS_ON	1
+#define	BIT_CAMERA_STATUS_OFF	0
+#define	REG_CAMERA_CONTROL	0xF7B7
+#define	BIT_CAMERA_CONTROL_OFF	0
+#define	BIT_CAMERA_CONTROL_ON	1
+/* Wlan Status */
+#define	REG_WLAN		0xF4FA
+#define	BIT_WLAN_ON		1
+#define	BIT_WLAN_OFF		0
+#define	REG_DISPLAY_LCD		0xF79F
+
+/* SCI Event Number from EC */
+enum {
+	EVENT_LID = 0x23,	/*  Turn on/off LID */
+	EVENT_DISPLAY_TOGGLE,	/*  Fn+F3 for display switch */
+	EVENT_SLEEP,		/*  Fn+F1 for entering sleep mode */
+	EVENT_OVERTEMP,		/*  Over-temperature happened */
+	EVENT_CRT_DETECT,	/*  CRT is connected */
+	EVENT_CAMERA,		/*  Camera on/off */
+	EVENT_USB_OC2,		/*  USB2 Over Current occurred */
+	EVENT_USB_OC0,		/*  USB0 Over Current occurred */
+	EVENT_BLACK_SCREEN,	/*  Turn on/off backlight */
+	EVENT_AUDIO_MUTE,	/*  Mute on/off */
+	EVENT_DISPLAY_BRIGHTNESS,/* LCD backlight brightness adjust */
+	EVENT_AC_BAT,		/*  AC & Battery relative issue */
+	EVENT_AUDIO_VOLUME,	/*  Volume adjust */
+	EVENT_WLAN,		/*  Wlan on/off */
+	EVENT_END
+};
+
+#endif /* !_EC_KB3310B_H */
-- 
1.6.2.1
