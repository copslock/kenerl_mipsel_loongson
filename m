Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 19:20:12 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:40614 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494062AbZKSSUG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 19:20:06 +0100
Received: by pxi3 with SMTP id 3so1831847pxi.22
        for <multiple recipients>; Thu, 19 Nov 2009 10:19:58 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nVznImrPOngzcDmVxM/FMoIlgCBzbEE0MAu2qVwuwiY=;
        b=fqAUNX+ZeixIFlBTwCKgT+x9qhkiha7tv84JUh8qqPbWBhQItnMzfx/fMBUjK2+hfF
         pwAOeBIEYqHrimAnDF/ENSR8UBmpWusENINGvF0Vtaz1bo1Llvr1BH0oqW3yBDwuDn+i
         vosXDolEhuqFzA/YM1hYVkw+/3pO4BKeAJKBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GXXJX8x9PAGcG2QqVhEW2Xg/Znr/Dxr0F0Ur9u4+QXqijaorsGNZaxz+uPPrJioci4
         ouPM6crbPznzbwgSdtXRR4MPu+LKWj5BuUHOEmUfdoqKdU6FcLIISQDd/4WJGpBCPWFO
         GBlmeMc4pPEex2Ta0SMScsUBIV8lOtShNZK1w=
Received: by 10.114.215.8 with SMTP id n8mr322397wag.78.1258654797679;
        Thu, 19 Nov 2009 10:19:57 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm470620pxi.2.2009.11.19.10.19.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 10:19:57 -0800 (PST)
From:	Wu <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Richard Purdie <rpurdie@rpsys.net>,
	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1] [loongson] yeeloong2f: add platform specific support
Date:	Fri, 20 Nov 2009 02:19:47 +0800
Message-Id: <d1ce13aed520016726512981bd7a0280a817a5a3.1258654550.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

(Hi, All, This v1 revision applied the fixes of compiling errors without
 CONFIG_PM, Could you please ignore the old one"[PATCH 5/5] [loongson]
 yeeloong2f: add platform specific support"? Thanks!)

This patch added the following subdrivers: backlight, hotkey, video
output, thermal cooling, hwmon and battery.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/kernel/setup.c                       |    1 +
 arch/mips/loongson/Kconfig                     |   18 +
 arch/mips/loongson/lemote-2f/Makefile          |    1 +
 arch/mips/loongson/lemote-2f/ec_kb3310b.h      |  150 +++
 arch/mips/loongson/lemote-2f/yeeloong_laptop.c | 1358 ++++++++++++++++++++++++
 5 files changed, 1528 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop.c

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
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 1041336..34a94b0 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -112,4 +112,22 @@ config LEMOTE_LYNLOONG2F_PDEV
 	  This driver adds the lynloong specific backlight driver and platform
 	  driver(mainly the suspend support).
 
+config LEMOTE_YEELOONG2F_PDEV
+	tristate "Lemote YeeLoong Platform Specific Driver"
+	depends on LEMOTE_MACH2F
+	default m
+	select INPUT_EVDEV
+	select HWMON
+	select VIDEO_OUTPUT_CONTROL
+	select THERMAL
+	select BACKLIGHT_CLASS_DEVICE
+	select SYS_SUPPORTS_APM_EMULATION
+	help
+	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
+	  compatible to FuLoong2F mini PC, but It has an extra Embedded
+	  Controller(kb3310b) for battery, hotkey, backlight, temperature and
+	  fan management.
+
+	  This driver adds the YeeLoong Platform Specific support.
+
 endif # LOONGSON_PLATFORM_DEVICES
diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index 81a97d0..4e8bf5d 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
 # Platform Drivers
 #
 obj-$(CONFIG_LEMOTE_LYNLOONG2F_PDEV) += lynloong_pc.o
+obj-$(CONFIG_LEMOTE_YEELOONG2F_PDEV) += yeeloong_laptop.o
diff --git a/arch/mips/loongson/lemote-2f/ec_kb3310b.h b/arch/mips/loongson/lemote-2f/ec_kb3310b.h
index 4d29953..00530e3 100644
--- a/arch/mips/loongson/lemote-2f/ec_kb3310b.h
+++ b/arch/mips/loongson/lemote-2f/ec_kb3310b.h
@@ -19,6 +19,13 @@ extern int ec_query_seq(unsigned char cmd);
 extern int ec_query_event_num(void);
 extern int ec_get_event_num(void);
 
+typedef int (*sci_handler) (int status);
+extern sci_handler yeeloong_report_lid_status;
+extern int yeeloong_install_sci_handler(int event, sci_handler handler);
+extern int yeeloong_uninstall_sci_handler(int event, sci_handler handler);
+
+#define SCI_IRQ_NUM 0x0A
+
 /*
  * The following registers are determined by the EC index configuration.
  * 1, fill the PORT_HIGH as EC register high part.
@@ -44,4 +51,147 @@ extern int ec_get_event_num(void);
 #define	CMD_GET_EVENT_NUM	0x84
 #define	CMD_PROGRAM_PIECE	0xda
 
+/* temperature & fan registers */
+#define	REG_TEMPERATURE_VALUE	0xF458	/*  current temperature value */
+#define	REG_FAN_AUTO_MAN_SWITCH 0xF459  /*  fan auto/manual control switch */
+#define	BIT_FAN_AUTO		0
+#define	BIT_FAN_MANUAL		1
+#define	REG_FAN_CONTROL		0xF4D2	/*  fan control */
+#define	BIT_FAN_CONTROL_ON	(1 << 0)
+#define	BIT_FAN_CONTROL_OFF	(0 << 0)
+#define	REG_FAN_STATUS		0xF4DA	/*  fan status */
+#define	BIT_FAN_STATUS_ON	(1 << 0)
+#define	BIT_FAN_STATUS_OFF	(0 << 0)
+#define	REG_FAN_SPEED_HIGH	0xFE22	/*  fan speed high byte */
+#define	REG_FAN_SPEED_LOW	0xFE23	/*  fan speed low byte */
+#define	REG_FAN_SPEED_LEVEL	0xF4CC	/*  fan speed level, from 1 to 5 */
+/* fan speed divider */
+#define	FAN_SPEED_DIVIDER	480000	/* (60*1000*1000/62.5/2)*/
+
+/* battery registers */
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
+/* other registers */
+/* Audio: rd/wr */
+#define	REG_AUDIO_VOLUME	0xF46C  /* volume level */
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
+#define	BIT_RESET_OFF		0
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
+	EVENT_LID = 0x23,	/*  press the lid or not */
+	EVENT_DISPLAY_TOGGLE,	/*  Fn+F3 for display switch */
+	EVENT_SLEEP,		/*  Fn+F1 for entering sleep mode */
+	EVENT_OVERTEMP,		/*  Over-temperature happened */
+	EVENT_CRT_DETECT,	/*  CRT is connected */
+	EVENT_CAMERA,		/*  Camera is on or off */
+	EVENT_USB_OC2,		/*  USB2 Over Current occurred */
+	EVENT_USB_OC0,		/*  USB0 Over Current occurred */
+	EVENT_BLACK_SCREEN,	/*  Black screen is on or off */
+	EVENT_AUDIO_MUTE,	/*  Mute is on or off */
+	EVENT_DISPLAY_BRIGHTNESS,/*  LCD backlight brightness adjust */
+	EVENT_AC_BAT,		/*  ac & battery relative issue */
+	EVENT_AUDIO_VOLUME,	/*  Volume adjust */
+	EVENT_WLAN,		/*  Wlan is on or off */
+	EVENT_END
+};
+
+enum {
+	BIT_AC_BAT_BAT_IN = 0,
+	BIT_AC_BAT_AC_IN,
+	BIT_AC_BAT_INIT_CAP,
+	BIT_AC_BAT_CHARGE_MODE,
+	BIT_AC_BAT_STOP_CHARGE,
+	BIT_AC_BAT_BAT_LOW,
+	BIT_AC_BAT_BAT_FULL
+};
+
 #endif /* !_EC_KB3310B_H */
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
new file mode 100644
index 0000000..46c3847
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
@@ -0,0 +1,1358 @@
+/*
+ *  Driver for YeeLoong laptop extras
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/video_output.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+#include <linux/apm-emulation.h>
+
+#include <asm/bootinfo.h>	/* for arcs_cmdline */
+
+#include <loongson.h>
+
+#include <cs5536/cs5536.h>
+#include "ec_kb3310b.h"
+
+#define DRIVER_VERSION "0.1"
+
+/* backlight subdriver */
+#define MAX_BRIGHTNESS 8
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
+	/* avoid tune the brightness when the EC is tuning it */
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
+static int yeeloong_backlight_init(struct device *dev)
+{
+	int ret;
+
+	yeeloong_backlight_dev = backlight_device_register("backlight0", dev,
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
+
+/* hwmon subdriver */
+
+/* pwm(auto/manual) enable or not */
+static int get_fan_pwm_enable(void)
+{
+	/* This get the fan control method: auto or manual */
+	return ec_read(REG_FAN_AUTO_MAN_SWITCH);
+}
+
+static void set_fan_pwm_enable(int manual)
+{
+	ec_write(REG_FAN_AUTO_MAN_SWITCH, !!manual);
+}
+
+static int get_fan_pwm(void)
+{
+	/* fan speed level */
+	return ec_read(REG_FAN_SPEED_LEVEL);
+}
+
+static void set_fan_pwm(int value)
+{
+	int status;
+
+	value = SENSORS_LIMIT(value, 0, 3);
+
+	/* if value is not ZERO, we should ensure it is on */
+	if (value != 0) {
+		status = ec_read(REG_FAN_STATUS);
+		if (status == 0)
+			ec_write(REG_FAN_CONTROL, BIT_FAN_CONTROL_ON);
+	}
+	/* 0xf4cc is for writing */
+	ec_write(REG_FAN_SPEED_LEVEL, value);
+}
+
+static int get_fan_rpm(void)
+{
+	int value = 0;
+
+	value = FAN_SPEED_DIVIDER /
+	    (((ec_read(REG_FAN_SPEED_HIGH) & 0x0f) << 8) |
+	     ec_read(REG_FAN_SPEED_LOW));
+
+	return value;
+}
+
+static int get_cpu_temp(void)
+{
+	int value;
+
+	value = ec_read(REG_TEMPERATURE_VALUE);
+
+	if (value & (1 << 7))
+		value = (value & 0x7f) - 128;
+	else
+		value = value & 0xff;
+
+	return value * 1000;
+}
+
+static int get_battery_temp(void)
+{
+	int value;
+
+	value = (ec_read(REG_BAT_TEMPERATURE_HIGH) << 8) |
+		(ec_read(REG_BAT_TEMPERATURE_LOW));
+
+	return value * 1000;
+}
+
+static int get_battery_current(void)
+{
+	int value;
+
+	value = (ec_read(REG_BAT_CURRENT_HIGH) << 8) |
+		(ec_read(REG_BAT_CURRENT_LOW));
+
+	if (value & 0x8000)
+		value = 0xffff - value;
+
+	return value;
+}
+
+static int get_battery_voltage(void)
+{
+	int value;
+
+	value = (ec_read(REG_BAT_VOLTAGE_HIGH) << 8) |
+		(ec_read(REG_BAT_VOLTAGE_LOW));
+
+	return value;
+}
+
+
+static int parse_arg(const char *buf, unsigned long count, int *val)
+{
+	if (!count)
+		return 0;
+	if (sscanf(buf, "%i", val) != 1)
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t store_sys_hwmon(void (*set) (int), const char *buf, size_t count)
+{
+	int rv, value;
+
+	rv = parse_arg(buf, count, &value);
+	if (rv > 0)
+		set(value);
+	return rv;
+}
+
+static ssize_t show_sys_hwmon(int (*get) (void), char *buf)
+{
+	return sprintf(buf, "%d\n", get());
+}
+
+#define CREATE_SENSOR_ATTR(_name, _mode, _set, _get)		\
+	static ssize_t show_##_name(struct device *dev,			\
+				    struct device_attribute *attr,	\
+				    char *buf)				\
+	{								\
+		return show_sys_hwmon(_set, buf);			\
+	}								\
+	static ssize_t store_##_name(struct device *dev,		\
+				     struct device_attribute *attr,	\
+				     const char *buf, size_t count)	\
+	{								\
+		return store_sys_hwmon(_get, buf, count);		\
+	}								\
+	static SENSOR_DEVICE_ATTR(_name, _mode, show_##_name, store_##_name, 0);
+
+CREATE_SENSOR_ATTR(fan1_input, S_IRUGO, get_fan_rpm, NULL);
+CREATE_SENSOR_ATTR(pwm1, S_IRUGO | S_IWUSR, get_fan_pwm, set_fan_pwm);
+CREATE_SENSOR_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, get_fan_pwm_enable,
+		set_fan_pwm_enable);
+CREATE_SENSOR_ATTR(temp1_input, S_IRUGO, get_cpu_temp, NULL);
+CREATE_SENSOR_ATTR(temp2_input, S_IRUGO, get_battery_temp, NULL);
+CREATE_SENSOR_ATTR(curr1_input, S_IRUGO, get_battery_current, NULL);
+CREATE_SENSOR_ATTR(in1_input, S_IRUGO, get_battery_voltage, NULL);
+
+static ssize_t
+show_name(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "yeeloong\n");
+}
+
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
+
+static struct attribute *hwmon_attributes[] = {
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_name.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group hwmon_attribute_group = {
+	.attrs = hwmon_attributes
+};
+
+struct device *yeeloong_hwmon_dev;
+
+static int yeeloong_hwmon_init(struct device *dev)
+{
+	int ret;
+
+	yeeloong_hwmon_dev = hwmon_device_register(dev);
+	if (IS_ERR(yeeloong_hwmon_dev)) {
+		printk(KERN_INFO "Could not register yeeloong hwmon device\n");
+		yeeloong_hwmon_dev = NULL;
+		return PTR_ERR(yeeloong_hwmon_dev);
+	}
+	ret = sysfs_create_group(&yeeloong_hwmon_dev->kobj,
+				 &hwmon_attribute_group);
+	if (ret) {
+		sysfs_remove_group(&yeeloong_hwmon_dev->kobj,
+				   &hwmon_attribute_group);
+		hwmon_device_unregister(yeeloong_hwmon_dev);
+		yeeloong_hwmon_dev = NULL;
+	}
+	/* ensure fan is set to auto mode */
+	set_fan_pwm_enable(BIT_FAN_AUTO);
+
+	return 0;
+}
+
+static void yeeloong_hwmon_exit(void)
+{
+	if (yeeloong_hwmon_dev) {
+		sysfs_remove_group(&yeeloong_hwmon_dev->kobj,
+				   &hwmon_attribute_group);
+		hwmon_device_unregister(yeeloong_hwmon_dev);
+		yeeloong_hwmon_dev = NULL;
+	}
+}
+
+/* video output subdriver */
+
+static int lcd_video_output_get(struct output_device *od)
+{
+	return ec_read(REG_DISPLAY_LCD);
+}
+
+static int lcd_video_output_set(struct output_device *od)
+{
+	unsigned long status = od->request_state;
+	int value;
+
+	if (status == BIT_DISPLAY_LCD_ON) {
+		/* open LCD */
+		outb(0x31, 0x3c4);
+		value = inb(0x3c5);
+		value = (value & 0xf8) | 0x03;
+		outb(0x31, 0x3c4);
+		outb(value, 0x3c5);
+		/* open backlight */
+		ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_ON);
+	} else {
+		/* close backlight */
+		ec_write(REG_BACKLIGHT_CTRL, BIT_BACKLIGHT_OFF);
+		/* close LCD */
+		outb(0x31, 0x3c4);
+		value = inb(0x3c5);
+		value = (value & 0xf8) | 0x02;
+		outb(0x31, 0x3c4);
+		outb(value, 0x3c5);
+	}
+
+	return 0;
+}
+
+static struct output_properties lcd_output_properties = {
+	.set_state = lcd_video_output_set,
+	.get_status = lcd_video_output_get,
+};
+
+static int crt_video_output_get(struct output_device *od)
+{
+	return ec_read(REG_CRT_DETECT);
+}
+
+static int crt_video_output_set(struct output_device *od)
+{
+	unsigned long status = od->request_state;
+	int value;
+
+	if (status == BIT_CRT_DETECT_PLUG) {
+		if (ec_read(REG_CRT_DETECT) == BIT_CRT_DETECT_PLUG) {
+			/* open CRT */
+			outb(0x21, 0x3c4);
+			value = inb(0x3c5);
+			value &= ~(1 << 7);
+			outb(0x21, 0x3c4);
+			outb(value, 0x3c5);
+		}
+	} else {
+		/* close CRT */
+		outb(0x21, 0x3c4);
+		value = inb(0x3c5);
+		value |= (1 << 7);
+		outb(0x21, 0x3c4);
+		outb(value, 0x3c5);
+	}
+
+	return 0;
+}
+
+static struct output_properties crt_output_properties = {
+	.set_state = crt_video_output_set,
+	.get_status = crt_video_output_get,
+};
+
+struct output_device *lcd_output_dev, *crt_output_dev;
+
+static void lcd_vo_set(int status)
+{
+	lcd_output_dev->request_state = status;
+	lcd_video_output_set(lcd_output_dev);
+}
+
+static void crt_vo_set(int status)
+{
+	crt_output_dev->request_state = status;
+	crt_video_output_set(crt_output_dev);
+}
+
+static int crt_detect_handler(int status)
+{
+	if (status == BIT_CRT_DETECT_PLUG) {
+		crt_vo_set(BIT_CRT_DETECT_PLUG);
+		lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	} else {
+		lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+	}
+	return status;
+}
+
+static int black_screen_handler(int status)
+{
+	char *p = NULL, *ec_ver = NULL;
+
+	ec_ver = strstr(arcs_cmdline, "EC_VER=");
+	if (ec_ver) {
+		p = strstr(ec_ver, " ");
+		if (p)
+			*p = '\0';
+	}
+
+	/* Seems EC(>=PQ1D26) does this job for us, we can not do it again,
+	 * otherwise, the brightness will not resume! */
+	if ((ec_ver == NULL) || strncasecmp(ec_ver, "EC_VER=PQ1D26", 64) < 0)
+		lcd_vo_set(status);
+
+	return status;
+}
+
+static int display_toggle_handler(int status)
+{
+	static int video_output_status;
+
+	/* only enable switch video output button
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
+		lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		crt_vo_set(BIT_CRT_DETECT_PLUG);
+		break;
+	case 2:
+		lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+		crt_vo_set(BIT_CRT_DETECT_PLUG);
+		break;
+	case 3:
+		lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+		crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+		break;
+	case 4:
+		lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+		break;
+	default:
+		/* ensure LCD is on */
+		lcd_vo_set(BIT_DISPLAY_LCD_ON);
+		break;
+	}
+	return video_output_status;
+}
+
+static int yeeloong_vo_init(struct device *dev)
+{
+	int ret;
+
+	/* register video output device: lcd, crt */
+	lcd_output_dev = video_output_register("LCD", dev, NULL,
+			&lcd_output_properties);
+
+	if (IS_ERR(lcd_output_dev)) {
+		ret = PTR_ERR(lcd_output_dev);
+		lcd_output_dev = NULL;
+		return ret;
+	}
+	/* ensure LCD is on by default */
+	lcd_vo_set(1);
+
+	crt_output_dev = video_output_register("CRT", dev, NULL,
+			&crt_output_properties);
+
+	if (IS_ERR(crt_output_dev)) {
+		ret = PTR_ERR(crt_output_dev);
+		crt_output_dev = NULL;
+		return ret;
+	}
+	/* close CRT by default, and will be enabled
+	 * when the CRT connectting event reported by SCI */
+	crt_vo_set(0);
+
+	/* install event handlers */
+	yeeloong_install_sci_handler(EVENT_CRT_DETECT,
+					   crt_detect_handler);
+	yeeloong_install_sci_handler(EVENT_BLACK_SCREEN,
+					   black_screen_handler);
+	yeeloong_install_sci_handler(EVENT_DISPLAY_TOGGLE,
+					   display_toggle_handler);
+
+	return 0;
+}
+
+static void yeeloong_vo_exit(void)
+{
+	/* uninstall event handlers */
+	yeeloong_uninstall_sci_handler(EVENT_CRT_DETECT,
+					   crt_detect_handler);
+	yeeloong_uninstall_sci_handler(EVENT_BLACK_SCREEN,
+					   black_screen_handler);
+	yeeloong_uninstall_sci_handler(EVENT_DISPLAY_TOGGLE,
+					   display_toggle_handler);
+
+	if (lcd_output_dev) {
+		video_output_unregister(lcd_output_dev);
+		lcd_output_dev = NULL;
+	}
+	if (crt_output_dev) {
+		video_output_unregister(crt_output_dev);
+		crt_output_dev = NULL;
+	}
+}
+
+/* Thermal cooling devices subdriver */
+
+static int video_get_max_state(struct thermal_cooling_device *cdev, unsigned
+			       long *state)
+{
+	*state = MAX_BRIGHTNESS;
+	return 0;
+}
+
+static int video_get_cur_state(struct thermal_cooling_device *cdev, unsigned
+			       long *state)
+{
+	static struct backlight_device *bd;
+
+	bd = (struct backlight_device *)cdev->devdata;
+
+	*state = yeeloong_get_brightness(bd);
+
+	return 0;
+}
+
+static int video_set_cur_state(struct thermal_cooling_device *cdev, unsigned
+			       long state)
+{
+	static struct backlight_device *bd;
+
+	bd = (struct backlight_device *)cdev->devdata;
+
+	yeeloong_backlight_dev->props.brightness = state;
+	backlight_update_status(bd);
+
+	return 0;
+}
+
+static struct thermal_cooling_device_ops video_cooling_ops = {
+	.get_max_state = video_get_max_state,
+	.get_cur_state = video_get_cur_state,
+	.set_cur_state = video_set_cur_state,
+};
+
+static struct thermal_cooling_device *yeeloong_thermal_cdev;
+
+/* TODO: register fan, cpu as the cooling devices */
+static int yeeloong_thermal_init(struct device *dev)
+{
+	int ret;
+
+	if (!dev)
+		return -1;
+
+	yeeloong_thermal_cdev = thermal_cooling_device_register("LCD", dev,
+			&video_cooling_ops);
+
+	if (IS_ERR(yeeloong_thermal_cdev)) {
+		ret = PTR_ERR(yeeloong_thermal_cdev);
+		return ret;
+	}
+
+	ret = sysfs_create_link(&dev->kobj,
+				&yeeloong_thermal_cdev->device.kobj,
+				"thermal_cooling");
+	if (ret) {
+		printk(KERN_ERR "Create sysfs link\n");
+		return ret;
+	}
+	ret = sysfs_create_link(&yeeloong_thermal_cdev->device.kobj,
+				&dev->kobj, "device");
+	if (ret) {
+		printk(KERN_ERR "Create sysfs link\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void yeeloong_thermal_exit(struct device *dev)
+{
+	if (yeeloong_thermal_cdev) {
+		if (dev)
+			sysfs_remove_link(&dev->kobj, "thermal_cooling");
+		sysfs_remove_link(&yeeloong_thermal_cdev->device.kobj,
+				  "device");
+		thermal_cooling_device_unregister(yeeloong_thermal_cdev);
+		yeeloong_thermal_cdev = NULL;
+	}
+}
+
+/* hotkey input subdriver */
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
+static struct key_entry yeeloong_keymap[] = {
+	{KE_SW, EVENT_LID, SW_LID},
+	/* SW_VIDEOOUT_INSERT? not included in hald-addon-input! */
+	{KE_KEY, EVENT_CRT_DETECT, KEY_PROG1},
+	/* Seems battery subdriver should report it */
+	{KE_KEY, EVENT_OVERTEMP, KEY_PROG2},
+	/*{KE_KEY, EVENT_AC_BAT, KEY_BATTERY},*/
+	{KE_KEY, EVENT_CAMERA, KEY_CAMERA},	/* Fn + ESC */
+	{KE_KEY, EVENT_SLEEP, KEY_SLEEP},	/* Fn + F1 */
+	/* Seems not clear? not included in hald-addon-input! */
+	{KE_KEY, EVENT_BLACK_SCREEN, KEY_PROG3},	/* Fn + F2 */
+	{KE_KEY, EVENT_DISPLAY_TOGGLE, KEY_SWITCHVIDEOMODE},	/* Fn + F3 */
+	{KE_KEY, EVENT_AUDIO_MUTE, KEY_MUTE},	/* Fn + F4 */
+	{KE_KEY, EVENT_WLAN, KEY_WLAN},	/* Fn + F5 */
+	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSUP},	/* Fn + up */
+	{KE_KEY, EVENT_DISPLAY_BRIGHTNESS, KEY_BRIGHTNESSDOWN},	/* Fn + down */
+	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEUP},	/* Fn + right */
+	{KE_KEY, EVENT_AUDIO_VOLUME, KEY_VOLUMEDOWN},	/* Fn + left */
+	{KE_END, 0}
+};
+
+static int yeeloong_lid_update_status(int status)
+{
+	input_report_switch(yeeloong_hotkey_dev, SW_LID, !status);
+	input_sync(yeeloong_hotkey_dev);
+
+	return status;
+}
+
+static void yeeloong_hotkey_update_status(int key)
+{
+	input_report_key(yeeloong_hotkey_dev, key, 1);
+	input_sync(yeeloong_hotkey_dev);
+	input_report_key(yeeloong_hotkey_dev, key, 0);
+	input_sync(yeeloong_hotkey_dev);
+}
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
+void yeeloong_report_key(void)
+{
+	int keycode;
+
+	keycode = get_event_keycode();
+
+	if (keycode == SW_LID)
+		yeeloong_lid_update_status(status);
+	else
+		yeeloong_hotkey_update_status(keycode);
+}
+
+enum { NO_REG, MUL_REG, REG_END };
+
+int event_reg[15] = {
+	REG_LID_DETECT,		/*  press the lid or not */
+	NO_REG,			/*  Fn+F3 for display switch */
+	NO_REG,			/*  Fn+F1 for entering sleep mode */
+	MUL_REG,		/*  Over-temperature happened */
+	REG_CRT_DETECT,		/*  CRT is connected */
+	REG_CAMERA_STATUS,	/*  Camera is on or off */
+	REG_USB2_FLAG,		/*  USB2 Over Current occurred */
+	REG_USB0_FLAG,		/*  USB0 Over Current occurred */
+	REG_DISPLAY_LCD,	/*  Black screen is on or off */
+	REG_AUDIO_MUTE,		/*  Mute is on or off */
+	REG_DISPLAY_BRIGHTNESS,	/*  LCD backlight brightness adjust */
+	NO_REG,			/*  ac & battery relative issue */
+	REG_AUDIO_VOLUME,	/*  Volume adjust */
+	REG_WLAN,		/*  Wlan is on or off */
+	REG_END
+};
+
+static int ec_get_event_status(void)
+{
+	int reg;
+
+	reg = event_reg[event - EVENT_LID];
+
+	if (reg == NO_REG)
+		return 1;
+	else if (reg == MUL_REG) {
+		if (event == EVENT_OVERTEMP) {
+			return (ec_read(REG_BAT_CHARGE_STATUS) &
+				BIT_BAT_CHARGE_STATUS_OVERTEMP) >> 2;
+		}
+	} else if (reg != REG_END)
+		return ec_read(reg);
+
+	return -1;
+}
+
+static sci_handler event_handler[15];
+
+int yeeloong_install_sci_handler(int event, sci_handler handler)
+{
+	if (event_handler[event - EVENT_LID] != NULL) {
+		printk(KERN_INFO "There is a handler installed for event: %d\n",
+		       event);
+		return -1;
+	}
+	event_handler[event - EVENT_LID] = handler;
+
+	return 0;
+}
+EXPORT_SYMBOL(yeeloong_install_sci_handler);
+
+int yeeloong_uninstall_sci_handler(int event, sci_handler handler)
+{
+	if (event_handler[event - EVENT_LID] == NULL) {
+		printk(KERN_INFO "There is no handler installed for event: %d\n",
+		       event);
+		return -1;
+	}
+	if (event_handler[event - EVENT_LID] != handler) {
+		printk(KERN_INFO "You can not uninstall the handler installed by others\n");
+		return -1;
+	}
+	event_handler[event - EVENT_LID] = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL(yeeloong_uninstall_sci_handler);
+
+static void yeeloong_event_action(void)
+{
+	sci_handler handler;
+
+	handler = event_handler[event - EVENT_LID];
+
+	if (handler == NULL)
+		return;
+
+	if (event == EVENT_CAMERA)
+		status = handler(3);
+	else
+		status = handler(status);
+}
+
+/*
+ * sci main interrupt routine
+ *
+ * we will do the query and get event number together so the interrupt routine
+ * should be longer than 120us now at least 3ms elpase for it.
+ */
+static irqreturn_t sci_irq_handler(int irq, void *dev_id)
+{
+	int ret;
+
+	if (SCI_IRQ_NUM != irq) {
+		printk(KERN_ERR "%s: spurious irq.\n", __func__);
+		return IRQ_NONE;
+	}
+
+	/* query the event number */
+	ret = ec_query_event_num();
+	if (ret < 0) {
+		printk(KERN_ERR "%s: return: %d\n", __func__, ret);
+		return IRQ_NONE;
+	}
+
+	event = ec_get_event_num();
+	if (event < 0) {
+		printk(KERN_ERR "%s: return: %d\n", __func__, event);
+		return IRQ_NONE;
+	}
+
+	printk(KERN_INFO "sci event number: 0x%x\n", event);
+
+	/* parse the event number and wake the queue */
+	if ((event != 0x00) && (event != 0xff)) {
+		/* get status of current event */
+		status = ec_get_event_status();
+		printk(KERN_INFO "%s: status: %d\n", __func__, status);
+		if (status == -1)
+			return IRQ_NONE;
+		/* execute relative actions */
+		yeeloong_event_action();
+		/* report current key */
+		yeeloong_report_key();
+	}
+	return IRQ_HANDLED;
+}
+
+/*
+ * config and init some msr and gpio register properly.
+ */
+static int sci_irq_init(void)
+{
+	u32 hi, lo;
+	u32 gpio_base;
+	int ret = 0;
+	unsigned long flags;
+
+	/* get gpio base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+	gpio_base = lo & 0xff00;
+
+	/* filter the former kb3310 interrupt for security */
+	ret = ec_query_event_num();
+	if (ret) {
+		printk(KERN_ERR "%s: failed.\n", __func__);
+		return ret;
+	}
+
+	/* for filtering next number interrupt */
+	udelay(10000);
+
+	/* set gpio native registers and msrs for GPIO27 SCI EVENT PIN
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
+	/* set gpio27 as sci interrupt
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
+struct irqaction sci_irqaction = {
+	.handler = sci_irq_handler,
+	.name = "sci",
+	.flags = IRQF_SHARED,
+};
+
+static int setup_sci(void)
+{
+	sci_irq_init();
+
+	setup_irq(SCI_IRQ_NUM, &sci_irqaction);
+
+	return 0;
+}
+
+static ssize_t
+ignore_store(struct device *dev,
+	     struct device_attribute *attr, const char *buf, size_t count)
+{
+	return count;
+}
+
+static ssize_t
+show_hotkeystate(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d %d\n", event, status);
+}
+
+static DEVICE_ATTR(state, 0444, show_hotkeystate, ignore_store);
+
+static struct attribute *hotkey_attributes[] = {
+	&dev_attr_state.attr,
+	NULL
+};
+
+static struct attribute_group hotkey_attribute_group = {
+	.attrs = hotkey_attributes
+};
+
+static int camera_set(int status)
+{
+	int value;
+	static int camera_status;
+
+	if (status == 2)
+		/* resume the old camera status */
+		camera_set(camera_status);
+	else if (status == 3) {
+		/* revert the camera status */
+		value = ec_read(REG_CAMERA_CONTROL);
+		ec_write(REG_CAMERA_CONTROL, value | (1 << 1));
+	} else {		/* status == 0 or status == 1 */
+		status = !!status;
+		camera_status = ec_read(REG_CAMERA_STATUS);
+		if (status != camera_status)
+			camera_set(3);
+	}
+	return ec_read(REG_CAMERA_STATUS);
+}
+
+#define I8042_STATUS_REG	0x64
+#define I8042_DATA_REG		0x60
+#define i8042_read_status() inb(I8042_STATUS_REG)
+#define i8042_read_data() inb(I8042_DATA_REG)
+#define I8042_STR_OBF		0x01
+#define I8042_BUFFER_SIZE	16
+
+static void i8042_flush(void)
+{
+	int i;
+
+	while ((i8042_read_status() & I8042_STR_OBF)
+		&& (i < I8042_BUFFER_SIZE)) {
+		udelay(50);
+		i8042_read_data();
+		i++;
+	}
+}
+
+static int yeeloong_hotkey_init(struct device *dev)
+{
+	int ret;
+	struct key_entry *key;
+
+	/* flush the buffer of keyboard */
+	i8042_flush();
+
+	/* setup the system control interface */
+	setup_sci();
+
+	yeeloong_hotkey_dev = input_allocate_device();
+
+	if (!yeeloong_hotkey_dev)
+		return -ENOMEM;
+
+	yeeloong_hotkey_dev->name = "HotKeys";
+	yeeloong_hotkey_dev->phys = "button/input0";
+	yeeloong_hotkey_dev->id.bustype = BUS_HOST;
+	yeeloong_hotkey_dev->dev.parent = dev;
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
+	ret = sysfs_create_group(&yeeloong_hotkey_dev->dev.kobj,
+				 &hotkey_attribute_group);
+	if (ret) {
+		sysfs_remove_group(&yeeloong_hotkey_dev->dev.kobj,
+				   &hotkey_attribute_group);
+		input_unregister_device(yeeloong_hotkey_dev);
+		yeeloong_hotkey_dev = NULL;
+	}
+	/* update the current status of lid */
+	yeeloong_lid_update_status(BIT_LID_DETECT_ON);
+
+#ifdef CONFIG_SUSPEND
+	/* install the real yeeloong_report_lid_status for pm.c */
+	yeeloong_report_lid_status = yeeloong_lid_update_status;
+#endif
+	/* install event handler */
+	yeeloong_install_sci_handler(EVENT_CAMERA, camera_set);
+
+	return 0;
+}
+
+static void yeeloong_hotkey_exit(void)
+{
+	/* free irq */
+	remove_irq(SCI_IRQ_NUM, &sci_irqaction);
+
+#ifdef CONFIG_SUSPEND
+	/* uninstall the real yeeloong_report_lid_status for pm.c */
+	yeeloong_report_lid_status = NULL;
+#endif
+	/* uninstall event handler */
+	yeeloong_uninstall_sci_handler(EVENT_CAMERA, camera_set);
+
+	if (yeeloong_hotkey_dev) {
+		sysfs_remove_group(&yeeloong_hotkey_dev->dev.kobj,
+				   &hotkey_attribute_group);
+		input_unregister_device(yeeloong_hotkey_dev);
+		yeeloong_hotkey_dev = NULL;
+	}
+}
+
+/* battery subdriver: APM emulated support */
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
+		printk(KERN_INFO
+		       "battery vendor(%s), cells count(%d), "
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
+static void __maybe_unused yeeloong_apm_get_power_status(struct apm_power_info
+		*info)
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
+			/* if the battery is fully charged */
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
+static int yeeloong_apm_init(void)
+{
+	/* print fixed information of battery */
+	get_fixed_battery_info();
+
+#ifdef APM_EMULATION
+	apm_get_power_status = yeeloong_apm_get_power_status;
+#endif
+	return 0;
+}
+
+static void yeeloong_apm_exit(void)
+{
+}
+
+/* platform subdriver */
+static struct platform_device *yeeloong_pdev;
+
+static void __maybe_unused usb_ports_set(int status)
+{
+	status = !!status;
+
+	ec_write(REG_USB0_FLAG, status);
+	ec_write(REG_USB1_FLAG, status);
+	ec_write(REG_USB2_FLAG, status);
+}
+
+static int __maybe_unused yeeloong_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	printk(KERN_INFO "yeeloong specific suspend\n");
+
+	/* close LCD */
+	lcd_vo_set(BIT_DISPLAY_LCD_OFF);
+	/* close CRT */
+	crt_vo_set(BIT_CRT_DETECT_UNPLUG);
+	/* power off camera */
+	camera_set(BIT_CAMERA_CONTROL_OFF);
+	/* poweroff three usb ports */
+	usb_ports_set(BIT_USB_FLAG_OFF);
+	/* minimize the speed of FAN */
+	set_fan_pwm_enable(BIT_FAN_MANUAL);
+	set_fan_pwm(1);
+
+	return 0;
+}
+
+static int __maybe_unused yeeloong_resume(struct platform_device *pdev)
+{
+	printk(KERN_INFO "yeeloong specific resume\n");
+
+	/* resume the status of lcd & crt */
+	lcd_vo_set(BIT_DISPLAY_LCD_ON);
+	crt_vo_set(BIT_CRT_DETECT_PLUG);
+
+	/* power on three usb ports */
+	usb_ports_set(BIT_USB_FLAG_ON);
+
+	/* resume the camera status */
+	camera_set(2);
+
+	/* resume fan to auto mode */
+	set_fan_pwm_enable(BIT_FAN_AUTO);
+
+	return 0;
+}
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		   .name = "yeeloong-laptop",
+		   .owner = THIS_MODULE,
+		   },
+#ifdef CONFIG_PM
+	.suspend = yeeloong_suspend,
+	.resume = yeeloong_resume,
+#endif
+};
+
+static ssize_t yeeloong_pdev_name_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "yeeloong laptop\n");
+}
+
+static struct device_attribute dev_attr_yeeloong_pdev_name =
+__ATTR(name, S_IRUGO, yeeloong_pdev_name_show, NULL);
+
+static int yeeloong_pdev_init(void)
+{
+	int ret;
+
+	/* Register platform stuff */
+	ret = platform_driver_register(&platform_driver);
+	if (ret)
+		return ret;
+
+	yeeloong_pdev = platform_device_alloc("yeeloong-laptop", -1);
+	if (!yeeloong_pdev) {
+		ret = -ENOMEM;
+		platform_driver_unregister(&platform_driver);
+		return ret;
+	}
+
+	ret = platform_device_add(yeeloong_pdev);
+	if (ret) {
+		platform_device_put(yeeloong_pdev);
+		return ret;
+	}
+
+	if (IS_ERR(yeeloong_pdev)) {
+		ret = PTR_ERR(yeeloong_pdev);
+		yeeloong_pdev = NULL;
+		printk(KERN_INFO "unable to register platform device\n");
+		return ret;
+	}
+
+	ret = device_create_file(&yeeloong_pdev->dev,
+				 &dev_attr_yeeloong_pdev_name);
+	if (ret) {
+		printk(KERN_INFO "unable to create sysfs device attributes\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void yeeloong_pdev_exit(void)
+{
+	if (yeeloong_pdev) {
+		platform_device_unregister(yeeloong_pdev);
+		yeeloong_pdev = NULL;
+		platform_driver_unregister(&platform_driver);
+	}
+}
+
+static int __init yeeloong_init(void)
+{
+	int ret;
+
+	if (mips_machtype != MACH_LEMOTE_YL2F89) {
+		printk(KERN_INFO "This Driver is for YeeLoong netbook, You"
+				"can not use it on the other Machines\n");
+		return -EFAULT;
+	}
+
+	printk(KERN_INFO "YeeLoong Platform Specific Drivers %s loaded\n",
+			DRIVER_VERSION);
+
+	ret = yeeloong_pdev_init();
+	if (ret) {
+		yeeloong_pdev_exit();
+		printk(KERN_INFO "init yeeloong platform driver failure\n");
+		return ret;
+	}
+	ret = yeeloong_hotkey_init(&yeeloong_pdev->dev);
+	if (ret) {
+		yeeloong_hotkey_exit();
+		printk(KERN_INFO "init yeeloong hotkey driver failure\n");
+		return ret;
+	}
+	ret = yeeloong_apm_init();
+	if (ret) {
+		yeeloong_apm_exit();
+		printk(KERN_INFO "init yeeloong apm driver failure\n");
+		return ret;
+	}
+	ret = yeeloong_backlight_init(&yeeloong_pdev->dev);
+	if (ret) {
+		yeeloong_backlight_exit();
+		printk(KERN_INFO "init yeeloong backlight driver failure\n");
+		return ret;
+	}
+	ret = yeeloong_thermal_init(&yeeloong_backlight_dev->dev);
+	if (ret) {
+		yeeloong_thermal_exit(&yeeloong_backlight_dev->dev);
+		printk(KERN_INFO
+		       "Fail to init yeeloong thermal cooling device.\n");
+		return ret;
+	}
+	ret = yeeloong_hwmon_init(&yeeloong_pdev->dev);
+	if (ret) {
+		yeeloong_hwmon_exit();
+		printk(KERN_INFO "init yeeloong hwmon driver failure\n");
+		return ret;
+	}
+	ret = yeeloong_vo_init(&yeeloong_pdev->dev);
+	if (ret) {
+		yeeloong_vo_exit();
+		printk(KERN_INFO "init yeeloong video output driver failure\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void __exit yeeloong_exit(void)
+{
+	yeeloong_vo_exit();
+	yeeloong_hwmon_exit();
+	yeeloong_thermal_exit(&yeeloong_backlight_dev->dev);
+	yeeloong_backlight_exit();
+	yeeloong_apm_exit();
+	yeeloong_hotkey_exit();
+	yeeloong_pdev_exit();
+
+	printk(KERN_INFO "YeeLoong Platform Specific Drivers %s unloaded\n",
+			DRIVER_VERSION);
+}
+
+module_init(yeeloong_init);
+module_exit(yeeloong_exit);
+
+MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>");
+MODULE_DESCRIPTION("YeeLoong laptop driver");
+MODULE_LICENSE("GPL");
-- 
1.6.2.1
