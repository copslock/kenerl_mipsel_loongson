Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:26:11 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:58268 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992553AbeFYRYWGhzBL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:24:22 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 11/25] MIPS: pci-ar71xx: convert to OF
Date:   Mon, 25 Jun 2018 19:15:35 +0200
Message-Id: <20180625171549.4618-12-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625171549.4618-1-john@phrozen.org>
References: <20180625171549.4618-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

With the ath79 target getting converted to pure OF, we can drop all the
platform data code and add the missing OF bits to the driver. We also add
a irq domain for the PCI/e controllers cascade, thus making it usable from
dts files.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/pci/pci-ar71xx.c | 82 +++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index bdf87b43633f..29d256ba83b6 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -18,8 +18,11 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
 
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/ath79.h>
@@ -49,12 +52,13 @@
 #define AR71XX_PCI_IRQ_COUNT		5
 
 struct ar71xx_pci_controller {
+	struct device_node *np;
 	void __iomem *cfg_base;
 	int irq;
-	int irq_base;
 	struct pci_controller pci_ctrl;
 	struct resource io_res;
 	struct resource mem_res;
+	struct irq_domain *domain;
 };
 
 /* Byte lane enable bits */
@@ -228,29 +232,30 @@ static struct pci_ops ar71xx_pci_ops = {
 
 static void ar71xx_pci_irq_handler(struct irq_desc *desc)
 {
-	struct ar71xx_pci_controller *apc;
 	void __iomem *base = ath79_reset_base;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct ar71xx_pci_controller *apc = irq_desc_get_handler_data(desc);
 	u32 pending;
 
-	apc = irq_desc_get_handler_data(desc);
-
+	chained_irq_enter(chip, desc);
 	pending = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_STATUS) &
 		  __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
 
 	if (pending & AR71XX_PCI_INT_DEV0)
-		generic_handle_irq(apc->irq_base + 0);
+		generic_handle_irq(irq_linear_revmap(apc->domain, 1));
 
 	else if (pending & AR71XX_PCI_INT_DEV1)
-		generic_handle_irq(apc->irq_base + 1);
+		generic_handle_irq(irq_linear_revmap(apc->domain, 2));
 
 	else if (pending & AR71XX_PCI_INT_DEV2)
-		generic_handle_irq(apc->irq_base + 2);
+		generic_handle_irq(irq_linear_revmap(apc->domain, 3));
 
 	else if (pending & AR71XX_PCI_INT_CORE)
-		generic_handle_irq(apc->irq_base + 4);
+		generic_handle_irq(irq_linear_revmap(apc->domain, 4));
 
 	else
 		spurious_interrupt();
+	chained_irq_exit(chip, desc);
 }
 
 static void ar71xx_pci_irq_unmask(struct irq_data *d)
@@ -261,7 +266,7 @@ static void ar71xx_pci_irq_unmask(struct irq_data *d)
 	u32 t;
 
 	apc = irq_data_get_irq_chip_data(d);
-	irq = d->irq - apc->irq_base;
+	irq = irq_linear_revmap(apc->domain, d->irq);
 
 	t = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
 	__raw_writel(t | (1 << irq), base + AR71XX_RESET_REG_PCI_INT_ENABLE);
@@ -278,7 +283,7 @@ static void ar71xx_pci_irq_mask(struct irq_data *d)
 	u32 t;
 
 	apc = irq_data_get_irq_chip_data(d);
-	irq = d->irq - apc->irq_base;
+	irq = irq_linear_revmap(apc->domain, d->irq);
 
 	t = __raw_readl(base + AR71XX_RESET_REG_PCI_INT_ENABLE);
 	__raw_writel(t & ~(1 << irq), base + AR71XX_RESET_REG_PCI_INT_ENABLE);
@@ -294,24 +299,31 @@ static struct irq_chip ar71xx_pci_irq_chip = {
 	.irq_mask_ack	= ar71xx_pci_irq_mask,
 };
 
+static int ar71xx_pci_irq_map(struct irq_domain *d,
+			      unsigned int irq, irq_hw_number_t hw)
+{
+	struct ar71xx_pci_controller *apc = d->host_data;
+
+	irq_set_chip_and_handler(irq, &ar71xx_pci_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, apc);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ar71xx_pci_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = ar71xx_pci_irq_map,
+};
+
 static void ar71xx_pci_irq_init(struct ar71xx_pci_controller *apc)
 {
 	void __iomem *base = ath79_reset_base;
-	int i;
 
 	__raw_writel(0, base + AR71XX_RESET_REG_PCI_INT_ENABLE);
 	__raw_writel(0, base + AR71XX_RESET_REG_PCI_INT_STATUS);
 
-	BUILD_BUG_ON(ATH79_PCI_IRQ_COUNT < AR71XX_PCI_IRQ_COUNT);
-
-	apc->irq_base = ATH79_PCI_IRQ_BASE;
-	for (i = apc->irq_base;
-	     i < apc->irq_base + AR71XX_PCI_IRQ_COUNT; i++) {
-		irq_set_chip_and_handler(i, &ar71xx_pci_irq_chip,
-					 handle_level_irq);
-		irq_set_chip_data(i, apc);
-	}
-
+	apc->domain = irq_domain_add_linear(apc->np, AR71XX_PCI_IRQ_COUNT,
+					    &ar71xx_pci_domain_ops, apc);
 	irq_set_chained_handler_and_data(apc->irq, ar71xx_pci_irq_handler,
 					 apc);
 }
@@ -328,6 +340,11 @@ static void ar71xx_pci_reset(void)
 	mdelay(100);
 }
 
+static const struct of_device_id ar71xx_pci_ids[] = {
+	{ .compatible = "qca,ar7100-pci" },
+	{},
+};
+
 static int ar71xx_pci_probe(struct platform_device *pdev)
 {
 	struct ar71xx_pci_controller *apc;
@@ -348,26 +365,6 @@ static int ar71xx_pci_probe(struct platform_device *pdev)
 	if (apc->irq < 0)
 		return -EINVAL;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_IO, "io_base");
-	if (!res)
-		return -EINVAL;
-
-	apc->io_res.parent = res;
-	apc->io_res.name = "PCI IO space";
-	apc->io_res.start = res->start;
-	apc->io_res.end = res->end;
-	apc->io_res.flags = IORESOURCE_IO;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem_base");
-	if (!res)
-		return -EINVAL;
-
-	apc->mem_res.parent = res;
-	apc->mem_res.name = "PCI memory space";
-	apc->mem_res.start = res->start;
-	apc->mem_res.end = res->end;
-	apc->mem_res.flags = IORESOURCE_MEM;
-
 	ar71xx_pci_reset();
 
 	/* setup COMMAND register */
@@ -380,9 +377,11 @@ static int ar71xx_pci_probe(struct platform_device *pdev)
 
 	ar71xx_pci_irq_init(apc);
 
+	apc->np = pdev->dev.of_node;
 	apc->pci_ctrl.pci_ops = &ar71xx_pci_ops;
 	apc->pci_ctrl.mem_resource = &apc->mem_res;
 	apc->pci_ctrl.io_resource = &apc->io_res;
+	pci_load_of_ranges(&apc->pci_ctrl, pdev->dev.of_node);
 
 	register_pci_controller(&apc->pci_ctrl);
 
@@ -393,6 +392,7 @@ static struct platform_driver ar71xx_pci_driver = {
 	.probe = ar71xx_pci_probe,
 	.driver = {
 		.name = "ar71xx-pci",
+		.of_match_table = of_match_ptr(ar71xx_pci_ids),
 	},
 };
 
-- 
2.11.0
