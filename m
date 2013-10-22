Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Oct 2013 13:20:31 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2814 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815858Ab3JVLU2leQfk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Oct 2013 13:20:28 +0200
Received: from [10.9.208.55] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 22 Oct 2013 04:20:07 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 22 Oct 2013 04:20:10 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 22 Oct 2013 04:20:10 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 41931246C8; Tue, 22
 Oct 2013 04:20:08 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>, ralf@linux-mips.org
Subject: [PATCH 15/18 UPDATED] MIPS: PCI: Netlogic XLP9XX support
Date:   Tue, 22 Oct 2013 16:56:53 +0530
Message-ID: <1382441213-11011-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1381756874-22616-16-git-send-email-jchandra@broadcom.com>
References: <1381756874-22616-16-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E7880ED150144807-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38383
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

Add PCI support for Netlogic XLP9XX. The PCI registers and
SoC bus numbers have changed in XLP9XX.

Also skip a few (bus,dev,fn) combinations which have issues when
read.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
Update for coding style compliance, braces on all the if blocks in
a group

 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h |   10 ++-
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h    |    3 +
 arch/mips/netlogic/xlp/nlm_hal.c                |    5 ++
 arch/mips/pci/pci-xlp.c                         |   95 ++++++++++++++++++-----
 4 files changed, 90 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h b/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
index 0fac32b..d4deb87 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
@@ -63,6 +63,12 @@
 #define PCIE_INT_EN0			0x261
 #define PCIE_INT_EN1			0x262
 
+/* XLP9XX has basic changes */
+#define PCIE_9XX_BYTE_SWAP_MEM_BASE	0x25c
+#define PCIE_9XX_BYTE_SWAP_MEM_LIM	0x25d
+#define PCIE_9XX_BYTE_SWAP_IO_BASE	0x25e
+#define PCIE_9XX_BYTE_SWAP_IO_LIM	0x25f
+
 /* other */
 #define PCIE_NLINKS			4
 
@@ -78,8 +84,8 @@
 
 #define nlm_read_pcie_reg(b, r)		nlm_read_reg(b, r)
 #define nlm_write_pcie_reg(b, r, v)	nlm_write_reg(b, r, v)
-#define nlm_get_pcie_base(node, inst)	\
-			nlm_pcicfg_base(XLP_IO_PCIE_OFFSET(node, inst))
+#define nlm_get_pcie_base(node, inst)	nlm_pcicfg_base(cpu_is_xlp9xx() ? \
+	XLP9XX_IO_PCIE_OFFSET(node, inst) : XLP_IO_PCIE_OFFSET(node, inst))
 
 #ifdef CONFIG_PCI_MSI
 void xlp_init_node_msi_irqs(int node, int link);
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index c29f222..848746b 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -84,6 +84,9 @@ void xlp_mmu_init(void);
 void nlm_hal_init(void);
 int xlp_get_dram_map(int n, uint64_t *dram_map);
 
+struct pci_dev;
+int xlp_socdev_to_node(const struct pci_dev *dev);
+
 /* Device tree related */
 void *xlp_dt_init(void *fdtp);
 
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index efd64ac..e7ff2d3 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -76,6 +76,11 @@ int nlm_irq_to_irt(int irq)
 			return 133;
 		case PIC_UART_1_IRQ:
 			return 134;
+		case PIC_PCIE_LINK_LEGACY_IRQ(0):
+		case PIC_PCIE_LINK_LEGACY_IRQ(1):
+		case PIC_PCIE_LINK_LEGACY_IRQ(2):
+		case PIC_PCIE_LINK_LEGACY_IRQ(3):
+			return 191 + irq - PIC_PCIE_LINK_LEGACY_IRQ_BASE;
 		}
 		return -1;
 	}
diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
index f390aa9..7babf01 100644
--- a/arch/mips/pci/pci-xlp.c
+++ b/arch/mips/pci/pci-xlp.c
@@ -67,9 +67,22 @@ static inline u32 pci_cfg_read_32bit(struct pci_bus *bus, unsigned int devfn,
 	u32 *cfgaddr;
 
 	where &= ~3;
-	if (bus->number == 0 && PCI_SLOT(devfn) == 1 && where == 0x954)
+	if (cpu_is_xlp9xx()) {
+		/* be very careful on SoC buses */
+		if (bus->number == 0) {
+			/* Scan only existing nodes - uboot bug? */
+			if (PCI_SLOT(devfn) != 0 ||
+					   !nlm_node_present(PCI_FUNC(devfn)))
+				return 0xffffffff;
+		} else if (bus->parent->number == 0) {	/* SoC bus */
+			if (PCI_SLOT(devfn) == 0)	/* b.0.0 hangs */
+				return 0xffffffff;
+			if (devfn == 44)		/* b.5.4 hangs */
+				return 0xffffffff;
+		}
+	} else if (bus->number == 0 && PCI_SLOT(devfn) == 1 && where == 0x954) {
 		return 0xffffffff;
-
+	}
 	cfgaddr = (u32 *)(pci_config_base +
 			pci_cfg_addr(bus->number, devfn, where));
 	data = *cfgaddr;
@@ -167,18 +180,35 @@ struct pci_dev *xlp_get_pcie_link(const struct pci_dev *dev)
 {
 	struct pci_bus *bus, *p;
 
-	/* Find the bridge on bus 0 */
 	bus = dev->bus;
-	for (p = bus->parent; p && p->number != 0; p = p->parent)
-		bus = p;
 
-	return p ? bus->self : NULL;
+	if (cpu_is_xlp9xx()) {
+		/* find bus with grand parent number == 0 */
+		for (p = bus->parent; p && p->parent && p->parent->number != 0;
+				p = p->parent)
+			bus = p;
+		return (p && p->parent) ? bus->self : NULL;
+	} else {
+		/* Find the bridge on bus 0 */
+		for (p = bus->parent; p && p->number != 0; p = p->parent)
+			bus = p;
+
+		return p ? bus->self : NULL;
+	}
+}
+
+int xlp_socdev_to_node(const struct pci_dev *lnkdev)
+{
+	if (cpu_is_xlp9xx())
+		return PCI_FUNC(lnkdev->bus->self->devfn);
+	else
+		return PCI_SLOT(lnkdev->devfn) / 8;
 }
 
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pci_dev *lnkdev;
-	int lnkslot, lnkfunc;
+	int lnkfunc, node;
 
 	/*
 	 * For XLP PCIe, there is an IRQ per Link, find out which
@@ -187,9 +217,11 @@ int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	lnkdev = xlp_get_pcie_link(dev);
 	if (lnkdev == NULL)
 		return 0;
+
 	lnkfunc = PCI_FUNC(lnkdev->devfn);
-	lnkslot = PCI_SLOT(lnkdev->devfn);
-	return nlm_irq_to_xirq(lnkslot / 8, PIC_PCIE_LINK_LEGACY_IRQ(lnkfunc));
+	node = xlp_socdev_to_node(lnkdev);
+
+	return nlm_irq_to_xirq(node, PIC_PCIE_LINK_LEGACY_IRQ(lnkfunc));
 }
 
 /* Do platform specific device initialization at pci_enable_device() time */
@@ -216,17 +248,38 @@ static void xlp_config_pci_bswap(int node, int link)
 	 *  Enable byte swap in hardware. Program each link's PCIe SWAP regions
 	 * from the link's address ranges.
 	 */
-	reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEMEM_BASE0 + link);
-	nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_MEM_BASE, reg);
-
-	reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEMEM_LIMIT0 + link);
-	nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_MEM_LIM, reg | 0xfff);
-
-	reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEIO_BASE0 + link);
-	nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_IO_BASE, reg);
-
-	reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEIO_LIMIT0 + link);
-	nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_IO_LIM, reg | 0xfff);
+	if (cpu_is_xlp9xx()) {
+		reg = nlm_read_bridge_reg(nbubase,
+				BRIDGE_9XX_PCIEMEM_BASE0 + link);
+		nlm_write_pci_reg(lnkbase, PCIE_9XX_BYTE_SWAP_MEM_BASE, reg);
+
+		reg = nlm_read_bridge_reg(nbubase,
+				BRIDGE_9XX_PCIEMEM_LIMIT0 + link);
+		nlm_write_pci_reg(lnkbase,
+				PCIE_9XX_BYTE_SWAP_MEM_LIM, reg | 0xfff);
+
+		reg = nlm_read_bridge_reg(nbubase,
+				BRIDGE_9XX_PCIEIO_BASE0 + link);
+		nlm_write_pci_reg(lnkbase, PCIE_9XX_BYTE_SWAP_IO_BASE, reg);
+
+		reg = nlm_read_bridge_reg(nbubase,
+				BRIDGE_9XX_PCIEIO_LIMIT0 + link);
+		nlm_write_pci_reg(lnkbase,
+				PCIE_9XX_BYTE_SWAP_IO_LIM, reg | 0xfff);
+	} else {
+		reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEMEM_BASE0 + link);
+		nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_MEM_BASE, reg);
+
+		reg = nlm_read_bridge_reg(nbubase,
+					BRIDGE_PCIEMEM_LIMIT0 + link);
+		nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_MEM_LIM, reg | 0xfff);
+
+		reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEIO_BASE0 + link);
+		nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_IO_BASE, reg);
+
+		reg = nlm_read_bridge_reg(nbubase, BRIDGE_PCIEIO_LIMIT0 + link);
+		nlm_write_pci_reg(lnkbase, PCIE_BYTE_SWAP_IO_LIM, reg | 0xfff);
+	}
 }
 #else
 /* Swap configuration not needed in little-endian mode */
@@ -260,7 +313,7 @@ static int __init pcibios_init(void)
 
 			/* put in intpin and irq - u-boot does not */
 			reg = nlm_read_pci_reg(pciebase, 0xf);
-			reg &= ~0x1fu;
+			reg &= ~0x1ffu;
 			reg |= (1 << 8) | PIC_PCIE_LINK_LEGACY_IRQ(link);
 			nlm_write_pci_reg(pciebase, 0xf, reg);
 			pr_info("XLP PCIe: Link %d-%d initialized.\n", n, link);
-- 
1.7.9.5
