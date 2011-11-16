Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 11:57:15 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:50962 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903785Ab1KPK4T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 11:56:19 +0100
Received: by bkat2 with SMTP id t2so446351bka.36
        for <multiple recipients>; Wed, 16 Nov 2011 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=03+7HhHGhwKf0Lw/GRA7WbGZEfPEbxEJp4vt8aFeiq0=;
        b=JvHxTd7vUQ/NINpfXdQCkIh2Q/gXz5aE+VWAMoSKE+KJu+xWMpdAVVdj6ujqyNYd5b
         u/DUL8w5q/qVIntlMxFOu7T37g//I+PPll5ewVJ5TuQZrSGyPWYFoJXJk45JtTsFmVu4
         Uz1NRiQgKrKmRdOuIUyaq5X+mvUqxcLot+dZc=
Received: by 10.205.124.144 with SMTP id go16mr20547780bkc.119.1321440973877;
        Wed, 16 Nov 2011 02:56:13 -0800 (PST)
Received: from localhost.localdomain (dslb-178-003-254-091.pools.arcor-ip.net. [178.3.254.91])
        by mx.google.com with ESMTPS id z7sm38609961bka.1.2011.11.16.02.56.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 02:56:13 -0800 (PST)
From:   Rene Bolldorf <xsecute@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Rene Bolldorf <xsecute@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=202/2=5D=20Initial=20support=20for=20the=20Ubiquiti=20Networks=20XM=20board=2E?=
Date:   Wed, 16 Nov 2011 11:55:40 +0100
Message-Id: <1321440940-20246-3-git-send-email-xsecute@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1321440940-20246-1-git-send-email-xsecute@googlemail.com>
References: <1321440940-20246-1-git-send-email-xsecute@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 31643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13291

Signed-off-by: Rene Bolldorf <xsecute@googlemail.com>
---
 arch/mips/ath79/Kconfig        |   12 ++++
 arch/mips/ath79/Makefile       |    1 +
 arch/mips/ath79/Platform       |    7 ++-
 arch/mips/ath79/mach-ubnt-xm.c |  110 ++++++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h    |    1 +
 5 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/ath79/mach-ubnt-xm.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 4770741..fa74e73 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -23,6 +23,16 @@ config ATH79_MACH_PB44
 	  Say 'Y' here if you want your kernel to support the
 	  Atheros PB44 reference board.
 
+config ATH79_MACH_UBNT_XM
+	bool "Ubiquiti Networks XM board"
+	select SOC_AR724X
+	select ATH79_DEV_GPIO_BUTTONS
+	select ATH79_DEV_LEDS_GPIO
+	select ATH79_DEV_SPI
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Ubiquiti Networks XM board.
+
 endmenu
 
 config SOC_AR71XX
@@ -33,6 +43,8 @@ config SOC_AR71XX
 config SOC_AR724X
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
+	select HW_HAS_PCI
+	select PCI
 	def_bool n
 
 config SOC_AR913X
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index c33d465..ac9f375 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_ATH79_DEV_SPI)		+= dev-spi.o
 #
 obj-$(CONFIG_ATH79_MACH_AP81)		+= mach-ap81.o
 obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
+obj-$(CONFIG_ATH79_MACH_UBNT_XM)	+= mach-ubnt-xm.o
diff --git a/arch/mips/ath79/Platform b/arch/mips/ath79/Platform
index 2bd6636..aca7ab1 100644
--- a/arch/mips/ath79/Platform
+++ b/arch/mips/ath79/Platform
@@ -2,6 +2,7 @@
 # Atheros AR71xx/AR724x/AR913x
 #
 
-platform-$(CONFIG_ATH79)	+= ath79/
-cflags-$(CONFIG_ATH79)		+= -I$(srctree)/arch/mips/include/asm/mach-ath79
-load-$(CONFIG_ATH79)		= 0xffffffff80060000
+platform-$(CONFIG_ATH79)		+= ath79/
+cflags-$(CONFIG_ATH79)			+= -I$(srctree)/arch/mips/include/asm/mach-ath79
+load-$(CONFIG_ATH79)			= 0xffffffff80060000
+load-$(CONFIG_ATH79_MACH_UBNT_XM)	= 0xffffffff80002000
diff --git a/arch/mips/ath79/mach-ubnt-xm.c b/arch/mips/ath79/mach-ubnt-xm.c
new file mode 100644
index 0000000..150a0a0
--- /dev/null
+++ b/arch/mips/ath79/mach-ubnt-xm.c
@@ -0,0 +1,110 @@
+/*
+ *  Ubiquiti Networks XM board support
+ *
+ *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
+ *
+ *  Derived from: mach-pb44.c
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/ath9k_platform.h>
+
+#include "machtypes.h"
+#include "dev-gpio-buttons.h"
+#include "dev-leds-gpio.h"
+#include "dev-spi.h"
+
+#define UBNT_XM_GPIO_LED_L1		0
+#define UBNT_XM_GPIO_LED_L2		1
+#define UBNT_XM_GPIO_LED_L3		11
+#define UBNT_XM_GPIO_LED_L4		7
+
+#define UBNT_XM_GPIO_BTN_RESET		12
+
+#define UBNT_XM_KEYS_POLL_INTERVAL	20
+#define UBNT_XM_KEYS_DEBOUNCE_INTERVAL	(3 * UBNT_XM_KEYS_POLL_INTERVAL)
+
+#define UBNT_XM_PCI_IRQ			48
+#define UBNT_XM_EEPROM_ADDR		(u8 *) KSEG1ADDR(0x1fff1000)
+
+static struct gpio_led ubnt_xm_leds_gpio[] __initdata = {
+	{
+		.name		= "signal:poor",
+		.gpio		= UBNT_XM_GPIO_LED_L1,
+		.active_low	= 0,
+	}, {
+		.name		= "signal:bad",
+		.gpio		= UBNT_XM_GPIO_LED_L2,
+		.active_low	= 0,
+	}, {
+		.name		= "signal:good",
+		.gpio		= UBNT_XM_GPIO_LED_L3,
+		.active_low	= 0,
+	}, {
+		.name		= "signal:excellent",
+		.gpio		= UBNT_XM_GPIO_LED_L4,
+		.active_low	= 0,
+	},
+};
+
+static struct gpio_keys_button ubnt_xm_gpio_keys[] __initdata = {
+	{
+		.desc		= "reset",
+		.type		= EV_KEY,
+		.code		= KEY_RESTART,
+		.debounce_interval = UBNT_XM_KEYS_DEBOUNCE_INTERVAL,
+		.gpio		= UBNT_XM_GPIO_BTN_RESET,
+		.active_low	= 1,
+	}
+};
+
+static struct spi_board_info ubnt_xm_spi_info[] = {
+	{
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.max_speed_hz	= 25000000,
+		.modalias	= "mx25l6405d",
+	}
+};
+
+static struct ath79_spi_platform_data ubnt_xm_spi_data = {
+	.bus_num		= 0,
+	.num_chipselect		= 1,
+};
+
+static struct ath9k_platform_data ubnt_xm_eeprom_data;
+
+int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
+{
+	return UBNT_XM_PCI_IRQ;
+}
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	dev->dev.platform_data = &ubnt_xm_eeprom_data;
+
+	return 0;
+}
+
+static void __init ubnt_xm_init(void)
+{
+	ath79_register_leds_gpio(-1, ARRAY_SIZE(ubnt_xm_leds_gpio),
+				 ubnt_xm_leds_gpio);
+
+	ath79_register_gpio_keys_polled(-1, UBNT_XM_KEYS_POLL_INTERVAL,
+					ARRAY_SIZE(ubnt_xm_gpio_keys),
+					ubnt_xm_gpio_keys);
+
+	ath79_register_spi(&ubnt_xm_spi_data, ubnt_xm_spi_info,
+			   ARRAY_SIZE(ubnt_xm_spi_info));
+
+	memcpy(ubnt_xm_eeprom_data.eeprom_data, UBNT_XM_EEPROM_ADDR,
+	       sizeof(ubnt_xm_eeprom_data.eeprom_data));
+}
+
+MIPS_MACHINE(ATH79_MACH_UBNT_XM, "UBNT-XM", "Ubiquiti Networks XM board", ubnt_xm_init);
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
index 3940fe4..1bb0747 100644
--- a/arch/mips/ath79/machtypes.h
+++ b/arch/mips/ath79/machtypes.h
@@ -18,6 +18,7 @@ enum ath79_mach_type {
 	ATH79_MACH_GENERIC = 0,
 	ATH79_MACH_AP81,		/* Atheros AP81 reference board */
 	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
+	ATH79_MACH_UBNT_XM,		/* Ubiquiti Networks XM board */
 };
 
 #endif /* _ATH79_MACHTYPE_H */
-- 
1.7.7.1
