Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2013 12:00:24 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37450 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816288Ab3BCLAYF6R9o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2013 12:00:24 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id E7B0725D404;
        Sun,  3 Feb 2013 12:00:18 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I1AFiIdHCOql; Sun,  3 Feb 2013 12:00:18 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 94CEF25D403;
        Sun,  3 Feb 2013 12:00:18 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 4/4] MIPS: pci-ar724x: use per-controller IRQ base
Date:   Sun,  3 Feb 2013 12:00:16 +0100
Message-Id: <1359889216-15851-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1359889120-15699-1-git-send-email-juhosg@openwrt.org>
References: <1359889120-15699-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35692
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

Change to the code to use per-controller IRQ base.
This is needed for multiple PCI controller support.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci-ar724x.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index d0d707d..0440d88 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -34,6 +34,7 @@ struct ar724x_pci_controller {
 	void __iomem *ctrl_base;
 
 	int irq;
+	int irq_base;
 
 	bool link_up;
 	bool bar0_is_cached;
@@ -205,7 +206,7 @@ static void ar724x_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 		  __raw_readl(base + AR724X_PCI_REG_INT_MASK);
 
 	if (pending & AR724X_PCI_INT_DEV0)
-		generic_handle_irq(ATH79_PCI_IRQ(0));
+		generic_handle_irq(apc->irq_base + 0);
 
 	else
 		spurious_interrupt();
@@ -215,13 +216,15 @@ static void ar724x_pci_irq_unmask(struct irq_data *d)
 {
 	struct ar724x_pci_controller *apc;
 	void __iomem *base;
+	int offset;
 	u32 t;
 
 	apc = irq_data_get_irq_chip_data(d);
 	base = apc->ctrl_base;
+	offset = apc->irq_base - d->irq;
 
-	switch (d->irq) {
-	case ATH79_PCI_IRQ(0):
+	switch (offset) {
+	case 0:
 		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
 		__raw_writel(t | AR724X_PCI_INT_DEV0,
 			     base + AR724X_PCI_REG_INT_MASK);
@@ -234,13 +237,15 @@ static void ar724x_pci_irq_mask(struct irq_data *d)
 {
 	struct ar724x_pci_controller *apc;
 	void __iomem *base;
+	int offset;
 	u32 t;
 
 	apc = irq_data_get_irq_chip_data(d);
 	base = apc->ctrl_base;
+	offset = apc->irq_base - d->irq;
 
-	switch (d->irq) {
-	case ATH79_PCI_IRQ(0):
+	switch (offset) {
+	case 0:
 		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
 		__raw_writel(t & ~AR724X_PCI_INT_DEV0,
 			     base + AR724X_PCI_REG_INT_MASK);
@@ -264,7 +269,8 @@ static struct irq_chip ar724x_pci_irq_chip = {
 	.irq_mask_ack	= ar724x_pci_irq_mask,
 };
 
-static void ar724x_pci_irq_init(struct ar724x_pci_controller *apc)
+static void ar724x_pci_irq_init(struct ar724x_pci_controller *apc,
+				int id)
 {
 	void __iomem *base;
 	int i;
@@ -274,10 +280,10 @@ static void ar724x_pci_irq_init(struct ar724x_pci_controller *apc)
 	__raw_writel(0, base + AR724X_PCI_REG_INT_MASK);
 	__raw_writel(0, base + AR724X_PCI_REG_INT_STATUS);
 
-	BUILD_BUG_ON(ATH79_PCI_IRQ_COUNT < AR724X_PCI_IRQ_COUNT);
+	apc->irq_base = ATH79_PCI_IRQ_BASE + (id * AR724X_PCI_IRQ_COUNT);
 
-	for (i = ATH79_PCI_IRQ_BASE;
-	     i < ATH79_PCI_IRQ_BASE + AR724X_PCI_IRQ_COUNT; i++) {
+	for (i = apc->irq_base;
+	     i < apc->irq_base + AR724X_PCI_IRQ_COUNT; i++) {
 		irq_set_chip_and_handler(i, &ar724x_pci_irq_chip,
 					 handle_level_irq);
 		irq_set_chip_data(i, apc);
@@ -291,6 +297,11 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 {
 	struct ar724x_pci_controller *apc;
 	struct resource *res;
+	int id;
+
+	id = pdev->id;
+	if (id == -1)
+		id = 0;
 
 	apc = devm_kzalloc(&pdev->dev, sizeof(struct ar724x_pci_controller),
 			    GFP_KERNEL);
@@ -347,7 +358,7 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 	if (!apc->link_up)
 		dev_warn(&pdev->dev, "PCIe link is down\n");
 
-	ar724x_pci_irq_init(apc);
+	ar724x_pci_irq_init(apc, id);
 
 	register_pci_controller(&apc->pci_controller);
 
-- 
1.7.10
