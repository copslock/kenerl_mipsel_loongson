Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2011 23:39:53 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47317 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491778Ab1FEVjA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2011 23:39:00 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 28B79140193;
        Sun,  5 Jun 2011 23:38:55 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 972E71400FF;
        Sun,  5 Jun 2011 23:38:54 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        Imre Kaloz <kaloz@openwrt.org>
Subject: [PATCH v2 3/3] MIPS: ath79: add common USB Host Controller device
Date:   Sun,  5 Jun 2011 23:38:46 +0200
Message-Id: <1307309926-2486-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1307309926-2486-1-git-send-email-juhosg@openwrt.org>
References: <1307309926-2486-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A12334BCF6B | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3676

Add common platform_device and helper code to make the registration of
the built-in USB controllers easier on the board which are using them.
Also register the USB controller on the AP81 and PB44 boards.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/ath79/Kconfig                        |    5 +
 arch/mips/ath79/Makefile                       |    1 +
 arch/mips/ath79/dev-usb.c                      |  178 ++++++++++++++++++++++++
 arch/mips/ath79/dev-usb.h                      |   17 +++
 arch/mips/ath79/mach-ap81.c                    |    2 +
 arch/mips/ath79/mach-pb44.c                    |    2 +
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   32 ++++-
 7 files changed, 236 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/ath79/dev-usb.c
 create mode 100644 arch/mips/ath79/dev-usb.h

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index b058282..8f42ab3 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -9,6 +9,7 @@ config ATH79_MACH_AP81
 	select ATH79_DEV_GPIO_BUTTONS
 	select ATH79_DEV_LEDS_GPIO
 	select ATH79_DEV_SPI
+	select ATH79_DEV_USB
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Atheros AP81 reference board.
@@ -19,6 +20,7 @@ config ATH79_MACH_PB44
 	select ATH79_DEV_GPIO_BUTTONS
 	select ATH79_DEV_LEDS_GPIO
 	select ATH79_DEV_SPI
+	select ATH79_DEV_USB
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Atheros PB44 reference board.
@@ -47,4 +49,7 @@ config ATH79_DEV_LEDS_GPIO
 config ATH79_DEV_SPI
 	def_bool n
 
+config ATH79_DEV_USB
+	def_bool n
+
 endif
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index c33d465..57188b6 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_ATH79_DEV_AR913X_WMAC)	+= dev-ar913x-wmac.o
 obj-$(CONFIG_ATH79_DEV_GPIO_BUTTONS)	+= dev-gpio-buttons.o
 obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
 obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
+obj-$(CONFIG_ATH79_DEV_USB)		+= dev-usb.o
 
 #
 # Machines
diff --git a/arch/mips/ath79/dev-usb.c b/arch/mips/ath79/dev-usb.c
new file mode 100644
index 0000000..c3f1999
--- /dev/null
+++ b/arch/mips/ath79/dev-usb.c
@@ -0,0 +1,178 @@
+/*
+ *  Atheros AR7XXX/AR9XXX USB Host Controller device
+ *
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
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
+#include "common.h"
+#include "dev-usb.h"
+
+static struct resource ath79_ohci_resources[] = {
+	[0] = {
+		/* .start and .end fields are filled dynamically */
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= ATH79_MISC_IRQ_OHCI,
+		.end	= ATH79_MISC_IRQ_OHCI,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 ath79_ohci_dmamask = DMA_BIT_MASK(32);
+static struct platform_device ath79_ohci_device = {
+	.name		= "ath79-ohci",
+	.id		= -1,
+	.resource	= ath79_ohci_resources,
+	.num_resources	= ARRAY_SIZE(ath79_ohci_resources),
+	.dev = {
+		.dma_mask		= &ath79_ohci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+static struct resource ath79_ehci_resources[] = {
+	[0] = {
+		/* .start and .end fields are filled dynamically */
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
+static struct platform_device ath79_ehci_device = {
+	.name		= "ath79-ehci",
+	.id		= -1,
+	.resource	= ath79_ehci_resources,
+	.num_resources	= ARRAY_SIZE(ath79_ehci_resources),
+	.dev = {
+		.dma_mask		= &ath79_ehci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+#define AR71XX_USB_RESET_MASK	(AR71XX_RESET_USB_HOST | \
+				 AR71XX_RESET_USB_PHY | \
+				 AR71XX_RESET_USB_OHCI_DLL)
+
+static void __init ath79_usb_setup(void)
+{
+	void __iomem *usb_ctrl_base;
+
+	ath79_device_reset_set(AR71XX_USB_RESET_MASK);
+	mdelay(1000);
+	ath79_device_reset_clear(AR71XX_USB_RESET_MASK);
+
+	usb_ctrl_base = ioremap(AR71XX_USB_CTRL_BASE, AR71XX_USB_CTRL_SIZE);
+
+	/* Turning on the Buff and Desc swap bits */
+	__raw_writel(0xf0000, usb_ctrl_base + AR71XX_USB_CTRL_REG_CONFIG);
+
+	/* WAR for HW bug. Here it adjusts the duration between two SOFS */
+	__raw_writel(0x20c00, usb_ctrl_base + AR71XX_USB_CTRL_REG_FLADJ);
+
+	iounmap(usb_ctrl_base);
+
+	mdelay(900);
+
+	ath79_ohci_resources[0].start = AR71XX_OHCI_BASE;
+	ath79_ohci_resources[0].end = AR71XX_OHCI_BASE + AR71XX_OHCI_SIZE - 1;
+	platform_device_register(&ath79_ohci_device);
+
+	ath79_ehci_resources[0].start = AR71XX_EHCI_BASE;
+	ath79_ehci_resources[0].end = AR71XX_EHCI_BASE + AR71XX_EHCI_SIZE - 1;
+	ath79_ehci_device.name = "ar71xx-ehci";
+	platform_device_register(&ath79_ehci_device);
+}
+
+static void __init ar7240_usb_setup(void)
+{
+	void __iomem *usb_ctrl_base;
+
+	ath79_device_reset_clear(AR7240_RESET_OHCI_DLL);
+	ath79_device_reset_set(AR7240_RESET_USB_HOST);
+
+	mdelay(1000);
+
+	ath79_device_reset_set(AR7240_RESET_OHCI_DLL);
+	ath79_device_reset_clear(AR7240_RESET_USB_HOST);
+
+	usb_ctrl_base = ioremap(AR7240_USB_CTRL_BASE, AR7240_USB_CTRL_SIZE);
+
+	/* WAR for HW bug. Here it adjusts the duration between two SOFS */
+	__raw_writel(0x3, usb_ctrl_base + AR71XX_USB_CTRL_REG_FLADJ);
+
+	iounmap(usb_ctrl_base);
+
+	ath79_ohci_resources[0].start = AR7240_OHCI_BASE;
+	ath79_ohci_resources[0].end = AR7240_OHCI_BASE + AR7240_OHCI_SIZE - 1;
+	platform_device_register(&ath79_ohci_device);
+}
+
+static void __init ar724x_usb_setup(void)
+{
+	ath79_device_reset_set(AR724X_RESET_USBSUS_OVERRIDE);
+	mdelay(10);
+
+	ath79_device_reset_clear(AR724X_RESET_USB_HOST);
+	mdelay(10);
+
+	ath79_device_reset_clear(AR724X_RESET_USB_PHY);
+	mdelay(10);
+
+	ath79_ehci_resources[0].start = AR724X_EHCI_BASE;
+	ath79_ehci_resources[0].end = AR724X_EHCI_BASE + AR724X_EHCI_SIZE - 1;
+	ath79_ehci_device.name = "ar724x-ehci";
+	platform_device_register(&ath79_ehci_device);
+}
+
+static void __init ar913x_usb_setup(void)
+{
+	ath79_device_reset_set(AR913X_RESET_USBSUS_OVERRIDE);
+	mdelay(10);
+
+	ath79_device_reset_clear(AR913X_RESET_USB_HOST);
+	mdelay(10);
+
+	ath79_device_reset_clear(AR913X_RESET_USB_PHY);
+	mdelay(10);
+
+	ath79_ehci_resources[0].start = AR913X_EHCI_BASE;
+	ath79_ehci_resources[0].end = AR913X_EHCI_BASE + AR913X_EHCI_SIZE - 1;
+	ath79_ehci_device.name = "ar913x-ehci";
+	platform_device_register(&ath79_ehci_device);
+}
+
+void __init ath79_register_usb(void)
+{
+	if (soc_is_ar71xx())
+		ath79_usb_setup();
+	else if (soc_is_ar7240())
+		ar7240_usb_setup();
+	else if (soc_is_ar7241() || soc_is_ar7242())
+		ar724x_usb_setup();
+	else if (soc_is_ar913x())
+		ar913x_usb_setup();
+	else
+		BUG();
+}
diff --git a/arch/mips/ath79/dev-usb.h b/arch/mips/ath79/dev-usb.h
new file mode 100644
index 0000000..4b86a69
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
+void ath79_register_usb(void);
+
+#endif /* _ATH79_DEV_USB_H */
diff --git a/arch/mips/ath79/mach-ap81.c b/arch/mips/ath79/mach-ap81.c
index eee4c12..6c08267 100644
--- a/arch/mips/ath79/mach-ap81.c
+++ b/arch/mips/ath79/mach-ap81.c
@@ -14,6 +14,7 @@
 #include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
+#include "dev-usb.h"
 
 #define AP81_GPIO_LED_STATUS	1
 #define AP81_GPIO_LED_AOSS	3
@@ -92,6 +93,7 @@ static void __init ap81_setup(void)
 	ath79_register_spi(&ap81_spi_data, ap81_spi_info,
 			   ARRAY_SIZE(ap81_spi_info));
 	ath79_register_ar913x_wmac(cal_data);
+	ath79_register_usb();
 }
 
 MIPS_MACHINE(ATH79_MACH_AP81, "AP81", "Atheros AP81 reference board",
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index ec7b7a1..fe9701a 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -18,6 +18,7 @@
 #include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
+#include "dev-usb.h"
 
 #define PB44_GPIO_I2C_SCL	0
 #define PB44_GPIO_I2C_SDA	1
@@ -112,6 +113,7 @@ static void __init pb44_init(void)
 					pb44_gpio_keys);
 	ath79_register_spi(&pb44_spi_data, pb44_spi_info,
 			   ARRAY_SIZE(pb44_spi_info));
+	ath79_register_usb();
 }
 
 MIPS_MACHINE(ATH79_MACH_PB44, "PB44", "Atheros PB44 reference board",
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index da0d894..86f0fc8 100644
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
@@ -34,6 +40,16 @@
 #define AR71XX_RESET_BASE	(AR71XX_APB_BASE + 0x00060000)
 #define AR71XX_RESET_SIZE	0x100
 
+#define AR7240_USB_CTRL_BASE	(AR71XX_APB_BASE + 0x00030000)
+#define AR7240_USB_CTRL_SIZE	0x100
+#define AR7240_OHCI_BASE	0x1b000000
+#define AR7240_OHCI_SIZE	0x1000
+
+#define AR724X_EHCI_BASE	0x1b000000
+#define AR724X_EHCI_SIZE	0x1000
+
+#define AR913X_EHCI_BASE	0x1b000000
+#define AR913X_EHCI_SIZE	0x1000
 #define AR913X_WMAC_BASE	(AR71XX_APB_BASE + 0x000C0000)
 #define AR913X_WMAC_SIZE	0x30000
 
@@ -105,6 +121,12 @@
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
@@ -162,14 +184,22 @@
 #define AR71XX_RESET_PCI_BUS		BIT(1)
 #define AR71XX_RESET_PCI_CORE		BIT(0)
 
+#define AR7240_RESET_USB_HOST		BIT(5)
+#define AR7240_RESET_OHCI_DLL		BIT(3)
+
 #define AR724X_RESET_GE1_MDIO		BIT(23)
 #define AR724X_RESET_GE0_MDIO		BIT(22)
 #define AR724X_RESET_PCIE_PHY_SERIAL	BIT(10)
 #define AR724X_RESET_PCIE_PHY		BIT(7)
 #define AR724X_RESET_PCIE		BIT(6)
-#define AR724X_RESET_OHCI_DLL		BIT(3)
+#define AR724X_RESET_USB_HOST		BIT(5)
+#define AR724X_RESET_USB_PHY		BIT(4)
+#define AR724X_RESET_USBSUS_OVERRIDE	BIT(3)
 
 #define AR913X_RESET_AMBA2WMAC		BIT(22)
+#define AR913X_RESET_USBSUS_OVERRIDE	BIT(10)
+#define AR913X_RESET_USB_HOST		BIT(5)
+#define AR913X_RESET_USB_PHY		BIT(4)
 
 #define REV_ID_MAJOR_MASK		0xfff0
 #define REV_ID_MAJOR_AR71XX		0x00a0
-- 
1.7.2.1
