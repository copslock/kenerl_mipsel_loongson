Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2007 10:56:38 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:40320 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20025714AbXI3Jzt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2007 10:55:49 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l8U9tM56009421;
	Sun, 30 Sep 2007 02:55:22 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:55:21 -0700
Received: from [128.224.162.179] ([128.224.162.179]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Sep 2007 02:55:21 -0700
Message-ID: <46FF7279.3020102@windriver.com>
Date:	Sun, 30 Sep 2007 17:55:05 +0800
From:	Mark Zhan <rongkai.zhan@windriver.com>
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
MIME-Version: 1.0
To:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
CC:	ralf@linux-mips.org, a.zummo@towertech.it,
	rongkai.zhan@windriver.com
Subject: [PATCH 3/4] RTC: add Xicor 1241 driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2007 09:55:21.0604 (UTC) FILETIME=[03C83440:01C80348]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

This patch add the Xicor 1241 RTC driver which is used in
MIPS Sibyte 1250/1480 boards.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
  drivers/rtc/Kconfig         |   10 ++
  drivers/rtc/Makefile        |    2
  drivers/rtc/rtc-xicor1241.c |  184 ++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 196 insertions(+)

--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -184,6 +184,16 @@ config RTC_DRV_X1205
  	  This driver can also be built as a module. If so, the module
  	  will be called rtc-x1205.

+config RTC_DRV_XICOR1241
+	tristate "Xicor 1241"
+	depends on RTC_CLASS && I2C && MIPS
+	help
+	  If you say yes here you get support for the
+	  Xicor 1241 RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-xicor1241.
+
  config RTC_DRV_PCF8563
  	tristate "Philips PCF8563/Epson RTC8564"
  	help
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -48,3 +48,5 @@ obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
  obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
  obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
  obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
+obj-$(CONFIG_RTC_DRV_XICOR1241)	+= rtc-xicor1241.o
+
--- /dev/null
+++ b/drivers/rtc/rtc-xicor1241.c
@@ -0,0 +1,184 @@
+/*
+ * Xicor 1241 RTC driver
+ *
+ * Copyright (c) 2007 Wind River Systems, Inc.
+ *
+ * Author: Mark Zhan <rongkai.zhan@windriver.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/bcd.h>
+#include <linux/rtc.h>
+#include <linux/i2c.h>
+
+/*
+ * Register bits
+ */
+#define X1241_SR_BAT	0x80		/* currently on battery power */
+#define X1241_SR_RWEL	0x04		/* r/w latch is enabled, can write RTC */
+#define X1241_SR_WEL	0x02		/* r/w latch is unlocked, can enable r/w now */
+#define X1241_SR_RTCF	0x01		/* clock failed */
+#define X1241_HR_MIL	0x80		/* 24 hours format */
+
+/*
+ * Register Offset
+ */
+#define X1241_SEC	0x30		/* Seconds */
+#define X1241_MIN	0x31		/* Minutes */
+#define X1241_HOUR	0x32		/* Hours */
+#define X1241_MDAY	0x33		/* Day of month */
+#define X1241_MON	0x34		/* Month */
+#define X1241_YEAR	0x35		/* Year */
+#define X1241_WDAY	0x36		/* Day of Week */
+#define X1241_Y2K	0x37		/* Year 2K */
+#define X1241_SR	0x3F		/* Status register */
+
+DEFINE_SPINLOCK(xicor1241_lock);
+
+static int xicor1241_get_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned int y2k, year, mon, mday, wday, hour, min, sec;
+	unsigned long flags;
+
+	spin_lock_irqsave(&xicor1241_lock, flags);
+
+	i2c_smbus_write_byte_data(client, X1241_SEC, X1241_SEC);
+	sec = i2c_smbus_read_byte_data(client, X1241_SEC);
+	min = i2c_smbus_read_byte_data(client, X1241_MIN);
+	hour = i2c_smbus_read_byte_data(client, X1241_HOUR);
+	mday = i2c_smbus_read_byte_data(client, X1241_MDAY);
+	mon = i2c_smbus_read_byte_data(client, X1241_MON);
+	year = i2c_smbus_read_byte_data(client, X1241_YEAR);
+	wday = i2c_smbus_read_byte_data(client, X1241_WDAY);
+	y2k = i2c_smbus_read_byte_data(client, X1241_Y2K);
+
+	spin_unlock_irqrestore(&xicor1241_lock, flags);
+
+	dev_dbg(dev, "X1241 read reg: y2k=%02x,year=%02x,mon=%02x,"
+		"mday=%02x,wday=%02x,hour=%02x,min=%02x,sec=%02x\n",
+		y2k, year, mon, mday, wday, hour, min, sec);
+
+	tm->tm_sec = BCD2BIN(sec);
+	tm->tm_min = BCD2BIN(min);
+	tm->tm_hour = BCD2BIN(hour & 0x3F); /* hr is 0-23 */
+	tm->tm_mday = BCD2BIN(mday);
+	tm->tm_wday = BCD2BIN(wday);
+	tm->tm_mon = BCD2BIN(mon) - 1; /* tm_mon is 0-11 */
+	tm->tm_year = BCD2BIN(year);
+	tm->tm_year += (BCD2BIN(y2k) * 100) - 1900;
+
+	dev_dbg(dev, "RTC read time %04d-%02d-%02d %02d:%02d:%02d, y2k=%02d\n",
+		tm->tm_year + 1900, tm->tm_mon+1, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec, y2k);
+	return 0;
+}
+
+static int xicor1241_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned int y2k, year, mon, mday, wday, hour, min, sec;
+	unsigned long flags;
+
+	dev_dbg(dev, "RTC set time %04d-%02d-%02d %02d:%02d:%02d\n",
+		tm->tm_year + 1900, tm->tm_mon+1, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	sec = BIN2BCD(tm->tm_sec);
+	min = BIN2BCD(tm->tm_min);
+	hour = BIN2BCD(tm->tm_hour) | X1241_HR_MIL; /* 24 hours format */
+	mday = BIN2BCD(tm->tm_mday);
+	wday = BIN2BCD(tm->tm_wday);
+	mon = BIN2BCD(tm->tm_mon + 1); /* tm_mon is 0-11 */
+	year = BIN2BCD(tm->tm_year % 100);
+	y2k = BIN2BCD((tm->tm_year / 100) + 19);
+
+	dev_dbg(dev, "X1241 write reg: y2k=%02x,year=%02x,mon=%02x,"
+		"mday=%02x,wday=%02x,hour=%02x,min=%02x,sec=%02x\n",
+		y2k, year, mon, mday, wday, hour, min, sec);
+
+	spin_lock_irqsave(&xicor1241_lock, flags);
+
+	/* unlock writes to the CCR */
+	i2c_smbus_write_word_data(client, X1241_SR,
+			(X1241_SR_WEL << 8) | X1241_SR);
+	i2c_smbus_write_word_data(client, X1241_SR,
+			((X1241_SR_WEL | X1241_SR_RWEL) << 8) | X1241_SR);
+
+	i2c_smbus_write_word_data(client, X1241_SEC, (sec << 8) | X1241_SEC);
+	i2c_smbus_write_word_data(client, X1241_MIN, (min << 8) | X1241_MIN);
+	i2c_smbus_write_word_data(client, X1241_HOUR, (hour << 8) | X1241_HOUR);
+	i2c_smbus_write_word_data(client, X1241_MDAY, (mday << 8) | X1241_MDAY);
+	i2c_smbus_write_word_data(client, X1241_WDAY, (wday << 8) | X1241_WDAY);
+	i2c_smbus_write_word_data(client, X1241_MON, (mon << 8) | X1241_MON);
+	i2c_smbus_write_word_data(client, X1241_YEAR, (year << 8) | X1241_YEAR);
+	i2c_smbus_write_word_data(client, X1241_Y2K, (y2k << 8) | X1241_Y2K);
+
+	i2c_smbus_write_word_data(client, X1241_SR, (0 << 8) | X1241_SR);
+
+	spin_unlock_irqrestore(&xicor1241_lock, flags);
+	return 0;
+}
+
+static const struct rtc_class_ops xicor1241_rtc_ops = {
+	.read_time = xicor1241_get_time,
+	.set_time  = xicor1241_set_time,
+};
+
+static int __devinit xicor1241_rtc_probe(struct i2c_client *client)
+{
+	struct rtc_device *rtc;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
+		dev_dbg(&client->dev, "I2C adapter function check failure!\n");
+		return -ENODEV;
+	}
+
+	rtc = rtc_device_register(client->name, &client->dev,
+				  &xicor1241_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
+
+	i2c_set_clientdata(client, rtc);
+	return 0;
+}
+
+static int __devexit xicor1241_rtc_remove(struct i2c_client *client)
+{
+	struct rtc_device *rtc = i2c_get_clientdata(client);
+
+	rtc_device_unregister(rtc);
+	return 0;
+}
+
+static struct i2c_driver xicor1241_i2c_driver = {
+	.driver		= {
+		.name	= "rtc-xicor1241",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= xicor1241_rtc_probe,
+	.remove		= __devexit_p(xicor1241_rtc_remove),
+};
+
+static int __init xicor1241_rtc_init(void)
+{
+	return i2c_add_driver(&xicor1241_i2c_driver);
+}
+
+static void __exit xicor1241_rtc_exit(void)
+{
+	i2c_del_driver(&xicor1241_i2c_driver);
+}
+
+module_init(xicor1241_rtc_init);
+module_exit(xicor1241_rtc_exit);
+
+MODULE_AUTHOR("Mark Zhan <rongkai.zhan@windriver.com>");
+MODULE_DESCRIPTION("Xicor1241 RTC driver");
+MODULE_LICENSE("GPL");
