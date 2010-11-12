Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:54:10 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:56998 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492163Ab0KLVv6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:51:58 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 68A3A41C007;
        Fri, 12 Nov 2010 22:51:50 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id B09A6270002;
        Fri, 12 Nov 2010 22:51:49 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC 06/18] MIPS: ath79: add common GPIO LEDs device
Date:   Fri, 12 Nov 2010 22:51:12 +0100
Message-Id: <1289598684-30624-7-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A12280F3C5F | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Almost all boards have one or more LEDs connected to GPIO lines. This
patch adds common code to register a platform_device for them.

The patch also adds support for the LEDs on the PB44 board.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/ath79/Kconfig         |    4 +++
 arch/mips/ath79/Makefile        |    1 +
 arch/mips/ath79/dev-leds-gpio.c |   56 +++++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/dev-leds-gpio.h |   21 ++++++++++++++
 arch/mips/ath79/mach-pb44.c     |   18 ++++++++++++
 5 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/dev-leds-gpio.c
 create mode 100644 arch/mips/ath79/dev-leds-gpio.h

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 47a8af4..2bd35ef 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -5,6 +5,7 @@ menu "Atheros AR71XX/AR724X/AR913X machine selection"
 config ATH79_MACH_PB44
 	bool "Atheros PB44 reference board"
 	select SOC_AR71XX
+	select ATH79_DEV_LEDS_GPIO
 	default n
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -21,6 +22,9 @@ config SOC_AR724X
 config SOC_AR913X
 	def_bool n
 
+config ATH79_DEV_LEDS_GPIO
+	def_bool n
+
 config ATH79_DEV_UART
 	def_bool y
 
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index aef7ce6..a231967 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -12,6 +12,7 @@ obj-y	:= prom.o setup.o irq.o common.o gpio.o
 
 obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 
+obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
 obj-$(CONFIG_ATH79_DEV_UART)		+= dev-uart.o
 
 #
diff --git a/arch/mips/ath79/dev-leds-gpio.c b/arch/mips/ath79/dev-leds-gpio.c
new file mode 100644
index 0000000..cdade68
--- /dev/null
+++ b/arch/mips/ath79/dev-leds-gpio.c
@@ -0,0 +1,56 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X common GPIO LEDs support
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#include "dev-leds-gpio.h"
+
+void __init ath79_register_leds_gpio(int id,
+				     unsigned num_leds,
+				     struct gpio_led *leds)
+{
+	struct platform_device *pdev;
+	struct gpio_led_platform_data pdata;
+	struct gpio_led *p;
+	int err;
+
+	p = kmalloc(num_leds * sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return;
+
+	memcpy(p, leds, num_leds * sizeof(*p));
+
+	pdev = platform_device_alloc("leds-gpio", id);
+	if (!pdev)
+		goto err_free_leds;
+
+	memset(&pdata, 0, sizeof(pdata));
+	pdata.num_leds = num_leds;
+	pdata.leds = p;
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
+err_free_leds:
+	kfree(p);
+}
diff --git a/arch/mips/ath79/dev-leds-gpio.h b/arch/mips/ath79/dev-leds-gpio.h
new file mode 100644
index 0000000..0fb0ed1
--- /dev/null
+++ b/arch/mips/ath79/dev-leds-gpio.h
@@ -0,0 +1,21 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X common GPIO LEDs support
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH79_DEV_LEDS_GPIO_H
+#define _ATH79_DEV_LEDS_GPIO_H
+
+#include <linux/leds.h>
+
+void ath79_register_leds_gpio(int id,
+			      unsigned num_leds,
+			      struct gpio_led *leds) __init;
+
+#endif /* _ATH79_DEV_LEDS_GPIO_H */
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index ffc24d7..e176779 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -15,11 +15,14 @@
 #include <linux/i2c/pcf857x.h>
 
 #include "machtypes.h"
+#include "dev-leds-gpio.h"
 
 #define PB44_GPIO_I2C_SCL	0
 #define PB44_GPIO_I2C_SDA	1
 
 #define PB44_GPIO_EXP_BASE	16
+#define PB44_GPIO_LED_JUMP1	(PB44_GPIO_EXP_BASE + 9)
+#define PB44_GPIO_LED_JUMP2	(PB44_GPIO_EXP_BASE + 10)
 
 static struct i2c_gpio_platform_data pb44_i2c_gpio_data = {
 	.sda_pin        = PB44_GPIO_I2C_SDA,
@@ -45,11 +48,26 @@ static struct i2c_board_info pb44_i2c_board_info[] __initdata = {
 	},
 };
 
+static struct gpio_led pb44_leds_gpio[] __initdata = {
+	{
+		.name		= "pb44:amber:jump1",
+		.gpio		= PB44_GPIO_LED_JUMP1,
+		.active_low	= 1,
+	}, {
+		.name		= "pb44:green:jump2",
+		.gpio		= PB44_GPIO_LED_JUMP2,
+		.active_low	= 1,
+	},
+};
+
 static void __init pb44_init(void)
 {
 	i2c_register_board_info(0, pb44_i2c_board_info,
 				ARRAY_SIZE(pb44_i2c_board_info));
 	platform_device_register(&pb44_i2c_gpio_device);
+
+	ath79_register_leds_gpio(-1, ARRAY_SIZE(pb44_leds_gpio),
+				 pb44_leds_gpio);
 }
 
 MIPS_MACHINE(ATH79_MACH_PB44, "PB44", "Atheros PB44 reference board",
-- 
1.7.2.1
