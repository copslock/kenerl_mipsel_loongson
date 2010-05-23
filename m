Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 15:59:44 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:53436 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491896Ab0EWN6m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 15:58:42 +0200
Received: by mail-px0-f177.google.com with SMTP id 1so1165383pxi.36
        for <multiple recipients>; Sun, 23 May 2010 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=EBTRW5rPBXn+0pq7uWLnOFYfGGeLU30R5a5jFT9JinE=;
        b=WHAY7ORYlsh+CrH89SINYdCvNhUoN5DwXYUI6MU8K9mE/Lll3np+ANceH0qrzyM/XG
         6D/roJjdJVmDhWhjxEXwbzCltKpuol3ePN1c1MAaQmcdUrNfELsn0akiuH+lrz2bZ144
         9AQ1XrRMGrSHHRNfH96xgIyKoYnD/F8Z4uBvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PgpNR2w+rzI3cLjRkHnjE5HGrYetTYxhLQ+sJlF3bo6z8u3A1/nnReunNSgAM7FDzh
         KOswEEWO+z0LOOvdPZYfz8raVtP5mOYiZa/+7vH64PHTabs2Eyyl+hXrGgahf89MDQHv
         xpmuwgbxd19Nd5wCcE1Yy/MHwMQ3I+VfWKWt4=
Received: by 10.142.60.14 with SMTP id i14mr2696095wfa.196.1274623121227;
        Sun, 23 May 2010 06:58:41 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id r20sm29067398wam.17.2010.05.23.06.58.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 06:58:40 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 4/9] Loongson: YeeLoong: add hardware monitoring driver
Date:   Sun, 23 May 2010 21:57:59 +0800
Message-Id: <44fb570537bbc375925c88c17ea16e8aa7bcc47c.1274622624.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1274622624.git.wuzhangjin@gmail.com>
References: <cover.1274622624.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Changes from v11 5/8:

	o add a get_bat_info() macro to cleanup the battery related
	operation.

Changes from v10 5/8:

	o ensure the whole fan related source code follow the hwmon
	interfaces.

Changes from v9 5/8:

	o ensure the fan controlling interface is compatible with the
	one described in Documentation/hwmon/sysfs-interface

----------------

This patch adds hardware monitoring driver, it provides standard
interface(/sys/class/hwmon/) for lm-sensors/sensors-applet to monitor
the temperatures of CPU and battery, the PWM of fan, the current,
voltage of battery.

Please refer to Documentation/hwmon/userspace-tools and
Documentation/hwmon/sysfs-interface to get more information about the
hwmon.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/platform/mips/Kconfig           |    1 +
 drivers/platform/mips/yeeloong_laptop.c |  253 ++++++++++++++++++++++++++++++-
 2 files changed, 250 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index c1ba03d..d4ce744 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -18,6 +18,7 @@ config LEMOTE_YEELOONG2F
 	tristate "Lemote YeeLoong Laptop"
 	depends on LEMOTE_MACH2F
 	select BACKLIGHT_CLASS_DEVICE
+	select HWMON
 	help
 	  YeeLoong netbook is a mini laptop made by Lemote, which is basically
 	  compatible to FuLoong2F mini PC, but it has an extra Embedded
diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/mips/yeeloong_laptop.c
index 0ec8c03..a422acb 100644
--- a/drivers/platform/mips/yeeloong_laptop.c
+++ b/drivers/platform/mips/yeeloong_laptop.c
@@ -12,6 +12,8 @@
 #include <linux/platform_device.h>
 #include <linux/backlight.h>	/* for backlight subdriver */
 #include <linux/fb.h>
+#include <linux/hwmon.h>	/* for hwmon subdriver */
+#include <linux/hwmon-sysfs.h>
 
 #include <ec_kb3310b.h>
 
@@ -27,10 +29,7 @@ static int yeeloong_set_brightness(struct backlight_device *bd)
 		 bd->props.power == FB_BLANK_UNBLANK) ?
 	    bd->props.brightness : 0;
 
-	if (level > MAX_BRIGHTNESS)
-		level = MAX_BRIGHTNESS;
-	else if (level < 0)
-		level = 0;
+	level = SENSORS_LIMIT(level, 0, MAX_BRIGHTNESS);
 
 	/* Avoid to modify the brightness when EC is tuning it */
 	if (old_level != level) {
@@ -86,6 +85,244 @@ static void yeeloong_backlight_exit(void)
 	}
 }
 
+/* hwmon subdriver */
+
+#define MIN_FAN_SPEED 0
+#define MAX_FAN_SPEED 3
+
+static int get_fan_pwm_enable(void)
+{
+	int level, mode;
+
+	level = ec_read(REG_FAN_SPEED_LEVEL);
+	mode = ec_read(REG_FAN_AUTO_MAN_SWITCH);
+
+	if (level == MAX_FAN_SPEED && mode == BIT_FAN_MANUAL)
+		mode = 0;
+	else if (mode == BIT_FAN_MANUAL)
+		mode = 1;
+	else
+		mode = 2;
+
+	return mode;
+}
+
+static void set_fan_pwm_enable(int mode)
+{
+	switch (mode) {
+	case 0:
+		/* fullspeed */
+		ec_write(REG_FAN_AUTO_MAN_SWITCH, BIT_FAN_MANUAL);
+		ec_write(REG_FAN_SPEED_LEVEL, MAX_FAN_SPEED);
+		break;
+	case 1:
+		ec_write(REG_FAN_AUTO_MAN_SWITCH, BIT_FAN_MANUAL);
+		break;
+	case 2:
+		ec_write(REG_FAN_AUTO_MAN_SWITCH, BIT_FAN_AUTO);
+		break;
+	default:
+		break;
+	}
+}
+
+static int get_fan_pwm(void)
+{
+	return ec_read(REG_FAN_SPEED_LEVEL);
+}
+
+static void set_fan_pwm(int value)
+{
+	int mode;
+
+	mode = ec_read(REG_FAN_AUTO_MAN_SWITCH);
+	if (mode != BIT_FAN_MANUAL)
+		return;
+
+	value = SENSORS_LIMIT(value, 0, 3);
+
+	/* We must ensure the fan is on */
+	if (value > 0)
+		ec_write(REG_FAN_CONTROL, BIT_FAN_CONTROL_ON);
+
+	ec_write(REG_FAN_SPEED_LEVEL, value);
+}
+
+static int get_fan_rpm(void)
+{
+	int value;
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
+	s8 value;
+
+	value = ec_read(REG_TEMPERATURE_VALUE);
+
+	return value * 1000;
+}
+
+static int get_cpu_temp_max(void)
+{
+	return 60 * 1000;
+}
+
+#define get_bat_info(type) \
+	((ec_read(REG_BAT_##type##_HIGH) << 8) | \
+	 (ec_read(REG_BAT_##type##_LOW)))
+
+static int get_battery_temp(void)
+{
+	int value;
+
+	value = get_bat_info(TEMPERATURE);
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
+	s16 value;
+
+	value = get_bat_info(CURRENT);
+
+	return -value;
+}
+
+static int get_battery_voltage(void)
+{
+	int value;
+
+	value = get_bat_info(VOLTAGE);
+
+	return value;
+}
+
+static ssize_t store_sys_hwmon(void (*set) (int), const char *buf, size_t count)
+{
+	int ret;
+	unsigned long value;
+
+	if (!count)
+		return 0;
+
+	ret = strict_strtoul(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	set(value);
+
+	return count;
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
+CREATE_SENSOR_ATTR(temp1_max, S_IRUGO, get_cpu_temp_max, NULL);
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
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
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
+static struct device *yeeloong_hwmon_dev;
+
+static int yeeloong_hwmon_init(void)
+{
+	int ret;
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
+		hwmon_device_unregister(yeeloong_hwmon_dev);
+		yeeloong_hwmon_dev = NULL;
+		return ret;
+	}
+	/* ensure fan is set to auto mode */
+	set_fan_pwm_enable(2);
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
 static struct platform_device_id platform_device_ids[] = {
 	{
 		.name = "yeeloong_laptop",
@@ -123,11 +360,19 @@ static int __init yeeloong_init(void)
 		return ret;
 	}
 
+	ret = yeeloong_hwmon_init();
+	if (ret) {
+		pr_err("Fail to register yeeloong hwmon driver.\n");
+		yeeloong_hwmon_exit();
+		return ret;
+	}
+
 	return 0;
 }
 
 static void __exit yeeloong_exit(void)
 {
+	yeeloong_hwmon_exit();
 	yeeloong_backlight_exit();
 	platform_driver_unregister(&platform_driver);
 
-- 
1.7.0.4
