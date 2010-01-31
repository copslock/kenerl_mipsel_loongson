Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2010 13:24:31 +0100 (CET)
Received: from mail-px0-f181.google.com ([209.85.216.181]:42449 "EHLO
        mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492318Ab0AaMW2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Jan 2010 13:22:28 +0100
Received: by pxi11 with SMTP id 11so3141235pxi.22
        for <multiple recipients>; Sun, 31 Jan 2010 04:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=TbRzJXX6ngk5JuV0zPQbNy6MOE4oF1qu7DUCuDegpNs=;
        b=FOZrkZOoiGpMeiIIh3brdAhkc2Z1HVn9wITt9mYNoznvgP+bCIG5m0agudyFyT5sz1
         o9KXON6Ok09tLDjNj3pCbgddt/yBOSs47GmThO5ByGyYVqeBrQ8ty76zXZywsdbr4J3F
         VQ0VgoQxlbOyoh/CvywlnZaiKzwOtSYye1rNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oV84/nd4nqy4CKM3tOVuMG0ZS9h6KLF7t+PRv4dRTNXdGw564RI8QMUybkpAux7qEc
         NjMowPJhC2bf4qeCLNsj5ZHCqI7wuwmZ0C2ib4/mjRjd6UfImEBf+jZ6FOXKF9iVBP3O
         3rlvte/iRrVK1srMSkoEUgXIsKykZyCq/X4KA=
Received: by 10.142.4.11 with SMTP id 11mr2166049wfd.128.1264940541513;
        Sun, 31 Jan 2010 04:22:21 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm3552209pzk.3.2010.01.31.04.22.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 04:22:20 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: [PATCH v11 4/9] Loongson: YeeLoong: add hardware monitoring driver
Date:   Sun, 31 Jan 2010 20:15:50 +0800
Message-Id: <d83f0e8948c0552fe26998537d984bf47ef691ae.1264940063.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <edfa13e4c6c10f97ba984f0fa5b65404a9468cec.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
 <b25d80b0d15f92b93fa3cb70c97c39cfb0d79c16.1264940063.git.wuzhangjin@gmail.com>
 <b1305e7c601d017d8c612c985cc20bb1003620f4.1264940063.git.wuzhangjin@gmail.com>
 <edfa13e4c6c10f97ba984f0fa5b65404a9468cec.1264940063.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1264940063.git.wuzhangjin@gmail.com>
References: <cover.1264940063.git.wuzhangjin@gmail.com>
X-archive-position: 25782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19721

From: Wu Zhangjin <wuzhangjin@gmail.com>

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

Acked-by: Pavel Machek <pavel@ucw.cz>
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
index 31fbb49..7182580 100644
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
@@ -84,6 +83,244 @@ static void yeeloong_backlight_exit(void)
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
@@ -121,11 +358,19 @@ static int __init yeeloong_init(void)
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
1.6.6
