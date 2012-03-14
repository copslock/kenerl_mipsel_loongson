Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 20:34:03 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:35162 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903740Ab2CNTd5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 20:33:57 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 9C6CE23C00DA;
        Wed, 14 Mar 2012 20:03:30 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, juhosg@openwrt.org
Subject: [PATCH v2.1 13/13] MIPS: ath79: add initial support for the Atheros DB120 board
Date:   Wed, 14 Mar 2012 21:39:35 +0100
Message-Id: <1331757575-10161-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 32708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
v2.1: - use ISC license
v2: - remove USB controller registration, it will be added
      by a separate patch-set

Ralf,

Here is the ISC licensed version of the patch. Feel free to use
this if you are not satisfied with the ClearBSD version.

Thanks,
Gabor

 arch/mips/ath79/Kconfig      |   12 ++++
 arch/mips/ath79/Makefile     |    1 +
 arch/mips/ath79/mach-db120.c |  134 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h  |    1 +
 4 files changed, 148 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/ath79/mach-db120.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index ea28e89..f44feee 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -26,6 +26,18 @@ config ATH79_MACH_AP81
 	  Say 'Y' here if you want your kernel to support the
 	  Atheros AP81 reference board.
 
+config ATH79_MACH_DB120
+	bool "Atheros DB120 reference board"
+	select SOC_AR934X
+	select ATH79_DEV_GPIO_BUTTONS
+	select ATH79_DEV_LEDS_GPIO
+	select ATH79_DEV_SPI
+	select ATH79_DEV_USB
+	select ATH79_DEV_WMAC
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Atheros DB120 reference board.
+
 config ATH79_MACH_PB44
 	bool "Atheros PB44 reference board"
 	select SOC_AR71XX
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index 221a76a9..2b54d98 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -28,5 +28,6 @@ obj-$(CONFIG_ATH79_DEV_WMAC)		+= dev-wmac.o
 #
 obj-$(CONFIG_ATH79_MACH_AP121)		+= mach-ap121.o
 obj-$(CONFIG_ATH79_MACH_AP81)		+= mach-ap81.o
+obj-$(CONFIG_ATH79_MACH_DB120)		+= mach-db120.o
 obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
 obj-$(CONFIG_ATH79_MACH_UBNT_XM)	+= mach-ubnt-xm.o
diff --git a/arch/mips/ath79/mach-db120.c b/arch/mips/ath79/mach-db120.c
new file mode 100644
index 0000000..1983e4d
--- /dev/null
+++ b/arch/mips/ath79/mach-db120.c
@@ -0,0 +1,134 @@
+/*
+ * Atheros DB120 reference board support
+ *
+ * Copyright (c) 2011 Qualcomm Atheros
+ * Copyright (c) 2011 Gabor Juhos <juhosg@openwrt.org>
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/ath9k_platform.h>
+
+#include "machtypes.h"
+#include "dev-gpio-buttons.h"
+#include "dev-leds-gpio.h"
+#include "dev-spi.h"
+#include "dev-wmac.h"
+#include "pci.h"
+
+#define DB120_GPIO_LED_WLAN_5G		12
+#define DB120_GPIO_LED_WLAN_2G		13
+#define DB120_GPIO_LED_STATUS		14
+#define DB120_GPIO_LED_WPS		15
+
+#define DB120_GPIO_BTN_WPS		16
+
+#define DB120_KEYS_POLL_INTERVAL	20	/* msecs */
+#define DB120_KEYS_DEBOUNCE_INTERVAL	(3 * DB120_KEYS_POLL_INTERVAL)
+
+#define DB120_WMAC_CALDATA_OFFSET 0x1000
+#define DB120_PCIE_CALDATA_OFFSET 0x5000
+
+static struct gpio_led db120_leds_gpio[] __initdata = {
+	{
+		.name		= "db120:green:status",
+		.gpio		= DB120_GPIO_LED_STATUS,
+		.active_low	= 1,
+	},
+	{
+		.name		= "db120:green:wps",
+		.gpio		= DB120_GPIO_LED_WPS,
+		.active_low	= 1,
+	},
+	{
+		.name		= "db120:green:wlan-5g",
+		.gpio		= DB120_GPIO_LED_WLAN_5G,
+		.active_low	= 1,
+	},
+	{
+		.name		= "db120:green:wlan-2g",
+		.gpio		= DB120_GPIO_LED_WLAN_2G,
+		.active_low	= 1,
+	},
+};
+
+static struct gpio_keys_button db120_gpio_keys[] __initdata = {
+	{
+		.desc		= "WPS button",
+		.type		= EV_KEY,
+		.code		= KEY_WPS_BUTTON,
+		.debounce_interval = DB120_KEYS_DEBOUNCE_INTERVAL,
+		.gpio		= DB120_GPIO_BTN_WPS,
+		.active_low	= 1,
+	},
+};
+
+static struct spi_board_info db120_spi_info[] = {
+	{
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.max_speed_hz	= 25000000,
+		.modalias	= "s25sl064a",
+	}
+};
+
+static struct ath79_spi_platform_data db120_spi_data = {
+	.bus_num	= 0,
+	.num_chipselect	= 1,
+};
+
+#ifdef CONFIG_PCI
+static struct ath9k_platform_data db120_ath9k_data;
+
+static int db120_pci_plat_dev_init(struct pci_dev *dev)
+{
+	switch (PCI_SLOT(dev->devfn)) {
+	case 0:
+		dev->dev.platform_data = &db120_ath9k_data;
+		break;
+	}
+
+	return 0;
+}
+
+static void __init db120_pci_init(u8 *eeprom)
+{
+	memcpy(db120_ath9k_data.eeprom_data, eeprom,
+	       sizeof(db120_ath9k_data.eeprom_data));
+
+	ath79_pci_set_plat_dev_init(db120_pci_plat_dev_init);
+	ath79_register_pci();
+}
+#else
+static inline void db120_pci_init(void) {}
+#endif /* CONFIG_PCI */
+
+static void __init db120_setup(void)
+{
+	u8 *art = (u8 *) KSEG1ADDR(0x1fff0000);
+
+	ath79_register_leds_gpio(-1, ARRAY_SIZE(db120_leds_gpio),
+				 db120_leds_gpio);
+	ath79_register_gpio_keys_polled(-1, DB120_KEYS_POLL_INTERVAL,
+					ARRAY_SIZE(db120_gpio_keys),
+					db120_gpio_keys);
+	ath79_register_spi(&db120_spi_data, db120_spi_info,
+			   ARRAY_SIZE(db120_spi_info));
+	ath79_register_wmac(art + DB120_WMAC_CALDATA_OFFSET);
+	db120_pci_init(art + DB120_PCIE_CALDATA_OFFSET);
+}
+
+MIPS_MACHINE(ATH79_MACH_DB120, "DB120", "Atheros DB120 reference board",
+	     db120_setup);
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
index 9a1f382..af92e5c 100644
--- a/arch/mips/ath79/machtypes.h
+++ b/arch/mips/ath79/machtypes.h
@@ -18,6 +18,7 @@ enum ath79_mach_type {
 	ATH79_MACH_GENERIC = 0,
 	ATH79_MACH_AP121,		/* Atheros AP121 reference board */
 	ATH79_MACH_AP81,		/* Atheros AP81 reference board */
+	ATH79_MACH_DB120,		/* Atheros DB120 reference board */
 	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
 	ATH79_MACH_UBNT_XM,		/* Ubiquiti Networks XM board rev 1.0 */
 };
-- 
1.7.2.1
