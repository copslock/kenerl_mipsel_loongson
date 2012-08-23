Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2012 15:36:25 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:45991 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903681Ab2HWNgR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Aug 2012 15:36:17 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 034B923C0083;
        Thu, 23 Aug 2012 15:36:06 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>,
        <stable@vger.kernel.org>, #@arrakis.dune.hu, v3.5+@arrakis.dune.hu
Subject: [PATCH] MIPS: pci-ar724x: avoid data bus error due to a missing PCIe module
Date:   Thu, 23 Aug 2012 15:35:26 +0200
Message-Id: <1345728926-24917-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 34350
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
X-Keywords:                 
X-UID: 25908

If the controller has no PCIe module attached,
accessing of the device configuration space
causes a data bus error. Avoid this by checking
the status of the PCIe link in advance, and
indicate an error if the link is down.

Cc: <stable@vger.kernel.org> # v3.5+
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci-ar724x.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 414a745..86d77a6 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -23,9 +23,12 @@
 #define AR724X_PCI_MEM_BASE	0x10000000
 #define AR724X_PCI_MEM_SIZE	0x08000000
 
+#define AR724X_PCI_REG_RESET		0x18
 #define AR724X_PCI_REG_INT_STATUS	0x4c
 #define AR724X_PCI_REG_INT_MASK		0x50
 
+#define AR724X_PCI_RESET_LINK_UP	BIT(0)
+
 #define AR724X_PCI_INT_DEV0		BIT(14)
 
 #define AR724X_PCI_IRQ_COUNT		1
@@ -38,6 +41,15 @@ static void __iomem *ar724x_pci_ctrl_base;
 
 static u32 ar724x_pci_bar0_value;
 static bool ar724x_pci_bar0_is_cached;
+static bool ar724x_pci_link_up;
+
+static inline bool ar724x_pci_check_link(void)
+{
+	u32 reset;
+
+	reset = __raw_readl(ar724x_pci_ctrl_base + AR724X_PCI_REG_RESET);
+	return reset & AR724X_PCI_RESET_LINK_UP;
+}
 
 static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, uint32_t *value)
@@ -46,6 +58,9 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 	void __iomem *base;
 	u32 data;
 
+	if (!ar724x_pci_link_up)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -96,6 +111,9 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 	u32 data;
 	int s;
 
+	if (!ar724x_pci_link_up)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (devfn)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -280,6 +298,10 @@ int __init ar724x_pcibios_init(int irq)
 	if (ar724x_pci_ctrl_base == NULL)
 		goto err_unmap_devcfg;
 
+	ar724x_pci_link_up = ar724x_pci_check_link();
+	if (!ar724x_pci_link_up)
+		pr_warn("ar724x: PCIe link is down\n");
+
 	ar724x_pci_irq_init(irq);
 	register_pci_controller(&ar724x_pci_controller);
 
-- 
1.7.10
