Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 11:45:36 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4544 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824769Ab2KOKperz4J1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Nov 2012 11:45:34 +0100
Received: from [10.9.200.133] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Thu, 15 Nov 2012 02:41:15 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Thu, 15 Nov 2012 02:44:52 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0A7AC4102D; Thu, 15
 Nov 2012 02:45:09 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH] MIPS: PCI: Update XLR/XLS PCI for the new PIC code
Date:   Thu, 15 Nov 2012 16:15:55 +0530
Message-ID: <1352976355-2780-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7CBA19413P83174702-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Use the nlm_set_pic_extra_ack() call to setup the extra interrupt
ACK needed by XLR PCI and XLS PCIe. Simplify the code by adding
nlm_pci_link_to_irq().

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/pci/pci-xlr.c |   69 +++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
index 18af021..0c18ccc 100644
--- a/arch/mips/pci/pci-xlr.c
+++ b/arch/mips/pci/pci-xlr.c
@@ -47,6 +47,7 @@
 
 #include <asm/netlogic/interrupt.h>
 #include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
 
 #include <asm/netlogic/xlr/msidef.h>
 #include <asm/netlogic/xlr/iomap.h>
@@ -174,22 +175,9 @@ static struct pci_dev *xls_get_pcie_link(const struct pci_dev *dev)
 	return p ? bus->self : NULL;
 }
 
-static int get_irq_vector(const struct pci_dev *dev)
+static int nlm_pci_link_to_irq(int link)
 {
-	struct pci_dev *lnk;
-
-	if (!nlm_chip_is_xls())
-		return	PIC_PCIX_IRQ;	/* for XLR just one IRQ */
-
-	/*
-	 * For XLS PCIe, there is an IRQ per Link, find out which
-	 * link the device is on to assign interrupts
-	 */
-	lnk = xls_get_pcie_link(dev);
-	if (lnk == NULL)
-		return 0;
-
-	switch	(PCI_SLOT(lnk->devfn)) {
+	switch	(link) {
 	case 0:
 		return PIC_PCIE_LINK0_IRQ;
 	case 1:
@@ -205,10 +193,26 @@ static int get_irq_vector(const struct pci_dev *dev)
 		else
 			return PIC_PCIE_LINK3_IRQ;
 	}
-	WARN(1, "Unexpected devfn %d\n", lnk->devfn);
+	WARN(1, "Unexpected link %d\n", link);
 	return 0;
 }
 
+static int get_irq_vector(const struct pci_dev *dev)
+{
+	struct pci_dev *lnk;
+	int link;
+
+	if (!nlm_chip_is_xls())
+		return	PIC_PCIX_IRQ;	/* for XLR just one IRQ */
+
+	lnk = xls_get_pcie_link(dev);
+	if (lnk == NULL)
+		return 0;
+
+	link = PCI_SLOT(lnk->devfn);
+	return nlm_pci_link_to_irq(link);
+}
+
 #ifdef CONFIG_PCI_MSI
 void destroy_irq(unsigned int irq)
 {
@@ -332,6 +336,9 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 
 static int __init pcibios_init(void)
 {
+	void (*extra_ack)(struct irq_data *);
+	int link, irq;
+
 	/* PSB assigns PCI resources */
 	pci_set_flags(PCI_PROBE_ONLY);
 	pci_config_base = ioremap(DEFAULT_PCI_CONFIG_BASE, 16 << 20);
@@ -350,27 +357,19 @@ static int __init pcibios_init(void)
 	 * For PCI interrupts, we need to ack the PCI controller too, overload
 	 * irq handler data to do this
 	 */
-	if (nlm_chip_is_xls()) {
-		if (nlm_chip_is_xls_b()) {
-			irq_set_handler_data(PIC_PCIE_LINK0_IRQ,
-							xls_pcie_ack_b);
-			irq_set_handler_data(PIC_PCIE_LINK1_IRQ,
-							xls_pcie_ack_b);
-			irq_set_handler_data(PIC_PCIE_XLSB0_LINK2_IRQ,
-							xls_pcie_ack_b);
-			irq_set_handler_data(PIC_PCIE_XLSB0_LINK3_IRQ,
-							xls_pcie_ack_b);
-		} else {
-			irq_set_handler_data(PIC_PCIE_LINK0_IRQ, xls_pcie_ack);
-			irq_set_handler_data(PIC_PCIE_LINK1_IRQ, xls_pcie_ack);
-			irq_set_handler_data(PIC_PCIE_LINK2_IRQ, xls_pcie_ack);
-			irq_set_handler_data(PIC_PCIE_LINK3_IRQ, xls_pcie_ack);
-		}
-	} else {
+	if (!nlm_chip_is_xls()) {
 		/* XLR PCI controller ACK */
-		irq_set_handler_data(PIC_PCIX_IRQ, xlr_pci_ack);
+		nlm_set_pic_extra_ack(0, PIC_PCIX_IRQ, xlr_pci_ack);
+	} else {
+		if  (nlm_chip_is_xls_b())
+			extra_ack = xls_pcie_ack_b;
+		else
+			extra_ack = xls_pcie_ack;
+		for (link = 0; link < 4; link++) {
+			irq = nlm_pci_link_to_irq(link);
+			nlm_set_pic_extra_ack(0, irq, extra_ack);
+		}
 	}
-
 	return 0;
 }
 
-- 
1.7.9.5
