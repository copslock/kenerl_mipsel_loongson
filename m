Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 00:17:30 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:47766 "EHLO
        mail.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903844Ab1KVXPC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2011 00:15:02 +0100
Received: from localhost (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTP id A6C17140564;
        Wed, 23 Nov 2011 00:14:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.szarvasnet.hu
Received: from mail.szarvasnet.hu ([127.0.0.1])
        by localhost (phoenix3.szarvasnet.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ekP1beJKbMEr; Wed, 23 Nov 2011 00:14:54 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 4BCF3140582;
        Wed, 23 Nov 2011 00:14:52 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Ren=C3=A9=20Bolldorf?= <xsecute@googlemail.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 05/12] MIPS: ath79: add PCI IRQ handling code for AR724X SoCs
Date:   Wed, 23 Nov 2011 00:14:23 +0100
Message-Id: <1322003670-8797-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.1
In-Reply-To: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 31938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19234

The PCI Host Controller of the AR724x SoC has a
built-in IRQ controller. The current code does
not supports that, so the IRQ lines wired to this
controller are not usable. This leads to failed
'request_irq' calls:

  ath9k 0000:00:00.0: request_irq failed
  ath9k: probe of 0000:00:00.0 failed with error -89

This patch adds support for the IRQ controller
in order to make PCI IRQs work.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/pci.c                  |    3 +-
 arch/mips/include/asm/mach-ath79/pci.h |    4 +-
 arch/mips/pci/pci-ar724x.c             |  111 +++++++++++++++++++++++++++++++-
 3 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 72281fb..14f981c2 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -10,6 +10,7 @@
 
 #include <linux/pci.h>
 #include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/irq.h>
 #include <asm/mach-ath79/pci.h>
 #include "pci.h"
 
@@ -50,7 +51,7 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 int __init ath79_register_pci(void)
 {
 	if (soc_is_ar724x())
-		return ar724x_pcibios_init();
+		return ar724x_pcibios_init(ATH79_CPU_IRQ_IP2);
 
 	return -ENODEV;
 }
diff --git a/arch/mips/include/asm/mach-ath79/pci.h b/arch/mips/include/asm/mach-ath79/pci.h
index 0aaf41f..a659e40 100644
--- a/arch/mips/include/asm/mach-ath79/pci.h
+++ b/arch/mips/include/asm/mach-ath79/pci.h
@@ -12,9 +12,9 @@
 #define __ASM_MACH_ATH79_PCI_H
 
 #if defined(CONFIG_PCI) && defined(CONFIG_SOC_AR724X)
-int ar724x_pcibios_init(void);
+int ar724x_pcibios_init(int irq);
 #else
-static inline int ar724x_pcibios_init(void) { return 0 };
+static inline int ar724x_pcibios_init(int irq) { return 0 };
 #endif
 
 #endif /* __ASM_MACH_ATH79_PCI_H */
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index cef6519..6a520a6 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -8,12 +8,17 @@
  *  by the Free Software Foundation.
  */
 
+#include <linux/irq.h>
 #include <linux/pci.h>
 #include <asm/mach-ath79/ath79.h>
+#include <asm/mach-ath79/ar71xx_regs.h>
 #include <asm/mach-ath79/pci.h>
 
 #define AR724X_PCI_CFG_BASE	0x14000000
 #define AR724X_PCI_CFG_SIZE	0x1000
+#define AR724X_PCI_CTRL_BASE	(AR71XX_APB_BASE + 0x000f0000)
+#define AR724X_PCI_CTRL_SIZE	0x100
+
 #define AR724X_PCI_MEM_BASE	0x10000000
 #define AR724X_PCI_MEM_SIZE	0x08000000
 
@@ -29,6 +34,7 @@
 
 static DEFINE_SPINLOCK(ar724x_pci_lock);
 static void __iomem *ar724x_pci_devcfg_base;
+static void __iomem *ar724x_pci_ctrl_base;
 
 static u32 ar724x_pci_bar0_value;
 static bool ar724x_pci_bar0_is_cached;
@@ -175,14 +181,115 @@ static struct pci_controller ar724x_pci_controller = {
 	.mem_resource	= &ar724x_mem_resource,
 };
 
-int __init ar724x_pcibios_init(void)
+static void ar724x_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
+	void __iomem *base;
+	u32 pending;
+
+	base = ar724x_pci_ctrl_base;
+
+	pending = __raw_readl(base + AR724X_PCI_REG_INT_STATUS) &
+		  __raw_readl(base + AR724X_PCI_REG_INT_MASK);
+
+	if (pending & AR724X_PCI_INT_DEV0)
+		generic_handle_irq(ATH79_PCI_IRQ(0));
+
+	else
+		spurious_interrupt();
+}
+
+static void ar724x_pci_irq_unmask(struct irq_data *d)
+{
+	void __iomem *base;
+	u32 t;
+
+	base = ar724x_pci_ctrl_base;
+
+	switch (d->irq) {
+	case ATH79_PCI_IRQ(0):
+		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
+		__raw_writel(t | AR724X_PCI_INT_DEV0,
+			     base + AR724X_PCI_REG_INT_MASK);
+		/* flush write */
+		__raw_readl(base + AR724X_PCI_REG_INT_MASK);
+	}
+}
+
+static void ar724x_pci_irq_mask(struct irq_data *d)
+{
+	void __iomem *base;
+	u32 t;
+
+	base = ar724x_pci_ctrl_base;
+
+	switch (d->irq) {
+	case ATH79_PCI_IRQ(0):
+		t = __raw_readl(base + AR724X_PCI_REG_INT_MASK);
+		__raw_writel(t & ~AR724X_PCI_INT_DEV0,
+			     base + AR724X_PCI_REG_INT_MASK);
+
+		/* flush write */
+		__raw_readl(base + AR724X_PCI_REG_INT_MASK);
+
+		t = __raw_readl(base + AR724X_PCI_REG_INT_STATUS);
+		__raw_writel(t | AR724X_PCI_INT_DEV0,
+			     base + AR724X_PCI_REG_INT_STATUS);
+
+		/* flush write */
+		__raw_readl(base + AR724X_PCI_REG_INT_STATUS);
+	}
+}
+
+static struct irq_chip ar724x_pci_irq_chip = {
+	.name		= "AR724X PCI ",
+	.irq_mask	= ar724x_pci_irq_mask,
+	.irq_unmask	= ar724x_pci_irq_unmask,
+	.irq_mask_ack	= ar724x_pci_irq_mask,
+};
+
+static void __init ar724x_pci_irq_init(int irq)
+{
+	void __iomem *base;
+	int i;
+
+	base = ar724x_pci_ctrl_base;
+
+	__raw_writel(0, base + AR724X_PCI_REG_INT_MASK);
+	__raw_writel(0, base + AR724X_PCI_REG_INT_STATUS);
+
+	BUILD_BUG_ON(ATH79_PCI_IRQ_COUNT < AR724X_PCI_IRQ_COUNT);
+
+	for (i = ATH79_PCI_IRQ_BASE;
+	     i < ATH79_PCI_IRQ_BASE + AR724X_PCI_IRQ_COUNT; i++)
+		irq_set_chip_and_handler(i, &ar724x_pci_irq_chip,
+					 handle_level_irq);
+
+	irq_set_chained_handler(irq, ar724x_pci_irq_handler);
+}
+
+int __init ar724x_pcibios_init(int irq)
+{
+	int ret;
+
+	ret = -ENOMEM;
+
 	ar724x_pci_devcfg_base = ioremap(AR724X_PCI_CFG_BASE,
 					 AR724X_PCI_CFG_SIZE);
 	if (ar724x_pci_devcfg_base == NULL)
-		return -ENOMEM;
+		goto err;
 
+	ar724x_pci_ctrl_base = ioremap(AR724X_PCI_CTRL_BASE,
+				       AR724X_PCI_CTRL_SIZE);
+	if (ar724x_pci_ctrl_base == NULL)
+		goto err_unmap_devcfg;
+
+	ar724x_pci_irq_init(irq);
 	register_pci_controller(&ar724x_pci_controller);
 
 	return PCIBIOS_SUCCESSFUL;
+
+err_unmap_devcfg:
+	iounmap(ar724x_pci_devcfg_base);
+err:
+	return ret;
 }
-- 
1.7.2.1
