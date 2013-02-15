Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:41:38 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58612 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827636Ab3BOOieq7ndo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:34 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 53_5SFQutvdd; Fri, 15 Feb 2013 15:38:24 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id B22A32803BD;
        Fri, 15 Feb 2013 15:38:23 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH 09/11] MIPS: ath79: add PCI controller registration code for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 15:38:23 +0100
Message-Id: <1360939105-23591-10-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35762
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

Add SoC specific PCI IRQ map, and register platform
devices for the two built-in PCIe RCs.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/Kconfig                        |    2 ++
 arch/mips/ath79/pci.c                          |   36 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   13 +++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
index 77926e3..76a001e 100644
--- a/arch/mips/ath79/Kconfig
+++ b/arch/mips/ath79/Kconfig
@@ -90,6 +90,8 @@ config SOC_AR934X
 
 config SOC_QCA955X
 	select USB_ARCH_HAS_EHCI
+	select HW_HAS_PCI
+	select PCI_AR724X if PCI
 	def_bool n
 
 config PCI_AR724X
diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
index 4350c25..730c0b0 100644
--- a/arch/mips/ath79/pci.c
+++ b/arch/mips/ath79/pci.c
@@ -49,6 +49,21 @@ static const struct ath79_pci_irq ar724x_pci_irq_map[] __initconst = {
 	}
 };
 
+static const struct ath79_pci_irq qca955x_pci_irq_map[] __initconst = {
+	{
+		.bus	= 0,
+		.slot	= 0,
+		.pin	= 1,
+		.irq	= ATH79_PCI_IRQ(0),
+	},
+	{
+		.bus	= 1,
+		.slot	= 0,
+		.pin	= 1,
+		.irq	= ATH79_PCI_IRQ(1),
+	},
+};
+
 int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
 {
 	int irq = -1;
@@ -64,6 +79,9 @@ int __init pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
 			   soc_is_ar9344()) {
 			ath79_pci_irq_map = ar724x_pci_irq_map;
 			ath79_pci_nr_irqs = ARRAY_SIZE(ar724x_pci_irq_map);
+		} else if (soc_is_qca955x()) {
+			ath79_pci_irq_map = qca955x_pci_irq_map;
+			ath79_pci_nr_irqs = ARRAY_SIZE(qca955x_pci_irq_map);
 		} else {
 			pr_crit("pci %s: invalid irq map\n",
 				pci_name((struct pci_dev *) dev));
@@ -225,6 +243,24 @@ int __init ath79_register_pci(void)
 						 AR724X_PCI_MEM_SIZE,
 						 0,
 						 ATH79_IP2_IRQ(0));
+	} else if (soc_is_qca9558()) {
+		pdev = ath79_register_pci_ar724x(0,
+						 QCA955X_PCI_CFG_BASE0,
+						 QCA955X_PCI_CTRL_BASE0,
+						 QCA955X_PCI_CRP_BASE0,
+						 QCA955X_PCI_MEM_BASE0,
+						 QCA955X_PCI_MEM_SIZE,
+						 0,
+						 ATH79_IP2_IRQ(0));
+
+		pdev = ath79_register_pci_ar724x(1,
+						 QCA955X_PCI_CFG_BASE1,
+						 QCA955X_PCI_CTRL_BASE1,
+						 QCA955X_PCI_CRP_BASE1,
+						 QCA955X_PCI_MEM_BASE1,
+						 QCA955X_PCI_MEM_SIZE,
+						 1,
+						 ATH79_IP3_IRQ(2));
 	} else {
 		/* No PCI support */
 		return -ENODEV;
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 4728212..b7fa9d1 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -94,6 +94,19 @@
 #define AR934X_SRIF_BASE	(AR71XX_APB_BASE + 0x00116000)
 #define AR934X_SRIF_SIZE	0x1000
 
+#define QCA955X_PCI_MEM_BASE0	0x10000000
+#define QCA955X_PCI_MEM_BASE1	0x12000000
+#define QCA955X_PCI_MEM_SIZE	0x02000000
+#define QCA955X_PCI_CFG_BASE0	0x14000000
+#define QCA955X_PCI_CFG_BASE1	0x16000000
+#define QCA955X_PCI_CFG_SIZE	0x1000
+#define QCA955X_PCI_CRP_BASE0	(AR71XX_APB_BASE + 0x000c0000)
+#define QCA955X_PCI_CRP_BASE1	(AR71XX_APB_BASE + 0x00250000)
+#define QCA955X_PCI_CRP_SIZE	0x1000
+#define QCA955X_PCI_CTRL_BASE0	(AR71XX_APB_BASE + 0x000f0000)
+#define QCA955X_PCI_CTRL_BASE1	(AR71XX_APB_BASE + 0x00280000)
+#define QCA955X_PCI_CTRL_SIZE	0x100
+
 #define QCA955X_WMAC_BASE	(AR71XX_APB_BASE + 0x00100000)
 #define QCA955X_WMAC_SIZE	0x20000
 
-- 
1.7.10
