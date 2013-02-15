Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:42:16 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58632 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827646Ab3BOOifjH0py (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:35 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xt-y3m-zNdaP; Fri, 15 Feb 2013 15:38:24 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 93292280213;
        Fri, 15 Feb 2013 15:38:24 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH 11/11] MIPS: ath79: add support for the Qualcomm Atheros AP136-010 board
Date:   Fri, 15 Feb 2013 15:38:25 +0100
Message-Id: <1360939105-23591-12-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Also enable the board in the default configuration.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/Kconfig           |   12 +++
 arch/mips/ath79/Makefile          |    1 +
 arch/mips/ath79/mach-ap136.c      |  156 +++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h       |    1 +
 arch/mips/configs/ath79_defconfig |    1 +
 5 files changed, 171 insertions(+)
 create mode 100644 arch/mips/ath79/mach-ap136.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 76a001e..3995e31 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -14,6 +14,18 @@ config ATH79_MACH_AP121
 	  Say 'Y' here if you want your kernel to support the
 	  Atheros AP121 reference board.
 
+config ATH79_MACH_AP136
+	bool "Atheros AP136 reference board"
+	select SOC_QCA955X
+	select ATH79_DEV_GPIO_BUTTONS
+	select ATH79_DEV_LEDS_GPIO
+	select ATH79_DEV_SPI
+	select ATH79_DEV_USB
+	select ATH79_DEV_WMAC
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Atheros AP136 reference board.
+
 config ATH79_MACH_AP81
 	bool "Atheros AP81 reference board"
 	select SOC_AR913X
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index 2b54d98..5c9ff69 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_ATH79_DEV_WMAC)		+= dev-wmac.o
 # Machines
 #
 obj-$(CONFIG_ATH79_MACH_AP121)		+= mach-ap121.o
+obj-$(CONFIG_ATH79_MACH_AP136)		+= mach-ap136.o
 obj-$(CONFIG_ATH79_MACH_AP81)		+= mach-ap81.o
 obj-$(CONFIG_ATH79_MACH_DB120)		+= mach-db120.o
 obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
diff --git a/arch/mips/ath79/mach-ap136.c b/arch/mips/ath79/mach-ap136.c
new file mode 100644
index 0000000..479dd4b
--- /dev/null
+++ b/arch/mips/ath79/mach-ap136.c
@@ -0,0 +1,156 @@
+/*
+ * Qualcomm Atheros AP136 reference board support
+ *
+ * Copyright (c) 2012 Qualcomm Atheros
+ * Copyright (c) 2012-2013 Gabor Juhos <juhosg@openwrt.org>
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
+#include "dev-usb.h"
+#include "dev-wmac.h"
+#include "pci.h"
+
+#define AP136_GPIO_LED_STATUS_RED	14
+#define AP136_GPIO_LED_STATUS_GREEN	19
+#define AP136_GPIO_LED_USB		4
+#define AP136_GPIO_LED_WLAN_2G		13
+#define AP136_GPIO_LED_WLAN_5G		12
+#define AP136_GPIO_LED_WPS_RED		15
+#define AP136_GPIO_LED_WPS_GREEN	20
+
+#define AP136_GPIO_BTN_WPS		16
+#define AP136_GPIO_BTN_RFKILL		21
+
+#define AP136_KEYS_POLL_INTERVAL	20	/* msecs */
+#define AP136_KEYS_DEBOUNCE_INTERVAL	(3 * AP136_KEYS_POLL_INTERVAL)
+
+#define AP136_WMAC_CALDATA_OFFSET 0x1000
+#define AP136_PCIE_CALDATA_OFFSET 0x5000
+
+static struct gpio_led ap136_leds_gpio[] __initdata = {
+	{
+		.name		= "qca:green:status",
+		.gpio		= AP136_GPIO_LED_STATUS_GREEN,
+		.active_low	= 1,
+	},
+	{
+		.name		= "qca:red:status",
+		.gpio		= AP136_GPIO_LED_STATUS_RED,
+		.active_low	= 1,
+	},
+	{
+		.name		= "qca:green:wps",
+		.gpio		= AP136_GPIO_LED_WPS_GREEN,
+		.active_low	= 1,
+	},
+	{
+		.name		= "qca:red:wps",
+		.gpio		= AP136_GPIO_LED_WPS_RED,
+		.active_low	= 1,
+	},
+	{
+		.name		= "qca:red:wlan-2g",
+		.gpio		= AP136_GPIO_LED_WLAN_2G,
+		.active_low	= 1,
+	},
+	{
+		.name		= "qca:red:usb",
+		.gpio		= AP136_GPIO_LED_USB,
+		.active_low	= 1,
+	}
+};
+
+static struct gpio_keys_button ap136_gpio_keys[] __initdata = {
+	{
+		.desc		= "WPS button",
+		.type		= EV_KEY,
+		.code		= KEY_WPS_BUTTON,
+		.debounce_interval = AP136_KEYS_DEBOUNCE_INTERVAL,
+		.gpio		= AP136_GPIO_BTN_WPS,
+		.active_low	= 1,
+	},
+	{
+		.desc		= "RFKILL button",
+		.type		= EV_KEY,
+		.code		= KEY_RFKILL,
+		.debounce_interval = AP136_KEYS_DEBOUNCE_INTERVAL,
+		.gpio		= AP136_GPIO_BTN_RFKILL,
+		.active_low	= 1,
+	},
+};
+
+static struct spi_board_info ap136_spi_info[] = {
+	{
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.max_speed_hz	= 25000000,
+		.modalias	= "mx25l6405d",
+	}
+};
+
+static struct ath79_spi_platform_data ap136_spi_data = {
+	.bus_num	= 0,
+	.num_chipselect	= 1,
+};
+
+#ifdef CONFIG_PCI
+static struct ath9k_platform_data ap136_ath9k_data;
+
+static int ap136_pci_plat_dev_init(struct pci_dev *dev)
+{
+	if (dev->bus->number == 1 && (PCI_SLOT(dev->devfn)) == 0)
+		dev->dev.platform_data = &ap136_ath9k_data;
+
+	return 0;
+}
+
+static void __init ap136_pci_init(u8 *eeprom)
+{
+	memcpy(ap136_ath9k_data.eeprom_data, eeprom,
+	       sizeof(ap136_ath9k_data.eeprom_data));
+
+	ath79_pci_set_plat_dev_init(ap136_pci_plat_dev_init);
+	ath79_register_pci();
+}
+#else
+static inline void ap136_pci_init(void) {}
+#endif /* CONFIG_PCI */
+
+static void __init ap136_setup(void)
+{
+	u8 *art = (u8 *) KSEG1ADDR(0x1fff0000);
+
+	ath79_register_leds_gpio(-1, ARRAY_SIZE(ap136_leds_gpio),
+				 ap136_leds_gpio);
+	ath79_register_gpio_keys_polled(-1, AP136_KEYS_POLL_INTERVAL,
+					ARRAY_SIZE(ap136_gpio_keys),
+					ap136_gpio_keys);
+	ath79_register_spi(&ap136_spi_data, ap136_spi_info,
+			   ARRAY_SIZE(ap136_spi_info));
+	ath79_register_usb();
+	ath79_register_wmac(art + AP136_WMAC_CALDATA_OFFSET);
+	ap136_pci_init(art + AP136_PCIE_CALDATA_OFFSET);
+}
+
+MIPS_MACHINE(ATH79_MACH_AP136_010, "AP136-010",
+	     "Atheros AP136-010 reference board",
+	     ap136_setup);
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
index af92e5c..2625405 100644
--- a/arch/mips/ath79/machtypes.h
+++ b/arch/mips/ath79/machtypes.h
@@ -17,6 +17,7 @@
 enum ath79_mach_type {
 	ATH79_MACH_GENERIC = 0,
 	ATH79_MACH_AP121,		/* Atheros AP121 reference board */
+	ATH79_MACH_AP136_010,		/* Atheros AP136-010 reference board */
 	ATH79_MACH_AP81,		/* Atheros AP81 reference board */
 	ATH79_MACH_DB120,		/* Atheros DB120 reference board */
 	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index ea87d43..e3a3836 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ATH79=y
 CONFIG_ATH79_MACH_AP121=y
+CONFIG_ATH79_MACH_AP136=y
 CONFIG_ATH79_MACH_AP81=y
 CONFIG_ATH79_MACH_DB120=y
 CONFIG_ATH79_MACH_PB44=y
-- 
1.7.10
