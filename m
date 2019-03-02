Return-Path: <SRS0=FRkd=RF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108DAC43381
	for <linux-mips@archiver.kernel.org>; Sat,  2 Mar 2019 17:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7BA20836
	for <linux-mips@archiver.kernel.org>; Sat,  2 Mar 2019 17:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="BjrPkovS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCBRx4 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:53:56 -0500
Received: from tomli.me ([153.92.126.73]:41934 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCBRx4 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 2 Mar 2019 12:53:56 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 702567f7;
        Sat, 2 Mar 2019 17:53:52 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Mar 2019 17:53:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=J6V4n30ik1qFFd537+HSiEbQq8hGrx9yN5cKpzPfhJ8=; b=BjrPkovSe47kpINj7K3yhtT1zKHBoFKuKC0ZiE9c6TBPPlFUs3hJe0zUUdSRohZ2hH+N61XVN+LLkusrLFs9xH/s66XzopqXuMlm+MlaUVGcBMTStT9V0aiRsly82Nl6WHKpRx35Ik9Z5D0YyEn3t3XCl6BNqze+O9fNN9kvyJJ3Xig7v8ZW9U1yntVlJl25EMZnM+mKQckcL2o25wZJFJ559QSSZ3eEv7vxgBBP+7bmbF40z3oesyXGlP5kZ83vMjLpav3XrFszFLwRAqyBge1WOLMGeUUic4y/3Vh52Z6gxKCbVaVAl/XvhVF+VE0JXmHdwlFjP4Zlz0lAvtD0NQ==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mfd: yeeloong_kb3310b: support KB3310B EC for Lemote Yeeloong laptops.
Date:   Sun,  3 Mar 2019 01:53:28 +0800
Message-Id: <20190302175334.5103-2-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190302175334.5103-1-tomli@tomli.me>
References: <20190302175334.5103-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Lemote Yeeloong is a laptop powered by Loongson 2F MIPS processor,
primarily a demo platform for hobbyists and developers. It uses an
ENE KB3310B Embedded Controller with customized firmware to implement
hardware and power management.

A monolithic platform driver code for those functionality has existed
out-of-tree for many years. This commit creates a MFD driver for the EC
chip on Yeeloong laptop to isolate EC-related code from core MIPS code,
and serves as the foundation of various subdrivers.

My original attempt was to create a regmap for subdrivers to access the
EC, unfortunately, the board files in Linux/MIPS still needs to access
the EC directly for power management. Unless we find a better home for
those code, we simply export the EC-related functions.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 MAINTAINERS                          |   7 +
 drivers/mfd/Kconfig                  |  10 ++
 drivers/mfd/Makefile                 |   1 +
 drivers/mfd/yeeloong_kb3310b.c       | 206 ++++++++++++++++++++++++++
 include/linux/mfd/yeeloong_kb3310b.h | 211 +++++++++++++++++++++++++++
 5 files changed, 435 insertions(+)
 create mode 100644 drivers/mfd/yeeloong_kb3310b.c
 create mode 100644 include/linux/mfd/yeeloong_kb3310b.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..208f19801a23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16839,6 +16839,13 @@ S:	Maintained
 F:	Documentation/input/devices/yealink.rst
 F:	drivers/input/misc/yealink.*
 
+YEELOONG ENE KB3310B MFD DRIVER
+M:	Tom Li <tomli@tomli.me>
+L:	linux-mips@vger.kernel.org
+S:	Maintained
+F:	drivers/mfd/yeeloong_kb3310b.c
+F:	include/linux/mfd/yeeloong_kb3310b.h
+
 Z8530 DRIVER FOR AX.25
 M:	Joerg Reuter <jreuter@yaina.de>
 W:	http://yaina.de/jreuter/
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..a6da8cce72fc 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1872,6 +1872,16 @@ config MFD_STM32_TIMERS
 	  for PWM and IIO Timer. This driver allow to share the
 	  registers between the others drivers.
 
+config MFD_YEELOONG_KB3310B
+	bool "ENE KB3310B Embedded Controller on Lemote Yeeloong laptops"
+	depends on (MIPS && LEMOTE_MACH2F) || COMPILE_TEST
+	select MFD_CORE
+	help
+          Select this option to enable ENE KB3310B Embedded Controller
+          driver used on Lemote Yeeloong laptops, providing power, battery
+          and backlight services. This is a mandatory dependency for
+          Lemote 2F systems.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 12980a4ad460..a3446ce7c384 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -224,6 +224,7 @@ obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
 obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
+obj-$(CONFIG_MFD_YEELOONG_KB3310B) += yeeloong_kb3310b.o
 
 intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
diff --git a/drivers/mfd/yeeloong_kb3310b.c b/drivers/mfd/yeeloong_kb3310b.c
new file mode 100644
index 000000000000..9607b6069e13
--- /dev/null
+++ b/drivers/mfd/yeeloong_kb3310b.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * MFD driver for ENE KB3310B embedded controller on Lemote Yeeloong laptops
+ *
+ * Copyright (C) 2008 Lemote Inc.
+ * Author: liujl <liujl@lemote.com>, 2008-04-20
+ *
+ * Copyright (C) 2018 Yifeng Li
+ * Author: Yifeng Li <tomli@tomli.me>
+ *
+ * This is a MFD driver for the ENE KB3310B Embedded Controller for Lemote
+ * Yeeloong laptops to provide utility functions to access the chip from
+ * subdrivers, and handle events and interrupts in board files. This is a
+ * special-purpose driver, and it's only used on Lemote Yeeloong laptops,
+ * and is a mandatory dependency.
+ *
+ * My original attempt was to create a regmap for subdrivers to access the
+ * EC, unfortunately, the board files in Linux/MIPS still needs to access
+ * the EC directly for power management. Unless we find a better home for
+ * those code, we simply export the EC-related functions.
+ */
+
+#include <linux/export.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+#include <linux/delay.h>
+
+#include <linux/mfd/yeeloong_kb3310b.h>
+
+#define DRV_NAME "yeeloong_kb3310b: "
+
+/*****************************************************************************
+ * Most drivers, such as battery or backlight drivers, uses the I/O ports to
+ * access the Index Registers to obtain hardware status and information from
+ * EC chip.
+ ****************************************************************************/
+static struct kb3310b_chip *kb3310b_fwinfo;
+
+static const struct mfd_cell kb3310b_cells[] = {
+	{
+		.name = "yeeloong_sci"
+	},
+	{
+		.name = "yeeloong_hwmon"
+	},
+	{
+		.name = "yeeloong_battery"
+	},
+	{
+		.name = "yeeloong_backlight"
+	},
+	{
+		.name = "yeeloong_lcd"
+	},
+	{
+		.name = "yeeloong_hotkey"
+	},
+};
+
+static DEFINE_SPINLOCK(kb3310b_index_lock);
+
+u8 kb3310b_read(u16 reg)
+{
+	unsigned long flags;
+	u8 val;
+
+	spin_lock_irqsave(&kb3310b_index_lock, flags);
+
+	outb((reg & 0xff00) >> 8, KB3310B_IO_PORT_HIGH);
+	outb((reg & 0x00ff), KB3310B_IO_PORT_LOW);
+	val = inb(KB3310B_IO_PORT_DATA);
+
+	spin_unlock_irqrestore(&kb3310b_index_lock, flags);
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(kb3310b_read);
+
+void kb3310b_write(u16 reg, u8 val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&kb3310b_index_lock, flags);
+
+	outb((reg & 0xff00) >> 8, KB3310B_IO_PORT_HIGH);
+	outb((reg & 0x00ff), KB3310B_IO_PORT_LOW);
+	outb(val, KB3310B_IO_PORT_DATA);
+	inb(KB3310B_IO_PORT_DATA);  /* flush pending writes */
+
+	spin_unlock_irqrestore(&kb3310b_index_lock, flags);
+}
+EXPORT_SYMBOL_GPL(kb3310b_write);
+
+bool kb3310b_fw_earlier(char *version)
+{
+	return (strncasecmp(kb3310b_fwinfo->version,
+				version, KB3310B_VERSION_LEN) < 0);
+}
+EXPORT_SYMBOL_GPL(kb3310b_fw_earlier);
+
+static int kb3310b_probe(struct platform_device *pdev)
+{
+	kb3310b_fwinfo = dev_get_platdata(&pdev->dev);
+	pr_info(DRV_NAME "firmware version %s", kb3310b_fwinfo->version);
+
+	return devm_mfd_add_devices(&pdev->dev, -1, kb3310b_cells,
+				    ARRAY_SIZE(kb3310b_cells), NULL, 0, NULL);
+}
+
+static struct platform_driver kb3310b_driver = {
+	.driver = {
+		   .name = "yeeloong_kb3310b",
+	},
+	.probe = kb3310b_probe,
+};
+builtin_platform_driver(kb3310b_driver);
+
+/*****************************************************************************
+ * For interrupt handling and power management, the EC chip is also needed to
+ * be queried from the board file at arch/mips/loongson64, through a separate
+ * command port.
+ *****************************************************************************/
+
+static DEFINE_SPINLOCK(kb3310b_command_lock);
+
+/*
+ * This function is used for EC command writes and corresponding status queries.
+ */
+int kb3310b_query_seq(unsigned char cmd)
+{
+	int timeout;
+	unsigned char status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&kb3310b_command_lock, flags);
+
+	/* make chip goto reset mode */
+	udelay(KB3310B_REG_UDELAY);
+	outb(cmd, KB3310B_CMD_PORT);
+	udelay(KB3310B_REG_UDELAY);
+
+	/* check if the command is received by EC */
+	timeout = KB3310B_CMD_TIMEOUT;
+	status = inb(KB3310B_STS_PORT);
+	while (timeout-- && (status & (1 << 1))) {
+		status = inb(KB3310B_STS_PORT);
+		udelay(KB3310B_REG_UDELAY);
+	}
+
+	spin_unlock_irqrestore(&kb3310b_command_lock, flags);
+
+	if (timeout <= 0) {
+		pr_err(DRV_NAME
+			"(%x/NA) failed to issue command %d, no response!\n",
+			timeout, cmd);
+		return -EINVAL;
+	}
+
+	pr_info(DRV_NAME
+		 "(%x/%x) issued command %d, status: 0x%x\n",
+		 timeout, KB3310B_CMD_TIMEOUT - timeout,
+		 cmd, status);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kb3310b_query_seq);
+
+/*
+ * Send query command to EC to get the proper event number.
+ */
+int kb3310b_query_event_num(void)
+{
+	return kb3310b_query_seq(KB3310B_CMD_GET_EVENT_NUM);
+}
+EXPORT_SYMBOL_GPL(kb3310b_query_event_num);
+
+/*
+ * Get event number from EC.
+ *
+ * NOTE: This routine must follow the query_event_num function in the
+ * interrupt.
+ */
+int kb3310b_get_event_num(void)
+{
+	int timeout = 100;
+	unsigned char value;
+	unsigned char status;
+
+	udelay(KB3310B_REG_UDELAY);
+	status = inb(KB3310B_STS_PORT);
+	udelay(KB3310B_REG_UDELAY);
+	while (timeout-- && !(status & (1 << 0))) {
+		status = inb(KB3310B_STS_PORT);
+		udelay(KB3310B_REG_UDELAY);
+	}
+	if (timeout <= 0) {
+		pr_info("%s: get event number timeout.\n", __func__);
+		return -EINVAL;
+	}
+	value = inb(KB3310B_DAT_PORT);
+	udelay(KB3310B_REG_UDELAY);
+
+	return value;
+}
+EXPORT_SYMBOL_GPL(kb3310b_get_event_num);
diff --git a/include/linux/mfd/yeeloong_kb3310b.h b/include/linux/mfd/yeeloong_kb3310b.h
new file mode 100644
index 000000000000..1f16ba2579bc
--- /dev/null
+++ b/include/linux/mfd/yeeloong_kb3310b.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * MFD driver for ENE KB3310B embedded controller on Lemote Yeeloong laptops
+ *
+ * Copyright (C) 2008 Lemote Inc.
+ * Author: liujl <liujl@lemote.com>, 2008-04-20
+ *
+ * Copyright (C) 2018 Yifeng Li
+ * Author: Yifeng Li <tomli@tomli.me>
+ */
+
+#ifndef __LINUX_MFD_YEELOONG_KB3310B_H
+#define __LINUX_MFD_YEELOONG_KB3310B_H
+
+extern u8 kb3310b_read(u16 reg);
+extern void kb3310b_write(u16 reg, u8 val);
+extern bool kb3310b_fw_earlier(char *version);
+extern int kb3310b_query_seq(unsigned char cmd);
+extern int kb3310b_query_event_num(void);
+extern int kb3310b_get_event_num(void);
+
+typedef int (*sci_handler) (int status);
+
+extern int yeeloong_sci_register_notify(struct notifier_block *nb);
+extern int yeeloong_sci_unregister_notify(struct notifier_block *nb);
+
+#define KB3310B_VERSION_LEN 8
+
+struct kb3310b_chip {
+	char version[KB3310B_VERSION_LEN];
+};
+
+#define KB3310B_SCI_IRQ_NUM	0x0A
+
+/*
+ * The following registers are determined by the EC index configuration.
+ * 1, fill the PORT_HIGH as EC register high part.
+ * 2, fill the PORT_LOW as EC register low part.
+ * 3, fill the PORT_DATA as EC register write data or get the data from it.
+ */
+#define KB3310B_IO_PORT_HIGH	0x0381
+#define KB3310B_IO_PORT_LOW	0x0382
+#define KB3310B_IO_PORT_DATA	0x0383
+
+/*
+ * EC delay time is 500us for register and status access
+ */
+#define KB3310B_REG_UDELAY	500
+#define KB3310B_CMD_TIMEOUT	0x1000
+
+/*
+ * EC access port for SCI communication
+ */
+#define KB3310B_CMD_PORT		0x66
+#define KB3310B_STS_PORT		0x66
+#define KB3310B_DAT_PORT		0x62
+#define KB3310B_CMD_INIT_IDLE_MODE	0xdd
+#define KB3310B_CMD_EXIT_IDLE_MODE	0xdf
+#define KB3310B_CMD_INIT_RESET_MODE	0xd8
+#define KB3310B_CMD_REBOOT_SYSTEM	0x8c
+#define KB3310B_CMD_GET_EVENT_NUM	0x84
+#define KB3310B_CMD_PROGRAM_PIECE	0xda
+
+/* temperature & fan registers */
+#define KB3310B_REG_TEMPERATURE_VALUE	0xF458
+#define KB3310B_REG_FAN_AUTO_MAN_SWITCH 0xF459
+#define KB3310B_BIT_FAN_AUTO		0
+#define KB3310B_BIT_FAN_MANUAL		1
+#define KB3310B_REG_FAN_CONTROL		0xF4D2
+#define KB3310B_BIT_FAN_CONTROL_ON	(1 << 0)
+#define KB3310B_BIT_FAN_CONTROL_OFF	(0 << 0)
+#define KB3310B_REG_FAN_STATUS		0xF4DA
+#define KB3310B_BIT_FAN_STATUS_ON	(1 << 0)
+#define KB3310B_BIT_FAN_STATUS_OFF	(0 << 0)
+#define KB3310B_REG_FAN_SPEED_HIGH	0xFE22
+#define KB3310B_REG_FAN_SPEED_LOW	0xFE23
+#define KB3310B_REG_FAN_SPEED_LEVEL	0xF4CC
+
+/* fan speed divider */
+#define KB3310B_FAN_SPEED_DIVIDER	480000	/* (60*1000*1000/62.5/2)*/
+
+/* battery registers */
+#define KB3310B_REG_BAT_DESIGN_CAP_HIGH		0xF77D
+#define KB3310B_REG_BAT_DESIGN_CAP_LOW		0xF77E
+#define KB3310B_REG_BAT_FULLCHG_CAP_HIGH	0xF780
+#define KB3310B_REG_BAT_FULLCHG_CAP_LOW		0xF781
+#define KB3310B_REG_BAT_DESIGN_VOL_HIGH		0xF782
+#define KB3310B_REG_BAT_DESIGN_VOL_LOW		0xF783
+#define KB3310B_REG_BAT_CURRENT_HIGH		0xF784
+#define KB3310B_REG_BAT_CURRENT_LOW		0xF785
+#define KB3310B_REG_BAT_VOLTAGE_HIGH		0xF786
+#define KB3310B_REG_BAT_VOLTAGE_LOW		0xF787
+#define KB3310B_REG_BAT_TEMPERATURE_HIGH	0xF788
+#define KB3310B_REG_BAT_TEMPERATURE_LOW		0xF789
+#define KB3310B_REG_BAT_RELATIVE_CAP_HIGH	0xF492
+#define KB3310B_REG_BAT_RELATIVE_CAP_LOW	0xF493
+#define KB3310B_REG_BAT_VENDOR			0xF4C4
+#define KB3310B_FLAG_BAT_VENDOR_SANYO		0x01
+#define KB3310B_FLAG_BAT_VENDOR_SIMPLO		0x02
+#define KB3310B_REG_BAT_CELL_COUNT		0xF4C6
+#define KB3310B_FLAG_BAT_CELL_3S1P		0x03
+#define KB3310B_FLAG_BAT_CELL_3S2P		0x06
+#define KB3310B_REG_BAT_CHARGE			0xF4A2
+#define KB3310B_FLAG_BAT_CHARGE_DISCHARGE	0x01
+#define KB3310B_FLAG_BAT_CHARGE_CHARGE		0x02
+#define KB3310B_FLAG_BAT_CHARGE_ACPOWER		0x00
+#define KB3310B_REG_BAT_STATUS			0xF4B0
+#define KB3310B_BIT_BAT_STATUS_LOW		(1 << 5)
+#define KB3310B_BIT_BAT_STATUS_DESTROY		(1 << 2)
+#define KB3310B_BIT_BAT_STATUS_FULL		(1 << 1)
+#define KB3310B_BIT_BAT_STATUS_IN		(1 << 0)
+#define KB3310B_REG_BAT_CHARGE_STATUS		0xF4B1
+#define KB3310B_BIT_BAT_CHARGE_STATUS_OVERTEMP	(1 << 2)
+#define KB3310B_BIT_BAT_CHARGE_STATUS_PRECHG	(1 << 1)
+#define KB3310B_REG_BAT_STATE			0xF482
+#define KB3310B_BIT_BAT_STATE_CHARGING		(1 << 1)
+#define KB3310B_BIT_BAT_STATE_DISCHARGING	(1 << 0)
+#define KB3310B_REG_BAT_POWER			0xF440
+#define KB3310B_BIT_BAT_POWER_S3		(1 << 2)
+#define KB3310B_BIT_BAT_POWER_ON		(1 << 1)
+#define KB3310B_BIT_BAT_POWER_ACIN		(1 << 0)
+
+/* other registers */
+
+/* Audio: rd/wr */
+#define KB3310B_REG_AUDIO_VOLUME	0xF46C
+#define KB3310B_REG_AUDIO_MUTE		0xF4E7
+#define KB3310B_REG_AUDIO_BEEP		0xF4D0
+
+/* USB port power or not: rd/wr */
+#define KB3310B_REG_USB0_FLAG		0xF461
+#define KB3310B_REG_USB1_FLAG		0xF462
+#define KB3310B_REG_USB2_FLAG		0xF463
+#define KB3310B_BIT_USB_FLAG_ON		1
+#define KB3310B_BIT_USB_FLAG_OFF	0
+
+/* LID */
+#define KB3310B_REG_LID_DETECT		0xF4BD
+#define KB3310B_BIT_LID_DETECT_ON	1
+#define KB3310B_BIT_LID_DETECT_OFF	0
+
+/* CRT */
+#define KB3310B_REG_CRT_DETECT		0xF4AD
+#define KB3310B_BIT_CRT_DETECT_PLUG	1
+#define KB3310B_BIT_CRT_DETECT_UNPLUG	0
+
+/* LCD backlight brightness adjust: 9 levels */
+#define KB3310B_REG_DISPLAY_BRIGHTNESS	0xF4F5
+
+/* Black screen status */
+#define KB3310B_REG_DISPLAY_LCD		0xF79F
+#define KB3310B_BIT_DISPLAY_LCD_ON	1
+#define KB3310B_BIT_DISPLAY_LCD_OFF	0
+
+/* LCD backlight control: off/restore */
+#define KB3310B_REG_BACKLIGHT_CTRL	0xF7BD
+#define KB3310B_BIT_BACKLIGHT_ON	1
+#define KB3310B_BIT_BACKLIGHT_OFF	0
+
+/* Reset the machine auto-clear: rd/wr */
+#define KB3310B_REG_RESET		0xF4EC
+#define KB3310B_BIT_RESET_ON		1
+
+/* Light the LED: rd/wr */
+#define KB3310B_REG_LED			0xF4C8
+#define KB3310B_BIT_LED_RED_POWER	(1 << 0)
+#define KB3310B_BIT_LED_ORANGE_POWER	(1 << 1)
+#define KB3310B_BIT_LED_GREEN_CHARGE	(1 << 2)
+#define KB3310B_BIT_LED_RED_CHARGE	(1 << 3)
+#define KB3310B_BIT_LED_NUMLOCK		(1 << 4)
+
+/* Test LED mode, all LED on/off */
+#define KB3310B_REG_LED_TEST		0xF4C2
+#define KB3310B_BIT_LED_TEST_IN		1
+#define KB3310B_BIT_LED_TEST_OUT	0
+
+/* Camera on/off */
+#define KB3310B_REG_CAMERA_STATUS	0xF46A
+#define KB3310B_BIT_CAMERA_STATUS_ON	1
+#define KB3310B_BIT_CAMERA_STATUS_OFF	0
+#define KB3310B_REG_CAMERA_CONTROL	0xF7B7
+#define KB3310B_BIT_CAMERA_CONTROL_OFF	0
+#define KB3310B_BIT_CAMERA_CONTROL_ON	1
+
+/* WLAN Status */
+#define KB3310B_REG_WLAN		0xF4FA
+#define KB3310B_BIT_WLAN_ON		1
+#define KB3310B_BIT_WLAN_OFF		0
+
+/* SCI Event Number from EC */
+enum {
+	KB3310B_EVENT_START = 0x22,
+	KB3310B_EVENT_LID = 0x23,	   /* LID open/close */
+	KB3310B_EVENT_DISPLAY_TOGGLE,	   /* Fn+F3 for display switch */
+	KB3310B_EVENT_SLEEP,		   /* Fn+F1 for entering sleep mode */
+	KB3310B_EVENT_OVERTEMP,		   /* Over-temperature occurred */
+	KB3310B_EVENT_CRT_DETECT,	   /* CRT is connected */
+	KB3310B_EVENT_CAMERA,		   /* Camera on/off */
+	KB3310B_EVENT_USB_OC2,		   /* USB2 Overcurrent occurred */
+	KB3310B_EVENT_USB_OC0,		   /* USB0 Overcurrent occurred */
+	KB3310B_EVENT_BLACK_SCREEN,	   /* Turn on/off backlight */
+	KB3310B_EVENT_AUDIO_MUTE,	   /* Mute on/off */
+	KB3310B_EVENT_DISPLAY_BRIGHTNESS,  /* LCD backlight brightness adjust */
+	KB3310B_EVENT_AC_BAT,		   /* AC & Battery relative issue */
+	KB3310B_EVENT_AUDIO_VOLUME,	   /* Volume adjust */
+	KB3310B_EVENT_WLAN,		   /* WLAN on/off */
+	KB3310B_EVENT_END
+};
+
+#endif /* !__LINUX_MFD_YEELOONG_KB3310B_H */
-- 
2.20.1

