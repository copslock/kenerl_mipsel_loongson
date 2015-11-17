Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 17:48:54 +0100 (CET)
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:59898 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006607AbbKRQsw6si4I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 17:48:52 +0100
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id 8ADE1DAC9A9;
        Tue, 17 Nov 2015 20:35:54 +0100 (CET)
Received: from localhost.localdomain (unknown [80.171.215.189])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 476CCA623D;
        Tue, 17 Nov 2015 20:35:37 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 3/6] MIPS: ath79: irq: Prepare moving the MISC driver to drivers/irqchip
Date:   Tue, 17 Nov 2015 20:34:53 +0100
Message-Id: <1447788896-15553-4-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1447788896-15553-1-git-send-email-albeu@free.fr>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

To prepare moving out of the arch directory rework the MISC
implementation to use irq domains instead of hard coded IRQ numbers.
Also remove the uses of the ath79_reset_base global pointer in the IRQ
methods.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/irq.c | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 26f8d1b..511c065 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -26,9 +26,13 @@
 #include "common.h"
 #include "machtypes.h"
 
+static void __init ath79_misc_intc_domain_init(
+	struct device_node *node, int irq);
+
 static void ath79_misc_irq_handler(struct irq_desc *desc)
 {
-	void __iomem *base = ath79_reset_base;
+	struct irq_domain *domain = irq_desc_get_handler_data(desc);
+	void __iomem *base = domain->host_data;
 	u32 pending;
 
 	pending = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS) &
@@ -42,15 +46,15 @@ static void ath79_misc_irq_handler(struct irq_desc *desc)
 	while (pending) {
 		int bit = __ffs(pending);
 
-		generic_handle_irq(ATH79_MISC_IRQ(bit));
+		generic_handle_irq(irq_linear_revmap(domain, bit));
 		pending &= ~BIT(bit);
 	}
 }
 
 static void ar71xx_misc_irq_unmask(struct irq_data *d)
 {
-	unsigned int irq = d->irq - ATH79_MISC_IRQ_BASE;
-	void __iomem *base = ath79_reset_base;
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->hwirq;
 	u32 t;
 
 	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
@@ -62,8 +66,8 @@ static void ar71xx_misc_irq_unmask(struct irq_data *d)
 
 static void ar71xx_misc_irq_mask(struct irq_data *d)
 {
-	unsigned int irq = d->irq - ATH79_MISC_IRQ_BASE;
-	void __iomem *base = ath79_reset_base;
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->hwirq;
 	u32 t;
 
 	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_ENABLE);
@@ -75,8 +79,8 @@ static void ar71xx_misc_irq_mask(struct irq_data *d)
 
 static void ar724x_misc_irq_ack(struct irq_data *d)
 {
-	unsigned int irq = d->irq - ATH79_MISC_IRQ_BASE;
-	void __iomem *base = ath79_reset_base;
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = d->hwirq;
 	u32 t;
 
 	t = __raw_readl(base + AR71XX_RESET_REG_MISC_INT_STATUS);
@@ -94,12 +98,6 @@ static struct irq_chip ath79_misc_irq_chip = {
 
 static void __init ath79_misc_irq_init(void)
 {
-	void __iomem *base = ath79_reset_base;
-	int i;
-
-	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
-	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
-
 	if (soc_is_ar71xx() || soc_is_ar913x())
 		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
 	else if (soc_is_ar724x() ||
@@ -110,13 +108,7 @@ static void __init ath79_misc_irq_init(void)
 	else
 		BUG();
 
-	for (i = ATH79_MISC_IRQ_BASE;
-	     i < ATH79_MISC_IRQ_BASE + ATH79_MISC_IRQ_COUNT; i++) {
-		irq_set_chip_and_handler(i, &ath79_misc_irq_chip,
-					 handle_level_irq);
-	}
-
-	irq_set_chained_handler(ATH79_CPU_IRQ(6), ath79_misc_irq_handler);
+	ath79_misc_intc_domain_init(NULL, ATH79_CPU_IRQ(6));
 }
 
 static void ar934x_ip2_irq_dispatch(struct irq_desc *desc)
@@ -259,6 +251,7 @@ asmlinkage void plat_irq_dispatch(void)
 static int misc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	irq_set_chip_and_handler(irq, &ath79_misc_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, d->host_data);
 	return 0;
 }
 
@@ -267,19 +260,14 @@ static const struct irq_domain_ops misc_irq_domain_ops = {
 	.map = misc_map,
 };
 
-static int __init ath79_misc_intc_of_init(
-	struct device_node *node, struct device_node *parent)
+static void __init ath79_misc_intc_domain_init(
+	struct device_node *node, int irq)
 {
 	void __iomem *base = ath79_reset_base;
 	struct irq_domain *domain;
-	int irq;
-
-	irq = irq_of_parse_and_map(node, 0);
-	if (!irq)
-		panic("Failed to get MISC IRQ");
 
 	domain = irq_domain_add_legacy(node, ATH79_MISC_IRQ_COUNT,
-			ATH79_MISC_IRQ_BASE, 0, &misc_irq_domain_ops, NULL);
+			ATH79_MISC_IRQ_BASE, 0, &misc_irq_domain_ops, base);
 	if (!domain)
 		panic("Failed to add MISC irqdomain");
 
@@ -287,9 +275,19 @@ static int __init ath79_misc_intc_of_init(
 	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
 
+	irq_set_chained_handler_and_data(irq, ath79_misc_irq_handler, domain);
+}
 
-	irq_set_chained_handler(irq, ath79_misc_irq_handler);
+static int __init ath79_misc_intc_of_init(
+	struct device_node *node, struct device_node *parent)
+{
+	int irq;
 
+	irq = irq_of_parse_and_map(node, 0);
+	if (!irq)
+		panic("Failed to get MISC IRQ");
+
+	ath79_misc_intc_domain_init(node, irq);
 	return 0;
 }
 
-- 
2.0.0
