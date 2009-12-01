Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:13:07 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:34200 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492304AbZLALNC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 12:13:02 +0100
Received: by pzk35 with SMTP id 35so3581400pzk.22
        for <multiple recipients>; Tue, 01 Dec 2009 03:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=CNygnBg/vNfpIwP6PHdJh7MqN7lDfROzo31qBzOrgOw=;
        b=BeJRRhfiGyXY8K2fP/2ihWSf8Wa3npVGIDQN3zWH0B/4YY7TN/050vn3G3EdnahBlu
         oL+wwVieMLSKugRpWNL2gf94JRk2I35w5gJgmzEZFBuoHJ1OCMZ7UPoVML1t7FvScZJO
         dIDUWUIH/VA4RSzEPiMRcpqwjRek6rwoJBWD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V4FMpFygTkyF2XB/IAS8ee60N4URwM3Wm7b0D6Ep0VNlsh92SPpJUh+BnoNZ1Crg45
         tq+1Ad6cUPnQOco9dRY8BBBa74ukHi3AQcx5t+CXTYh3iB5BC8NBiY76XmuxYI5SIA8T
         1cp0Uhbm2wsGCY3ja16wjvbny5uCnXy0Bt1mc=
Received: by 10.115.112.40 with SMTP id p40mr10437324wam.182.1259665974026;
        Tue, 01 Dec 2009 03:12:54 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm477173pxi.3.2009.12.01.03.12.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 03:12:53 -0800 (PST)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6 8/8] Loongson: YeeLoong: add hotkey driver
Date:   Tue,  1 Dec 2009 19:12:37 +0800
Message-Id: <939c1425f653e3bda05799345c53198dfd2c1dcc.1259664573.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259660040.git.wuzhangjin@gmail.com>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1259664573.git.wuzhangjin@gmail.com>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds Hotkey Driver, which will do relative actions for The
hotkey event and report the corresponding input keys to the user-space
applications.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/setup.c                           |    1 +
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 +
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
 .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    4 +-
 .../loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c |  448 ++++++++++++++++++++
 5 files changed, 462 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bd55f71..b1e1272 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -60,6 +60,7 @@ struct boot_mem_map boot_mem_map;
 
 static char command_line[COMMAND_LINE_SIZE];
        char arcs_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+EXPORT_SYMBOL(arcs_cmdline);
 
 /*
  * mips_io_port_base is the begin of the address space to which x86 style
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index f1211b4..7a8084e 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -53,4 +53,13 @@ config YEELOONG_SUSPEND
 	  This option adds Suspend Driver, which will suspend the YeeLoong
 	  Platform specific devices.
 
+config YEELOONG_HOTKEY
+	tristate "Hotkey Driver"
+	depends on YEELOONG_VO && INPUT
+	default y
+	help
+	  This option adds Hotkey Driver, which will do relative actions for
+	  The hotkey event and report the corresponding input keys to the
+	  user-space applications.
+
 endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
index 29f8050..31bfda6 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_YEELOONG_BATTERY) += yl_battery.o
 obj-$(CONFIG_YEELOONG_HWMON) += yl_hwmon.o
 obj-$(CONFIG_YEELOONG_VO) += yl_vo.o
 obj-$(CONFIG_YEELOONG_SUSPEND) += yl_suspend.o
+obj-$(CONFIG_YEELOONG_HOTKEY) += yl_hotkey.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
index 9d06ad8..021ce11 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
@@ -185,7 +185,9 @@ enum {
 	EVENT_AC_BAT,		/*  AC & Battery relative issue */
 	EVENT_AUDIO_VOLUME,	/*  Volume adjust */
 	EVENT_WLAN,		/*  Wlan on/off */
-	EVENT_END
 };
 
+#define EVENT_START	EVENT_LID
+#define EVENT_END	EVENT_WLAN
+
 #endif /* !_EC_KB3310B_H */
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c
new file mode 100644
index 0000000..7a178b9
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hotkey.c
@@ -0,0 +1,448 @@
+/*
+ * YeeLoong Hotkey Driver
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *          Liu Junliang <liujl@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+
+#include <asm/bootinfo.h>	/* for arcs_cmdline */
+
+#include <cs5536/cs5536.h>
+#include "ec_kb3310b.h"
+
+MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>; Liu Junliang <liujl@lemote.com>");
+MODULE_DESCRIPTION("YeeLoong laptop hotkey driver");
+MODULE_LICENSE("GPL");
+
+static struct input_dev *yeeloong_hotkey_dev;
+static int event, status;
+
+struct key_entry {
+	char type;		/* See KE_* below */
+	int event;		/* event from SCI */
+	u16 keycode;		/* KEY_* or SW_* */
+};
+
+enum { KE_KEY, KE_SW, KE_END };
+
+#define EVENT_UNKNOWN	0
+
+static struct key_entry yeeloong_keymap[] = {
+	{KE_SW, EVENT_LID, SW_LID},
+	{KE_KEY, EVENT_CAMERA, KEY_CAMERA},	/* Fn + ESC */
+	{KE_KEY, EVENT_SLEEP, KEY_SLEEP},	/* Fn + F1 */
+	{KE_KEY, EVENT_DISPLAY_TOGGLE, KEY_SWITCHVIDEOMODE},	/* Fn + F3 */
+	{KE_KEY, EVENT_AUDIO_MUTE, KEY_MUTE},	/* Fn + F4 */
+	{KE_KEY, EVENT_WLAN, KEY_WLAN},	/* Fn + F5 */
+	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSUP},	/* Fn + up */
+	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSDOWN},	/* Fn + down */
+	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEUP},	/* Fn + right */
+	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEDOWN},	/* Fn + left */
+	{KE_END, EVENT_UNKNOWN, KEY_UNKNOWN}
+};
+
+static int get_event_keycode(void)
+{
+	struct key_entry *key;
+
+	for (key = yeeloong_keymap; key->type != KE_END; key++) {
+		if (key->event != event)
+			continue;
+		else {
+			if (EVENT_DISPLAY_BRIGHTNESS == event) {
+				static int old_brightness_status = -1;
+				/* current status > old one, means up */
+				if ((status < old_brightness_status)
+				    || (0 == status))
+					key++;
+				old_brightness_status = status;
+			} else if (EVENT_AUDIO_VOLUME == event) {
+				static int old_volume_status = -1;
+				if ((status < old_volume_status)
+				    || (0 == status))
+					key++;
+				old_volume_status = status;
+			}
+			break;
+		}
+	}
+	return key->keycode;
+}
+
+static int report_lid_switch(int status)
+{
+	input_report_switch(yeeloong_hotkey_dev, SW_LID, !status);
+	input_sync(yeeloong_hotkey_dev);
+
+	return status;
+}
+
+void report_key(int keycode)
+{
+	if (keycode == SW_LID)
+		report_lid_switch(status);
+	else {
+		input_report_key(yeeloong_hotkey_dev, keycode, 1);
+		input_sync(yeeloong_hotkey_dev);
+		input_report_key(yeeloong_hotkey_dev, keycode, 0);
+		input_sync(yeeloong_hotkey_dev);
+	}
+}
+
+static int crt_detect_handler(int status)
+{
+	if (status == BIT_CRT_DETECT_PLUG) {
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	} else {
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+	}
+	return status;
+}
+
+#define EC_VER_LEN 64
+
+static int black_screen_handler(int status)
+{
+	char *p, ec_ver[EC_VER_LEN];
+
+	p = strstr(arcs_cmdline, "EC_VER=");
+	if (!p)
+		memset(ec_ver, 0, EC_VER_LEN);
+	else {
+		strncpy(ec_ver, p, EC_VER_LEN);
+		p = strstr(ec_ver, " ");
+		if (p)
+			*p = '\0';
+	}
+
+	/* Seems EC(>=PQ1D26) does this job for us, we can not do it again,
+	 * otherwise, the brightness will not resume to the normal level! */
+	if (strncasecmp(ec_ver, "EC_VER=PQ1D26", 64) < 0)
+		yeeloong_lcd_vo_set(status);
+
+	return status;
+}
+
+static int display_toggle_handler(int status)
+{
+	static int video_output_status;
+
+	/* Only enable switch video output button
+	 * when CRT is connected */
+	if (ec_read(REG_CRT_DETECT) == BIT_CRT_DETECT_UNPLUG)
+		return 0;
+	/* 0. no CRT connected: LCD on, CRT off
+	 * 1. BOTH on
+	 * 2. LCD off, CRT on
+	 * 3. BOTH off
+	 * 4. LCD on, CRT off
+	 */
+	video_output_status++;
+	if (video_output_status > 4)
+		video_output_status = 1;
+
+	switch (video_output_status) {
+	case 1:
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+		break;
+	case 2:
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_PLUG);
+		break;
+	case 3:
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+		break;
+	case 4:
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		yeeloong_crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+		break;
+	default:
+		/* Ensure LCD is on */
+		yeeloong_lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		break;
+	}
+	return video_output_status;
+}
+
+static int camera_handler(int status)
+{
+	int value;
+
+	value = ec_read(REG_CAMERA_CONTROL);
+	ec_write(REG_CAMERA_CONTROL, value | (1 << 1));
+
+	return status;
+}
+
+static int usb2_handler(int status)
+{
+	pr_emerg("USB2 Over Current occurred\n");
+
+	return status;
+}
+
+static int usb0_handler(int status)
+{
+	pr_emerg("USB0 Over Current occurred\n");
+
+	return status;
+}
+
+/* yeeloong_wifi_handler may be implemented in the wifi driver */
+sci_handler yeeloong_wifi_handler;
+EXPORT_SYMBOL(yeeloong_wifi_handler);
+
+#define NO_REG		0
+#define NO_HANDLER	NULL
+/* 2 maybe used to indicate the key as a switch button, such as EVENT_WLAN */
+#define NO_STATUS	2
+
+static void do_event_action(void)
+{
+	sci_handler handler;
+	int reg, keycode;
+
+	reg = NO_REG;
+	handler = NO_HANDLER;
+	status = NO_STATUS;
+
+	switch (event) {
+	case EVENT_LID:
+		reg = REG_LID_DETECT;
+		break;
+	case EVENT_DISPLAY_TOGGLE:
+		handler = display_toggle_handler;
+		break;
+	case EVENT_CRT_DETECT:
+		reg = REG_CRT_DETECT;
+		handler = crt_detect_handler;
+		break;
+	case EVENT_CAMERA:
+		reg = REG_CAMERA_STATUS;
+		handler = camera_handler;
+		break;
+	case EVENT_USB_OC2:
+		reg = REG_USB2_FLAG;
+		handler = usb2_handler;
+		break;
+	case EVENT_USB_OC0:
+		reg = REG_USB0_FLAG;
+		handler = usb0_handler;
+		break;
+	case EVENT_BLACK_SCREEN:
+		reg = REG_DISPLAY_LCD;
+		handler = black_screen_handler;
+		break;
+	case EVENT_AUDIO_MUTE:
+		reg = REG_AUDIO_MUTE;
+		break;
+	case EVENT_DISPLAY_BRIGHTNESS:
+		reg = REG_DISPLAY_BRIGHTNESS;
+		break;
+	case EVENT_AUDIO_VOLUME:
+		reg = REG_AUDIO_VOLUME;
+		break;
+	case EVENT_WLAN:
+		handler = yeeloong_wifi_handler;
+		break;
+	default:
+		break;
+	}
+
+	if (reg != NO_REG)
+		status = ec_read(reg);
+
+	if (handler != NO_HANDLER)
+		status = handler(status);
+
+	/* Report current key to user-space */
+	keycode = get_event_keycode();
+	if (keycode != KEY_UNKNOWN)
+		report_key(keycode);
+}
+
+/*
+ * SCI(system control interrupt) main interrupt routine
+ *
+ * We will do the query and get event number together so the interrupt routine
+ * should be longer than 120us now at least 3ms elpase for it.
+ */
+static irqreturn_t sci_irq_handler(int irq, void *dev_id)
+{
+	int ret;
+
+	if (SCI_IRQ_NUM != irq)
+		return IRQ_NONE;
+
+	/* Query the event number */
+	ret = ec_query_event_num();
+	if (ret < 0)
+		return IRQ_NONE;
+
+	event = ec_get_event_num();
+	if (event < EVENT_START || event > EVENT_END)
+		return IRQ_NONE;
+
+	/* Execute corresponding actions */
+	do_event_action();
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Config and init some msr and gpio register properly.
+ */
+static int sci_irq_init(void)
+{
+	u32 hi, lo;
+	u32 gpio_base;
+	unsigned long flags;
+	int ret;
+
+	/* Get gpio base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+	gpio_base = lo & 0xff00;
+
+	/* Filter the former kb3310 interrupt for security */
+	ret = ec_query_event_num();
+	if (ret)
+		return ret;
+
+	/* For filtering next number interrupt */
+	udelay(10000);
+
+	/* Set gpio native registers and msrs for GPIO27 SCI EVENT PIN
+	 * gpio :
+	 *      input, pull-up, no-invert, event-count and value 0,
+	 *      no-filter, no edge mode
+	 *      gpio27 map to Virtual gpio0
+	 * msr :
+	 *      no primary and lpc
+	 *      Unrestricted Z input to IG10 from Virtual gpio 0.
+	 */
+	local_irq_save(flags);
+	_rdmsr(0x80000024, &hi, &lo);
+	lo &= ~(1 << 10);
+	_wrmsr(0x80000024, hi, lo);
+	_rdmsr(0x80000025, &hi, &lo);
+	lo &= ~(1 << 10);
+	_wrmsr(0x80000025, hi, lo);
+	_rdmsr(0x80000023, &hi, &lo);
+	lo |= (0x0a << 0);
+	_wrmsr(0x80000023, hi, lo);
+	local_irq_restore(flags);
+
+	/* Set gpio27 as sci interrupt
+	 *
+	 * input, pull-up, no-fliter, no-negedge, invert
+	 * the sci event is just about 120us
+	 */
+	asm(".set noreorder\n");
+	/*  input enable */
+	outl(0x00000800, (gpio_base | 0xA0));
+	/*  revert the input */
+	outl(0x00000800, (gpio_base | 0xA4));
+	/*  event-int enable */
+	outl(0x00000800, (gpio_base | 0xB8));
+	asm(".set reorder\n");
+
+	return 0;
+}
+
+static struct irqaction sci_irqaction = {
+	.handler = sci_irq_handler,
+	.name = "sci",
+	.flags = IRQF_SHARED,
+};
+
+static int __init yeeloong_hotkey_init(void)
+{
+	int ret;
+	struct key_entry *key;
+
+	if (mips_machtype != MACH_LEMOTE_YL2F89) {
+		pr_err("This Driver is only for YeeLoong laptop\n");
+		return -EFAULT;
+	}
+
+	ret = sci_irq_init();
+	if (ret)
+		return -EFAULT;
+
+	ret = setup_irq(SCI_IRQ_NUM, &sci_irqaction);
+	if (ret)
+		return -EFAULT;
+
+	yeeloong_hotkey_dev = input_allocate_device();
+
+	if (!yeeloong_hotkey_dev) {
+		remove_irq(SCI_IRQ_NUM, &sci_irqaction);
+		return -ENOMEM;
+	}
+
+	yeeloong_hotkey_dev->name = "HotKeys";
+	yeeloong_hotkey_dev->phys = "button/input0";
+	yeeloong_hotkey_dev->id.bustype = BUS_HOST;
+	yeeloong_hotkey_dev->dev.parent = NULL;
+
+	for (key = yeeloong_keymap; key->type != KE_END; key++) {
+		switch (key->type) {
+		case KE_KEY:
+			set_bit(EV_KEY, yeeloong_hotkey_dev->evbit);
+			set_bit(key->keycode, yeeloong_hotkey_dev->keybit);
+			break;
+		case KE_SW:
+			set_bit(EV_SW, yeeloong_hotkey_dev->evbit);
+			set_bit(key->keycode, yeeloong_hotkey_dev->swbit);
+			break;
+		}
+	}
+
+	ret = input_register_device(yeeloong_hotkey_dev);
+	if (ret) {
+		input_free_device(yeeloong_hotkey_dev);
+		return ret;
+	}
+
+	/* Update the current status of LID */
+	report_lid_switch(BIT_LID_DETECT_ON);
+
+#ifdef CONFIG_LOONGSON_SUSPEND
+	/* Install the real yeeloong_report_lid_status for pm.c */
+	yeeloong_report_lid_status = report_lid_switch;
+#endif
+
+	return 0;
+}
+
+static void __exit yeeloong_hotkey_exit(void)
+{
+	/* Free irq */
+	remove_irq(SCI_IRQ_NUM, &sci_irqaction);
+
+#ifdef CONFIG_LOONGSON_SUSPEND
+	/* Uninstall yeeloong_report_lid_status for pm.c */
+	yeeloong_report_lid_status = NULL;
+#endif
+
+	if (yeeloong_hotkey_dev) {
+		input_unregister_device(yeeloong_hotkey_dev);
+		yeeloong_hotkey_dev = NULL;
+	}
+}
+
+module_init(yeeloong_hotkey_init);
+module_exit(yeeloong_hotkey_exit);
-- 
1.6.2.1
