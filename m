Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:12:56 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:4936 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903692Ab2D1NMu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:12:50 +0200
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 28 Apr 2012 06:12:40 -0700
X-Server-Uuid: B730DE51-FC43-4C83-941F-F1F78A914BDD
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Sat, 28 Apr 2012 06:12:35 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0DA559F9F5; Sat, 28
 Apr 2012 06:12:35 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Sat, 28 Apr 2012 06:12:34 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 02/12] MIPS: Netlogic: MSI enable fix for XLS
Date:   Sat, 28 Apr 2012 18:42:08 +0530
Message-ID: <1335618738-4679-3-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1335618738-4679-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 638533423E024591323-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Ganesan Ramalingam <ganesanr@broadcom.com>

MSI interrupts do not work on XLS after commit a776c49, because
the change disables MSI interrupts on the XLS PCIe bridges at boot-up.

Fix this by enabling MSI interrupts on the bridge in the
arch_setup_msi_irq() function. Earlier, this was done from firmware
and we did not need to change the configuration in linux.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/pci/pci-xlr.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 50ff4dc..003e053 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -41,6 +41,7 @@
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
 #include <linux/console.h>
+#include <linux/pci_regs.h>
 
 #include <asm/io.h>
 
@@ -168,17 +169,17 @@ static int get_irq_vector(const struct pci_dev *dev)
 	if (dev->bus->self == NULL)
 		return 0;
 
-	switch	(dev->bus->self->devfn) {
-	case 0x0:
+	switch	(PCI_SLOT(dev->bus->self->devfn)) {
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
@@ -202,7 +203,26 @@ void arch_teardown_msi_irq(unsigned int irq)
 int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct msi_msg msg;
+	struct pci_bus *bus, *p;
 	int irq, ret;
+	u16 val;
+
+	/* Find the bridge on bus 0 */
+	bus = dev->bus;
+	for (p = bus->parent; p && p->number != 0; p = p->parent)
+		bus = p;
+	if (p == NULL)
+		return 1;
+
+	/*
+	 * Enable MSI which was disabled at enumeration, the bridge
+	 * MSI capability is at 0x50
+	 */
+	pci_read_config_word(bus->self, 0x50 + PCI_MSI_FLAGS, &val);
+	if ((val & PCI_MSI_FLAGS_ENABLE) == 0) {
+		val |= PCI_MSI_FLAGS_ENABLE;
+		pci_write_config_word(bus->self, 0x50 + PCI_MSI_FLAGS, val);
+	}
 
 	irq = get_irq_vector(dev);
 	if (irq <= 0)
-- 
1.7.9.5
