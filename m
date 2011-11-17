Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 00:16:30 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:36356 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904079Ab1KQXQY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 00:16:24 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 132C4140443;
        Fri, 18 Nov 2011 00:16:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sQxQpYZUYq34; Fri, 18 Nov 2011 00:16:18 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 500A31403CC;
        Fri, 18 Nov 2011 00:16:18 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, linux-mips@linux-mips.org,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/2] MIPS: ath79: rename dev-ar913x-wmac.h to dev-wmac.h
Date:   Fri, 18 Nov 2011 00:16:00 +0100
Message-Id: <1321571761-17612-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
X-archive-position: 31763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14935

The 'ar913x' part was removed from the common variable
and function names, so remove that from the relevant
header file name as well.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/dev-ar913x-wmac.c                 |    2 +-
 arch/mips/ath79/{dev-ar913x-wmac.h => dev-wmac.h} |    0
 arch/mips/ath79/mach-ap121.c                      |    2 +-
 arch/mips/ath79/mach-ap81.c                       |    2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/mips/ath79/{dev-ar913x-wmac.h => dev-wmac.h} (100%)

diff --git a/arch/mips/ath79/dev-ar913x-wmac.c b/arch/mips/ath79/dev-ar913x-wmac.c
index c424e9a..24f5469 100644
--- a/arch/mips/ath79/dev-ar913x-wmac.c
+++ b/arch/mips/ath79/dev-ar913x-wmac.c
@@ -17,7 +17,7 @@
 
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
-#include "dev-ar913x-wmac.h"
+#include "dev-wmac.h"
 
 static struct ath9k_platform_data ath79_wmac_data;
 
diff --git a/arch/mips/ath79/dev-ar913x-wmac.h b/arch/mips/ath79/dev-wmac.h
similarity index 100%
rename from arch/mips/ath79/dev-ar913x-wmac.h
rename to arch/mips/ath79/dev-wmac.h
diff --git a/arch/mips/ath79/mach-ap121.c b/arch/mips/ath79/mach-ap121.c
index 39ee828..4c20200 100644
--- a/arch/mips/ath79/mach-ap121.c
+++ b/arch/mips/ath79/mach-ap121.c
@@ -13,7 +13,7 @@
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
 #include "dev-usb.h"
-#include "dev-ar913x-wmac.h"
+#include "dev-wmac.h"
 
 #define AP121_GPIO_LED_WLAN		0
 #define AP121_GPIO_LED_USB		1
diff --git a/arch/mips/ath79/mach-ap81.c b/arch/mips/ath79/mach-ap81.c
index 84442da..abe19836 100644
--- a/arch/mips/ath79/mach-ap81.c
+++ b/arch/mips/ath79/mach-ap81.c
@@ -10,7 +10,7 @@
  */
 
 #include "machtypes.h"
-#include "dev-ar913x-wmac.h"
+#include "dev-wmac.h"
 #include "dev-gpio-buttons.h"
 #include "dev-leds-gpio.h"
 #include "dev-spi.h"
-- 
1.7.2.1
