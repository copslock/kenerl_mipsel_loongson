Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 22:43:27 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:46097 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1491826AbZKXEhk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 05:37:40 +0100
Received: by pwi15 with SMTP id 15so4091581pwi.24
        for <multiple recipients>; Mon, 23 Nov 2009 20:37:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PrE9RLABIzzeOKPVswVEIfQITRNbTn1dTebPC4kuESo=;
        b=TZjupaH5KXO/EzyMWz6yUc/VlsbTcxnH4/ftH4cbI+HPb9XXRPg5ii3CTo2eluiqqZ
         +hvF9bBSmcf4INNPXyt6sF0fIP302A5+ltDvLHF1WhSj7rp9b+PFAZJAqr8Ti90TSKNT
         M2Vjg5CmZJpDtTPoQIUUIbwvZ+0WVVHWbpAP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EobHeRyjwI6LhhYWSplNg1GaczXfdsLFK77GJViF7u8vhlgEPkrYCQjf38l0cyd0pB
         C0gxqFBI8nViQC6d66bCBkxemEJmsGi3NSDzm9yZA6kDhCyPhwztMB9d8FvCkUsTvGK0
         POlFkmpTdqKNxyH9165LVcvZnZF8P74Sdsy2A=
Received: by 10.115.84.21 with SMTP id m21mr5538023wal.109.1259037450326;
        Mon, 23 Nov 2009 20:37:30 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm3433799pzk.1.2009.11.23.20.37.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 20:37:29 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v2] [loongson] LynLoong2F: Add Platform Specific Support
Date:	Tue, 24 Nov 2009 12:37:20 +0800
Message-Id: <e8e43711f6ebfc7773a3c87674844d10bb3cf1f9.1259037097.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25110
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

(This v2 revision uses a shorter CONFIG_LEMOTE_LYNLOONG2F instead of
 CONFIG_LEMOTE_LYNLOONG2F_PDEV)

LynLoong PC is an AllINONE machine made by Lemote, which is basically
compatible to FuLoong2F Mini PC, the only difference is that it has a
size-fixed screen: 1360x768 with sisfb video driver. and also, it has
its own specific suspend support(e.g. suspend/resume the display, the
external clocks.).

This patch adds the backlight subdriver and platform specific suspend
support for LynLoong(ALLINONE) PC. And also, a kernel command line
argument "video=sisfb:1360x768-16@60" is appended for the size-fixed
display.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 .../mips/include/asm/mach-loongson/cs5536/cs5536.h |   35 ++
 .../asm/mach-loongson/cs5536/cs5536_mfgpt.h        |    5 +
 arch/mips/loongson/Kconfig                         |   35 ++
 arch/mips/loongson/common/cmdline.c                |   10 +
 arch/mips/loongson/lemote-2f/Makefile              |    5 +
 arch/mips/loongson/lemote-2f/lynloong_pc.c         |  612 ++++++++++++++++++++
 6 files changed, 702 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/lemote-2f/lynloong_pc.c

diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536.h b/arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
index 021f77c..1cf86f3 100644
--- a/arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
+++ b/arch/mips/include/asm/mach-loongson/cs5536/cs5536.h
@@ -301,5 +301,40 @@ extern void _wrmsr(u32 msr, u32 hi, u32 lo);
 /* GPIO : I/O SPACE; REG : 32BITS */
 #define	GPIOL_OUT_VAL		0x00
 #define	GPIOL_OUT_EN		0x04
+#define	GPIOL_OUT_AUX1_SEL	0x10
+/* SMB : I/O SPACE, REG : 8BITS WIDTH */
+#define	SMB_SDA			0x00
+#define	SMB_STS			0x01
+#define	SMB_STS_SLVSTP		(1 << 7)
+#define	SMB_STS_SDAST		(1 << 6)
+#define	SMB_STS_BER		(1 << 5)
+#define	SMB_STS_NEGACK		(1 << 4)
+#define	SMB_STS_STASTR		(1 << 3)
+#define	SMB_STS_NMATCH		(1 << 2)
+#define	SMB_STS_MASTER		(1 << 1)
+#define	SMB_STS_XMIT		(1 << 0)
+#define	SMB_CTRL_STS		0x02
+#define	SMB_CSTS_TGSTL		(1 << 5)
+#define	SMB_CSTS_TSDA		(1 << 4)
+#define	SMB_CSTS_GCMTCH		(1 << 3)
+#define	SMB_CSTS_MATCH		(1 << 2)
+#define	SMB_CSTS_BB		(1 << 1)
+#define	SMB_CSTS_BUSY		(1 << 0)
+#define	SMB_CTRL1		0x03
+#define	SMB_CTRL1_STASTRE	(1 << 7)
+#define	SMB_CTRL1_NMINTE	(1 << 6)
+#define	SMB_CTRL1_GCMEN		(1 << 5)
+#define	SMB_CTRL1_ACK		(1 << 4)
+#define	SMB_CTRL1_RSVD		(1 << 3)
+#define	SMB_CTRL1_INTEN		(1 << 2)
+#define	SMB_CTRL1_STOP		(1 << 1)
+#define	SMB_CTRL1_START		(1 << 0)
+#define	SMB_ADDR		0x04
+#define	SMB_ADDR_SAEN		(1 << 7)
+#define	SMB_CONTROLLER_ADDR	(0xef << 0)
+#define	SMB_CTRL2		0x05
+#define	SMB_FREQ		(0x20 << 1)
+#define	SMB_ENABLE		(0x01 << 0)
+#define	SMB_CTRL3		0x06
 
 #endif				/* _CS5536_H */
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
index 4b493d6..cac04ee 100644
--- a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
+++ b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
@@ -32,4 +32,9 @@ static inline void __maybe_unused enable_mfgpt0_counter(void)
 #define MFGPT0_CNT	(MFGPT_BASE + 4)
 #define MFGPT0_SETUP	(MFGPT_BASE + 6)
 
+#define MFGPT2_CMP1	(MFGPT_BASE + 0x10)
+#define MFGPT2_CMP2	(MFGPT_BASE + 0x12)
+#define MFGPT2_CNT	(MFGPT_BASE + 0x14)
+#define MFGPT2_SETUP	(MFGPT_BASE + 0x16)
+
 #endif /*!_CS5536_MFGPT_H */
diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 7a86987..bb87f8d 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -78,3 +78,38 @@ config LOONGSON_SUSPEND
 	bool
 	default y
 	depends on CPU_SUPPORTS_CPUFREQ && SUSPEND
+
+#
+# Loongson Platform Specific Drivers
+#
+
+comment "Loongson Platform Specific Drivers"
+
+menuconfig LOONGSON_PLATFORM_DEVICES
+	bool "Loongson Platform Specific Drivers"
+	default y
+	---help---
+	  Say Y here to get to see options for device drivers for various
+	  loongson platforms, including vendor-specific laptop/pc extension drivers.
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if LOONGSON_PLATFORM_DEVICES
+
+config LEMOTE_LYNLOONG2F
+	tristate "Lemote LynLoong(ALLINONE) Platform Specific Driver"
+	depends on LEMOTE_MACH2F
+	select THERMAL
+	select BACKLIGHT_CLASS_DEVICE
+	default m
+	help
+	  LynLoong PC is an AllINONE machine made by Lemote, which is basically
+	  compatible to FuLoong2F Mini PC, the only difference is that it has a
+	  size-fixed screen: 1360x768 with sisfb video driver. and also, it has
+	  its own specific suspend support.
+
+	  This driver adds the lynloong specific backlight driver and platform
+	  driver(mainly the suspend support).
+
+endif # LOONGSON_PLATFORM_DEVICES
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
index 7ad47f2..13ce9b1 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -51,4 +51,14 @@ void __init prom_init_cmdline(void)
 		strcat(arcs_cmdline, " root=/dev/hda1");
 
 	prom_init_machtype();
+
+	/* append machine specific command line */
+	switch (mips_machtype) {
+	case MACH_LEMOTE_LL2F:
+		if ((strstr(arcs_cmdline, "video=")) == NULL)
+			strcat(arcs_cmdline, " video=sisfb:1360x768-16@60");
+		break;
+	default:
+		break;
+	}
 }
diff --git a/arch/mips/loongson/lemote-2f/Makefile b/arch/mips/loongson/lemote-2f/Makefile
index 4d84b27..c058753 100644
--- a/arch/mips/loongson/lemote-2f/Makefile
+++ b/arch/mips/loongson/lemote-2f/Makefile
@@ -9,3 +9,8 @@ obj-y += irq.o reset.o ec_kb3310b.o
 #
 
 obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
+
+#
+# Platform Drivers
+#
+obj-$(CONFIG_LEMOTE_LYNLOONG2F) += lynloong_pc.o
diff --git a/arch/mips/loongson/lemote-2f/lynloong_pc.c b/arch/mips/loongson/lemote-2f/lynloong_pc.c
new file mode 100644
index 0000000..56f431e
--- /dev/null
+++ b/arch/mips/loongson/lemote-2f/lynloong_pc.c
@@ -0,0 +1,612 @@
+/*
+ *  Driver for LynLoong pc extras
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Xiang Yu <xiangy@lemote.com>
+ *          Wu Zhangjin <wuzj@lemote.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <linux/thermal.h>
+
+#include <asm/bootinfo.h>
+
+#include <loongson.h>
+
+#include <cs5536/cs5536.h>
+#include <cs5536/cs5536_pci.h>
+#include <cs5536/cs5536_mfgpt.h>
+
+static u32 gpio_base, smb_base, mfgpt_base;
+
+/* gpio operations */
+static void set_gpio_reg_high(int gpio, int reg)
+{
+	u32 val;
+
+	val = inl(gpio_base + reg);
+	val |= (1 << gpio);
+	val &= ~(1 << (16 + gpio));
+	outl(val, gpio_base + reg);
+	mmiowb();
+}
+
+static void set_gpio_reg_low(int gpio, int reg)
+{
+	u32 val;
+
+	val = inl(gpio_base + reg);
+	val |= (1 << (16 + gpio));
+	val &= ~(1 << gpio);
+	outl(val, gpio_base + reg);
+	mmiowb();
+}
+
+static void set_gpio_output_low(int gpio)
+{
+	set_gpio_reg_high(gpio, GPIOL_OUT_EN);
+	set_gpio_reg_low(gpio, GPIOL_OUT_VAL);
+}
+
+static void set_gpio_output_high(int gpio)
+{
+	set_gpio_reg_high(gpio, GPIOL_OUT_EN);
+	set_gpio_reg_high(gpio, GPIOL_OUT_VAL);
+}
+
+/* backlight subdriver */
+
+#define MAX_BRIGHTNESS 100
+#define DEFAULT_BRIGHTNESS 50
+#define MIN_BRIGHTNESS 0
+static uint level;
+
+/* tune the brightness */
+static void setup_mfgpt2(void)
+{
+	/* set MFGPT2 comparator 1,2 */
+	outw(MAX_BRIGHTNESS-level, MFGPT2_CMP1);
+	outw(MAX_BRIGHTNESS, MFGPT2_CMP2);
+	/* clear MFGPT2 UP COUNTER */
+	outw(0, MFGPT2_CNT);
+	/* enable counter, compare mode, 32k */
+	outw(0x8280, MFGPT2_SETUP);
+}
+
+static int lynloong_set_brightness(struct backlight_device *bd)
+{
+	uint i;
+
+	level = (bd->props.fb_blank == FB_BLANK_UNBLANK &&
+		 bd->props.power == FB_BLANK_UNBLANK) ?
+	    bd->props.brightness : 0;
+
+	if (level > MAX_BRIGHTNESS)
+		level = MAX_BRIGHTNESS;
+	else if (level < MIN_BRIGHTNESS)
+		level = MIN_BRIGHTNESS;
+
+	if (level == 0) {
+		/* turn off the backlight */
+		set_gpio_output_low(11);
+		for (i = 0; i < 0x500; i++)
+			delay();
+		/* turn off the LCD */
+		set_gpio_output_high(8);
+	} else {
+		/* turn on the LCD */
+		set_gpio_output_low(8);
+		for (i = 0; i < 0x500; i++)
+			delay();
+		/* turn on the backlight */
+		set_gpio_output_high(11);
+	}
+
+	setup_mfgpt2();
+
+	return 0;
+}
+
+static int lynloong_get_brightness(struct backlight_device *bd)
+{
+	return level;
+}
+
+static struct backlight_ops backlight_ops = {
+	.get_brightness = lynloong_get_brightness,
+	.update_status = lynloong_set_brightness,
+};
+
+static struct backlight_device *lynloong_backlight_dev;
+
+static void lynloong_backlight_exit(void)
+{
+	if (lynloong_backlight_dev) {
+		backlight_device_unregister(lynloong_backlight_dev);
+		lynloong_backlight_dev = NULL;
+	}
+	/* disable brightness controlling */
+	set_gpio_output_low(7);
+
+	printk(KERN_INFO "exit from LingLoong Backlight Driver");
+}
+
+static int __init lynloong_backlight_init(struct device *dev)
+{
+	int ret;
+
+	/* select for mfgpt */
+	set_gpio_reg_high(7, GPIOL_OUT_AUX1_SEL);
+	/* enable brightness controlling */
+	set_gpio_output_high(7);
+
+	lynloong_backlight_dev =
+	    backlight_device_register("backlight0", dev, NULL,
+				      &backlight_ops);
+
+	if (IS_ERR(lynloong_backlight_dev)) {
+		ret = PTR_ERR(lynloong_backlight_dev);
+		return ret;
+	}
+
+	lynloong_backlight_dev->props.max_brightness = MAX_BRIGHTNESS;
+	lynloong_backlight_dev->props.brightness = DEFAULT_BRIGHTNESS;
+	backlight_update_status(lynloong_backlight_dev);
+
+	return 0;
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
+	*state = lynloong_get_brightness(bd);
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
+	lynloong_backlight_dev->props.brightness = state;
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
+static struct thermal_cooling_device *lynloong_thermal_cdev;
+
+/* TODO: register cpu as the cooling device */
+static int lynloong_thermal_init(struct device *dev)
+{
+	int ret;
+
+	if (!dev)
+		return -1;
+
+	lynloong_thermal_cdev = thermal_cooling_device_register("LCD", dev,
+			&video_cooling_ops);
+
+	if (IS_ERR(lynloong_thermal_cdev)) {
+		ret = PTR_ERR(lynloong_thermal_cdev);
+		return ret;
+	}
+
+	ret = sysfs_create_link(&dev->kobj,
+				&lynloong_thermal_cdev->device.kobj,
+				"thermal_cooling");
+	if (ret) {
+		printk(KERN_ERR "Create sysfs link\n");
+		return ret;
+	}
+	ret = sysfs_create_link(&lynloong_thermal_cdev->device.kobj,
+				&dev->kobj, "device");
+	if (ret) {
+		printk(KERN_ERR "Create sysfs link\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void lynloong_thermal_exit(struct device *dev)
+{
+	if (lynloong_thermal_cdev) {
+		if (dev)
+			sysfs_remove_link(&dev->kobj, "thermal_cooling");
+		sysfs_remove_link(&lynloong_thermal_cdev->device.kobj,
+				  "device");
+		thermal_cooling_device_unregister(lynloong_thermal_cdev);
+		lynloong_thermal_cdev = NULL;
+	}
+}
+
+/* platform subdriver */
+
+/* I2C operations */
+
+static int i2c_wait(void)
+{
+	char c;
+	int i;
+
+	udelay(1000);
+	for (i = 0; i < 20; i++) {
+		c = inb(smb_base | SMB_STS);
+		if (c & (SMB_STS_BER | SMB_STS_NEGACK))
+			return -1;
+		if (c & SMB_STS_SDAST)
+			return 0;
+		udelay(100);
+	}
+	return -2;
+}
+
+static void i2c_read_single(int addr, int regNo, char *value)
+{
+	unsigned char c;
+
+	/* Start condition */
+	c = inb(smb_base | SMB_CTRL1);
+	outb(c | SMB_CTRL1_START, smb_base | SMB_CTRL1);
+	i2c_wait();
+
+	/* Send slave address */
+	outb(addr & 0xfe, smb_base | SMB_SDA);
+	i2c_wait();
+
+	/* Acknowledge smbus */
+	c = inb(smb_base | SMB_CTRL1);
+	outb(c | SMB_CTRL1_ACK, smb_base | SMB_CTRL1);
+
+	/* Send register index */
+	outb(regNo, smb_base | SMB_SDA);
+	i2c_wait();
+
+	/* Acknowledge smbus */
+	c = inb(smb_base | SMB_CTRL1);
+	outb(c | SMB_CTRL1_ACK, smb_base | SMB_CTRL1);
+
+	/* Start condition again */
+	c = inb(smb_base | SMB_CTRL1);
+	outb(c | SMB_CTRL1_START, smb_base | SMB_CTRL1);
+	i2c_wait();
+
+	/* Send salve address again */
+	outb(1 | addr, smb_base | SMB_SDA);
+	i2c_wait();
+
+	/* Acknowledge smbus */
+	c = inb(smb_base | SMB_CTRL1);
+	outb(c | SMB_CTRL1_ACK, smb_base | SMB_CTRL1);
+
+	/* Read data */
+	*value = inb(smb_base | SMB_SDA);
+
+	/* Stop condition */
+	outb(SMB_CTRL1_STOP, smb_base | SMB_CTRL1);
+	i2c_wait();
+}
+
+static void i2c_write_single(int addr, int regNo, char value)
+{
+	unsigned char c;
+
+	/* Start condition */
+	c = inb(smb_base | SMB_CTRL1);
+	outb(c | SMB_CTRL1_START, smb_base | SMB_CTRL1);
+	i2c_wait();
+	/* Send slave address */
+	outb(addr & 0xfe, smb_base | SMB_SDA);
+	i2c_wait();;
+
+	/* Send register index */
+	outb(regNo, smb_base | SMB_SDA);
+	i2c_wait();
+
+	/* Write data */
+	outb(value, smb_base | SMB_SDA);
+	i2c_wait();
+	/* Stop condition */
+	outb(SMB_CTRL1_STOP, smb_base | SMB_CTRL1);
+	i2c_wait();
+}
+
+static void stop_clock(int clk_reg, int clk_sel)
+{
+	u8 value;
+
+	i2c_read_single(0xd3, clk_reg, &value);
+	value &= ~(1 << clk_sel);
+	i2c_write_single(0xd2, clk_reg, value);
+}
+
+static void enable_clock(int clk_reg, int clk_sel)
+{
+	u8 value;
+
+	i2c_read_single(0xd3, clk_reg, &value);
+	value |= (1 << clk_sel);
+	i2c_write_single(0xd2, clk_reg, value);
+}
+
+static char cached_clk_freq;
+static char cached_pci_fixed_freq;
+
+static void decrease_clk_freq(void)
+{
+	char value;
+
+	i2c_read_single(0xd3, 1, &value);
+	cached_clk_freq = value;
+
+	/* select frequency by software */
+	value |= (1 << 1);
+	/* CPU, 3V66, PCI : 100, 66, 33(1) */
+	value |= (1 << 2);
+	i2c_write_single(0xd2, 1, value);
+
+	/* cache the pci frequency */
+	i2c_read_single(0xd3, 14, &value);
+	cached_pci_fixed_freq = value;
+
+	/* enable PCI fix mode */
+	value |= (1 << 5);
+	/* 3V66, PCI : 64MHz, 32MHz */
+	value |= (1 << 3);
+	i2c_write_single(0xd2, 14, value);
+
+}
+
+static void resume_clk_freq(void)
+{
+	i2c_write_single(0xd2, 1, cached_clk_freq);
+	i2c_write_single(0xd2, 14, cached_pci_fixed_freq);
+}
+
+static void stop_clocks(void)
+{
+	/* CPU Clock Register */
+	stop_clock(2, 5);	/* not used */
+	stop_clock(2, 6);	/* not used */
+	stop_clock(2, 7);	/* not used */
+
+	/* PCI Clock Register */
+	stop_clock(3, 1);	/* 8100 */
+	stop_clock(3, 5);	/* SIS */
+	stop_clock(3, 0);	/* not used */
+	stop_clock(3, 6);	/* not used */
+
+	/* PCI 48M Clock Register */
+	stop_clock(4, 6);	/* USB grounding */
+	stop_clock(4, 5);	/* REF(5536_14M) */
+
+	/* 3V66 Control Register */
+	stop_clock(5, 0);	/* VCH_CLK..., grounding */
+}
+static void enable_clocks(void)
+{
+	enable_clock(3, 1);	/* 8100 */
+	enable_clock(3, 5);	/* SIS */
+
+	enable_clock(4, 6);
+	enable_clock(4, 5);	/* REF(5536_14M) */
+
+	enable_clock(5, 0);	/* VCH_CLOCK, grounding */
+}
+
+static struct platform_device *lynloong_pdev;
+
+static int __maybe_unused lynloong_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	int i;
+
+	printk(KERN_INFO "lynloong specific suspend\n");
+
+	/* disable AMP */
+	set_gpio_output_high(6);
+	/* disable the brightness control */
+	set_gpio_output_low(7);
+	/* disable the backlight output */
+	set_gpio_output_low(11);
+
+	/* stop the clocks of some devices */
+	stop_clocks();
+
+	/* decrease the external clock frequency */
+	decrease_clk_freq();
+
+	/* turn off the LCD */
+	for (i = 0; i < 0x600; i++)
+		delay();
+	set_gpio_output_high(8);
+
+	return 0;
+}
+
+static int __maybe_unused lynloong_resume(struct platform_device *pdev)
+{
+	int i;
+
+	printk(KERN_INFO "lynloong specific resume\n");
+
+	/* turn on the LCD */
+	set_gpio_output_low(8);
+	for (i = 0; i < 0x1000; i++)
+		delay();
+
+	/* resume clock frequency, enable the relative clocks */
+	resume_clk_freq();
+	enable_clocks();
+
+	/* enable the backlight output */
+	set_gpio_output_high(11);
+	/* enable the brightness control */
+	set_gpio_output_high(7);
+	/* enable AMP */
+	set_gpio_output_low(6);
+
+	return 0;
+}
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		   .name = "lynloong-pc",
+		   .owner = THIS_MODULE,
+		   },
+#ifdef CONFIG_PM
+	.suspend = lynloong_suspend,
+	.resume = lynloong_resume,
+#endif
+};
+
+static ssize_t lynloong_pdev_name_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "lynloong pc\n");
+}
+
+static struct device_attribute dev_attr_lynloong_pdev_name =
+__ATTR(name, S_IRUGO, lynloong_pdev_name_show, NULL);
+
+static int lynloong_pdev_init(void)
+{
+	int ret;
+
+	/* Register platform stuff */
+	ret = platform_driver_register(&platform_driver);
+	if (ret)
+		return ret;
+
+	lynloong_pdev = platform_device_alloc("lynloong-laptop", -1);
+	if (!lynloong_pdev) {
+		ret = -ENOMEM;
+		platform_driver_unregister(&platform_driver);
+		return ret;
+	}
+
+	ret = platform_device_add(lynloong_pdev);
+	if (ret) {
+		platform_device_put(lynloong_pdev);
+		return ret;
+	}
+
+	if (IS_ERR(lynloong_pdev)) {
+		ret = PTR_ERR(lynloong_pdev);
+		lynloong_pdev = NULL;
+		printk(KERN_INFO "unable to register platform device\n");
+		return ret;
+	}
+
+	ret = device_create_file(&lynloong_pdev->dev,
+				 &dev_attr_lynloong_pdev_name);
+	if (ret) {
+		printk(KERN_INFO "unable to create sysfs device attributes\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void lynloong_pdev_exit(void)
+{
+	if (lynloong_pdev) {
+		platform_device_unregister(lynloong_pdev);
+		lynloong_pdev = NULL;
+		platform_driver_unregister(&platform_driver);
+	}
+}
+
+static int __init lynloong_init(void)
+{
+	int ret;
+	u32 hi;
+
+	if (mips_machtype != MACH_LEMOTE_LL2F) {
+		printk(KERN_INFO "This Driver is for LynLoong(Allinone) PC, You"
+				" can not use it on the other Machines\n");
+		return -EFAULT;
+	}
+
+	printk(KERN_INFO "Load LynLoong Platform Driver\n");
+
+	/* get mfgpt_base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_MFGPT), &hi, &mfgpt_base);
+	/* get gpio_base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &gpio_base);
+	/* get smb base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_SMB), &hi, &smb_base);
+
+	ret = lynloong_pdev_init();
+	if (ret) {
+		lynloong_pdev_exit();
+		printk(KERN_INFO "init lynloong platform driver failure\n");
+		return ret;
+	}
+
+	ret = lynloong_backlight_init(&lynloong_pdev->dev);
+	if (ret) {
+		lynloong_backlight_exit();
+		printk(KERN_INFO "init lynloong backlight driver failure\n");
+		return ret;
+	}
+	ret = lynloong_thermal_init(&lynloong_backlight_dev->dev);
+	if (ret) {
+		lynloong_thermal_exit(&lynloong_backlight_dev->dev);
+		printk(KERN_INFO
+		       "init lynloong thermal cooling device failure\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit lynloong_exit(void)
+{
+	lynloong_pdev_exit();
+	lynloong_thermal_exit(&lynloong_backlight_dev->dev);
+	lynloong_backlight_exit();
+
+	printk(KERN_INFO "Unload LynLoong Platform Driver\n");
+}
+
+module_init(lynloong_init);
+module_exit(lynloong_exit);
+
+MODULE_AUTHOR("Xiang Yu <xiangy@lemote.com>; Wu Zhangjin <wuzj@lemote.com>");
+MODULE_DESCRIPTION("LynLoong Platform Specific Driver");
+MODULE_LICENSE("GPL");
-- 
1.6.2.1
