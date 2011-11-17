Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 23:14:51 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:46690 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904063Ab1KQWOU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 23:14:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 8196D1404F0;
        Thu, 17 Nov 2011 23:14:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QreY7cNW1xCY; Thu, 17 Nov 2011 23:14:15 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 60E1E140451;
        Thu, 17 Nov 2011 23:14:14 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/6] MIPS: ath79: remove 'ar913x' from common variable and function names
Date:   Thu, 17 Nov 2011 23:13:43 +0100
Message-Id: <1321568027-32066-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14879

The wireless MAC specific variables and the registration
code can be shared between multiple SoCs. Remove the 'ar913x'
part from the function and variable names to avoid confusions.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-ar913x-wmac.c |   20 ++++++++++----------
 arch/mips/ath79/dev-ar913x-wmac.h |    8 ++++----
 arch/mips/ath79/mach-ap81.c       |    2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/mips/ath79/dev-ar913x-wmac.c b/arch/mips/ath79/dev-ar913x-wmac.c
index 48f425a..2c9ba40 100644
--- a/arch/mips/ath79/dev-ar913x-wmac.c
+++ b/arch/mips/ath79/dev-ar913x-wmac.c
@@ -19,9 +19,9 @@
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "dev-ar913x-wmac.h"
 
-static struct ath9k_platform_data ar913x_wmac_data;
+static struct ath9k_platform_data ath79_wmac_data;
 
-static struct resource ar913x_wmac_resources[] = {
+static struct resource ath79_wmac_resources[] = {
 	{
 		.start	= AR913X_WMAC_BASE,
 		.end	= AR913X_WMAC_BASE + AR913X_WMAC_SIZE - 1,
@@ -33,21 +33,21 @@ static struct resource ar913x_wmac_resources[] = {
 	},
 };
 
-static struct platform_device ar913x_wmac_device = {
+static struct platform_device ath79_wmac_device = {
 	.name		= "ath9k",
 	.id		= -1,
-	.resource	= ar913x_wmac_resources,
-	.num_resources	= ARRAY_SIZE(ar913x_wmac_resources),
+	.resource	= ath79_wmac_resources,
+	.num_resources	= ARRAY_SIZE(ath79_wmac_resources),
 	.dev = {
-		.platform_data = &ar913x_wmac_data,
+		.platform_data = &ath79_wmac_data,
 	},
 };
 
-void __init ath79_register_ar913x_wmac(u8 *cal_data)
+void __init ath79_register_wmac(u8 *cal_data)
 {
 	if (cal_data)
-		memcpy(ar913x_wmac_data.eeprom_data, cal_data,
-		       sizeof(ar913x_wmac_data.eeprom_data));
+		memcpy(ath79_wmac_data.eeprom_data, cal_data,
+		       sizeof(ath79_wmac_data.eeprom_data));
 
 	/* reset the WMAC */
 	ath79_device_reset_set(AR913X_RESET_AMBA2WMAC);
@@ -56,5 +56,5 @@ void __init ath79_register_ar913x_wmac(u8 *cal_data)
 	ath79_device_reset_clear(AR913X_RESET_AMBA2WMAC);
 	mdelay(10);
 
-	platform_device_register(&ar913x_wmac_device);
+	platform_device_register(&ath79_wmac_device);
 }
diff --git a/arch/mips/ath79/dev-ar913x-wmac.h b/arch/mips/ath79/dev-ar913x-wmac.h
index 579d562..de1d784 100644
--- a/arch/mips/ath79/dev-ar913x-wmac.h
+++ b/arch/mips/ath79/dev-ar913x-wmac.h
@@ -9,9 +9,9 @@
  *  by the Free Software Foundation.
  */
 
-#ifndef _ATH79_DEV_AR913X_WMAC_H
-#define _ATH79_DEV_AR913X_WMAC_H
+#ifndef _ATH79_DEV_WMAC_H
+#define _ATH79_DEV_WMAC_H
 
-void ath79_register_ar913x_wmac(u8 *cal_data);
+void ath79_register_wmac(u8 *cal_data);
 
-#endif /* _ATH79_DEV_AR913X_WMAC_H */
+#endif /* _ATH79_DEV_WMAC_H */
diff --git a/arch/mips/ath79/mach-ap81.c b/arch/mips/ath79/mach-ap81.c
index 6c08267..84442da 100644
--- a/arch/mips/ath79/mach-ap81.c
+++ b/arch/mips/ath79/mach-ap81.c
@@ -92,7 +92,7 @@ static void __init ap81_setup(void)
 					ap81_gpio_keys);
 	ath79_register_spi(&ap81_spi_data, ap81_spi_info,
 			   ARRAY_SIZE(ap81_spi_info));
-	ath79_register_ar913x_wmac(cal_data);
+	ath79_register_wmac(cal_data);
 	ath79_register_usb();
 }
 
-- 
1.7.2.1
