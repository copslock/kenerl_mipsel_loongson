Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2011 21:33:15 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:48591 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491036Ab1ADU3N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jan 2011 21:29:13 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 7771A45C023;
        Tue,  4 Jan 2011 21:29:06 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 98BBA1F0001;
        Tue,  4 Jan 2011 21:29:05 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v5 10/16] MIPS: ath79: add common SPI controller device
Date:   Tue,  4 Jan 2011 21:28:23 +0100
Message-Id: <1294172909-1309-11-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1294172909-1309-1-git-send-email-juhosg@openwrt.org>
References: <1294172909-1309-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A108D43FC0C | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Several boards are using the built-in SPI controller of the
AR71XX/AR724X/AR913X SoCs. This patch adds common platform_device
and helper code to register it. Additionally, the patch registers
the SPI bus on the PB44 board.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Changes since RFC: ---

Changes since v1:
    - rebased against 2.6.37-rc7

Changes since v2:
    - don't use __init for function declarations

Changes since v3
    - rebased against 2.6.37-rc8

Changes since v4: ---

 arch/mips/ath79/Kconfig                        |    4 ++
 arch/mips/ath79/Makefile                       |    1 +
 arch/mips/ath79/dev-spi.c                      |   38 ++++++++++++++++++++++++
 arch/mips/ath79/dev-spi.h                      |   22 ++++++++++++++
 arch/mips/ath79/mach-pb44.c                    |   17 ++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    2 +
 6 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/dev-spi.c
 create mode 100644 arch/mips/ath79/dev-spi.h

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 185a8d6..cd6c738 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -7,6 +7,7 @@ config ATH79_MACH_PB44
 	select SOC_AR71XX
 	select ATH79_DEV_GPIO_BUTTONS
 	select ATH79_DEV_LEDS_GPIO
+	select ATH79_DEV_SPI
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Atheros PB44 reference board.
@@ -28,4 +29,7 @@ config ATH79_DEV_GPIO_BUTTONS
 config ATH79_DEV_LEDS_GPIO
 	def_bool n
 
+config ATH79_DEV_SPI
+	def_bool n
+
 endif
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index 344e9ab..42f4295 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 obj-y					+= dev-common.o
 obj-$(CONFIG_ATH79_DEV_GPIO_BUTTONS)	+= dev-gpio-buttons.o
 obj-$(CONFIG_ATH79_DEV_LEDS_GPIO)	+= dev-leds-gpio.o
+obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
 
 #
 # Machines
diff --git a/arch/mips/ath79/dev-spi.c b/arch/mips/ath79/dev-spi.c
new file mode 100644
index 0000000..aa30163
--- /dev/null
+++ b/arch/mips/ath79/dev-spi.c
@@ -0,0 +1,38 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X SPI controller device
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include "dev-spi.h"
+
+static struct resource ath79_spi_resources[] = {
+	{
+		.start	= AR71XX_SPI_BASE,
+		.end	= AR71XX_SPI_BASE + AR71XX_SPI_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device ath79_spi_device = {
+	.name		= "ath79-spi",
+	.id		= -1,
+	.resource	= ath79_spi_resources,
+	.num_resources	= ARRAY_SIZE(ath79_spi_resources),
+};
+
+void __init ath79_register_spi(struct ath79_spi_platform_data *pdata,
+			       struct spi_board_info const *info,
+			       unsigned n)
+{
+	spi_register_board_info(info, n);
+	ath79_spi_device.dev.platform_data = pdata;
+	platform_device_register(&ath79_spi_device);
+}
diff --git a/arch/mips/ath79/dev-spi.h b/arch/mips/ath79/dev-spi.h
new file mode 100644
index 0000000..d732565
--- /dev/null
+++ b/arch/mips/ath79/dev-spi.h
@@ -0,0 +1,22 @@
+/*
+ *  Atheros AR71XX/AR724X/AR913X SPI controller device
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH79_DEV_SPI_H
+#define _ATH79_DEV_SPI_H
+
+#include <linux/spi/spi.h>
+#include <asm/mach-ath79/ath79_spi_platform.h>
+
+void ath79_register_spi(struct ath79_spi_platform_data *pdata,
+			 struct spi_board_info const *info,
+			 unsigned n);
+
+#endif /* _ATH79_DEV_SPI_H */
diff --git a/arch/mips/ath79/mach-pb44.c b/arch/mips/ath79/mach-pb44.c
index 3dc5080..ec7b7a1 100644
--- a/arch/mips/ath79/mach-pb44.c
+++ b/arch/mips/ath79/mach-pb44.c
@@ -17,6 +17,7 @@
 #include "machtypes.h"
 #include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
+#include "dev-spi.h"
 
 #define PB44_GPIO_I2C_SCL	0
 #define PB44_GPIO_I2C_SDA	1
@@ -84,6 +85,20 @@ static struct gpio_keys_button pb44_gpio_keys[] __initdata = {
 	}
 };
 
+static struct spi_board_info pb44_spi_info[] = {
+	{
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.max_speed_hz	= 25000000,
+		.modalias	= "m25p64",
+	},
+};
+
+static struct ath79_spi_platform_data pb44_spi_data = {
+	.bus_num		= 0,
+	.num_chipselect		= 1,
+};
+
 static void __init pb44_init(void)
 {
 	i2c_register_board_info(0, pb44_i2c_board_info,
@@ -95,6 +110,8 @@ static void __init pb44_init(void)
 	ath79_register_gpio_keys_polled(-1, PB44_KEYS_POLL_INTERVAL,
 					ARRAY_SIZE(pb44_gpio_keys),
 					pb44_gpio_keys);
+	ath79_register_spi(&pb44_spi_data, pb44_spi_info,
+			   ARRAY_SIZE(pb44_spi_info));
 }
 
 MIPS_MACHINE(ATH79_MACH_PB44, "PB44", "Atheros PB44 reference board",
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 7f2933d..4f2b621 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -20,6 +20,8 @@
 #include <linux/bitops.h>
 
 #define AR71XX_APB_BASE		0x18000000
+#define AR71XX_SPI_BASE		0x1f000000
+#define AR71XX_SPI_SIZE		0x01000000
 
 #define AR71XX_DDR_CTRL_BASE	(AR71XX_APB_BASE + 0x00000000)
 #define AR71XX_DDR_CTRL_SIZE	0x100
-- 
1.7.2.1
