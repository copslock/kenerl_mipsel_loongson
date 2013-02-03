Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2013 16:52:56 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:42373 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816288Ab3BCPwwr5Blh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Feb 2013 16:52:52 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id 6606E25D424;
        Sun,  3 Feb 2013 16:52:46 +0100 (CET)
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5UfKkb4ZncJx; Sun,  3 Feb 2013 16:52:46 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 33AE025C76B;
        Sun,  3 Feb 2013 16:52:46 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 5/4] MIPS: pci-ar724x: setup command register of the PCI controller
Date:   Sun,  3 Feb 2013 16:52:47 +0100
Message-Id: <1359906767-20512-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1359889120-15699-1-git-send-email-juhosg@openwrt.org>
References: <1359889120-15699-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35696
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

The command register of the PCI controller is
not initialized correctly by the bootloader on
some boards and this leads to non working PCI
bus.

Add code to initialize the command register
from the Linux code to avoid this.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Sorry for the confusing patch number. This belongs to the 
previous 'pci-ar724x' series but I forgot to add it there.

Gabor


 arch/mips/ath79/pci.c                          |   10 +++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    2 +
 arch/mips/pci/pci-ar724x.c                     |   63 ++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 45d1112..942e3f9 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -139,13 +139,14 @@ static struct platform_device *
 ath79_register_pci_ar724x(int id,
 			  unsigned long cfg_base,
 			  unsigned long ctrl_base,
+			  unsigned long crp_base,
 			  unsigned long mem_base,
 			  unsigned long mem_size,
 			  unsigned long io_base,
 			  int irq)
 {
 	struct platform_device *pdev;
-	struct resource res[5];
+	struct resource res[6];
 
 	memset(res, 0, sizeof(res));
 
@@ -173,6 +174,11 @@ ath79_register_pci_ar724x(int id,
 	res[4].start = io_base;
 	res[4].end = io_base;
 
+	res[5].name = "crp_base";
+	res[5].flags = IORESOURCE_MEM;
+	res[5].start = crp_base;
+	res[5].end = crp_base + AR724X_PCI_CRP_SIZE - 1;
+
 	pdev = platform_device_register_simple("ar724x-pci", id,
 					       res, ARRAY_SIZE(res));
 	return pdev;
@@ -188,6 +194,7 @@ int __init ath79_register_pci(void)
 		pdev = ath79_register_pci_ar724x(-1,
 						 AR724X_PCI_CFG_BASE,
 						 AR724X_PCI_CTRL_BASE,
+						 AR724X_PCI_CRP_BASE,
 						 AR724X_PCI_MEM_BASE,
 						 AR724X_PCI_MEM_SIZE,
 						 0,
@@ -203,6 +210,7 @@ int __init ath79_register_pci(void)
 		pdev = ath79_register_pci_ar724x(-1,
 						 AR724X_PCI_CFG_BASE,
 						 AR724X_PCI_CTRL_BASE,
+						 AR724X_PCI_CRP_BASE,
 						 AR724X_PCI_MEM_BASE,
 						 AR724X_PCI_MEM_SIZE,
 						 0,
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 7c87bfe..a77f6ee 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -67,6 +67,8 @@
 
 #define AR724X_PCI_CFG_BASE	0x14000000
 #define AR724X_PCI_CFG_SIZE	0x1000
+#define AR724X_PCI_CRP_BASE	(AR71XX_APB_BASE + 0x000c0000)
+#define AR724X_PCI_CRP_SIZE	0x1000
 #define AR724X_PCI_CTRL_BASE	(AR71XX_APB_BASE + 0x000f0000)
 #define AR724X_PCI_CTRL_SIZE	0x100
 
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 0440d88..8a0700d 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -29,9 +29,17 @@
 
 #define AR7240_BAR0_WAR_VALUE	0xffff
 
+#define AR724X_PCI_CMD_INIT	(PCI_COMMAND_MEMORY |		\
+				 PCI_COMMAND_MASTER |		\
+				 PCI_COMMAND_INVALIDATE |	\
+				 PCI_COMMAND_PARITY |		\
+				 PCI_COMMAND_SERR |		\
+				 PCI_COMMAND_FAST_BACK)
+
 struct ar724x_pci_controller {
 	void __iomem *devcfg_base;
 	void __iomem *ctrl_base;
+	void __iomem *crp_base;
 
 	int irq;
 	int irq_base;
@@ -64,6 +72,51 @@ pci_bus_to_ar724x_controller(struct pci_bus *bus)
 	return container_of(hose, struct ar724x_pci_controller, pci_controller);
 }
 
+static int ar724x_pci_local_write(struct ar724x_pci_controller *apc,
+				  int where, int size, u32 value)
+{
+	unsigned long flags;
+	void __iomem *base;
+	u32 data;
+	int s;
+
+	WARN_ON(where & (size - 1));
+
+	if (!apc->link_up)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	base = apc->crp_base;
+
+	spin_lock_irqsave(&apc->lock, flags);
+	data = __raw_readl(base + (where & ~3));
+
+	switch (size) {
+	case 1:
+		s = ((where & 3) * 8);
+		data &= ~(0xff << s);
+		data |= ((value & 0xff) << s);
+		break;
+	case 2:
+		s = ((where & 2) * 8);
+		data &= ~(0xffff << s);
+		data |= ((value & 0xffff) << s);
+		break;
+	case 4:
+		data = value;
+		break;
+	default:
+		spin_unlock_irqrestore(&apc->lock, flags);
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	__raw_writel(data, base + (where & ~3));
+	/* flush write */
+	__raw_readl(base + (where & ~3));
+	spin_unlock_irqrestore(&apc->lock, flags);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, uint32_t *value)
 {
@@ -324,6 +377,14 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 	if (!apc->devcfg_base)
 		return -EBUSY;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "crp_base");
+	if (!res)
+		return -EINVAL;
+
+	apc->crp_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (apc->crp_base == NULL)
+		return -EBUSY;
+
 	apc->irq = platform_get_irq(pdev, 0);
 	if (apc->irq < 0)
 		return -EINVAL;
@@ -360,6 +421,8 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 
 	ar724x_pci_irq_init(apc, id);
 
+	ar724x_pci_local_write(apc, PCI_COMMAND, 4, AR724X_PCI_CMD_INIT);
+
 	register_pci_controller(&apc->pci_controller);
 
 	return 0;
-- 
1.7.10
