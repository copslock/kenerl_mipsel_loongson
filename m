Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 23:17:00 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:46702 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904069Ab1KQWOZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 23:14:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 966661403D6;
        Thu, 17 Nov 2011 23:14:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QYRBcrJtOyGg; Thu, 17 Nov 2011 23:14:17 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 478781404EF;
        Thu, 17 Nov 2011 23:14:15 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 6/6] MIPS: ath79: register the wireless MAC device on the AP121 board
Date:   Thu, 17 Nov 2011 23:13:47 +0100
Message-Id: <1321568027-32066-7-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14887

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/mach-ap121.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/mach-ap121.c b/arch/mips/ath79/mach-ap121.c
index 353af55..39ee828 100644
--- a/arch/mips/ath79/mach-ap121.c
+++ b/arch/mips/ath79/mach-ap121.c
@@ -13,6 +13,7 @@
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
 #include "dev-usb.h"
+#include "dev-ar913x-wmac.h"
 
 #define AP121_GPIO_LED_WLAN		0
 #define AP121_GPIO_LED_USB		1
@@ -73,6 +74,8 @@ static struct ath79_spi_platform_data ap121_spi_data = {
 
 static void __init ap121_setup(void)
 {
+	u8 *cal_data = (u8 *) KSEG1ADDR(AP121_CAL_DATA_ADDR);
+
 	ath79_register_leds_gpio(-1, ARRAY_SIZE(ap121_leds_gpio),
 				 ap121_leds_gpio);
 	ath79_register_gpio_keys_polled(-1, AP121_KEYS_POLL_INTERVAL,
@@ -82,6 +85,7 @@ static void __init ap121_setup(void)
 	ath79_register_spi(&ap121_spi_data, ap121_spi_info,
 			   ARRAY_SIZE(ap121_spi_info));
 	ath79_register_usb();
+	ath79_register_wmac(cal_data);
 }
 
 MIPS_MACHINE(ATH79_MACH_AP121, "AP121", "Atheros AP121 reference board",
-- 
1.7.2.1
