Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:56:14 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:57015 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492169Ab0KLVv7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:51:59 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id A120941C00B;
        Fri, 12 Nov 2010 22:51:51 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E0E07270002;
        Fri, 12 Nov 2010 22:51:50 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC 10/18] MIPS: ath79: add common GPIO buttons device
Date:   Fri, 12 Nov 2010 22:51:16 +0100
Message-Id: <1289598684-30624-11-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A122942C7B7 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Almost all boards have one or more push buttons connected to GPIO lines.
This patch adds common code to register a platform_device for them.

The patch also adds support for the buttons on the PB44 board.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/ath79/Kconfig            |    4 ++
 arch/mips/ath79/Makefile           |    1 +
 arch/mips/ath79/dev-gpio-buttons.c |   58 ++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/dev-gpio-buttons.h |   23 ++++++++++++++
 arch/mips/ath79/mach-pb44.c        |   26 ++++++++++++++++
 5 files changed, 112 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/dev-gpio-buttons.c
 create mode 100644 arch/mips/ath79/dev-gpio-buttons.h

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 79bb528..0c34db1 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -5,6 +5,7 @@ menu "Atheros AR71XX/AR724X/AR913X machine selection"
 config ATH79_MACH_PB44
 	bool "Atheros PB44 reference board"
 	select SOC_AR71XX
+	select ATH79_DEV_GPIO_BUTTONS
 	select ATH79_DEV_LEDS_GPIO
 	default n
 	help
@@ -22,6 +23,9 @@ config SOC_AR724X
 config SOC_AR913X
 	def_bool n
 
+config ATH79_DEV_GPIO_BUTTONS
+	def_bool n
+
 config ATH79_DEV_LEDS_GPIO
 	def_bool n
 
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index 1b01868..c604f46 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -12,6 +12,7 @@ obj-y	:= prom.o setup.o irq.o common.o gpio.o
 
 obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 
+obj-$(CONFIG_ATH79_DEV_GPIO_BUTTONS)	+= dev-gpio-buttons.o
 obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
 obj-$(CONFIG_ATH79_DEV_UART)		+= dev-uart.o
 obj-$(CONFIG_ATH79_DEV_WDT)		+= dev-wdt.o
diff --git a/arch/mips/ath79/dev-gpio-buttons.c b/arch/mips/ath79/dev-gpio-buttons.c
new file mode 100644
index 0000000..3bc4a18
--- /dev/null
+++ b/arch/mips/ath79/dev-gpio-buttons.c
@@ -0,0 +1,58 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X GPIO button support
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include "linux/init.h"
+#include "linux/slab.h"
+#include <linux/platform_device.h>
+
+#include "dev-gpio-buttons.h"
+
+void __init ath79_register_gpio_buttons(int id,
+					unsigned poll_interval,
+					unsigned nbuttons,
+					struct gpio_button *buttons)
+{
+	struct platform_device *pdev;
+	struct gpio_buttons_platform_data pdata;
+	struct gpio_button *p;
+	int err;
+
+	p = kmalloc(nbuttons * sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return;
+
+	memcpy(p, buttons, nbuttons * sizeof(*p));
+
+	pdev = platform_device_alloc("gpio-buttons", id);
+	if (!pdev)
+		goto err_free_buttons;
+
+	memset(&pdata, 0, sizeof(pdata));
+	pdata.poll_interval = poll_interval;
+	pdata.nbuttons = nbuttons;
+	pdata.buttons = p;
+
+	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+	if (err)
+		goto err_put_pdev;
+
+	err = platform_device_add(pdev);
+	if (err)
+		goto err_put_pdev;
+
+	return;
+
+err_put_pdev:
+	platform_device_put(pdev);
+
+err_free_buttons:
+	kfree(p);
+}
diff --git a/arch/mips/ath79/dev-gpio-buttons.h b/arch/mips/ath79/dev-gpio-buttons.h
new file mode 100644
index 0000000..57bf1d6f
--- /dev/null
+++ b/arch/mips/ath79/dev-gpio-buttons.h
@@ -0,0 +1,23 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X GPIO button support
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH79_DEV_GPIO_BUTTONS_H
+#define _ATH79_DEV_GPIO_BUTTONS_H
+
+#include <linux/input.h>
+#include <linux/gpio_buttons.h>
+
+void ath79_register_gpio_buttons(int id,
+				 unsigned poll_interval,
+				 unsigned nbuttons,
+				 struct gpio_button *buttons) __init;
+
+#endif /* _ATH79_DEV_GPIO_BUTTONS_H */
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index e176779..5e7b544 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -15,15 +15,20 @@
 #include <linux/i2c/pcf857x.h>
 
 #include "machtypes.h"
+#include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
 
 #define PB44_GPIO_I2C_SCL	0
 #define PB44_GPIO_I2C_SDA	1
 
 #define PB44_GPIO_EXP_BASE	16
+#define PB44_GPIO_SW_RESET	(PB44_GPIO_EXP_BASE + 6)
+#define PB44_GPIO_SW_JUMP	(PB44_GPIO_EXP_BASE + 8)
 #define PB44_GPIO_LED_JUMP1	(PB44_GPIO_EXP_BASE + 9)
 #define PB44_GPIO_LED_JUMP2	(PB44_GPIO_EXP_BASE + 10)
 
+#define PB44_BUTTONS_POLL_INTERVAL	20
+
 static struct i2c_gpio_platform_data pb44_i2c_gpio_data = {
 	.sda_pin        = PB44_GPIO_I2C_SDA,
 	.scl_pin        = PB44_GPIO_I2C_SCL,
@@ -60,6 +65,24 @@ static struct gpio_led pb44_leds_gpio[] __initdata = {
 	},
 };
 
+static struct gpio_button pb44_gpio_buttons[] __initdata = {
+	{
+		.desc		= "soft_reset",
+		.type		= EV_KEY,
+		.code		= KEY_RESTART,
+		.threshold	= 3,
+		.gpio		= PB44_GPIO_SW_RESET,
+		.active_low	= 1,
+	} , {
+		.desc		= "jumpstart",
+		.type		= EV_KEY,
+		.code		= KEY_WPS_BUTTON,
+		.threshold	= 3,
+		.gpio		= PB44_GPIO_SW_JUMP,
+		.active_low	= 1,
+	}
+};
+
 static void __init pb44_init(void)
 {
 	i2c_register_board_info(0, pb44_i2c_board_info,
@@ -68,6 +91,9 @@ static void __init pb44_init(void)
 
 	ath79_register_leds_gpio(-1, ARRAY_SIZE(pb44_leds_gpio),
 				 pb44_leds_gpio);
+	ath79_register_gpio_buttons(-1, PB44_BUTTONS_POLL_INTERVAL,
+				    ARRAY_SIZE(pb44_gpio_buttons),
+				    pb44_gpio_buttons);
 }
 
 MIPS_MACHINE(ATH79_MACH_PB44, "PB44", "Atheros PB44 reference board",
-- 
1.7.2.1
