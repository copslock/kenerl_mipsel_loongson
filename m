Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Oct 2016 17:35:48 +0200 (CEST)
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38191 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990845AbcJCPfkdrO0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Oct 2016 17:35:40 +0200
Received: by mail-wm0-f43.google.com with SMTP id p138so157784961wmb.1
        for <linux-mips@linux-mips.org>; Mon, 03 Oct 2016 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TlqwoQvxsX+0Rcm5xWqRP50OHj0qeowLr4PWQWkBiVg=;
        b=lZ+tXKD8DM3uupXa1VVfYG+BtF+tGEwRC3CNWiDD2SbhzIeQpcwyrQ89ldTNOdlEKe
         C/HLSriJuE2HcQlZ7013W+ojD7qCRQ0qxOsCpYq8MNrr5hEiyCteOln+rSoslG6gHo+I
         hC2ZLuZV1W614t4EGgo2kpntDzWFaGWxLRLZyoE6/U0aY1wf04fWQQmwKNn43MKPz+Bk
         YXKJMRVsiFeFQfb0vNH3jjONls7aZT5l6h5XgftLZvOphaq9aAzWSv6fyJNdG6Lgf4Fq
         cP4SEHuu9kjnHnpoahC8/p/qHcGf/a7qKpnTsgHbHKhBPXs0mx+iiu5sN0S3v/Ocbacy
         2STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TlqwoQvxsX+0Rcm5xWqRP50OHj0qeowLr4PWQWkBiVg=;
        b=MtnbM17drUMxNDIA4hm4YcPAXkxZo3PIzIiKpD5Lf/HckijffTrMUh+SlJb1OjVEFT
         kpw9iBVI4bOKVvrmHXn8pK3sIW7R3TATqXTPhSm80iExa5AHsng1KN43xOUyvUXJ5Twp
         VzZqZYJqGC6Q9C/zBlZFImWLioxag1RRT/iCGE+NWbXM07llsKTCEhZYPTAlLhoHo4sR
         NjHdy2L/ESl0AqVPpIzv17WBPoXQkcwS7KlTilGFBUBL+QDofXpXTVyFG6RpuZoBwT5+
         bDv+VmoenPanp5jKjYjf16U2jiWdAUg08KftuBGO4/zhyVhT+Fy5t0ZtfJFaRS9D1Td+
         BVvw==
X-Gm-Message-State: AA6/9Rkaoqjzd8pJ4pBWpUzzR7A/HSvvg4L14R2O85r4bU/K5OAeRTprAQMVzzzUL3pXiXjd
X-Received: by 10.194.205.134 with SMTP id lg6mr21918139wjc.148.1475508935121;
        Mon, 03 Oct 2016 08:35:35 -0700 (PDT)
Received: from localhost.localdomain ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ce6sm34924915wjc.27.2016.10.03.08.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Oct 2016 08:35:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ralf@linux-mips.org, albeu@free.fr
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ath79: Add initial support for the HAPROXY Aloha Pocket board
Date:   Mon,  3 Oct 2016 17:35:31 +0200
Message-Id: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <narmstrong@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: narmstrong@baylibre.com
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

The HAPROXY Aloha pocket board is a Load Balancer demo board based on the
Atheros AR9331 SoC with 64Mbytes DDR and 16Mbytes on-board SPI Flash.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/mips/ath79/Kconfig             | 12 ++++++
 arch/mips/ath79/Makefile            |  1 +
 arch/mips/ath79/mach-aloha-pocket.c | 86 +++++++++++++++++++++++++++++++++++++
 arch/mips/ath79/machtypes.h         |  1 +
 4 files changed, 100 insertions(+)
 create mode 100644 arch/mips/ath79/mach-aloha-pocket.c

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index dfc6020..937cede 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -71,6 +71,18 @@ config ATH79_MACH_UBNT_XM
 	  Say 'Y' here if you want your kernel to support the
 	  Ubiquiti Networks XM (rev 1.0) board.
 
+config ATH79_MACH_ALOHA_POCKET
+	bool "HAPROXY Aloha Pocket board"
+	select SOC_AR933X
+	select ATH79_DEV_GPIO_BUTTONS
+	select ATH79_DEV_LEDS_GPIO
+	select ATH79_DEV_SPI
+	select ATH79_DEV_USB
+	select ATH79_DEV_WMAC
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  HAPROXY Aloha Pocket board.
+
 endmenu
 
 config SOC_AR71XX
diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index fcc382c..a87c4ee 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_ATH79_MACH_AP81)		+= mach-ap81.o
 obj-$(CONFIG_ATH79_MACH_DB120)		+= mach-db120.o
 obj-$(CONFIG_ATH79_MACH_PB44)		+= mach-pb44.o
 obj-$(CONFIG_ATH79_MACH_UBNT_XM)	+= mach-ubnt-xm.o
+obj-$(CONFIG_ATH79_MACH_ALOHA_POCKET)	+= mach-aloha-pocket.o
diff --git a/arch/mips/ath79/mach-aloha-pocket.c b/arch/mips/ath79/mach-aloha-pocket.c
new file mode 100644
index 0000000..2beb068
--- /dev/null
+++ b/arch/mips/ath79/mach-aloha-pocket.c
@@ -0,0 +1,86 @@
+/*
+ *  HAPROXY Aloha Pocket board support
+ *
+ *  Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
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
+#include "dev-wmac.h"
+
+#define ALOHA_POCKET_GPIO_LED_WLAN		0
+#define ALOHA_POCKET_GPIO_LED_LAN		13
+
+#define ALOHA_POCKET_GPIO_BTN_RESET		11
+
+#define ALOHA_POCKET_KEYS_POLL_INTERVAL	20	/* msecs */
+#define ALOHA_POCKET_KEYS_DEBOUNCE_INTERVAL	\
+					(3 * ALOHA_POCKET_KEYS_POLL_INTERVAL)
+
+#define ALOHA_POCKET_CAL_DATA_ADDR	0x1fff1000
+
+static struct gpio_led aloha_pocket_leds_gpio[] __initdata = {
+	{
+		.name		= "aloha-pocket:red:wlan",
+		.gpio		= ALOHA_POCKET_GPIO_LED_WLAN,
+		.active_low	= 0,
+	},
+	{
+		.name		= "aloha-pocket:green:lan",
+		.gpio		= ALOHA_POCKET_GPIO_LED_LAN,
+		.active_low	= 0,
+		.default_state	= 1,
+	},
+};
+
+static struct gpio_keys_button aloha_pocket_gpio_keys[] __initdata = {
+	{
+		.desc		= "reset button",
+		.type		= EV_KEY,
+		.code		= KEY_RESTART,
+		.debounce_interval = ALOHA_POCKET_KEYS_DEBOUNCE_INTERVAL,
+		.gpio		= ALOHA_POCKET_GPIO_BTN_RESET,
+		.active_low	= 0,
+	}
+};
+
+static struct spi_board_info aloha_pocket_spi_info[] = {
+	{
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.max_speed_hz	= 25000000,
+		.modalias	= "mx25l1606e",
+	}
+};
+
+static struct ath79_spi_platform_data aloha_pocket_spi_data = {
+	.bus_num	= 0,
+	.num_chipselect = 1,
+};
+
+static void __init aloha_pocket_setup(void)
+{
+	u8 *cal_data = (u8 *) KSEG1ADDR(ALOHA_POCKET_CAL_DATA_ADDR);
+
+	ath79_register_leds_gpio(-1, ARRAY_SIZE(aloha_pocket_leds_gpio),
+				 aloha_pocket_leds_gpio);
+	ath79_register_gpio_keys_polled(-1, ALOHA_POCKET_KEYS_POLL_INTERVAL,
+					ARRAY_SIZE(aloha_pocket_gpio_keys),
+					aloha_pocket_gpio_keys);
+
+	ath79_register_spi(&aloha_pocket_spi_data, aloha_pocket_spi_info,
+			   ARRAY_SIZE(aloha_pocket_spi_info));
+	ath79_register_usb();
+	ath79_register_wmac(cal_data);
+}
+
+MIPS_MACHINE(ATH79_MACH_ALOHA_POCKET, "ALOHA-Pocket",
+	     "HAPROXY ALOHA Pocket board", aloha_pocket_setup);
diff --git a/arch/mips/ath79/machtypes.h b/arch/mips/ath79/machtypes.h
index a13db3d..9c63895 100644
--- a/arch/mips/ath79/machtypes.h
+++ b/arch/mips/ath79/machtypes.h
@@ -23,6 +23,7 @@ enum ath79_mach_type {
 	ATH79_MACH_DB120,		/* Atheros DB120 reference board */
 	ATH79_MACH_PB44,		/* Atheros PB44 reference board */
 	ATH79_MACH_UBNT_XM,		/* Ubiquiti Networks XM board rev 1.0 */
+	ATH79_MACH_ALOHA_POCKET,	/* HAPROXY Aloha Pocket board */
 };
 
 #endif /* _ATH79_MACHTYPE_H */
-- 
1.9.1
