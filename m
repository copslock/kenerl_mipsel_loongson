Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 19:28:25 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46088 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903629Ab1LWS0N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2011 19:26:13 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 8585123C008D;
        Fri, 23 Dec 2011 19:26:12 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 05/16] MIPS: ath79: add GPIO support code for AR934X
Date:   Fri, 23 Dec 2011 19:25:31 +0100
Message-Id: <1324664742-3648-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19092

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
 arch/mips/ath79/gpio.c                         |   47 +++++++++++++++++++++++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    1 +
 2 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
index a2f8ca6..29054f2 100644
--- a/arch/mips/ath79/gpio.c
+++ b/arch/mips/ath79/gpio.c
@@ -1,9 +1,12 @@
 /*
  *  Atheros AR71XX/AR724X/AR913X GPIO API support
  *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
+ *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
+ *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
@@ -89,6 +92,42 @@ static int ath79_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+static int ar934x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	void __iomem *base = ath79_gpio_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ath79_gpio_lock, flags);
+
+	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) | (1 << offset),
+		     base + AR71XX_GPIO_REG_OE);
+
+	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+
+	return 0;
+}
+
+static int ar934x_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
+					int value)
+{
+	void __iomem *base = ath79_gpio_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ath79_gpio_lock, flags);
+
+	if (value)
+		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_SET);
+	else
+		__raw_writel(1 << offset, base + AR71XX_GPIO_REG_CLEAR);
+
+	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_OE) & ~(1 << offset),
+		     base + AR71XX_GPIO_REG_OE);
+
+	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+
+	return 0;
+}
+
 static struct gpio_chip ath79_gpio_chip = {
 	.label			= "ath79",
 	.get			= ath79_gpio_get_value,
@@ -155,11 +194,17 @@ void __init ath79_gpio_init(void)
 		ath79_gpio_count = AR913X_GPIO_COUNT;
 	else if (soc_is_ar933x())
 		ath79_gpio_count = AR933X_GPIO_COUNT;
+	else if (soc_is_ar934x())
+		ath79_gpio_count = AR934X_GPIO_COUNT;
 	else
 		BUG();
 
 	ath79_gpio_base = ioremap_nocache(AR71XX_GPIO_BASE, AR71XX_GPIO_SIZE);
 	ath79_gpio_chip.ngpio = ath79_gpio_count;
+	if (soc_is_ar934x()) {
+		ath79_gpio_chip.direction_input = ar934x_gpio_direction_input;
+		ath79_gpio_chip.direction_output = ar934x_gpio_direction_output;
+	}
 
 	err = gpiochip_add(&ath79_gpio_chip);
 	if (err)
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index bc1c345..1a9234b 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -367,5 +367,6 @@
 #define AR724X_GPIO_COUNT		18
 #define AR913X_GPIO_COUNT		22
 #define AR933X_GPIO_COUNT		30
+#define AR934X_GPIO_COUNT		23
 
 #endif /* __ASM_MACH_AR71XX_REGS_H */
-- 
1.7.2.1
