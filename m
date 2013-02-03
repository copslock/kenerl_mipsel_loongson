Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2013 11:58:53 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37410 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6819546Ab3BCK6wJJVIy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2013 11:58:52 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id CB2EE25D404;
        Sun,  3 Feb 2013 11:58:46 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pmSN2DpSBIQ5; Sun,  3 Feb 2013 11:58:46 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id DEECA25D3E0;
        Sun,  3 Feb 2013 11:58:45 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/4] MIPS: pci-ar724x: use dynamically allocated PCI controller structure
Date:   Sun,  3 Feb 2013 11:58:38 +0100
Message-Id: <1359889120-15699-2-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1359889120-15699-1-git-send-email-juhosg@openwrt.org>
References: <1359889120-15699-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35689
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

The current code uses static variables to store the
PCI controller specific data. This works if the system
contains one PCI controller only, however it becomes
impractical when multiple PCI controllers are present.

Move the variables into a dynamically allocated controller
specific structure, and use that instead of the static
variables.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci-ar724x.c |  129 ++++++++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 47 deletions(-)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 8f008d9..93ab877 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -9,6 +9,7 @@
  *  by the Free Software Foundation.
  */
 
+#include <linux/spinlock.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/module.h>
@@ -28,38 +29,56 @@
 
 #define AR7240_BAR0_WAR_VALUE	0xffff
 
-static DEFINE_SPINLOCK(ar724x_pci_lock);
-static void __iomem *ar724x_pci_devcfg_base;
-static void __iomem *ar724x_pci_ctrl_base;
+struct ar724x_pci_controller {
+	void __iomem *devcfg_base;
+	void __iomem *ctrl_base;
 
-static u32 ar724x_pci_bar0_value;
-static bool ar724x_pci_bar0_is_cached;
-static bool ar724x_pci_link_up;
+	int irq;
+
+	bool link_up;
+	bool bar0_is_cached;
+	u32  bar0_value;
+
+	spinlock_t lock;
+
+	struct pci_controller pci_controller;
+};
 
-static inline bool ar724x_pci_check_link(void)
+static inline bool ar724x_pci_check_link(struct ar724x_pci_controller *apc)
 {
 	u32 reset;
 
-	reset = __raw_readl(ar724x_pci_ctrl_base + AR724X_PCI_REG_RESET);
+	reset = __raw_readl(apc->ctrl_base + AR724X_PCI_REG_RESET);
 	return reset & AR724X_PCI_RESET_LINK_UP;
 }
 
+static inline struct ar724x_pci_controller *
+pci_bus_to_ar724x_controller(struct pci_bus *bus)
+{
+	struct pci_controller *hose;
+
+	hose = (struct pci_controller *) bus->sysdata;
+	return container_of(hose, struct ar724x_pci_controller, pci_controller);
+}
+
 static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, uint32_t *value)
 {
+	struct ar724x_pci_controller *apc;
 	unsigned long flags;
 	void __iomem *base;
 	u32 data;
 
-	if (!ar724x_pci_link_up)
+	apc = pci_bus_to_ar724x_controller(bus);
+	if (!apc->link_up)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	base = ar724x_pci_devcfg_base;
+	base = apc->devcfg_base;
 
-	spin_lock_irqsave(&ar724x_pci_lock, flags);
+	spin_lock_irqsave(&apc->lock, flags);
 	data = __raw_readl(base + (where & ~3));
 
 	switch (size) {
@@ -78,17 +97,17 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 	case 4:
 		break;
 	default:
-		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
+		spin_unlock_irqrestore(&apc->lock, flags);
 
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
+	spin_unlock_irqrestore(&apc->lock, flags);
 
 	if (where == PCI_BASE_ADDRESS_0 && size == 4 &&
-	    ar724x_pci_bar0_is_cached) {
+	    apc->bar0_is_cached) {
 		/* use the cached value */
-		*value = ar724x_pci_bar0_value;
+		*value = apc->bar0_value;
 	} else {
 		*value = data;
 	}
@@ -99,12 +118,14 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			     int size, uint32_t value)
 {
+	struct ar724x_pci_controller *apc;
 	unsigned long flags;
 	void __iomem *base;
 	u32 data;
 	int s;
 
-	if (!ar724x_pci_link_up)
+	apc = pci_bus_to_ar724x_controller(bus);
+	if (!apc->link_up)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (devfn)
@@ -122,18 +143,18 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			 * BAR0 register in order to make the device memory
 			 * accessible.
 			 */
-			ar724x_pci_bar0_is_cached = true;
-			ar724x_pci_bar0_value = value;
+			apc->bar0_is_cached = true;
+			apc->bar0_value = value;
 
 			value = AR7240_BAR0_WAR_VALUE;
 		} else {
-			ar724x_pci_bar0_is_cached = false;
+			apc->bar0_is_cached = false;
 		}
 	}
 
-	base = ar724x_pci_devcfg_base;
+	base = apc->devcfg_base;
 
-	spin_lock_irqsave(&ar724x_pci_lock, flags);
+	spin_lock_irqsave(&apc->lock, flags);
 	data = __raw_readl(base + (where & ~3));
 
 	switch (size) {
@@ -151,7 +172,7 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 		data = value;
 		break;
 	default:
-		spin_unlock_irqrestore(&ar724x_pci_lock, flags);
+		spin_unlock_irqrestore(&apc->lock, flags);
 
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
@@ -159,7 +180,7 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 	__raw_writel(data, base + (where & ~3));
 	/* flush write */
 	__raw_readl(base + (where & ~3));
-	spin_unlock_irqrestore(&ar724x_pci_lock, flags);
+	spin_unlock_irqrestore(&apc->lock, flags);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -183,18 +204,14 @@ static struct resource ar724x_mem_resource = {
 	.flags  = IORESOURCE_MEM,
 };
 
-static struct pci_controller ar724x_pci_controller = {
-	.pci_ops        = &ar724x_pci_ops,
-	.io_resource    = &ar724x_io_resource,
-	.mem_resource	= &ar724x_mem_resource,
-};
-
 static void ar724x_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
+	struct ar724x_pci_controller *apc;
 	void __iomem *base;
 	u32 pending;
 
-	base = ar724x_pci_ctrl_base;
+	apc = irq_get_handler_data(irq);
+	base = apc->ctrl_base;
 
 	pending = __raw_readl(base + AR724X_PCI_REG_INT_STATUS) &
 		  __raw_readl(base + AR724X_PCI_REG_INT_MASK);
@@ -208,10 +225,12 @@ static void ar724x_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 static void ar724x_pci_irq_unmask(struct irq_data *d)
 {
+	struct ar724x_pci_controller *apc;
 	void __iomem *base;
 	u32 t;
 
-	base = ar724x_pci_ctrl_base;
+	apc = irq_data_get_irq_chip_data(d);
+	base = apc->ctrl_base;
 
 	switch (d->irq) {
 	case ATH79_PCI_IRQ(0):
@@ -225,10 +244,12 @@ static void ar724x_pci_irq_unmask(struct irq_data *d)
 
 static void ar724x_pci_irq_mask(struct irq_data *d)
 {
+	struct ar724x_pci_controller *apc;
 	void __iomem *base;
 	u32 t;
 
-	base = ar724x_pci_ctrl_base;
+	apc = irq_data_get_irq_chip_data(d);
+	base = apc->ctrl_base;
 
 	switch (d->irq) {
 	case ATH79_PCI_IRQ(0):
@@ -255,12 +276,12 @@ static struct irq_chip ar724x_pci_irq_chip = {
 	.irq_mask_ack	= ar724x_pci_irq_mask,
 };
 
-static void ar724x_pci_irq_init(int irq)
+static void ar724x_pci_irq_init(struct ar724x_pci_controller *apc)
 {
 	void __iomem *base;
 	int i;
 
-	base = ar724x_pci_ctrl_base;
+	base = apc->ctrl_base;
 
 	__raw_writel(0, base + AR724X_PCI_REG_INT_MASK);
 	__raw_writel(0, base + AR724X_PCI_REG_INT_STATUS);
@@ -268,45 +289,59 @@ static void ar724x_pci_irq_init(int irq)
 	BUILD_BUG_ON(ATH79_PCI_IRQ_COUNT < AR724X_PCI_IRQ_COUNT);
 
 	for (i = ATH79_PCI_IRQ_BASE;
-	     i < ATH79_PCI_IRQ_BASE + AR724X_PCI_IRQ_COUNT; i++)
+	     i < ATH79_PCI_IRQ_BASE + AR724X_PCI_IRQ_COUNT; i++) {
 		irq_set_chip_and_handler(i, &ar724x_pci_irq_chip,
 					 handle_level_irq);
+		irq_set_chip_data(i, apc);
+	}
 
-	irq_set_chained_handler(irq, ar724x_pci_irq_handler);
+	irq_set_handler_data(apc->irq, apc);
+	irq_set_chained_handler(apc->irq, ar724x_pci_irq_handler);
 }
 
 static int ar724x_pci_probe(struct platform_device *pdev)
 {
+	struct ar724x_pci_controller *apc;
 	struct resource *res;
-	int irq;
+
+	apc = devm_kzalloc(&pdev->dev, sizeof(struct ar724x_pci_controller),
+			    GFP_KERNEL);
+	if (!apc)
+		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl_base");
 	if (!res)
 		return -EINVAL;
 
-	ar724x_pci_ctrl_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (ar724x_pci_ctrl_base == NULL)
+	apc->ctrl_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (apc->ctrl_base == NULL)
 		return -EBUSY;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
 	if (!res)
 		return -EINVAL;
 
-	ar724x_pci_devcfg_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!ar724x_pci_devcfg_base)
+	apc->devcfg_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!apc->devcfg_base)
 		return -EBUSY;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	apc->irq = platform_get_irq(pdev, 0);
+	if (apc->irq < 0)
 		return -EINVAL;
 
-	ar724x_pci_link_up = ar724x_pci_check_link();
-	if (!ar724x_pci_link_up)
+	spin_lock_init(&apc->lock);
+
+	apc->pci_controller.pci_ops = &ar724x_pci_ops;
+	apc->pci_controller.io_resource = &ar724x_io_resource;
+	apc->pci_controller.mem_resource = &ar724x_mem_resource;
+
+	apc->link_up = ar724x_pci_check_link(apc);
+	if (!apc->link_up)
 		dev_warn(&pdev->dev, "PCIe link is down\n");
 
-	ar724x_pci_irq_init(irq);
+	ar724x_pci_irq_init(apc);
 
-	register_pci_controller(&ar724x_pci_controller);
+	register_pci_controller(&apc->pci_controller);
 
 	return 0;
 }
-- 
1.7.10
