Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2013 21:29:47 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53290 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827522Ab3BGU3qJEFEG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2013 21:29:46 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E376D25E1FF;
        Thu,  7 Feb 2013 21:29:40 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j8jeAWm28Fdw; Thu,  7 Feb 2013 21:29:40 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 9DC6025E1F1;
        Thu,  7 Feb 2013 21:29:40 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 3/3] MIPS: pci-ar71xx: move irq base to the controller structure
Date:   Thu,  7 Feb 2013 21:29:38 +0100
Message-Id: <1360268978-13570-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360268896-13434-1-git-send-email-juhosg@openwrt.org>
References: <1360268896-13434-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35723
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

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci-ar71xx.c |   32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index e48dddb..412ec02 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -52,6 +52,7 @@ struct ar71xx_pci_controller {
 	void __iomem *cfg_base;
 	spinlock_t lock;
 	int irq;
+	int irq_base;
 	struct pci_controller pci_ctrl;
 	struct resource io_res;
 	struct resource mem_res;
@@ -238,23 +239,26 @@ static struct pci_ops ar71xx_pci_ops = {
 
 static void ar71xx_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
+	struct ar71xx_pci_controller *apc;
 	void __iomem *base = ath79_reset_base;
 	u32 pending;
 
+	apc = irq_get_handler_data(irq);
+
 	pending = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_STATUS) &
 		  __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
 
 	if (pending & AR71XX_PCI_INT_DEV0)
-		generic_handle_irq(ATH79_PCI_IRQ(0));
+		generic_handle_irq(apc->irq_base + 0);
 
 	else if (pending & AR71XX_PCI_INT_DEV1)
-		generic_handle_irq(ATH79_PCI_IRQ(1));
+		generic_handle_irq(apc->irq_base + 1);
 
 	else if (pending & AR71XX_PCI_INT_DEV2)
-		generic_handle_irq(ATH79_PCI_IRQ(2));
+		generic_handle_irq(apc->irq_base + 2);
 
 	else if (pending & AR71XX_PCI_INT_CORE)
-		generic_handle_irq(ATH79_PCI_IRQ(4));
+		generic_handle_irq(apc->irq_base + 4);
 
 	else
 		spurious_interrupt();
@@ -262,10 +266,14 @@ static void ar71xx_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 static void ar71xx_pci_irq_unmask(struct irq_data *d)
 {
-	unsigned int irq = d->irq - ATH79_PCI_IRQ_BASE;
+	struct ar71xx_pci_controller *apc;
+	unsigned int irq;
 	void __iomem *base = ath79_reset_base;
 	u32 t;
 
+	apc = irq_data_get_irq_chip_data(d);
+	irq = d->irq - apc->irq_base;
+
 	t = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
 	__raw_writel(t | (1 << irq), base + AR71XX_RESET_REG_PCI_INT_ENABLE);
 
@@ -275,10 +283,14 @@ static void ar71xx_pci_irq_unmask(struct irq_data *d)
 
 static void ar71xx_pci_irq_mask(struct irq_data *d)
 {
-	unsigned int irq = d->irq - ATH79_PCI_IRQ_BASE;
+	struct ar71xx_pci_controller *apc;
+	unsigned int irq;
 	void __iomem *base = ath79_reset_base;
 	u32 t;
 
+	apc = irq_data_get_irq_chip_data(d);
+	irq = d->irq - apc->irq_base;
+
 	t = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
 	__raw_writel(t & ~(1 << irq), base + AR71XX_RESET_REG_PCI_INT_ENABLE);
 
@@ -303,11 +315,15 @@ static void ar71xx_pci_irq_init(struct ar71xx_pci_controller *apc)
 
 	BUILD_BUG_ON(ATH79_PCI_IRQ_COUNT < AR71XX_PCI_IRQ_COUNT);
 
-	for (i = ATH79_PCI_IRQ_BASE;
-	     i < ATH79_PCI_IRQ_BASE + AR71XX_PCI_IRQ_COUNT; i++)
+	apc->irq_base = ATH79_PCI_IRQ_BASE;
+	for (i = apc->irq_base;
+	     i < apc->irq_base + AR71XX_PCI_IRQ_COUNT; i++) {
 		irq_set_chip_and_handler(i, &ar71xx_pci_irq_chip,
 					 handle_level_irq);
+		irq_set_chip_data(i, apc);
+	}
 
+	irq_set_handler_data(apc->irq, apc);
 	irq_set_chained_handler(apc->irq, ar71xx_pci_irq_handler);
 }
 
-- 
1.7.10
