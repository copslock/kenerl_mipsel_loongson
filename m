Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 16:15:01 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:44000 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492072Ab0KWPHG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 16:07:06 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 71EC44DC022;
        Tue, 23 Nov 2010 16:06:56 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id EFA961F0001;
        Tue, 23 Nov 2010 16:06:55 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, kaloz@openwrt.org,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 18/18] MIPS: ath79: add common WMAC device for AR913X based boards
Date:   Tue, 23 Nov 2010 16:06:40 +0100
Message-Id: <1290524800-21419-19-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A14B7F3EAA8 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Add common platform_device and helper code to make the registration
of the built-in wireless MAC easier on the Atheros AR9130/AR9132
based boards. Also register the WMAC device on the AR81 board.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---

Changes since RFC: ---

 arch/mips/ath79/Kconfig                        |    5 ++
 arch/mips/ath79/Makefile                       |    1 +
 arch/mips/ath79/dev-ar913x-wmac.c              |   60 ++++++++++++++++++++++++
 arch/mips/ath79/dev-ar913x-wmac.h              |   17 +++++++
 arch/mips/ath79/mach-ap81.c                    |    5 ++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 +
 6 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/dev-ar913x-wmac.c
 create mode 100644 arch/mips/ath79/dev-ar913x-wmac.h

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 1912d54..af01669 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -5,6 +5,7 @@ menu "Atheros AR71XX/AR724X/AR913X machine selection"
 config ATH79_MACH_AP81
 	bool "Atheros AP81 reference board"
 	select SOC_AR913X
+	select ATH79_DEV_AR913X_WMAC
 	select ATH79_DEV_GPIO_BUTTONS
 	select ATH79_DEV_LEDS_GPIO
 	select ATH79_DEV_SPI
@@ -40,6 +41,10 @@ config SOC_AR913X
 	select USB_ARCH_HAS_EHCI
 	def_bool n
 
+config ATH79_DEV_AR913X_WMAC
+	depends on SOC_AR913X
+	def_bool n
+
 config ATH79_DEV_GPIO_BUTTONS
 	def_bool n
 
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index 1b111d8..48398561 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 # Devices
 #
 obj-y					+= dev-common.o
+obj-$(CONFIG_ATH79_DEV_AR913X_WMAC)	+= dev-ar913x-wmac.o
 obj-$(CONFIG_ATH79_DEV_GPIO_BUTTONS)	+= dev-gpio-buttons.o
 obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
 obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
diff --git a/arch/mips/ath79/dev-ar913x-wmac.c b/arch/mips/ath79/dev-ar913x-wmac.c
new file mode 100644
index 0000000..ad2a39f
--- /dev/null
+++ b/arch/mips/ath79/dev-ar913x-wmac.c
@@ -0,0 +1,60 @@
+/*
+ *  Atheros AR913X SoC built-in WMAC device support
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
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/ath9k_platform.h>
+
+#include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include "dev-ar913x-wmac.h"
+
+static struct ath9k_platform_data ar913x_wmac_data;
+
+static struct resource ar913x_wmac_resources[] = {
+	{
+		.start	= AR913X_WMAC_BASE,
+		.end	= AR913X_WMAC_BASE + AR913X_WMAC_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= ATH79_CPU_IRQ_IP2,
+		.end	= ATH79_CPU_IRQ_IP2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ar913x_wmac_device = {
+	.name		= "ath9k",
+	.id		= -1,
+	.resource	= ar913x_wmac_resources,
+	.num_resources	= ARRAY_SIZE(ar913x_wmac_resources),
+	.dev = {
+		.platform_data = &ar913x_wmac_data,
+	},
+};
+
+void __init ath79_register_ar913x_wmac(u8 *cal_data)
+{
+	if (cal_data)
+		memcpy(ar913x_wmac_data.eeprom_data, cal_data,
+		       sizeof(ar913x_wmac_data.eeprom_data));
+
+	/* reset the WMAC */
+	ath79_device_stop(AR913X_RESET_AMBA2WMAC);
+	mdelay(10);
+
+	ath79_device_start(AR913X_RESET_AMBA2WMAC);
+	mdelay(10);
+
+	platform_device_register(&ar913x_wmac_device);
+}
diff --git a/arch/mips/ath79/dev-ar913x-wmac.h b/arch/mips/ath79/dev-ar913x-wmac.h
new file mode 100644
index 0000000..5df653f
--- /dev/null
+++ b/arch/mips/ath79/dev-ar913x-wmac.h
@@ -0,0 +1,17 @@
+/*
+ *  Atheros AR913X SoC built-in WMAC device support
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH79_DEV_AR913X_WMAC_H
+#define _ATH79_DEV_AR913X_WMAC_H
+
+void ath79_register_ar913x_wmac(u8 *cal_data) __init;
+
+#endif /* _ATH79_DEV_AR913X_WMAC_H */
diff --git a/arch/mips/ath79/mach-ap81.c b/arch/mips/ath79/mach-ap81.c
index 9cfaff3..00ef1cd 100644
--- a/arch/mips/ath79/mach-ap81.c
+++ b/arch/mips/ath79/mach-ap81.c
@@ -10,6 +10,7 @@
  */
 
 #include "machtypes.h"
+#include "dev-ar913x-wmac.h"
 #include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
@@ -24,6 +25,7 @@
 #define AP81_GPIO_BTN_SW1	21
 
 #define AP81_BUTTONS_POLL_INTERVAL	20
+#define AP81_CAL_DATA_ADDR	0x1fff1000
 
 static struct gpio_led ap81_leds_gpio[] __initdata = {
 	{
@@ -79,6 +81,8 @@ static struct ath79_spi_platform_data ap81_spi_data = {
 
 static void __init ap81_setup(void)
 {
+	u8 *cal_data = (u8 *) KSEG1ADDR(AP81_CAL_DATA_ADDR);
+
 	ath79_register_leds_gpio(-1, ARRAY_SIZE(ap81_leds_gpio),
 				 ap81_leds_gpio);
 	ath79_register_gpio_buttons(-1, AP81_BUTTONS_POLL_INTERVAL,
@@ -87,6 +91,7 @@ static void __init ap81_setup(void)
 	ath79_register_spi(&ap81_spi_data, ap81_spi_info,
 			   ARRAY_SIZE(ap81_spi_info));
 	ath79_register_usb();
+	ath79_register_ar913x_wmac(cal_data);
 }
 
 MIPS_MACHINE(ATH79_MACH_AP81, "AP81", "Atheros AP81 reference board",
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 95be423..e8b0e2f 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -43,6 +43,9 @@
 #define AR7240_OHCI_BASE	0x1b000000
 #define AR7240_OHCI_SIZE	0x1000
 
+#define AR913X_WMAC_BASE	(AR71XX_APB_BASE + 0x000C0000)
+#define AR913X_WMAC_SIZE	0x30000
+
 /*
  * DDR_CTRL block
  */
-- 
1.7.2.1
