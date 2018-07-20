Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 14:25:56 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:47180 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993880AbeGTMYKnfTil (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 14:24:10 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH V2 12/25] MIPS: pci-ar724x: convert to OF
Date:   Fri, 20 Jul 2018 13:58:29 +0200
Message-Id: <20180720115842.8406-13-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64978
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
 arch/mips/pci/pci-ar724x.c | 88 ++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 64b58cc48a91..86b7b9d2edab 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -14,8 +14,11 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/irqchip/chained_irq.h>
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
 
 #define AR724X_PCI_REG_APP		0x00
 #define AR724X_PCI_REG_RESET		0x18
@@ -45,17 +48,20 @@ struct ar724x_pci_controller {
 	void __iomem *crp_base;
 
 	int irq;
-	int irq_base;
 
 	bool link_up;
 	bool bar0_is_cached;
 	u32  bar0_value;
 
+	struct device_node *np;
 	struct pci_controller pci_controller;
+	struct irq_domain *domain;
 	struct resource io_res;
 	struct resource mem_res;
 };
 
+static struct irq_chip ar724x_pci_irq_chip;
+
 static inline bool ar724x_pci_check_link(struct ar724x_pci_controller *apc)
 {
 	u32 reset;
@@ -231,35 +237,31 @@ static struct pci_ops ar724x_pci_ops = {
 
 static void ar724x_pci_irq_handler(struct irq_desc *desc)
 {
-	struct ar724x_pci_controller *apc;
-	void __iomem *base;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct ar724x_pci_controller *apc = irq_desc_get_handler_data(desc);
 	u32 pending;
 
-	apc = irq_desc_get_handler_data(desc);
-	base = apc->ctrl_base;
-
-	pending = __raw_readl(base + AR724X_PCI_REG_INT_STATUS) &
-		  __raw_readl(base + AR724X_PCI_REG_INT_MASK);
+	chained_irq_enter(chip, desc);
+	pending = __raw_readl(apc->ctrl_base + AR724X_PCI_REG_INT_STATUS) &
+		  __raw_readl(apc->ctrl_base + AR724X_PCI_REG_INT_MASK);
 
 	if (pending & AR724X_PCI_INT_DEV0)
-		generic_handle_irq(apc->irq_base + 0);
-
+		generic_handle_irq(irq_linear_revmap(apc->domain, 1));
 	else
 		spurious_interrupt();
+	chained_irq_exit(chip, desc);
 }
 
 static void ar724x_pci_irq_unmask(struct irq_data *d)
 {
 	struct ar724x_pci_controller *apc;
 	void __iomem *base;
-	int offset;
 	u32 t;
 
 	apc = irq_data_get_irq_chip_data(d);
 	base = apc->ctrl_base;
-	offset = apc->irq_base - d->irq;
 
-	switch (offset) {
+	switch (irq_linear_revmap(apc->domain, d->irq)) {
 	case 0:
 		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
 		__raw_writel(t | AR724X_PCI_INT_DEV0,
@@ -273,14 +275,12 @@ static void ar724x_pci_irq_mask(struct irq_data *d)
 {
 	struct ar724x_pci_controller *apc;
 	void __iomem *base;
-	int offset;
 	u32 t;
 
 	apc = irq_data_get_irq_chip_data(d);
 	base = apc->ctrl_base;
-	offset = apc->irq_base - d->irq;
 
-	switch (offset) {
+	switch (irq_linear_revmap(apc->domain, d->irq)) {
 	case 0:
 		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
 		__raw_writel(t & ~AR724X_PCI_INT_DEV0,
@@ -305,26 +305,34 @@ static struct irq_chip ar724x_pci_irq_chip = {
 	.irq_mask_ack	= ar724x_pci_irq_mask,
 };
 
+static int ar724x_pci_irq_map(struct irq_domain *d,
+			      unsigned int irq, irq_hw_number_t hw)
+{
+	struct ar724x_pci_controller *apc = d->host_data;
+
+	irq_set_chip_and_handler(irq, &ar724x_pci_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, apc);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ar724x_pci_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = ar724x_pci_irq_map,
+};
+
 static void ar724x_pci_irq_init(struct ar724x_pci_controller *apc,
 				int id)
 {
 	void __iomem *base;
-	int i;
 
 	base = apc->ctrl_base;
 
 	__raw_writel(0, base + AR724X_PCI_REG_INT_MASK);
 	__raw_writel(0, base + AR724X_PCI_REG_INT_STATUS);
 
-	apc->irq_base = ATH79_PCI_IRQ_BASE + (id * AR724X_PCI_IRQ_COUNT);
-
-	for (i = apc->irq_base;
-	     i < apc->irq_base + AR724X_PCI_IRQ_COUNT; i++) {
-		irq_set_chip_and_handler(i, &ar724x_pci_irq_chip,
-					 handle_level_irq);
-		irq_set_chip_data(i, apc);
-	}
-
+	apc->domain = irq_domain_add_linear(apc->np, 2,
+					    &ar724x_pci_domain_ops, apc);
 	irq_set_chained_handler_and_data(apc->irq, ar724x_pci_irq_handler,
 					 apc);
 }
@@ -394,29 +402,11 @@ static int ar724x_pci_probe(struct platform_device *pdev)
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
+	apc->np = pdev->dev.of_node;
 	apc->pci_controller.pci_ops = &ar724x_pci_ops;
 	apc->pci_controller.io_resource = &apc->io_res;
 	apc->pci_controller.mem_resource = &apc->mem_res;
+	pci_load_of_ranges(&apc->pci_controller, pdev->dev.of_node);
 
 	/*
 	 * Do the full PCIE Root Complex Initialization Sequence if the PCIe
@@ -438,10 +428,16 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ar724x_pci_ids[] = {
+	{ .compatible = "qcom,ar7240-pci" },
+	{},
+};
+
 static struct platform_driver ar724x_pci_driver = {
 	.probe = ar724x_pci_probe,
 	.driver = {
 		.name = "ar724x-pci",
+		.of_match_table = of_match_ptr(ar724x_pci_ids),
 	},
 };
 
-- 
2.11.0
