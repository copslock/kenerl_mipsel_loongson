Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2013 10:19:24 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53171 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824769Ab3A2JTUYWaDI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jan 2013 10:19:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E2AD525C68D;
        Tue, 29 Jan 2013 10:19:14 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vuedki2FnstE; Tue, 29 Jan 2013 10:19:14 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 9393925C67D;
        Tue, 29 Jan 2013 10:19:14 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: ath79: fix GPIO function selection for AR934x SoCs
Date:   Tue, 29 Jan 2013 10:19:12 +0100
Message-Id: <1359451153-13335-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35612
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

GPIO function selection is not working on the AR934x
SoCs because the offset of the function selection
register is different on those.

Add a helper routine which returns the correct
register address based on the SoC type, and use
that in the 'ath79_gpio_function_*' routines.

Cc: <stable@vger.kernel.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/gpio.c                         |   38 ++++++++++++++++--------
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
index 48fe762..662a10e 100644
--- a/arch/mips/ath79/gpio.c
+++ b/arch/mips/ath79/gpio.c
@@ -137,47 +137,61 @@ static struct gpio_chip ath79_gpio_chip = {
 	.base			= 0,
 };
 
+static void __iomem *ath79_gpio_get_function_reg(void)
+{
+	u32 reg = 0;
+
+	if (soc_is_ar71xx() ||
+	    soc_is_ar724x() ||
+	    soc_is_ar913x() ||
+	    soc_is_ar933x())
+		reg = AR71XX_GPIO_REG_FUNC;
+	else if (soc_is_ar934x())
+		reg = AR934X_GPIO_REG_FUNC;
+	else
+		BUG();
+
+	return ath79_gpio_base + reg;
+}
+
 void ath79_gpio_function_enable(u32 mask)
 {
-	void __iomem *base = ath79_gpio_base;
+	void __iomem *reg = ath79_gpio_get_function_reg();
 	unsigned long flags;
 
 	spin_lock_irqsave(&ath79_gpio_lock, flags);
 
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_FUNC) | mask,
-		     base + AR71XX_GPIO_REG_FUNC);
+	__raw_writel(__raw_readl(reg) | mask, reg);
 	/* flush write */
-	__raw_readl(base + AR71XX_GPIO_REG_FUNC);
+	__raw_readl(reg);
 
 	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
 }
 
 void ath79_gpio_function_disable(u32 mask)
 {
-	void __iomem *base = ath79_gpio_base;
+	void __iomem *reg = ath79_gpio_get_function_reg();
 	unsigned long flags;
 
 	spin_lock_irqsave(&ath79_gpio_lock, flags);
 
-	__raw_writel(__raw_readl(base + AR71XX_GPIO_REG_FUNC) & ~mask,
-		     base + AR71XX_GPIO_REG_FUNC);
+	__raw_writel(__raw_readl(reg) & ~mask, reg);
 	/* flush write */
-	__raw_readl(base + AR71XX_GPIO_REG_FUNC);
+	__raw_readl(reg);
 
 	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
 }
 
 void ath79_gpio_function_setup(u32 set, u32 clear)
 {
-	void __iomem *base = ath79_gpio_base;
+	void __iomem *reg = ath79_gpio_get_function_reg();
 	unsigned long flags;
 
 	spin_lock_irqsave(&ath79_gpio_lock, flags);
 
-	__raw_writel((__raw_readl(base + AR71XX_GPIO_REG_FUNC) & ~clear) | set,
-		     base + AR71XX_GPIO_REG_FUNC);
+	__raw_writel((__raw_readl(reg) & ~clear) | set, reg);
 	/* flush write */
-	__raw_readl(base + AR71XX_GPIO_REG_FUNC);
+	__raw_readl(reg);
 
 	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index a5e0f17..7d44b5d 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -401,6 +401,8 @@
 #define AR71XX_GPIO_REG_INT_ENABLE	0x24
 #define AR71XX_GPIO_REG_FUNC		0x28
 
+#define AR934X_GPIO_REG_FUNC		0x6c
+
 #define AR71XX_GPIO_COUNT		16
 #define AR7240_GPIO_COUNT		18
 #define AR7241_GPIO_COUNT		20
-- 
1.7.10
