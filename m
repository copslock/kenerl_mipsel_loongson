Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2013 18:13:27 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:40205 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833287Ab3A2RN0CHfco (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jan 2013 18:13:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id C3F2025C822;
        Tue, 29 Jan 2013 18:13:20 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sL4iKH-EXXHU; Tue, 29 Jan 2013 18:13:20 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 8565725C820;
        Tue, 29 Jan 2013 18:13:20 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] MIPS: ath79: simplify MISC IRQ handling
Date:   Tue, 29 Jan 2013 18:13:17 +0100
Message-Id: <1359479597-11431-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35616
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

The current code uses multiple if statements for
demultiplexing the different interrupt sources.
Additionally, the MISC interrupt controller has
32 interrupt sources and the current code does not
handles all of them.

Get rid of the if statements and process all interrupt
sources in a loop to fix these issues.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/irq.c                  |   45 +++++++-------------------------
 arch/mips/include/asm/mach-ath79/irq.h |    1 +
 2 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 90d09fc..219cfa1 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -35,44 +35,17 @@ static void ath79_misc_irq_handler(unsigned int irq, struct irq_desc *desc)
 	pending = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS) &
 		  __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 
-	if (pending & MISC_INT_UART)
-		generic_handle_irq(ATH79_MISC_IRQ_UART);
-
-	else if (pending & MISC_INT_DMA)
-		generic_handle_irq(ATH79_MISC_IRQ_DMA);
-
-	else if (pending & MISC_INT_PERFC)
-		generic_handle_irq(ATH79_MISC_IRQ_PERFC);
-
-	else if (pending & MISC_INT_TIMER)
-		generic_handle_irq(ATH79_MISC_IRQ_TIMER);
-
-	else if (pending & MISC_INT_TIMER2)
-		generic_handle_irq(ATH79_MISC_IRQ_TIMER2);
-
-	else if (pending & MISC_INT_TIMER3)
-		generic_handle_irq(ATH79_MISC_IRQ_TIMER3);
-
-	else if (pending & MISC_INT_TIMER4)
-		generic_handle_irq(ATH79_MISC_IRQ_TIMER4);
-
-	else if (pending & MISC_INT_OHCI)
-		generic_handle_irq(ATH79_MISC_IRQ_OHCI);
-
-	else if (pending & MISC_INT_ERROR)
-		generic_handle_irq(ATH79_MISC_IRQ_ERROR);
-
-	else if (pending & MISC_INT_GPIO)
-		generic_handle_irq(ATH79_MISC_IRQ_GPIO);
-
-	else if (pending & MISC_INT_WDOG)
-		generic_handle_irq(ATH79_MISC_IRQ_WDOG);
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
 
-	else if (pending & MISC_INT_ETHSW)
-		generic_handle_irq(ATH79_MISC_IRQ_ETHSW);
+	while (pending) {
+		int bit = __ffs(pending);
 
-	else
-		spurious_interrupt();
+		generic_handle_irq(ATH79_MISC_IRQ(bit));
+		pending &= ~BIT(bit);
+	}
 }
 
 static void ar71xx_misc_irq_unmask(struct irq_data *d)
diff --git a/arch/mips/include/asm/mach-ath79/irq.h b/arch/mips/include/asm/mach-ath79/irq.h
index 0968f69..158ad7f 100644
--- a/arch/mips/include/asm/mach-ath79/irq.h
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -14,6 +14,7 @@
 
 #define ATH79_MISC_IRQ_BASE	8
 #define ATH79_MISC_IRQ_COUNT	32
+#define ATH79_MISC_IRQ(_x)	(ATH79_MISC_IRQ_BASE + (_x))
 
 #define ATH79_PCI_IRQ_BASE	(ATH79_MISC_IRQ_BASE + ATH79_MISC_IRQ_COUNT)
 #define ATH79_PCI_IRQ_COUNT	6
-- 
1.7.10
