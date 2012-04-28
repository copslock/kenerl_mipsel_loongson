Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:33:32 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:60906 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903724Ab2D1NdA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:33:00 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6BF1623C0088;
        Sat, 28 Apr 2012 15:32:58 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2 1/2] MIPS: ath79: fix number of GPIO lines for AR724[12]
Date:   Sat, 28 Apr 2012 15:32:52 +0200
Message-Id: <1335619973-6175-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1335619973-6175-1-git-send-email-juhosg@openwrt.org>
References: <1335619973-6175-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 33061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

The AR724[12] SoCs have more GPIO lines than the AR7240.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/gpio.c                         |    6 ++++--
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
index 29054f2..48fe762 100644
--- a/arch/mips/ath79/gpio.c
+++ b/arch/mips/ath79/gpio.c
@@ -188,8 +188,10 @@ void __init ath79_gpio_init(void)
 
 	if (soc_is_ar71xx())
 		ath79_gpio_count = AR71XX_GPIO_COUNT;
-	else if (soc_is_ar724x())
-		ath79_gpio_count = AR724X_GPIO_COUNT;
+	else if (soc_is_ar7240())
+		ath79_gpio_count = AR7240_GPIO_COUNT;
+	else if (soc_is_ar7241() || soc_is_ar7242())
+		ath79_gpio_count = AR7241_GPIO_COUNT;
 	else if (soc_is_ar913x())
 		ath79_gpio_count = AR913X_GPIO_COUNT;
 	else if (soc_is_ar933x())
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 1caa78a..dde5044 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -393,7 +393,8 @@
 #define AR71XX_GPIO_REG_FUNC		0x28
 
 #define AR71XX_GPIO_COUNT		16
-#define AR724X_GPIO_COUNT		18
+#define AR7240_GPIO_COUNT		18
+#define AR7241_GPIO_COUNT		20
 #define AR913X_GPIO_COUNT		22
 #define AR933X_GPIO_COUNT		30
 #define AR934X_GPIO_COUNT		23
-- 
1.7.2.1
