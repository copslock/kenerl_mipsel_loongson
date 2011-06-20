Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:33:25 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35948 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491161Ab1FTT1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:17 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id F30A4140220;
        Mon, 20 Jun 2011 21:27:08 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 725A7140209;
        Mon, 20 Jun 2011 21:27:08 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 13/13] MIPS: ath79: add initial support for the Atheros AP121 reference board
Date:   Mon, 20 Jun 2011 21:26:13 +0200
Message-Id: <1308597973-6037-14-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A131A599EB1 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16507

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/Kconfig      |   11 +++++
 arch/mips/ath79/Makefile     |    1 +
 arch/mips/ath79/mach-ap121.c |   88 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h  |    1 +
 4 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/mach-ap121.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index c3680c8..4a7e0e8 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -2,6 +2,17 @@ if ATH79
 
 menu "Atheros AR71XX/AR724X/AR913X machine selection"
 
+config ATH79_MACH_AP121
+	bool "Atheros AP121 reference board"
+	select SOC_AR933X
+	select ATH79_DEV_GPIO_BUTTONS
+	select ATH79_DEV_LEDS_GPIO
+	select ATH79_DEV_SPI
+	select ATH79_DEV_USB
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Atheros AP121 reference board.
+
 config ATH79_MACH_AP81
 	bool "Atheros AP81 reference board"
 	select SOC_AR913X
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index 57188b6..8933d18 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -25,5 +25,6 @@ obj-$(CONFIG_ATH79_DEV_USB)		+= dev-usb.o
 #
 # Machines
 #
+obj-$(CONFIG_ATH79_MACH_AP121)		+= mach-ap121.o
 obj-$(CONFIG_ATH79_MACH_AP81)		+= mach-ap81.o
 obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
diff --git a/arch/mips/ath79/mach-ap121.c b/arch/mips/ath79/mach-ap121.c
new file mode 100644
index 0000000..353af55
--- /dev/null
+++ b/arch/mips/ath79/mach-ap121.c
@@ -0,0 +1,88 @@
+/*
+ *  Atheros AP121 board support
+ *
+ *  Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include "machtypes.h"
+#include "dev-gpio-buttons.h"
+#include "dev-leds-gpio.h"
+#include "dev-spi.h"
+#include "dev-usb.h"
+
+#define AP121_GPIO_LED_WLAN		0
+#define AP121_GPIO_LED_USB		1
+
+#define AP121_GPIO_BTN_JUMPSTART	11
+#define AP121_GPIO_BTN_RESET		12
+
+#define AP121_KEYS_POLL_INTERVAL	20	/* msecs */
+#define AP121_KEYS_DEBOUNCE_INTERVAL	(3 * AP121_KEYS_POLL_INTERVAL)
+
+#define AP121_CAL_DATA_ADDR	0x1fff1000
+
+static struct gpio_led ap121_leds_gpio[] __initdata = {
+	{
+		.name		= "ap121:green:usb",
+		.gpio		= AP121_GPIO_LED_USB,
+		.active_low	= 0,
+	},
+	{
+		.name		= "ap121:green:wlan",
+		.gpio		= AP121_GPIO_LED_WLAN,
+		.active_low	= 0,
+	},
+};
+
+static struct gpio_keys_button ap121_gpio_keys[] __initdata = {
+	{
+		.desc		= "jumpstart button",
+		.type		= EV_KEY,
+		.code		= KEY_WPS_BUTTON,
+		.debounce_interval = AP121_KEYS_DEBOUNCE_INTERVAL,
+		.gpio		= AP121_GPIO_BTN_JUMPSTART,
+		.active_low	= 1,
+	},
+	{
+		.desc		= "reset button",
+		.type		= EV_KEY,
+		.code		= KEY_RESTART,
+		.debounce_interval = AP121_KEYS_DEBOUNCE_INTERVAL,
+		.gpio		= AP121_GPIO_BTN_RESET,
+		.active_low	= 1,
+	}
+};
+
+static struct spi_board_info ap121_spi_info[] = {
+	{
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.max_speed_hz	= 25000000,
+		.modalias	= "mx25l1606e",
+	}
+};
+
+static struct ath79_spi_platform_data ap121_spi_data = {
+	.bus_num	= 0,
+	.num_chipselect	= 1,
+};
+
+static void __init ap121_setup(void)
+{
+	ath79_register_leds_gpio(-1, ARRAY_SIZE(ap121_leds_gpio),
+				 ap121_leds_gpio);
+	ath79_register_gpio_keys_polled(-1, AP121_KEYS_POLL_INTERVAL,
+					ARRAY_SIZE(ap121_gpio_keys),
+					ap121_gpio_keys);
+
+	ath79_register_spi(&ap121_spi_data, ap121_spi_info,
+			   ARRAY_SIZE(ap121_spi_info));
+	ath79_register_usb();
+}
+
+MIPS_MACHINE(ATH79_MACH_AP121, "AP121", "Atheros AP121 reference board",
+	     ap121_setup);
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
index 3940fe4..6e28d51 100644
--- a/arch/mips/ath79/machtypes.h
+++ b/arch/mips/ath79/machtypes.h
@@ -16,6 +16,7 @@
 
 enum ath79_mach_type {
 	ATH79_MACH_GENERIC = 0,
+	ATH79_MACH_AP121,		/* Atheros AP121 reference board */
 	ATH79_MACH_AP81,		/* Atheros AP81 reference board */
 	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
 };
-- 
1.7.2.1
