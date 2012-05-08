Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 14:44:56 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2260 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903687Ab2EHMmo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 14:42:44 +0200
Received: from [10.9.200.133] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 08 May 2012 05:42:39 -0700
X-Server-Uuid: B730DE51-FC43-4C83-941F-F1F78A914BDD
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Tue, 8 May 2012 05:41:42 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1B60F9F9FA; Tue, 8
 May 2012 05:42:22 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Tue, 8 May 2012 05:42:21 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 02/14] MIPS: Netlogic: MSI enable fix for XLS
Date:   Tue, 8 May 2012 18:11:56 +0530
Message-ID: <1336480928-18887-3-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1336480928-18887-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1336480928-18887-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 63B7CB353E029935953-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Ganesan Ramalingam <ganesanr@broadcom.com>

MSI interrupts do not work on XLS after commit a776c49
( "PCI: msi: Disable msi interrupts when we initialize a pci device" )
because the change disables MSI interrupts on the XLS PCIe bridges
during the PCI enumeration.

Fix this by enabling MSI interrupts on the bridge in the
arch_setup_msi_irq() function. A new function xls_get_pcie_link()
has been introduced to get the PCI device corresponding to the
top level PCIe bridge on which MSI has to be enabled.

Also, update get_irq_vector() to use the new xls_get_pcie_link()
function and PCI_SLOT() macro for determining the IRQ of PCI devices.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/pci/pci-xlr.c |   59 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 50ff4dc..172af1c 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -41,6 +41,7 @@
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
 #include <linux/console.h>
+#include <linux/pci_regs.h>
 
 #include <asm/io.h>
 
@@ -156,35 +157,55 @@ struct pci_controller nlm_pci_controller = {
 	.io_offset      = 0x00000000UL,
 };
 
+/*
+ * The top level PCIe links on the XLS PCIe controller appear as
+ * bridges. Given a device, this function finds which link it is
+ * on.
+ */
+static struct pci_dev *xls_get_pcie_link(const struct pci_dev *dev)
+{
+	struct pci_bus *bus, *p;
+
+	/* Find the bridge on bus 0 */
+	bus = dev->bus;
+	for (p = bus->parent; p && p->number != 0; p = p->parent)
+		bus = p;
+
+	return p ? bus->self : NULL;
+}
+
 static int get_irq_vector(const struct pci_dev *dev)
 {
+	struct pci_dev *lnk;
+
 	if (!nlm_chip_is_xls())
-		return	PIC_PCIX_IRQ;	/* for XLR just one IRQ*/
+		return	PIC_PCIX_IRQ;	/* for XLR just one IRQ */
 
 	/*
 	 * For XLS PCIe, there is an IRQ per Link, find out which
 	 * link the device is on to assign interrupts
-	*/
-	if (dev->bus->self == NULL)
+	 */
+	lnk = xls_get_pcie_link(dev);
+	if (lnk == NULL)
 		return 0;
 
-	switch	(dev->bus->self->devfn) {
-	case 0x0:
+	switch	(PCI_SLOT(lnk->devfn)) {
+	case 0:
 		return PIC_PCIE_LINK0_IRQ;
-	case 0x8:
+	case 1:
 		return PIC_PCIE_LINK1_IRQ;
-	case 0x10:
+	case 2:
 		if (nlm_chip_is_xls_b())
 			return PIC_PCIE_XLSB0_LINK2_IRQ;
 		else
 			return PIC_PCIE_LINK2_IRQ;
-	case 0x18:
+	case 3:
 		if (nlm_chip_is_xls_b())
 			return PIC_PCIE_XLSB0_LINK3_IRQ;
 		else
 			return PIC_PCIE_LINK3_IRQ;
 	}
-	WARN(1, "Unexpected devfn %d\n", dev->bus->self->devfn);
+	WARN(1, "Unexpected devfn %d\n", lnk->devfn);
 	return 0;
 }
 
@@ -202,7 +223,27 @@ void arch_teardown_msi_irq(unsigned int irq)
 int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_msg msg;
+	struct pci_dev *lnk;
 	int irq, ret;
+	u16 val;
+
+	/* MSI not supported on XLR */
+	if (!nlm_chip_is_xls())
+		return 1;
+
+	/*
+	 * Enable MSI on the XLS PCIe controller bridge which was disabled
+	 * at enumeration, the bridge MSI capability is at 0x50
+	 */
+	lnk = xls_get_pcie_link(dev);
+	if (lnk == NULL)
+		return 1;
+
+	pci_read_config_word(lnk, 0x50 + PCI_MSI_FLAGS, &val);
+	if ((val & PCI_MSI_FLAGS_ENABLE) == 0) {
+		val |= PCI_MSI_FLAGS_ENABLE;
+		pci_write_config_word(lnk, 0x50 + PCI_MSI_FLAGS, val);
+	}
 
 	irq = get_irq_vector(dev);
 	if (irq <= 0)
-- 
1.7.9.5
