Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2013 21:28:27 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53264 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827522Ab3BGU20QHn0g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Feb 2013 21:28:26 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 8D4D025E1FF;
        Thu,  7 Feb 2013 21:28:19 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2JmOHkUQYUPb; Thu,  7 Feb 2013 21:28:19 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 5111C25E1F1;
        Thu,  7 Feb 2013 21:28:19 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/3] MIPS: pci-ar71xx: use dynamically allocated PCI controller structure
Date:   Thu,  7 Feb 2013 21:28:14 +0100
Message-Id: <1360268896-13434-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35721
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
 arch/mips/pci/pci-ar71xx.c |   84 ++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 69e0bb4..44dc5bf 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -48,8 +48,12 @@
 
 #define AR71XX_PCI_IRQ_COUNT		5
 
-static DEFINE_SPINLOCK(ar71xx_pci_lock);
-static void __iomem *ar71xx_pcicfg_base;
+struct ar71xx_pci_controller {
+	void __iomem *cfg_base;
+	spinlock_t lock;
+	int irq;
+	struct pci_controller pci_ctrl;
+};
 
 /* Byte lane enable bits */
 static const u8 ar71xx_pci_ble_table[4][4] = {
@@ -92,9 +96,18 @@ static inline u32 ar71xx_pci_bus_addr(struct pci_bus *bus, unsigned int devfn,
 	return ret;
 }
 
-static int ar71xx_pci_check_error(int quiet)
+static inline struct ar71xx_pci_controller *
+pci_bus_to_ar71xx_controller(struct pci_bus *bus)
 {
-	void __iomem *base = ar71xx_pcicfg_base;
+	struct pci_controller *hose;
+
+	hose = (struct pci_controller *) bus->sysdata;
+	return container_of(hose, struct ar71xx_pci_controller, pci_ctrl);
+}
+
+static int ar71xx_pci_check_error(struct ar71xx_pci_controller *apc, int quiet)
+{
+	void __iomem *base = apc->cfg_base;
 	u32 pci_err;
 	u32 ahb_err;
 
@@ -129,9 +142,10 @@ static int ar71xx_pci_check_error(int quiet)
 	return !!(ahb_err | pci_err);
 }
 
-static inline void ar71xx_pci_local_write(int where, int size, u32 value)
+static inline void ar71xx_pci_local_write(struct ar71xx_pci_controller *apc,
+					  int where, int size, u32 value)
 {
-	void __iomem *base = ar71xx_pcicfg_base;
+	void __iomem *base = apc->cfg_base;
 	u32 ad_cbe;
 
 	value = value << (8 * (where & 3));
@@ -147,7 +161,8 @@ static inline int ar71xx_pci_set_cfgaddr(struct pci_bus *bus,
 					 unsigned int devfn,
 					 int where, int size, u32 cmd)
 {
-	void __iomem *base = ar71xx_pcicfg_base;
+	struct ar71xx_pci_controller *apc = pci_bus_to_ar71xx_controller(bus);
+	void __iomem *base = apc->cfg_base;
 	u32 addr;
 
 	addr = ar71xx_pci_bus_addr(bus, devfn, where);
@@ -156,13 +171,14 @@ static inline int ar71xx_pci_set_cfgaddr(struct pci_bus *bus,
 	__raw_writel(cmd | ar71xx_pci_get_ble(where, size, 0),
 		     base + AR71XX_PCI_REG_CFG_CBE);
 
-	return ar71xx_pci_check_error(1);
+	return ar71xx_pci_check_error(apc, 1);
 }
 
 static int ar71xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *value)
 {
-	void __iomem *base = ar71xx_pcicfg_base;
+	struct ar71xx_pci_controller *apc = pci_bus_to_ar71xx_controller(bus);
+	void __iomem *base = apc->cfg_base;
 	unsigned long flags;
 	u32 data;
 	int err;
@@ -171,7 +187,7 @@ static int ar71xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	ret = PCIBIOS_SUCCESSFUL;
 	data = ~0;
 
-	spin_lock_irqsave(&ar71xx_pci_lock, flags);
+	spin_lock_irqsave(&apc->lock, flags);
 
 	err = ar71xx_pci_set_cfgaddr(bus, devfn, where, size,
 				     AR71XX_PCI_CFG_CMD_READ);
@@ -180,7 +196,7 @@ static int ar71xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	else
 		data = __raw_readl(base + AR71XX_PCI_REG_CFG_RDDATA);
 
-	spin_unlock_irqrestore(&ar71xx_pci_lock, flags);
+	spin_unlock_irqrestore(&apc->lock, flags);
 
 	*value = (data >> (8 * (where & 3))) & ar71xx_pci_read_mask[size & 7];
 
@@ -190,7 +206,8 @@ static int ar71xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 static int ar71xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 				   int where, int size, u32 value)
 {
-	void __iomem *base = ar71xx_pcicfg_base;
+	struct ar71xx_pci_controller *apc = pci_bus_to_ar71xx_controller(bus);
+	void __iomem *base = apc->cfg_base;
 	unsigned long flags;
 	int err;
 	int ret;
@@ -198,7 +215,7 @@ static int ar71xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	value = value << (8 * (where & 3));
 	ret = PCIBIOS_SUCCESSFUL;
 
-	spin_lock_irqsave(&ar71xx_pci_lock, flags);
+	spin_lock_irqsave(&apc->lock, flags);
 
 	err = ar71xx_pci_set_cfgaddr(bus, devfn, where, size,
 				     AR71XX_PCI_CFG_CMD_WRITE);
@@ -207,7 +224,7 @@ static int ar71xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	else
 		__raw_writel(value, base + AR71XX_PCI_REG_CFG_WRDATA);
 
-	spin_unlock_irqrestore(&ar71xx_pci_lock, flags);
+	spin_unlock_irqrestore(&apc->lock, flags);
 
 	return ret;
 }
@@ -231,12 +248,6 @@ static struct resource ar71xx_pci_mem_resource = {
 	.flags		= IORESOURCE_MEM
 };
 
-static struct pci_controller ar71xx_pci_controller = {
-	.pci_ops	= &ar71xx_pci_ops,
-	.mem_resource	= &ar71xx_pci_mem_resource,
-	.io_resource	= &ar71xx_pci_io_resource,
-};
-
 static void ar71xx_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	void __iomem *base = ath79_reset_base;
@@ -294,7 +305,7 @@ static struct irq_chip ar71xx_pci_irq_chip = {
 	.irq_mask_ack	= ar71xx_pci_irq_mask,
 };
 
-static void ar71xx_pci_irq_init(int irq)
+static void ar71xx_pci_irq_init(struct ar71xx_pci_controller *apc)
 {
 	void __iomem *base = ath79_reset_base;
 	int i;
@@ -309,7 +320,7 @@ static void ar71xx_pci_irq_init(int irq)
 		irq_set_chip_and_handler(i, &ar71xx_pci_irq_chip,
 					 handle_level_irq);
 
-	irq_set_chained_handler(irq, ar71xx_pci_irq_handler);
+	irq_set_chained_handler(apc->irq, ar71xx_pci_irq_handler);
 }
 
 static void ar71xx_pci_reset(void)
@@ -336,20 +347,27 @@ static void ar71xx_pci_reset(void)
 
 static int ar71xx_pci_probe(struct platform_device *pdev)
 {
+	struct ar71xx_pci_controller *apc;
 	struct resource *res;
-	int irq;
 	u32 t;
 
+	apc = devm_kzalloc(&pdev->dev, sizeof(struct ar71xx_pci_controller),
+			   GFP_KERNEL);
+	if (!apc)
+		return -ENOMEM;
+
+	spin_lock_init(&apc->lock);
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
 	if (!res)
 		return -EINVAL;
 
-	ar71xx_pcicfg_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!ar71xx_pcicfg_base)
+	apc->cfg_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!apc->cfg_base)
 		return -ENOMEM;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	apc->irq = platform_get_irq(pdev, 0);
+	if (apc->irq < 0)
 		return -EINVAL;
 
 	ar71xx_pci_reset();
@@ -357,14 +375,18 @@ static int ar71xx_pci_probe(struct platform_device *pdev)
 	/* setup COMMAND register */
 	t = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE
 	  | PCI_COMMAND_PARITY | PCI_COMMAND_SERR | PCI_COMMAND_FAST_BACK;
-	ar71xx_pci_local_write(PCI_COMMAND, 4, t);
+	ar71xx_pci_local_write(apc, PCI_COMMAND, 4, t);
 
 	/* clear bus errors */
-	ar71xx_pci_check_error(1);
+	ar71xx_pci_check_error(apc, 1);
+
+	ar71xx_pci_irq_init(apc);
 
-	ar71xx_pci_irq_init(irq);
+	apc->pci_ctrl.pci_ops = &ar71xx_pci_ops;
+	apc->pci_ctrl.mem_resource = &ar71xx_pci_mem_resource;
+	apc->pci_ctrl.io_resource = &ar71xx_pci_io_resource;
 
-	register_pci_controller(&ar71xx_pci_controller);
+	register_pci_controller(&apc->pci_ctrl);
 
 	return 0;
 }
-- 
1.7.10
