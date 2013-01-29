Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2013 10:19:42 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53174 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825706Ab3A2JTU2O1T0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jan 2013 10:19:20 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 5D75B25C68E;
        Tue, 29 Jan 2013 10:19:15 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mQOzrZ0V36gN; Tue, 29 Jan 2013 10:19:15 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id EFE5625C67D;
        Tue, 29 Jan 2013 10:19:14 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/2] MIPS: ath79: simplify ath79_gpio_function_* routines
Date:   Tue, 29 Jan 2013 10:19:13 +0100
Message-Id: <1359451153-13335-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1359451153-13335-1-git-send-email-juhosg@openwrt.org>
References: <1359451153-13335-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35613
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

Make ath79_gpio_function_{en,dis}able to be wrappers
around ath79_gpio_function_setup.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/gpio.c |   30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/arch/mips/ath79/gpio.c b/arch/mips/ath79/gpio.c
index 662a10e..b7ed207 100644
--- a/arch/mips/ath79/gpio.c
+++ b/arch/mips/ath79/gpio.c
@@ -154,46 +154,28 @@ static void __iomem *ath79_gpio_get_function_reg(void)
 	return ath79_gpio_base + reg;
 }
 
-void ath79_gpio_function_enable(u32 mask)
+void ath79_gpio_function_setup(u32 set, u32 clear)
 {
 	void __iomem *reg = ath79_gpio_get_function_reg();
 	unsigned long flags;
 
 	spin_lock_irqsave(&ath79_gpio_lock, flags);
 
-	__raw_writel(__raw_readl(reg) | mask, reg);
+	__raw_writel((__raw_readl(reg) & ~clear) | set, reg);
 	/* flush write */
 	__raw_readl(reg);
 
 	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
 }
 
-void ath79_gpio_function_disable(u32 mask)
+void ath79_gpio_function_enable(u32 mask)
 {
-	void __iomem *reg = ath79_gpio_get_function_reg();
-	unsigned long flags;
-
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
-
-	__raw_writel(__raw_readl(reg) & ~mask, reg);
-	/* flush write */
-	__raw_readl(reg);
-
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+	ath79_gpio_function_setup(mask, 0);
 }
 
-void ath79_gpio_function_setup(u32 set, u32 clear)
+void ath79_gpio_function_disable(u32 mask)
 {
-	void __iomem *reg = ath79_gpio_get_function_reg();
-	unsigned long flags;
-
-	spin_lock_irqsave(&ath79_gpio_lock, flags);
-
-	__raw_writel((__raw_readl(reg) & ~clear) | set, reg);
-	/* flush write */
-	__raw_readl(reg);
-
-	spin_unlock_irqrestore(&ath79_gpio_lock, flags);
+	ath79_gpio_function_setup(0, mask);
 }
 
 void __init ath79_gpio_init(void)
-- 
1.7.10
