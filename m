Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 04:26:52 +0100 (CET)
Received: from forward100p.mail.yandex.net ([77.88.28.100]:38648 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLZD017NIqo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 04:26:27 +0100
Received: from mxback3g.mail.yandex.net (mxback3g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:164])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 70284510346E;
        Tue, 26 Dec 2017 06:26:21 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback3g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id srRL7o5wjy-QJb88Wm4;
        Tue, 26 Dec 2017 06:26:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514258781;
        bh=yfGXoBG4XqhCP1wMwAPnoiZYDgxJ+V+C8LtCjkvCRGQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=kKQjxt9N7t7DMqzmb9NNvXMJmggif76lOZ2l/5kOGHKbalswb89sC31ItFpTN9ijH
         yW4o34Cuhzso1TwYxlzkig5rqwUnlsle+8WNF/YMf3t06KZh8l7ncaiKengiZgscxP
         3qeHMe76suIpA7bWG2JKynscP3VqBDfNLy9dT98w=
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id NFRULz4HAX-QFx0BArm;
        Tue, 26 Dec 2017 06:26:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514258778;
        bh=yfGXoBG4XqhCP1wMwAPnoiZYDgxJ+V+C8LtCjkvCRGQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=DuAInX+4gEJt05TQR2St841CwC0DPtW1Ku4Mfgq75gk7g5iXKmYYR6M8jvLRraUyy
         TnK1LwZHwFKarmRYBpA7XbJ/YVp/lTeTK0i75fXZ7nz8qKHC+672rYYtNrv6ypYM5J
         aGDETZ3rZ5Ik5mQjAltDMhLU0cXVabwZ4ZR8s+j0=
Authentication-Results: smtp4j.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v6 1/4] MIPS: Loongson64: lemote-2f move ec_kb3310b.h to include dir and clean up
Date:   Tue, 26 Dec 2017 11:25:59 +0800
Message-Id: <20171226032602.11417-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171226032602.11417-1-jiaxun.yang@flygoat.com>
References: <20171226032602.11417-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

To operate EC from platform driver, this head file need able to be include
from anywhere. This patch just move ec_kb3310b.h to include dir and
clean up ec_kb3310b.h.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-loongson64/ec_kb3310b.h | 170 +++++++++++++++++++
 arch/mips/loongson64/lemote-2f/ec_kb3310b.c        |   2 +-
 arch/mips/loongson64/lemote-2f/ec_kb3310b.h        | 188 ---------------------
 arch/mips/loongson64/lemote-2f/pm.c                |   4 +-
 arch/mips/loongson64/lemote-2f/reset.c             |   4 +-
 5 files changed, 175 insertions(+), 193 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
 delete mode 100644 arch/mips/loongson64/lemote-2f/ec_kb3310b.h

diff --git a/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h b/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
new file mode 100644
index 000000000000..2e8690532ea5
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson64/ec_kb3310b.h
@@ -0,0 +1,170 @@
+/*
+ * KB3310B Embedded Controller
+ *
+ *  Copyright (C) 2008 Lemote Inc.
+ *  Author: liujl <liujl@lemote.com>, 2008-03-14
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzhangjin@gmail.com>
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
+#define ON	1
+#define OFF	0
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
+#define	REG_FAN_STATUS		0xF4DA
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
+/* LID */
+#define	REG_LID_DETECT		0xF4BD
+/* CRT */
+#define	REG_CRT_DETECT		0xF4AD
+/* LCD backlight brightness adjust: 9 levels */
+#define	REG_DISPLAY_BRIGHTNESS	0xF4F5
+/* LCD backlight control: off/restore */
+#define	REG_BACKLIGHT_CTRL	0xF7BD
+/* Reset the machine auto-clear: rd/wr */
+#define	REG_RESET		0xF4EC
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
+#define	REG_CAMERA_CONTROL	0xF7B7
+/* Wlan Status */
+#define	REG_WLAN		0xF4FA
+#define	REG_DISPLAY_LCD		0xF79F
+
+/* SCI Event Number from EC */
+enum {
+	EVENT_LID = 0x23,	/*  Turn on/off LID */
+	EVENT_SWITCHVIDEOMODE,	/*  Fn+F3 for display switch */
+	EVENT_SLEEP,		/*  Fn+F1 for entering sleep mode */
+	EVENT_OVERTEMP,		/*  Over-temperature happened */
+	EVENT_CRT_DETECT,	/*  CRT is connected */
+	EVENT_CAMERA,		/*  Camera on/off */
+	EVENT_USB_OC2,		/*  USB2 Over Current occurred */
+	EVENT_USB_OC0,		/*  USB0 Over Current occurred */
+	EVENT_DISPLAYTOGGLE,	/*  Fn+F2, Turn on/off backlight */
+	EVENT_AUDIO_MUTE,	/*  Fn+F4, Mute on/off */
+	EVENT_DISPLAY_BRIGHTNESS,/* Fn+^/V, LCD backlight brightness adjust */
+	EVENT_AC_BAT,		/*  AC & Battery relative issue */
+	EVENT_AUDIO_VOLUME,	/*  Fn+<|>, Volume adjust */
+	EVENT_WLAN,		/*  Wlan on/off */
+};
+
+#define EVENT_START	EVENT_LID
+#define EVENT_END	EVENT_WLAN
+
+#endif /* !_EC_KB3310B_H */
diff --git a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
index 321822997e76..6e416d55b42a 100644
--- a/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
+++ b/arch/mips/loongson64/lemote-2f/ec_kb3310b.c
@@ -15,7 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 
-#include "ec_kb3310b.h"
+#include <ec_kb3310b.h>
 
 static DEFINE_SPINLOCK(index_access_lock);
 static DEFINE_SPINLOCK(port_access_lock);
diff --git a/arch/mips/loongson64/lemote-2f/ec_kb3310b.h b/arch/mips/loongson64/lemote-2f/ec_kb3310b.h
deleted file mode 100644
index 5a3f1860d4d2..000000000000
--- a/arch/mips/loongson64/lemote-2f/ec_kb3310b.h
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
-#define EC_IO_PORT_HIGH 0x0381
-#define EC_IO_PORT_LOW	0x0382
-#define EC_IO_PORT_DATA 0x0383
-
-/*
- * EC delay time is 500us for register and status access
- */
-#define EC_REG_DELAY	500	/* unit : us */
-#define EC_CMD_TIMEOUT	0x1000
-
-/*
- * EC access port for SCI communication
- */
-#define EC_CMD_PORT		0x66
-#define EC_STS_PORT		0x66
-#define EC_DAT_PORT		0x62
-#define CMD_INIT_IDLE_MODE	0xdd
-#define CMD_EXIT_IDLE_MODE	0xdf
-#define CMD_INIT_RESET_MODE	0xd8
-#define CMD_REBOOT_SYSTEM	0x8c
-#define CMD_GET_EVENT_NUM	0x84
-#define CMD_PROGRAM_PIECE	0xda
-
-/* temperature & fan registers */
-#define REG_TEMPERATURE_VALUE	0xF458
-#define REG_FAN_AUTO_MAN_SWITCH 0xF459
-#define BIT_FAN_AUTO		0
-#define BIT_FAN_MANUAL		1
-#define REG_FAN_CONTROL		0xF4D2
-#define BIT_FAN_CONTROL_ON	(1 << 0)
-#define BIT_FAN_CONTROL_OFF	(0 << 0)
-#define REG_FAN_STATUS		0xF4DA
-#define BIT_FAN_STATUS_ON	(1 << 0)
-#define BIT_FAN_STATUS_OFF	(0 << 0)
-#define REG_FAN_SPEED_HIGH	0xFE22
-#define REG_FAN_SPEED_LOW	0xFE23
-#define REG_FAN_SPEED_LEVEL	0xF4CC
-/* fan speed divider */
-#define FAN_SPEED_DIVIDER	480000	/* (60*1000*1000/62.5/2)*/
-
-/* battery registers */
-#define REG_BAT_DESIGN_CAP_HIGH		0xF77D
-#define REG_BAT_DESIGN_CAP_LOW		0xF77E
-#define REG_BAT_FULLCHG_CAP_HIGH	0xF780
-#define REG_BAT_FULLCHG_CAP_LOW		0xF781
-#define REG_BAT_DESIGN_VOL_HIGH		0xF782
-#define REG_BAT_DESIGN_VOL_LOW		0xF783
-#define REG_BAT_CURRENT_HIGH		0xF784
-#define REG_BAT_CURRENT_LOW		0xF785
-#define REG_BAT_VOLTAGE_HIGH		0xF786
-#define REG_BAT_VOLTAGE_LOW		0xF787
-#define REG_BAT_TEMPERATURE_HIGH	0xF788
-#define REG_BAT_TEMPERATURE_LOW		0xF789
-#define REG_BAT_RELATIVE_CAP_HIGH	0xF492
-#define REG_BAT_RELATIVE_CAP_LOW	0xF493
-#define REG_BAT_VENDOR			0xF4C4
-#define FLAG_BAT_VENDOR_SANYO		0x01
-#define FLAG_BAT_VENDOR_SIMPLO		0x02
-#define REG_BAT_CELL_COUNT		0xF4C6
-#define FLAG_BAT_CELL_3S1P		0x03
-#define FLAG_BAT_CELL_3S2P		0x06
-#define REG_BAT_CHARGE			0xF4A2
-#define FLAG_BAT_CHARGE_DISCHARGE	0x01
-#define FLAG_BAT_CHARGE_CHARGE		0x02
-#define FLAG_BAT_CHARGE_ACPOWER		0x00
-#define REG_BAT_STATUS			0xF4B0
-#define BIT_BAT_STATUS_LOW		(1 << 5)
-#define BIT_BAT_STATUS_DESTROY		(1 << 2)
-#define BIT_BAT_STATUS_FULL		(1 << 1)
-#define BIT_BAT_STATUS_IN		(1 << 0)
-#define REG_BAT_CHARGE_STATUS		0xF4B1
-#define BIT_BAT_CHARGE_STATUS_OVERTEMP	(1 << 2)
-#define BIT_BAT_CHARGE_STATUS_PRECHG	(1 << 1)
-#define REG_BAT_STATE			0xF482
-#define BIT_BAT_STATE_CHARGING		(1 << 1)
-#define BIT_BAT_STATE_DISCHARGING	(1 << 0)
-#define REG_BAT_POWER			0xF440
-#define BIT_BAT_POWER_S3		(1 << 2)
-#define BIT_BAT_POWER_ON		(1 << 1)
-#define BIT_BAT_POWER_ACIN		(1 << 0)
-
-/* other registers */
-/* Audio: rd/wr */
-#define REG_AUDIO_VOLUME	0xF46C
-#define REG_AUDIO_MUTE		0xF4E7
-#define REG_AUDIO_BEEP		0xF4D0
-/* USB port power or not: rd/wr */
-#define REG_USB0_FLAG		0xF461
-#define REG_USB1_FLAG		0xF462
-#define REG_USB2_FLAG		0xF463
-#define BIT_USB_FLAG_ON		1
-#define BIT_USB_FLAG_OFF	0
-/* LID */
-#define REG_LID_DETECT		0xF4BD
-#define BIT_LID_DETECT_ON	1
-#define BIT_LID_DETECT_OFF	0
-/* CRT */
-#define REG_CRT_DETECT		0xF4AD
-#define BIT_CRT_DETECT_PLUG	1
-#define BIT_CRT_DETECT_UNPLUG	0
-/* LCD backlight brightness adjust: 9 levels */
-#define REG_DISPLAY_BRIGHTNESS	0xF4F5
-/* Black screen Status */
-#define BIT_DISPLAY_LCD_ON	1
-#define BIT_DISPLAY_LCD_OFF	0
-/* LCD backlight control: off/restore */
-#define REG_BACKLIGHT_CTRL	0xF7BD
-#define BIT_BACKLIGHT_ON	1
-#define BIT_BACKLIGHT_OFF	0
-/* Reset the machine auto-clear: rd/wr */
-#define REG_RESET		0xF4EC
-#define BIT_RESET_ON		1
-/* Light the led: rd/wr */
-#define REG_LED			0xF4C8
-#define BIT_LED_RED_POWER	(1 << 0)
-#define BIT_LED_ORANGE_POWER	(1 << 1)
-#define BIT_LED_GREEN_CHARGE	(1 << 2)
-#define BIT_LED_RED_CHARGE	(1 << 3)
-#define BIT_LED_NUMLOCK		(1 << 4)
-/* Test led mode, all led on/off */
-#define REG_LED_TEST		0xF4C2
-#define BIT_LED_TEST_IN		1
-#define BIT_LED_TEST_OUT	0
-/* Camera on/off */
-#define REG_CAMERA_STATUS	0xF46A
-#define BIT_CAMERA_STATUS_ON	1
-#define BIT_CAMERA_STATUS_OFF	0
-#define REG_CAMERA_CONTROL	0xF7B7
-#define BIT_CAMERA_CONTROL_OFF	0
-#define BIT_CAMERA_CONTROL_ON	1
-/* Wlan Status */
-#define REG_WLAN		0xF4FA
-#define BIT_WLAN_ON		1
-#define BIT_WLAN_OFF		0
-#define REG_DISPLAY_LCD		0xF79F
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
diff --git a/arch/mips/loongson64/lemote-2f/pm.c b/arch/mips/loongson64/lemote-2f/pm.c
index 6859e934862d..0768739155f6 100644
--- a/arch/mips/loongson64/lemote-2f/pm.c
+++ b/arch/mips/loongson64/lemote-2f/pm.c
@@ -88,7 +88,7 @@ EXPORT_SYMBOL(yeeloong_report_lid_status);
 static void yeeloong_lid_update_task(struct work_struct *work)
 {
 	if (yeeloong_report_lid_status)
-		yeeloong_report_lid_status(BIT_LID_DETECT_ON);
+		yeeloong_report_lid_status(ON);
 }
 
 int wakeup_loongson(void)
@@ -118,7 +118,7 @@ int wakeup_loongson(void)
 			/* check the LID status */
 			lid_status = ec_read(REG_LID_DETECT);
 			/* wakeup cpu when people open the LID */
-			if (lid_status == BIT_LID_DETECT_ON) {
+			if (lid_status == ON) {
 				/* If we call it directly here, the WARNING
 				 * will be sent out by getnstimeofday
 				 * via "WARN_ON(timekeeping_suspended);"
diff --git a/arch/mips/loongson64/lemote-2f/reset.c b/arch/mips/loongson64/lemote-2f/reset.c
index a26ca7fcd7e0..2b72b197c51d 100644
--- a/arch/mips/loongson64/lemote-2f/reset.c
+++ b/arch/mips/loongson64/lemote-2f/reset.c
@@ -20,7 +20,7 @@
 #include <loongson.h>
 
 #include <cs5536/cs5536.h>
-#include "ec_kb3310b.h"
+#include <ec_kb3310b.h>
 
 static void reset_cpu(void)
 {
@@ -81,7 +81,7 @@ static void ml2f_reboot(void)
 	reset_cpu();
 
 	/* sending an reset signal to EC(embedded controller) */
-	ec_write(REG_RESET, BIT_RESET_ON);
+	ec_write(REG_RESET, ON);
 }
 
 #define yl2f89_reboot ml2f_reboot
-- 
2.15.1
