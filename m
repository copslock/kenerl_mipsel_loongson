Return-Path: <SRS0=rYMR=PT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517EC43387
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3190520874
	for <linux-mips@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfAKOXh (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:23:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37767 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388136AbfAKOX1 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 11 Jan 2019 09:23:27 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiT-00054S-Nb; Fri, 11 Jan 2019 15:23:21 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <ore@pengutronix.de>)
        id 1ghxiO-0002xN-AR; Fri, 11 Jan 2019 15:23:16 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH v1 10/11] MIPS: ath79: drop platform device registration code
Date:   Fri, 11 Jan 2019 15:22:39 +0100
Message-Id: <20190111142240.10908-11-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111142240.10908-1-o.rempel@pengutronix.de>
References: <20190111142240.10908-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@vger.kernel.org
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: John Crispin <john@phrozen.org>

With the target now being fully OF based, we can drop the legacy platform
device registration code. All devices and their drivers are now probed
via OF.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/Makefile           |  10 --
 arch/mips/ath79/common.h           |   2 -
 arch/mips/ath79/dev-common.c       | 159 -------------------
 arch/mips/ath79/dev-common.h       |  18 ---
 arch/mips/ath79/dev-gpio-buttons.c |  56 -------
 arch/mips/ath79/dev-gpio-buttons.h |  23 ---
 arch/mips/ath79/dev-leds-gpio.c    |  54 -------
 arch/mips/ath79/dev-leds-gpio.h    |  21 ---
 arch/mips/ath79/dev-spi.c          |  38 -----
 arch/mips/ath79/dev-spi.h          |  22 ---
 arch/mips/ath79/dev-usb.c          | 242 -----------------------------
 arch/mips/ath79/dev-usb.h          |  17 --
 arch/mips/ath79/dev-wmac.c         | 155 ------------------
 arch/mips/ath79/dev-wmac.h         |  17 --
 arch/mips/ath79/setup.c            |   1 -
 15 files changed, 835 deletions(-)
 delete mode 100644 arch/mips/ath79/dev-common.c
 delete mode 100644 arch/mips/ath79/dev-common.h
 delete mode 100644 arch/mips/ath79/dev-gpio-buttons.c
 delete mode 100644 arch/mips/ath79/dev-gpio-buttons.h
 delete mode 100644 arch/mips/ath79/dev-leds-gpio.c
 delete mode 100644 arch/mips/ath79/dev-leds-gpio.h
 delete mode 100644 arch/mips/ath79/dev-spi.c
 delete mode 100644 arch/mips/ath79/dev-spi.h
 delete mode 100644 arch/mips/ath79/dev-usb.c
 delete mode 100644 arch/mips/ath79/dev-usb.h
 delete mode 100644 arch/mips/ath79/dev-wmac.c
 delete mode 100644 arch/mips/ath79/dev-wmac.h

diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index bd0c9b8b1b5b..e18d9a2ecf62 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -11,13 +11,3 @@
 obj-y	:= prom.o setup.o common.o clock.o
 
 obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
-
-#
-# Devices
-#
-obj-y					+= dev-common.o
-obj-$(CONFIG_ATH79_DEV_GPIO_BUTTONS)	+= dev-gpio-buttons.o
-obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
-obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
-obj-$(CONFIG_ATH79_DEV_USB)		+= dev-usb.o
-obj-$(CONFIG_ATH79_DEV_WMAC)		+= dev-wmac.o
diff --git a/arch/mips/ath79/common.h b/arch/mips/ath79/common.h
index 870c6b2e97e8..77dd989e5ce0 100644
--- a/arch/mips/ath79/common.h
+++ b/arch/mips/ath79/common.h
@@ -24,6 +24,4 @@ unsigned long ath79_get_sys_clk_rate(const char *id);
 
 void ath79_ddr_ctrl_init(void);
 
-void ath79_gpio_init(void);
-
 #endif /* __ATH79_COMMON_H */
diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
deleted file mode 100644
index 9d0172a4dc69..000000000000
--- a/arch/mips/ath79/dev-common.c
+++ /dev/null
@@ -1,159 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X common devices
- *
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  Parts of this file are based on Atheros' 2.6.15 BSP
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/gpio-ath79.h>
-#include <linux/serial_8250.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-
-#include <asm/mach-ath79/ath79.h>
-#include <asm/mach-ath79/ar71xx_regs.h>
-#include "common.h"
-#include "dev-common.h"
-
-static struct resource ath79_uart_resources[] = {
-	{
-		.start	= AR71XX_UART_BASE,
-		.end	= AR71XX_UART_BASE + AR71XX_UART_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-#define AR71XX_UART_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP)
-static struct plat_serial8250_port ath79_uart_data[] = {
-	{
-		.mapbase	= AR71XX_UART_BASE,
-		.irq		= ATH79_MISC_IRQ(3),
-		.flags		= AR71XX_UART_FLAGS,
-		.iotype		= UPIO_MEM32,
-		.regshift	= 2,
-	}, {
-		/* terminating entry */
-	}
-};
-
-static struct platform_device ath79_uart_device = {
-	.name		= "serial8250",
-	.id		= PLAT8250_DEV_PLATFORM,
-	.resource	= ath79_uart_resources,
-	.num_resources	= ARRAY_SIZE(ath79_uart_resources),
-	.dev = {
-		.platform_data	= ath79_uart_data
-	},
-};
-
-static struct resource ar933x_uart_resources[] = {
-	{
-		.start	= AR933X_UART_BASE,
-		.end	= AR933X_UART_BASE + AR71XX_UART_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= ATH79_MISC_IRQ(3),
-		.end	= ATH79_MISC_IRQ(3),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device ar933x_uart_device = {
-	.name		= "ar933x-uart",
-	.id		= -1,
-	.resource	= ar933x_uart_resources,
-	.num_resources	= ARRAY_SIZE(ar933x_uart_resources),
-};
-
-void __init ath79_register_uart(void)
-{
-	unsigned long uart_clk_rate;
-
-	uart_clk_rate = ath79_get_sys_clk_rate("uart");
-
-	if (soc_is_ar71xx() ||
-	    soc_is_ar724x() ||
-	    soc_is_ar913x() ||
-	    soc_is_ar934x() ||
-	    soc_is_qca955x()) {
-		ath79_uart_data[0].uartclk = uart_clk_rate;
-		platform_device_register(&ath79_uart_device);
-	} else if (soc_is_ar933x()) {
-		platform_device_register(&ar933x_uart_device);
-	} else {
-		BUG();
-	}
-}
-
-void __init ath79_register_wdt(void)
-{
-	struct resource res;
-
-	memset(&res, 0, sizeof(res));
-
-	res.flags = IORESOURCE_MEM;
-	res.start = AR71XX_RESET_BASE + AR71XX_RESET_REG_WDOG_CTRL;
-	res.end = res.start + 0x8 - 1;
-
-	platform_device_register_simple("ath79-wdt", -1, &res, 1);
-}
-
-static struct ath79_gpio_platform_data ath79_gpio_pdata;
-
-static struct resource ath79_gpio_resources[] = {
-	{
-		.flags = IORESOURCE_MEM,
-		.start = AR71XX_GPIO_BASE,
-		.end = AR71XX_GPIO_BASE + AR71XX_GPIO_SIZE - 1,
-	},
-	{
-		.start	= ATH79_MISC_IRQ(2),
-		.end	= ATH79_MISC_IRQ(2),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device ath79_gpio_device = {
-	.name		= "ath79-gpio",
-	.id		= -1,
-	.resource	= ath79_gpio_resources,
-	.num_resources	= ARRAY_SIZE(ath79_gpio_resources),
-	.dev = {
-		.platform_data	= &ath79_gpio_pdata
-	},
-};
-
-void __init ath79_gpio_init(void)
-{
-	if (soc_is_ar71xx()) {
-		ath79_gpio_pdata.ngpios = AR71XX_GPIO_COUNT;
-	} else if (soc_is_ar7240()) {
-		ath79_gpio_pdata.ngpios = AR7240_GPIO_COUNT;
-	} else if (soc_is_ar7241() || soc_is_ar7242()) {
-		ath79_gpio_pdata.ngpios = AR7241_GPIO_COUNT;
-	} else if (soc_is_ar913x()) {
-		ath79_gpio_pdata.ngpios = AR913X_GPIO_COUNT;
-	} else if (soc_is_ar933x()) {
-		ath79_gpio_pdata.ngpios = AR933X_GPIO_COUNT;
-	} else if (soc_is_ar934x()) {
-		ath79_gpio_pdata.ngpios = AR934X_GPIO_COUNT;
-		ath79_gpio_pdata.oe_inverted = 1;
-	} else if (soc_is_qca955x()) {
-		ath79_gpio_pdata.ngpios = QCA955X_GPIO_COUNT;
-		ath79_gpio_pdata.oe_inverted = 1;
-	} else {
-		BUG();
-	}
-
-	platform_device_register(&ath79_gpio_device);
-}
diff --git a/arch/mips/ath79/dev-common.h b/arch/mips/ath79/dev-common.h
deleted file mode 100644
index 0f514e1affce..000000000000
--- a/arch/mips/ath79/dev-common.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X common devices
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _ATH79_DEV_COMMON_H
-#define _ATH79_DEV_COMMON_H
-
-void ath79_register_uart(void);
-void ath79_register_wdt(void);
-
-#endif /* _ATH79_DEV_COMMON_H */
diff --git a/arch/mips/ath79/dev-gpio-buttons.c b/arch/mips/ath79/dev-gpio-buttons.c
deleted file mode 100644
index 366b35fb164d..000000000000
--- a/arch/mips/ath79/dev-gpio-buttons.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X GPIO button support
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include "linux/init.h"
-#include "linux/slab.h"
-#include <linux/platform_device.h>
-
-#include "dev-gpio-buttons.h"
-
-void __init ath79_register_gpio_keys_polled(int id,
-					    unsigned poll_interval,
-					    unsigned nbuttons,
-					    struct gpio_keys_button *buttons)
-{
-	struct platform_device *pdev;
-	struct gpio_keys_platform_data pdata;
-	struct gpio_keys_button *p;
-	int err;
-
-	p = kmemdup(buttons, nbuttons * sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
-
-	pdev = platform_device_alloc("gpio-keys-polled", id);
-	if (!pdev)
-		goto err_free_buttons;
-
-	memset(&pdata, 0, sizeof(pdata));
-	pdata.poll_interval = poll_interval;
-	pdata.nbuttons = nbuttons;
-	pdata.buttons = p;
-
-	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
-	if (err)
-		goto err_put_pdev;
-
-	err = platform_device_add(pdev);
-	if (err)
-		goto err_put_pdev;
-
-	return;
-
-err_put_pdev:
-	platform_device_put(pdev);
-
-err_free_buttons:
-	kfree(p);
-}
diff --git a/arch/mips/ath79/dev-gpio-buttons.h b/arch/mips/ath79/dev-gpio-buttons.h
deleted file mode 100644
index 481847ac1cba..000000000000
--- a/arch/mips/ath79/dev-gpio-buttons.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X GPIO button support
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _ATH79_DEV_GPIO_BUTTONS_H
-#define _ATH79_DEV_GPIO_BUTTONS_H
-
-#include <linux/input.h>
-#include <linux/gpio_keys.h>
-
-void ath79_register_gpio_keys_polled(int id,
-				     unsigned poll_interval,
-				     unsigned nbuttons,
-				     struct gpio_keys_button *buttons);
-
-#endif /* _ATH79_DEV_GPIO_BUTTONS_H */
diff --git a/arch/mips/ath79/dev-leds-gpio.c b/arch/mips/ath79/dev-leds-gpio.c
deleted file mode 100644
index dcb1debcefb8..000000000000
--- a/arch/mips/ath79/dev-leds-gpio.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X common GPIO LEDs support
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/platform_device.h>
-
-#include "dev-leds-gpio.h"
-
-void __init ath79_register_leds_gpio(int id,
-				     unsigned num_leds,
-				     struct gpio_led *leds)
-{
-	struct platform_device *pdev;
-	struct gpio_led_platform_data pdata;
-	struct gpio_led *p;
-	int err;
-
-	p = kmemdup(leds, num_leds * sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
-
-	pdev = platform_device_alloc("leds-gpio", id);
-	if (!pdev)
-		goto err_free_leds;
-
-	memset(&pdata, 0, sizeof(pdata));
-	pdata.num_leds = num_leds;
-	pdata.leds = p;
-
-	err = platform_device_add_data(pdev, &pdata, sizeof(pdata));
-	if (err)
-		goto err_put_pdev;
-
-	err = platform_device_add(pdev);
-	if (err)
-		goto err_put_pdev;
-
-	return;
-
-err_put_pdev:
-	platform_device_put(pdev);
-
-err_free_leds:
-	kfree(p);
-}
diff --git a/arch/mips/ath79/dev-leds-gpio.h b/arch/mips/ath79/dev-leds-gpio.h
deleted file mode 100644
index 6e5d8851ebcf..000000000000
--- a/arch/mips/ath79/dev-leds-gpio.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X common GPIO LEDs support
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _ATH79_DEV_LEDS_GPIO_H
-#define _ATH79_DEV_LEDS_GPIO_H
-
-#include <linux/leds.h>
-
-void ath79_register_leds_gpio(int id,
-			      unsigned num_leds,
-			      struct gpio_led *leds);
-
-#endif /* _ATH79_DEV_LEDS_GPIO_H */
diff --git a/arch/mips/ath79/dev-spi.c b/arch/mips/ath79/dev-spi.c
deleted file mode 100644
index aa30163efbfd..000000000000
--- a/arch/mips/ath79/dev-spi.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X SPI controller device
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/platform_device.h>
-#include <asm/mach-ath79/ar71xx_regs.h>
-#include "dev-spi.h"
-
-static struct resource ath79_spi_resources[] = {
-	{
-		.start	= AR71XX_SPI_BASE,
-		.end	= AR71XX_SPI_BASE + AR71XX_SPI_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device ath79_spi_device = {
-	.name		= "ath79-spi",
-	.id		= -1,
-	.resource	= ath79_spi_resources,
-	.num_resources	= ARRAY_SIZE(ath79_spi_resources),
-};
-
-void __init ath79_register_spi(struct ath79_spi_platform_data *pdata,
-			       struct spi_board_info const *info,
-			       unsigned n)
-{
-	spi_register_board_info(info, n);
-	ath79_spi_device.dev.platform_data = pdata;
-	platform_device_register(&ath79_spi_device);
-}
diff --git a/arch/mips/ath79/dev-spi.h b/arch/mips/ath79/dev-spi.h
deleted file mode 100644
index d732565ca736..000000000000
--- a/arch/mips/ath79/dev-spi.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X SPI controller device
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _ATH79_DEV_SPI_H
-#define _ATH79_DEV_SPI_H
-
-#include <linux/spi/spi.h>
-#include <asm/mach-ath79/ath79_spi_platform.h>
-
-void ath79_register_spi(struct ath79_spi_platform_data *pdata,
-			 struct spi_board_info const *info,
-			 unsigned n);
-
-#endif /* _ATH79_DEV_SPI_H */
diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
deleted file mode 100644
index 8227265bcc2d..000000000000
--- a/arch/mips/ath79/dev-usb.c
+++ /dev/null
@@ -1,242 +0,0 @@
-/*
- *  Atheros AR7XXX/AR9XXX USB Host Controller device
- *
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  Parts of this file are based on Atheros' 2.6.15 BSP
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/usb/ehci_pdriver.h>
-#include <linux/usb/ohci_pdriver.h>
-
-#include <asm/mach-ath79/ath79.h>
-#include <asm/mach-ath79/ar71xx_regs.h>
-#include "common.h"
-#include "dev-usb.h"
-
-static u64 ath79_usb_dmamask = DMA_BIT_MASK(32);
-
-static struct usb_ohci_pdata ath79_ohci_pdata = {
-};
-
-static struct usb_ehci_pdata ath79_ehci_pdata_v1 = {
-	.has_synopsys_hc_bug	= 1,
-};
-
-static struct usb_ehci_pdata ath79_ehci_pdata_v2 = {
-	.caps_offset		= 0x100,
-	.has_tt			= 1,
-};
-
-static void __init ath79_usb_register(const char *name, int id,
-				      unsigned long base, unsigned long size,
-				      int irq, const void *data,
-				      size_t data_size)
-{
-	struct resource res[2];
-	struct platform_device *pdev;
-
-	memset(res, 0, sizeof(res));
-
-	res[0].flags = IORESOURCE_MEM;
-	res[0].start = base;
-	res[0].end = base + size - 1;
-
-	res[1].flags = IORESOURCE_IRQ;
-	res[1].start = irq;
-	res[1].end = irq;
-
-	pdev = platform_device_register_resndata(NULL, name, id,
-						 res, ARRAY_SIZE(res),
-						 data, data_size);
-
-	if (IS_ERR(pdev)) {
-		pr_err("ath79: unable to register USB at %08lx, err=%d\n",
-		       base, (int) PTR_ERR(pdev));
-		return;
-	}
-
-	pdev->dev.dma_mask = &ath79_usb_dmamask;
-	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-}
-
-#define AR71XX_USB_RESET_MASK	(AR71XX_RESET_USB_HOST | \
-				 AR71XX_RESET_USB_PHY | \
-				 AR71XX_RESET_USB_OHCI_DLL)
-
-static void __init ath79_usb_setup(void)
-{
-	void __iomem *usb_ctrl_base;
-
-	ath79_device_reset_set(AR71XX_USB_RESET_MASK);
-	mdelay(1000);
-	ath79_device_reset_clear(AR71XX_USB_RESET_MASK);
-
-	usb_ctrl_base = ioremap(AR71XX_USB_CTRL_BASE, AR71XX_USB_CTRL_SIZE);
-
-	/* Turning on the Buff and Desc swap bits */
-	__raw_writel(0xf0000, usb_ctrl_base + AR71XX_USB_CTRL_REG_CONFIG);
-
-	/* WAR for HW bug. Here it adjusts the duration between two SOFS */
-	__raw_writel(0x20c00, usb_ctrl_base + AR71XX_USB_CTRL_REG_FLADJ);
-
-	iounmap(usb_ctrl_base);
-
-	mdelay(900);
-
-	ath79_usb_register("ohci-platform", -1,
-			   AR71XX_OHCI_BASE, AR71XX_OHCI_SIZE,
-			   ATH79_MISC_IRQ(6),
-			   &ath79_ohci_pdata, sizeof(ath79_ohci_pdata));
-
-	ath79_usb_register("ehci-platform", -1,
-			   AR71XX_EHCI_BASE, AR71XX_EHCI_SIZE,
-			   ATH79_CPU_IRQ(3),
-			   &ath79_ehci_pdata_v1, sizeof(ath79_ehci_pdata_v1));
-}
-
-static void __init ar7240_usb_setup(void)
-{
-	void __iomem *usb_ctrl_base;
-
-	ath79_device_reset_clear(AR7240_RESET_OHCI_DLL);
-	ath79_device_reset_set(AR7240_RESET_USB_HOST);
-
-	mdelay(1000);
-
-	ath79_device_reset_set(AR7240_RESET_OHCI_DLL);
-	ath79_device_reset_clear(AR7240_RESET_USB_HOST);
-
-	usb_ctrl_base = ioremap(AR7240_USB_CTRL_BASE, AR7240_USB_CTRL_SIZE);
-
-	/* WAR for HW bug. Here it adjusts the duration between two SOFS */
-	__raw_writel(0x3, usb_ctrl_base + AR71XX_USB_CTRL_REG_FLADJ);
-
-	iounmap(usb_ctrl_base);
-
-	ath79_usb_register("ohci-platform", -1,
-			   AR7240_OHCI_BASE, AR7240_OHCI_SIZE,
-			   ATH79_CPU_IRQ(3),
-			   &ath79_ohci_pdata, sizeof(ath79_ohci_pdata));
-}
-
-static void __init ar724x_usb_setup(void)
-{
-	ath79_device_reset_set(AR724X_RESET_USBSUS_OVERRIDE);
-	mdelay(10);
-
-	ath79_device_reset_clear(AR724X_RESET_USB_HOST);
-	mdelay(10);
-
-	ath79_device_reset_clear(AR724X_RESET_USB_PHY);
-	mdelay(10);
-
-	ath79_usb_register("ehci-platform", -1,
-			   AR724X_EHCI_BASE, AR724X_EHCI_SIZE,
-			   ATH79_CPU_IRQ(3),
-			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
-}
-
-static void __init ar913x_usb_setup(void)
-{
-	ath79_device_reset_set(AR913X_RESET_USBSUS_OVERRIDE);
-	mdelay(10);
-
-	ath79_device_reset_clear(AR913X_RESET_USB_HOST);
-	mdelay(10);
-
-	ath79_device_reset_clear(AR913X_RESET_USB_PHY);
-	mdelay(10);
-
-	ath79_usb_register("ehci-platform", -1,
-			   AR913X_EHCI_BASE, AR913X_EHCI_SIZE,
-			   ATH79_CPU_IRQ(3),
-			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
-}
-
-static void __init ar933x_usb_setup(void)
-{
-	ath79_device_reset_set(AR933X_RESET_USBSUS_OVERRIDE);
-	mdelay(10);
-
-	ath79_device_reset_clear(AR933X_RESET_USB_HOST);
-	mdelay(10);
-
-	ath79_device_reset_clear(AR933X_RESET_USB_PHY);
-	mdelay(10);
-
-	ath79_usb_register("ehci-platform", -1,
-			   AR933X_EHCI_BASE, AR933X_EHCI_SIZE,
-			   ATH79_CPU_IRQ(3),
-			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
-}
-
-static void __init ar934x_usb_setup(void)
-{
-	u32 bootstrap;
-
-	bootstrap = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
-	if (bootstrap & AR934X_BOOTSTRAP_USB_MODE_DEVICE)
-		return;
-
-	ath79_device_reset_set(AR934X_RESET_USBSUS_OVERRIDE);
-	udelay(1000);
-
-	ath79_device_reset_clear(AR934X_RESET_USB_PHY);
-	udelay(1000);
-
-	ath79_device_reset_clear(AR934X_RESET_USB_PHY_ANALOG);
-	udelay(1000);
-
-	ath79_device_reset_clear(AR934X_RESET_USB_HOST);
-	udelay(1000);
-
-	ath79_usb_register("ehci-platform", -1,
-			   AR934X_EHCI_BASE, AR934X_EHCI_SIZE,
-			   ATH79_CPU_IRQ(3),
-			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
-}
-
-static void __init qca955x_usb_setup(void)
-{
-	ath79_usb_register("ehci-platform", 0,
-			   QCA955X_EHCI0_BASE, QCA955X_EHCI_SIZE,
-			   ATH79_IP3_IRQ(0),
-			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
-
-	ath79_usb_register("ehci-platform", 1,
-			   QCA955X_EHCI1_BASE, QCA955X_EHCI_SIZE,
-			   ATH79_IP3_IRQ(1),
-			   &ath79_ehci_pdata_v2, sizeof(ath79_ehci_pdata_v2));
-}
-
-void __init ath79_register_usb(void)
-{
-	if (soc_is_ar71xx())
-		ath79_usb_setup();
-	else if (soc_is_ar7240())
-		ar7240_usb_setup();
-	else if (soc_is_ar7241() || soc_is_ar7242())
-		ar724x_usb_setup();
-	else if (soc_is_ar913x())
-		ar913x_usb_setup();
-	else if (soc_is_ar933x())
-		ar933x_usb_setup();
-	else if (soc_is_ar934x())
-		ar934x_usb_setup();
-	else if (soc_is_qca955x())
-		qca955x_usb_setup();
-	else
-		BUG();
-}
diff --git a/arch/mips/ath79/dev-usb.h b/arch/mips/ath79/dev-usb.h
deleted file mode 100644
index 4b86a69ca080..000000000000
--- a/arch/mips/ath79/dev-usb.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X/AR913X USB Host Controller support
- *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _ATH79_DEV_USB_H
-#define _ATH79_DEV_USB_H
-
-void ath79_register_usb(void);
-
-#endif /* _ATH79_DEV_USB_H */
diff --git a/arch/mips/ath79/dev-wmac.c b/arch/mips/ath79/dev-wmac.c
deleted file mode 100644
index da190b1b87ce..000000000000
--- a/arch/mips/ath79/dev-wmac.c
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- *  Atheros AR913X/AR933X SoC built-in WMAC device support
- *
- *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  Parts of this file are based on Atheros 2.6.15/2.6.31 BSP
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
-#include <linux/ath9k_platform.h>
-
-#include <asm/mach-ath79/ath79.h>
-#include <asm/mach-ath79/ar71xx_regs.h>
-#include "dev-wmac.h"
-
-static struct ath9k_platform_data ath79_wmac_data;
-
-static struct resource ath79_wmac_resources[] = {
-	{
-		/* .start and .end fields are filled dynamically */
-		.flags	= IORESOURCE_MEM,
-	}, {
-		/* .start and .end fields are filled dynamically */
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device ath79_wmac_device = {
-	.name		= "ath9k",
-	.id		= -1,
-	.resource	= ath79_wmac_resources,
-	.num_resources	= ARRAY_SIZE(ath79_wmac_resources),
-	.dev = {
-		.platform_data = &ath79_wmac_data,
-	},
-};
-
-static void __init ar913x_wmac_setup(void)
-{
-	/* reset the WMAC */
-	ath79_device_reset_set(AR913X_RESET_AMBA2WMAC);
-	mdelay(10);
-
-	ath79_device_reset_clear(AR913X_RESET_AMBA2WMAC);
-	mdelay(10);
-
-	ath79_wmac_resources[0].start = AR913X_WMAC_BASE;
-	ath79_wmac_resources[0].end = AR913X_WMAC_BASE + AR913X_WMAC_SIZE - 1;
-	ath79_wmac_resources[1].start = ATH79_CPU_IRQ(2);
-	ath79_wmac_resources[1].end = ATH79_CPU_IRQ(2);
-}
-
-
-static int ar933x_wmac_reset(void)
-{
-	ath79_device_reset_set(AR933X_RESET_WMAC);
-	ath79_device_reset_clear(AR933X_RESET_WMAC);
-
-	return 0;
-}
-
-static int ar933x_r1_get_wmac_revision(void)
-{
-	return ath79_soc_rev;
-}
-
-static void __init ar933x_wmac_setup(void)
-{
-	u32 t;
-
-	ar933x_wmac_reset();
-
-	ath79_wmac_device.name = "ar933x_wmac";
-
-	ath79_wmac_resources[0].start = AR933X_WMAC_BASE;
-	ath79_wmac_resources[0].end = AR933X_WMAC_BASE + AR933X_WMAC_SIZE - 1;
-	ath79_wmac_resources[1].start = ATH79_CPU_IRQ(2);
-	ath79_wmac_resources[1].end = ATH79_CPU_IRQ(2);
-
-	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
-	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
-		ath79_wmac_data.is_clk_25mhz = false;
-	else
-		ath79_wmac_data.is_clk_25mhz = true;
-
-	if (ath79_soc_rev == 1)
-		ath79_wmac_data.get_mac_revision = ar933x_r1_get_wmac_revision;
-
-	ath79_wmac_data.external_reset = ar933x_wmac_reset;
-}
-
-static void ar934x_wmac_setup(void)
-{
-	u32 t;
-
-	ath79_wmac_device.name = "ar934x_wmac";
-
-	ath79_wmac_resources[0].start = AR934X_WMAC_BASE;
-	ath79_wmac_resources[0].end = AR934X_WMAC_BASE + AR934X_WMAC_SIZE - 1;
-	ath79_wmac_resources[1].start = ATH79_IP2_IRQ(1);
-	ath79_wmac_resources[1].end = ATH79_IP2_IRQ(1);
-
-	t = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
-	if (t & AR934X_BOOTSTRAP_REF_CLK_40)
-		ath79_wmac_data.is_clk_25mhz = false;
-	else
-		ath79_wmac_data.is_clk_25mhz = true;
-}
-
-static void qca955x_wmac_setup(void)
-{
-	u32 t;
-
-	ath79_wmac_device.name = "qca955x_wmac";
-
-	ath79_wmac_resources[0].start = QCA955X_WMAC_BASE;
-	ath79_wmac_resources[0].end = QCA955X_WMAC_BASE + QCA955X_WMAC_SIZE - 1;
-	ath79_wmac_resources[1].start = ATH79_IP2_IRQ(1);
-	ath79_wmac_resources[1].end = ATH79_IP2_IRQ(1);
-
-	t = ath79_reset_rr(QCA955X_RESET_REG_BOOTSTRAP);
-	if (t & QCA955X_BOOTSTRAP_REF_CLK_40)
-		ath79_wmac_data.is_clk_25mhz = false;
-	else
-		ath79_wmac_data.is_clk_25mhz = true;
-}
-
-void __init ath79_register_wmac(u8 *cal_data)
-{
-	if (soc_is_ar913x())
-		ar913x_wmac_setup();
-	else if (soc_is_ar933x())
-		ar933x_wmac_setup();
-	else if (soc_is_ar934x())
-		ar934x_wmac_setup();
-	else if (soc_is_qca955x())
-		qca955x_wmac_setup();
-	else
-		BUG();
-
-	if (cal_data)
-		memcpy(ath79_wmac_data.eeprom_data, cal_data,
-		       sizeof(ath79_wmac_data.eeprom_data));
-
-	platform_device_register(&ath79_wmac_device);
-}
diff --git a/arch/mips/ath79/dev-wmac.h b/arch/mips/ath79/dev-wmac.h
deleted file mode 100644
index c9cd8709f090..000000000000
--- a/arch/mips/ath79/dev-wmac.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- *  Atheros AR913X/AR933X SoC built-in WMAC device support
- *
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _ATH79_DEV_WMAC_H
-#define _ATH79_DEV_WMAC_H
-
-void ath79_register_wmac(u8 *cal_data);
-
-#endif /* _ATH79_DEV_WMAC_H */
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 7a9ba4464756..4a70c5de8c92 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -32,7 +32,6 @@
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
-#include "dev-common.h"
 
 #define ATH79_SYS_TYPE_LEN	64
 
-- 
2.20.1

