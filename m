Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 12:10:28 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:45951 "EHLO
        mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491817AbZLALKY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 12:10:24 +0100
Received: by pxi26 with SMTP id 26so3680336pxi.21
        for <multiple recipients>; Tue, 01 Dec 2009 03:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ZPndBdJtMvn0wyv61oW7jM/U1tTmJswDKkCksy8Ea7I=;
        b=m1SkiqOlBCXSPzzp1jqbt/jh+sR4wTRf2ayHGZT62cMPQfN65YEJEKhuM3Ibp79t8s
         S4spTNab3UgbVKUsTyB/U4xIv0PziL2mR/MAO4/7T9Mm3TeAWm3CP3f3aFBEQwj1vJja
         XpoKR/EPk5s9RNxVsBqSmVIoSBN2KCBjVCGKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cB65Q1PqW3intHf+NSFRxZ9YEIhsvhkSiSLrMHgJ1qu/wRmqjESoWnzoQTaSUjNN3v
         ze/h/eE5xfSTUwIFJilB8O2Ix9c6RKA9OW+/SLd7UOH1riHqpb59UmOYk+p7vTkm4vku
         mC3IsRXfnGvqTFYe+/u1GHkVHEmweLKTwABaA=
Received: by 10.114.49.6 with SMTP id w6mr10580166waw.148.1259665817218;
        Tue, 01 Dec 2009 03:10:17 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm488751pxi.13.2009.12.01.03.10.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 03:10:16 -0800 (PST)
From:   Wu Zhangin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        lm-sensors@lm-sensors.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v6 5/8] Loongson: YeeLoong: add hwmon driver
Date:   Tue,  1 Dec 2009 19:09:59 +0800
Message-Id: <3973cc1fdb6ff2b2e540ed93ae92dac8d7b2a38f.1259664573.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1259660040.git.wuzhangjin@gmail.com>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1259664573.git.wuzhangjin@gmail.com>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch adds hwmon driver for managing the temperature of battery,
cpu and controlling the fan.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 +
 .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
 .../loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c  |  239 ++++++++++++++++++++
 3 files changed, 249 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
index 2401ed6..d13e1ab 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
@@ -28,4 +28,13 @@ config YEELOONG_BATTERY
 	  This option adds APM emulated Battery Driver, which provides standard
 	  interface for user-space applications to manage the battery.
 
+config YEELOONG_HWMON
+	tristate "Hardware Monitor Driver"
+	select HWMON
+	default y
+	help
+	  This option adds hardware monitor driver, which provides standard
+	  interface for lm-sensors to monitor the temperatures of CPU and
+	  battery, the PWM of fan, the current, voltage of battery.
+
 endif
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
index 31e2145..b38fb2a 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Makefile
@@ -4,3 +4,4 @@ obj-y += ec_kb3310b.o
 
 obj-$(CONFIG_YEELOONG_BACKLIGHT) += yl_backlight.o
 obj-$(CONFIG_YEELOONG_BATTERY) += yl_battery.o
+obj-$(CONFIG_YEELOONG_HWMON) += yl_hwmon.o
diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c
new file mode 100644
index 0000000..ed8b705
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/yl_hwmon.c
@@ -0,0 +1,239 @@
+/*
+ * YeeLoong Hwmon Driver
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#include <asm/bootinfo.h>
+
+#include "ec_kb3310b.h"
+
+MODULE_AUTHOR("Wu Zhangjin <wuzj@lemote.com>");
+MODULE_DESCRIPTION("YeeLoong laptop hwmon driver");
+MODULE_LICENSE("GPL");
+
+/* pwm(auto/manual) enable or not */
+static int get_fan_pwm_enable(void)
+{
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
+	return ec_read(REG_FAN_SPEED_LEVEL);
+}
+
+static void set_fan_pwm(int value)
+{
+	int status;
+
+	value = SENSORS_LIMIT(value, 0, 3);
+
+	/* If value is not ZERO, We should ensure it is on */
+	if (value != 0) {
+		status = ec_read(REG_FAN_STATUS);
+		if (status == 0)
+			ec_write(REG_FAN_CONTROL, BIT_FAN_CONTROL_ON);
+	}
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
+static int get_battery_temp_alarm(void)
+{
+	int status;
+
+	status = (ec_read(REG_BAT_CHARGE_STATUS) &
+			BIT_BAT_CHARGE_STATUS_OVERTEMP);
+
+	return !!status;
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
+CREATE_SENSOR_ATTR(temp2_max_alarm, S_IRUGO, get_battery_temp_alarm, NULL);
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
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
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
+static int __init yeeloong_hwmon_init(void)
+{
+	int ret;
+
+	if (mips_machtype != MACH_LEMOTE_YL2F89) {
+		pr_err("This Driver is only for YeeLoong laptop\n");
+		return -EFAULT;
+	}
+
+	yeeloong_hwmon_dev = hwmon_device_register(NULL);
+	if (IS_ERR(yeeloong_hwmon_dev)) {
+		pr_err("Fail to register yeeloong hwmon device\n");
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
+static void __exit yeeloong_hwmon_exit(void)
+{
+	if (yeeloong_hwmon_dev) {
+		sysfs_remove_group(&yeeloong_hwmon_dev->kobj,
+				   &hwmon_attribute_group);
+		hwmon_device_unregister(yeeloong_hwmon_dev);
+		yeeloong_hwmon_dev = NULL;
+	}
+}
+
+module_init(yeeloong_hwmon_init);
+module_exit(yeeloong_hwmon_exit);
-- 
1.6.2.1
