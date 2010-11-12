Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:59:11 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:57020 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492175Ab0KLVwE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:52:04 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id B773841C001;
        Fri, 12 Nov 2010 22:51:53 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E8C7E270002;
        Fri, 12 Nov 2010 22:51:52 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC 16/18] MIPS: ath79: add common USB Host Controller device
Date:   Fri, 12 Nov 2010 22:51:22 +0100
Message-Id: <1289598684-30624-17-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A122B63A736 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28383
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Add common platform_device and helper code to make the registration of
the built-in USB controllers easier on the board which are using them.
Also register the USB controller on the PB44 board.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/ath79/Kconfig                        |    4 +
 arch/mips/ath79/Makefile                       |    1 +
 arch/mips/ath79/dev-usb.c                      |  192 ++++++++++++++++++++++++
 arch/mips/ath79/dev-usb.h                      |   17 ++
 arch/mips/ath79/mach-pb44.c                    |    2 +
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   15 ++
 6 files changed, 231 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/dev-usb.c
 create mode 100644 arch/mips/ath79/dev-usb.h

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 78f9999..9843044 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -8,6 +8,7 @@ config ATH79_MACH_PB44
 	select ATH79_DEV_GPIO_BUTTONS
 	select ATH79_DEV_LEDS_GPIO
 	select ATH79_DEV_SPI
+	select ATH79_DEV_USB
 	default n
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -36,6 +37,9 @@ config ATH79_DEV_SPI
 config ATH79_DEV_UART
 	def_bool y
 
+config ATH79_DEV_USB
+	def_bool n
+
 config ATH79_DEV_WDT
 	def_bool y
 
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index 875df71..e0c07a7 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_ATH79_DEV_GPIO_BUTTONS)	+= dev-gpio-buttons.o
 obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
 obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
 obj-$(CONFIG_ATH79_DEV_UART)		+= dev-uart.o
+obj-$(CONFIG_ATH79_DEV_USB)		+= dev-usb.o
 obj-$(CONFIG_ATH79_DEV_WDT)		+= dev-wdt.o
 
 #
diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
new file mode 100644
index 0000000..78b049a
--- /dev/null
+++ b/arch/mips/ath79/dev-usb.c
@@ -0,0 +1,192 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X USB Host Controller support
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include <asm/mach-ath79/ath79_ehci_platform.h>
+#include "common.h"
+#include "dev-usb.h"
+
+static void __iomem *ath79_usb_ctrl_base;
+
+static struct resource ar71xx_ohci_resources[] = {
+	[0] = {
+		.start	= AR71XX_OHCI_BASE,
+		.end	= AR71XX_OHCI_BASE + AR71XX_OHCI_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= ATH79_MISC_IRQ_OHCI,
+		.end	= ATH79_MISC_IRQ_OHCI,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource ar724x_usb_resources[] = {
+	[0] = {
+		.start	= AR7240_OHCI_BASE,
+		.end	= AR7240_OHCI_BASE + AR7240_OHCI_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= ATH79_CPU_IRQ_USB,
+		.end	= ATH79_CPU_IRQ_USB,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 ath79_ohci_dmamask = DMA_BIT_MASK(32);
+static struct platform_device ath79_ohci_device = {
+	.name		= "ath79-ohci",
+	.id		= -1,
+	.resource	= ar71xx_ohci_resources,
+	.num_resources	= ARRAY_SIZE(ar71xx_ohci_resources),
+	.dev = {
+		.dma_mask		= &ath79_ohci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+static struct resource ar71xx_ehci_resources[] = {
+	[0] = {
+		.start	= AR71XX_EHCI_BASE,
+		.end	= AR71XX_EHCI_BASE + AR71XX_EHCI_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= ATH79_CPU_IRQ_USB,
+		.end	= ATH79_CPU_IRQ_USB,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 ath79_ehci_dmamask = DMA_BIT_MASK(32);
+static struct ath79_ehci_platform_data ath79_ehci_data;
+
+static struct platform_device ath79_ehci_device = {
+	.name		= "ath79-ehci",
+	.id		= -1,
+	.resource	= ar71xx_ehci_resources,
+	.num_resources	= ARRAY_SIZE(ar71xx_ehci_resources),
+	.dev = {
+		.dma_mask		= &ath79_ehci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &ath79_ehci_data,
+	},
+};
+
+#define AR71XX_USB_RESET_MASK	(AR71XX_RESET_USB_HOST | \
+				 AR71XX_RESET_USB_PHY | \
+				 AR71XX_RESET_USB_OHCI_DLL)
+
+static void __init ar71xx_usb_setup(void)
+{
+	ath79_device_stop(AR71XX_USB_RESET_MASK);
+	mdelay(1000);
+	ath79_device_start(AR71XX_USB_RESET_MASK);
+
+	/* Turning on the Buff and Desc swap bits */
+	__raw_writel(0xf0000, ath79_usb_ctrl_base + AR71XX_USB_CTRL_REG_CONFIG);
+
+	/* WAR for HW bug. Here it adjusts the duration between two SOFS */
+	__raw_writel(0x20c00, ath79_usb_ctrl_base + AR71XX_USB_CTRL_REG_FLADJ);
+
+	mdelay(900);
+
+	platform_device_register(&ath79_ohci_device);
+	platform_device_register(&ath79_ehci_device);
+}
+
+#define AR724X_USB_RESET_MASK	(AR71XX_RESET_USB_HOST | AR724X_RESET_OHCI_DLL)
+
+static void __init ar7240_usb_setup(void)
+{
+	ath79_device_stop(AR724X_USB_RESET_MASK);
+	mdelay(1000);
+	ath79_device_start(AR724X_USB_RESET_MASK);
+
+	/* WAR for HW bug. Here it adjusts the duration between two SOFS */
+	__raw_writel(0x3, ath79_usb_ctrl_base + AR71XX_USB_CTRL_REG_FLADJ);
+
+	ath79_ohci_device.resource = ar724x_usb_resources;
+	ath79_ohci_device.num_resources = ARRAY_SIZE(ar724x_usb_resources);
+	platform_device_register(&ath79_ohci_device);
+}
+
+static void __init ar724x_usb_setup(void)
+{
+	ath79_device_stop(AR724X_USB_RESET_MASK);
+	mdelay(1000);
+	ath79_device_start(AR724X_USB_RESET_MASK);
+
+	/* WAR for HW bug. Here it adjusts the duration between two SOFS */
+	__raw_writel(0x3, ath79_usb_ctrl_base + AR71XX_USB_CTRL_REG_FLADJ);
+
+	ath79_ehci_data.is_ar913x = 1;
+	ath79_ehci_device.resource = ar724x_usb_resources;
+	ath79_ehci_device.num_resources = ARRAY_SIZE(ar724x_usb_resources);
+	platform_device_register(&ath79_ehci_device);
+}
+
+static void __init ar913x_usb_setup(void)
+{
+	ath79_device_stop(AR71XX_RESET_USBSUS_OVERRIDE);
+	mdelay(10);
+
+	ath79_device_start(AR71XX_RESET_USB_HOST);
+	mdelay(10);
+
+	ath79_device_start(AR71XX_RESET_USB_PHY);
+	mdelay(10);
+
+	ath79_ehci_data.is_ar913x = 1;
+	platform_device_register(&ath79_ehci_device);
+}
+
+void __init ath79_register_usb(void)
+{
+	ath79_usb_ctrl_base = ioremap(AR71XX_USB_CTRL_BASE,
+				      AR71XX_USB_CTRL_SIZE);
+
+	switch (ath79_soc) {
+	case ATH79_SOC_AR7130:
+	case ATH79_SOC_AR7141:
+	case ATH79_SOC_AR7161:
+		ar71xx_usb_setup();
+		break;
+
+	case ATH79_SOC_AR7240:
+		ar7240_usb_setup();
+		break;
+
+	case ATH79_SOC_AR7241:
+	case ATH79_SOC_AR7242:
+		ar724x_usb_setup();
+		break;
+
+	case ATH79_SOC_AR9130:
+	case ATH79_SOC_AR9132:
+		ar913x_usb_setup();
+		break;
+
+	default:
+		BUG();
+	}
+}
diff --git a/arch/mips/ath79/dev-usb.h b/arch/mips/ath79/dev-usb.h
new file mode 100644
index 0000000..dbe6d3d
--- /dev/null
+++ b/arch/mips/ath79/dev-usb.h
@@ -0,0 +1,17 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X USB Host Controller support
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH79_DEV_USB_H
+#define _ATH79_DEV_USB_H
+
+void ath79_register_usb(void) __init;
+
+#endif /* _ATH79_DEV_USB_H */
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index 257815e..3e0bb05 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -18,6 +18,7 @@
 #include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
+#include "dev-usb.h"
 
 #define PB44_GPIO_I2C_SCL	0
 #define PB44_GPIO_I2C_SDA	1
@@ -111,6 +112,7 @@ static void __init pb44_init(void)
 				    pb44_gpio_buttons);
 	ath79_register_spi(&pb44_spi_data, pb44_spi_info,
 			   ARRAY_SIZE(pb44_spi_info));
+	ath79_register_usb();
 }
 
 MIPS_MACHINE(ATH79_MACH_PB44, "PB44", "Atheros PB44 reference board",
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 4f2b621..95be423 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -20,6 +20,10 @@
 #include <linux/bitops.h>
 
 #define AR71XX_APB_BASE		0x18000000
+#define AR71XX_EHCI_BASE	0x1b000000
+#define AR71XX_EHCI_SIZE	0x1000
+#define AR71XX_OHCI_BASE	0x1c000000
+#define AR71XX_OHCI_SIZE	0x1000
 #define AR71XX_SPI_BASE		0x1f000000
 #define AR71XX_SPI_SIZE		0x01000000
 
@@ -27,6 +31,8 @@
 #define AR71XX_DDR_CTRL_SIZE	0x100
 #define AR71XX_UART_BASE	(AR71XX_APB_BASE + 0x00020000)
 #define AR71XX_UART_SIZE	0x100
+#define AR71XX_USB_CTRL_BASE	(AR71XX_APB_BASE + 0x00030000)
+#define AR71XX_USB_CTRL_SIZE	0x100
 #define AR71XX_GPIO_BASE        (AR71XX_APB_BASE + 0x00040000)
 #define AR71XX_GPIO_SIZE        0x100
 #define AR71XX_PLL_BASE		(AR71XX_APB_BASE + 0x00050000)
@@ -34,6 +40,9 @@
 #define AR71XX_RESET_BASE	(AR71XX_APB_BASE + 0x00060000)
 #define AR71XX_RESET_SIZE	0x100
 
+#define AR7240_OHCI_BASE	0x1b000000
+#define AR7240_OHCI_SIZE	0x1000
+
 /*
  * DDR_CTRL block
  */
@@ -102,6 +111,12 @@
 #define AR913X_AHB_DIV_MASK		0x1
 
 /*
+ * USB_CONFIG block
+ */
+#define AR71XX_USB_CTRL_REG_FLADJ	0x00
+#define AR71XX_USB_CTRL_REG_CONFIG	0x04
+
+/*
  * RESET block
  */
 #define AR71XX_RESET_REG_TIMER			0x00
-- 
1.7.2.1
