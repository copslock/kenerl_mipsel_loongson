Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:55:22 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:56999 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492166Ab0KLVv7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Nov 2010 22:51:59 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id E4F6041C011;
        Fri, 12 Nov 2010 22:51:53 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 3ECDC270001;
        Fri, 12 Nov 2010 22:51:53 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC 17/18] MIPS: ath79: add initial support for the Atheros AP81 reference board
Date:   Fri, 12 Nov 2010 22:51:23 +0100
Message-Id: <1289598684-30624-18-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A122BA70962 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/mips/ath79/Kconfig     |   13 ++++++
 arch/mips/ath79/Makefile    |    1 +
 arch/mips/ath79/mach-ap81.c |   93 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h |    1 +
 4 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/mach-ap81.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 9843044..53d9b39 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -2,6 +2,19 @@ if ATH79
 
 menu "Atheros AR71XX/AR724X/AR913X machine selection"
 
+config ATH79_MACH_AP81
+	bool "Atheros AP81 reference board"
+	select SOC_AR913X
+	select ATH79_DEV_AR913X_WMAC
+	select ATH79_DEV_GPIO_BUTTONS
+	select ATH79_DEV_LEDS_GPIO
+	select ATH79_DEV_SPI
+	select ATH79_DEV_USB
+	default n
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Atheros AP81 reference board.
+
 config ATH79_MACH_PB44
 	bool "Atheros PB44 reference board"
 	select SOC_AR71XX
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index e0c07a7..107f1e8 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -22,4 +22,5 @@ obj-$(CONFIG_ATH79_DEV_WDT)		+= dev-wdt.o
 #
 # Machines
 #
+obj-$(CONFIG_ATH79_MACH_AP81)		+= mach-ap81.o
 obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
diff --git a/arch/mips/ath79/mach-ap81.c b/arch/mips/ath79/mach-ap81.c
new file mode 100644
index 0000000..9cfaff3
--- /dev/null
+++ b/arch/mips/ath79/mach-ap81.c
@@ -0,0 +1,93 @@
+/*
+ *  Atheros AP81 board support
+ *
+ *  Copyright (C) 2009-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2009 Imre Kaloz <kaloz@openwrt.org>
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
+#define AP81_GPIO_LED_STATUS	1
+#define AP81_GPIO_LED_AOSS	3
+#define AP81_GPIO_LED_WLAN	6
+#define AP81_GPIO_LED_POWER	14
+
+#define AP81_GPIO_BTN_SW4	12
+#define AP81_GPIO_BTN_SW1	21
+
+#define AP81_BUTTONS_POLL_INTERVAL	20
+
+static struct gpio_led ap81_leds_gpio[] __initdata = {
+	{
+		.name		= "ap81:green:status",
+		.gpio		= AP81_GPIO_LED_STATUS,
+		.active_low	= 1,
+	}, {
+		.name		= "ap81:amber:aoss",
+		.gpio		= AP81_GPIO_LED_AOSS,
+		.active_low	= 1,
+	}, {
+		.name		= "ap81:green:wlan",
+		.gpio		= AP81_GPIO_LED_WLAN,
+		.active_low	= 1,
+	}, {
+		.name		= "ap81:green:power",
+		.gpio		= AP81_GPIO_LED_POWER,
+		.active_low	= 1,
+	}
+};
+
+static struct gpio_button ap81_gpio_buttons[] __initdata = {
+	{
+		.desc		= "sw1",
+		.type		= EV_KEY,
+		.code		= BTN_0,
+		.threshold	= 3,
+		.gpio		= AP81_GPIO_BTN_SW1,
+		.active_low	= 1,
+	} , {
+		.desc		= "sw4",
+		.type		= EV_KEY,
+		.code		= BTN_1,
+		.threshold	= 3,
+		.gpio		= AP81_GPIO_BTN_SW4,
+		.active_low	= 1,
+	}
+};
+
+static struct spi_board_info ap81_spi_info[] = {
+	{
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.max_speed_hz	= 25000000,
+		.modalias	= "m25p64",
+	}
+};
+
+static struct ath79_spi_platform_data ap81_spi_data = {
+	.bus_num	= 0,
+	.num_chipselect	= 1,
+};
+
+static void __init ap81_setup(void)
+{
+	ath79_register_leds_gpio(-1, ARRAY_SIZE(ap81_leds_gpio),
+				 ap81_leds_gpio);
+	ath79_register_gpio_buttons(-1, AP81_BUTTONS_POLL_INTERVAL,
+				    ARRAY_SIZE(ap81_gpio_buttons),
+				    ap81_gpio_buttons);
+	ath79_register_spi(&ap81_spi_data, ap81_spi_info,
+			   ARRAY_SIZE(ap81_spi_info));
+	ath79_register_usb();
+}
+
+MIPS_MACHINE(ATH79_MACH_AP81, "AP81", "Atheros AP81 reference board",
+	     ap81_setup);
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
index a796fa3..3940fe4 100644
--- a/arch/mips/ath79/machtypes.h
+++ b/arch/mips/ath79/machtypes.h
@@ -16,6 +16,7 @@
 
 enum ath79_mach_type {
 	ATH79_MACH_GENERIC = 0,
+	ATH79_MACH_AP81,		/* Atheros AP81 reference board */
 	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
 };
 
-- 
1.7.2.1
