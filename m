Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 13:10:33 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:2009 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832211Ab3APMKLnn9EW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Jan 2013 13:10:11 +0100
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 16 Jan 2013 04:04:42 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 irvexchcas06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server id 14.1.355.2; Wed, 16 Jan 2013 04:09:54 -0800
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 9014740FE3; Wed, 16
 Jan 2013 04:09:53 -0800 (PST)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 10/10] MIPS: PCI: Multi-node PCI support for Netlogic
 XLP
Date:   Wed, 16 Jan 2013 17:42:41 +0530
Message-ID: <1358338361-15499-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1358338361-15499-1-git-send-email-jchandra@broadcom.com>
References: <1358231908-14458-2-git-send-email-jchandra@broadcom.com>
 <1358338361-15499-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7CE848D03Q43158780-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35466
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

On a multi-chip XLP board, each node can have 4 PCIe links. Update
XLP PCI code to initialize PCIe on all the nodes.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
[ Updated for the new PATCH 3/10]

 arch/mips/pci/pci-xlp.c |  109 ++++++++++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 43 deletions(-)

diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index fbf001a..dd2d3eb 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -46,6 +46,7 @@
 
 #include <asm/netlogic/interrupt.h>
 #include <asm/netlogic/haldefs.h>
+#include <asm/netlogic/common.h>
 
 #include <asm/netlogic/xlp-hal/iomap.h>
 #include <asm/netlogic/xlp-hal/pic.h>
@@ -161,32 +162,38 @@ struct pci_controller nlm_pci_controller = {
 	.io_offset      = 0x00000000UL,
 };
 
-static int get_irq_vector(const struct pci_dev *dev)
+static struct pci_dev *xlp_get_pcie_link(const struct pci_dev *dev)
 {
-	/*
-	 * For XLP PCIe, there is an IRQ per Link, find out which
-	 * link the device is on to assign interrupts
-	*/
-	if (dev->bus->self == NULL)
-		return 0;
+	struct pci_bus *bus, *p;
 
-	switch	(dev->bus->self->devfn) {
-	case 0x8:
-		return PIC_PCIE_LINK_0_IRQ;
-	case 0x9:
-		return PIC_PCIE_LINK_1_IRQ;
-	case 0xa:
-		return PIC_PCIE_LINK_2_IRQ;
-	case 0xb:
-		return PIC_PCIE_LINK_3_IRQ;
-	}
-	WARN(1, "Unexpected devfn %d\n", dev->bus->self->devfn);
-	return 0;
+	/* Find the bridge on bus 0 */
+	bus = dev->bus;
+	for (p = bus->parent; p && p->number != 0; p = p->parent)
+		bus = p;
+
+	return p ? bus->self : NULL;
+}
+
+static inline int nlm_pci_link_to_irq(int link)
+{
+	return PIC_PCIE_LINK_0_IRQ + link;
 }
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	return get_irq_vector(dev);
+	struct pci_dev *lnkdev;
+	int lnkslot, lnkfunc;
+
+	/*
+	 * For XLP PCIe, there is an IRQ per Link, find out which
+	 * link the device is on to assign interrupts
+	*/
+	lnkdev = xlp_get_pcie_link(dev);
+	if (lnkdev == NULL)
+		return 0;
+	lnkfunc = PCI_FUNC(lnkdev->devfn);
+	lnkslot = PCI_SLOT(lnkdev->devfn);
+	return nlm_irq_to_xirq(lnkslot / 8, nlm_pci_link_to_irq(lnkfunc));
 }
 
 /* Do platform specific device initialization at pci_enable_device() time */
@@ -201,45 +208,42 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
  * readl/writel.
  */
 #ifdef __BIG_ENDIAN
-static void xlp_config_pci_bswap(void)
+static void xlp_config_pci_bswap(int node, int link)
 {
-	uint64_t pciebase, sysbase;
-	int node, i;
+	uint64_t nbubase, lnkbase;
 	u32 reg;
 
-	/* Chip-0 so node set to 0 */
-	node = 0;
-	sysbase = nlm_get_bridge_regbase(node);
+	nbubase = nlm_get_bridge_regbase(node);
+	lnkbase = nlm_get_pcie_base(node, link);
+
 	/*
 	 *  Enable byte swap in hardware. Program each link's PCIe SWAP regions
 	 * from the link's address ranges.
 	 */
-	for (i = 0; i < 4; i++) {
-		pciebase = nlm_pcicfg_base(XLP_IO_PCIE_OFFSET(node, i));
-		if (nlm_read_pci_reg(pciebase, 0) == 0xffffffff)
-			continue;
+	reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEMEM_BASE0 + link);
+	nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_MEM_BASE, reg);
 
-		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEMEM_BASE0 + i);
-		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_MEM_BASE, reg);
+	reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEMEM_LIMIT0 + link);
+	nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_MEM_LIM, reg | 0xfff);
 
-		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEMEM_LIMIT0 + i);
-		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_MEM_LIM,
-			reg | 0xfff);
+	reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEIO_BASE0 + link);
+	nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_IO_BASE, reg);
 
-		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_BASE0 + i);
-		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_BASE, reg);
-
-		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_LIMIT0 + i);
-		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_LIM, reg | 0xfff);
-	}
+	reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEIO_LIMIT0 + link);
+	nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_IO_LIM, reg | 0xfff);
 }
 #else
 /* Swap configuration not needed in little-endian mode */
-static inline void xlp_config_pci_bswap(void) {}
+static inline void xlp_config_pci_bswap(int node, int link) {}
 #endif /* __BIG_ENDIAN */
 
 static int __init pcibios_init(void)
 {
+	struct nlm_soc_info *nodep;
+	uint64_t pciebase;
+	int link, n;
+	u32 reg;
+
 	/* Firmware assigns PCI resources */
 	pci_set_flags(PCI_PROBE_ONLY);
 	pci_config_base = ioremap(XLP_DEFAULT_PCI_ECFG_BASE, 64 << 20);
@@ -248,7 +252,26 @@ static int __init pcibios_init(void)
 	ioport_resource.start =  0;
 	ioport_resource.end   = ~0;
 
-	xlp_config_pci_bswap();
+	for (n = 0; n < NLM_NR_NODES; n++) {
+		nodep = nlm_get_node(n);
+		if (!nodep->coremask)
+			continue;	/* node does not exist */
+
+		for (link = 0; link < 4; link++) {
+			pciebase = nlm_get_pcie_base(n, link);
+			if (nlm_read_pci_reg(pciebase, 0) == 0xffffffff)
+				continue;
+			xlp_config_pci_bswap(n, link);
+
+			/* put in intpin and irq - u-boot does not */
+			reg = nlm_read_pci_reg(pciebase, 0xf);
+			reg &= ~0x1fu;
+			reg |= (1 << 8) | nlm_pci_link_to_irq(link);
+			nlm_write_pci_reg(pciebase, 0xf, reg);
+			pr_info("XLP PCIe: Link %d-%d initialized.\n", n, link);
+		}
+	}
+
 	set_io_port_base(CKSEG1);
 	nlm_pci_controller.io_map_base = CKSEG1;
 
-- 
1.7.9.5
