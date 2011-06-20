Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2011 21:30:24 +0200 (CEST)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:35941 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491155Ab1FTT1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2011 21:27:17 +0200
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id B0A48140222;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 38AE7140209;
        Mon, 20 Jun 2011 21:27:07 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 07/13] MIPS: ath79: add AR933X specific GPIO initialization
Date:   Mon, 20 Jun 2011 21:26:07 +0200
Message-Id: <1308597973-6037-8-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org>
X-VBMS: A131875F6F6 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
X-archive-position: 30459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16498

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/gpio.c                         |    2 ++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
index a0c426b..a2f8ca6 100644
--- a/arch/mips/ath79/gpio.c
+++ b/arch/mips/ath79/gpio.c
@@ -153,6 +153,8 @@ void __init ath79_gpio_init(void)
 		ath79_gpio_count = AR724X_GPIO_COUNT;
 	else if (soc_is_ar913x())
 		ath79_gpio_count = AR913X_GPIO_COUNT;
+	else if (soc_is_ar933x())
+		ath79_gpio_count = AR933X_GPIO_COUNT;
 	else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 9c76185..e65c10d 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -298,5 +298,6 @@
 #define AR71XX_GPIO_COUNT		16
 #define AR724X_GPIO_COUNT		18
 #define AR913X_GPIO_COUNT		22
+#define AR933X_GPIO_COUNT		30
 
 #endif /* __ASM_MACH_AR71XX_REGS_H */
-- 
1.7.2.1
