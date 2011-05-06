Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 22:08:02 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:4837 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491113Ab1EFUHB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2011 22:07:01 +0200
X-TM-IMSS-Message-ID: <2cf5f7f40003a953@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 2cf5f7f40003a953 ; Fri, 6 May 2011 13:06:31 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 6 May 2011 13:07:21 -0700
Date:   Sat, 7 May 2011 01:37:31 +0530
From:   Jayachandran C <jayachandranc@netlogicmicro.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 7/8] PCI support for XLR/XLS
Message-ID: <308b8963d3ed2beb54b96634e3b72d84c4b45cfa.1304712046.git.jayachandranc@netlogicmicro.com>
References: <cover.1304712046.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1304712046.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 06 May 2011 20:07:21.0369 (UTC) FILETIME=[35433090:01CC0C29]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

Adds pci/pci-xlr.c to support for XLR PCI/PCI-X interface and XLS PCIe
interface.
Update irq.c to ack PCI interrupts, use irq handler data to do the
PCI/PCIe bus ack.

Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/include/asm/netlogic/xlr/xlr.h |   21 +++
 arch/mips/netlogic/xlr/irq.c             |   86 ++++++++++++-
 arch/mips/pci/Makefile                   |    1 +
 arch/mips/pci/pci-xlr.c                  |  214 ++++++++++++++++++++++++++++++
 4 files changed, 321 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/pci/pci-xlr.c

diff --git a/arch/mips/include/asm/netlogic/xlr/xlr.h b/arch/mips/include/asm/netlogic/xlr/xlr.h
index 454c236..3e63726 100644
--- a/arch/mips/include/asm/netlogic/xlr/xlr.h
+++ b/arch/mips/include/asm/netlogic/xlr/xlr.h
@@ -41,6 +41,7 @@ unsigned int nlm_xlr_uart_in(struct uart_port *, int);
 void nlm_xlr_uart_out(struct uart_port *, int, int);
 
 /* SMP support functions */
+struct irq_desc;
 void nlm_smp_function_ipi_handler(unsigned int irq, struct irq_desc *desc);
 void nlm_smp_resched_ipi_handler(unsigned int irq, struct irq_desc *desc);
 int nlm_wakeup_secondary_cpus(u32 wakeup_mask);
@@ -51,4 +52,24 @@ void prom_pre_boot_secondary_cpus(void);
 extern struct plat_smp_ops nlm_smp_ops;
 extern unsigned long nlm_common_ebase;
 
+/* XLS B silicon "Rook" */
+static inline unsigned int nlm_chip_is_xls_b(void)
+{
+	uint32_t prid = read_c0_prid();
+
+	return ((prid & 0xf000) == 0x4000);
+}
+
+/*
+ *  XLR chip types
+ */
+ /* The XLS product line has chip versions 0x[48c]? */
+static inline unsigned int nlm_chip_is_xls(void)
+{
+	uint32_t prid = read_c0_prid();
+
+	return ((prid & 0xf000) == 0x8000 || (prid & 0xf000) == 0x4000 ||
+		(prid & 0xf000) == 0xc000);
+}
+
 #endif /* _ASM_NLM_XLR_H */
diff --git a/arch/mips/netlogic/xlr/irq.c b/arch/mips/netlogic/xlr/irq.c
index 2033f56..1446d58 100644
--- a/arch/mips/netlogic/xlr/irq.c
+++ b/arch/mips/netlogic/xlr/irq.c
@@ -83,14 +83,71 @@ static void xlr_pic_mask(struct irq_data *d)
 	spin_unlock_irqrestore(&nlm_pic_lock, flags);
 }
 
+#ifdef CONFIG_PCI
+/* Extra ACK needed for XLR on chip PCI controller */
+static void xlr_pci_ack(struct irq_data *d)
+{
+	nlm_reg_t *pci_mmio = netlogic_io_mmio(NETLOGIC_IO_PCIX_OFFSET);
+
+	netlogic_read_reg(pci_mmio, (0x140 >> 2));
+}
+
+/* Extra ACK needed for XLS on chip PCIe controller */
+static void xls_pcie_ack(struct irq_data *d)
+{
+	nlm_reg_t *pcie_mmio_le = netlogic_io_mmio(NETLOGIC_IO_PCIE_1_OFFSET);
+
+	switch (d->irq) {
+	case PIC_PCIE_LINK0_IRQ:
+		netlogic_write_reg(pcie_mmio_le, (0x90 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_LINK1_IRQ:
+		netlogic_write_reg(pcie_mmio_le, (0x94 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_LINK2_IRQ:
+		netlogic_write_reg(pcie_mmio_le, (0x190 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_LINK3_IRQ:
+		netlogic_write_reg(pcie_mmio_le, (0x194 >> 2), 0xffffffff);
+		break;
+	}
+}
+
+/* For XLS B silicon, the 3,4 PCI interrupts are different */
+static void xls_pcie_ack_b(struct irq_data *d)
+{
+	nlm_reg_t *pcie_mmio_le = netlogic_io_mmio(NETLOGIC_IO_PCIE_1_OFFSET);
+
+	switch (d->irq) {
+	case PIC_PCIE_LINK0_IRQ:
+		netlogic_write_reg(pcie_mmio_le, (0x90 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_LINK1_IRQ:
+		netlogic_write_reg(pcie_mmio_le, (0x94 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_XLSB0_LINK2_IRQ:
+		netlogic_write_reg(pcie_mmio_le, (0x190 >> 2), 0xffffffff);
+		break;
+	case PIC_PCIE_XLSB0_LINK3_IRQ:
+		netlogic_write_reg(pcie_mmio_le, (0x194 >> 2), 0xffffffff);
+		break;
+	}
+}
+#endif
+
 static void xlr_pic_ack(struct irq_data *d)
 {
 	unsigned long flags;
 	nlm_reg_t *mmio;
 	int irq = d->irq;
+	void *hd = irq_data_get_irq_handler_data(d);
 
 	WARN(!PIC_IRQ_IS_IRT(irq), "Bad irq %d", irq);
 
+	if (hd) {
+		void (*extra_ack)(void *) = hd;
+		extra_ack(d);
+	}
 	mmio = netlogic_io_mmio(NETLOGIC_IO_PIC_OFFSET);
 	spin_lock_irqsave(&nlm_pic_lock, flags);
 	netlogic_write_reg(mmio, PIC_INT_ACK, (1 << (irq - PIC_IRQ_BASE)));
@@ -162,6 +219,33 @@ void __init init_xlr_irqs(void)
 	nlm_irq_mask |=
 	    ((1ULL << IRQ_IPI_SMP_FUNCTION) | (1ULL << IRQ_IPI_SMP_RESCHEDULE));
 #endif
+
+#ifdef CONFIG_PCI
+	/*
+	 * For PCI interrupts, we need to ack the PIC controller too, overload
+	 * irq handler data to do this
+	 */
+	if (nlm_chip_is_xls()) {
+		if (nlm_chip_is_xls_b()) {
+			irq_set_handler_data(PIC_PCIE_LINK0_IRQ,
+							xls_pcie_ack_b);
+			irq_set_handler_data(PIC_PCIE_LINK1_IRQ,
+							xls_pcie_ack_b);
+			irq_set_handler_data(PIC_PCIE_XLSB0_LINK2_IRQ,
+							xls_pcie_ack_b);
+			irq_set_handler_data(PIC_PCIE_XLSB0_LINK3_IRQ,
+							xls_pcie_ack_b);
+		} else {
+			irq_set_handler_data(PIC_PCIE_LINK0_IRQ, xls_pcie_ack);
+			irq_set_handler_data(PIC_PCIE_LINK1_IRQ, xls_pcie_ack);
+			irq_set_handler_data(PIC_PCIE_LINK2_IRQ, xls_pcie_ack);
+			irq_set_handler_data(PIC_PCIE_LINK3_IRQ, xls_pcie_ack);
+		}
+	} else {
+		/* XLR PCI controller ACK */
+		irq_set_handler_data(PIC_PCIE_XLSB0_LINK3_IRQ, xlr_pci_ack);
+	}
+#endif
 	/* unmask all PIC related interrupts. If no handler is installed by the
 	 * drivers, it'll just ack the interrupt and return
 	 */
@@ -199,7 +283,7 @@ asmlinkage void plat_irq_dispatch(void)
 		return;
 	}
 
-	/* TODO use dcltz: optimize below code */
+	/* use dcltz: optimize below code */
 	for (i = 63; i != -1; i--) {
 		if (eirr & (1ULL << i))
 			break;
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index c9209ca..f0d5329 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
 obj-$(CONFIG_MIKROTIK_RB532)	+= pci-rc32434.o ops-rc32434.o fixup-rc32434.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= pci-octeon.o pcie-octeon.o
+obj-$(CONFIG_NLM_XLR)		+= pci-xlr.o
 
 ifdef CONFIG_PCI_MSI
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= msi-octeon.o
diff --git a/arch/mips/pci/pci-xlr.c b/arch/mips/pci/pci-xlr.c
new file mode 100644
index 0000000..38fece1
--- /dev/null
+++ b/arch/mips/pci/pci-xlr.c
@@ -0,0 +1,214 @@
+/*
+ * Copyright 2003-2011 NetLogic Microsystems, Inc. (NetLogic). All rights
+ * reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the NetLogic
+ * license below:
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY NETLOGIC ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL NETLOGIC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/console.h>
+
+#include <asm/io.h>
+
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/xlr/iomap.h>
+#include <asm/netlogic/xlr/pic.h>
+#include <asm/netlogic/xlr/xlr.h>
+
+static void *pci_config_base;
+
+#define	pci_cfg_addr(bus, devfn, off) (((bus) << 16) | ((devfn) << 8) | (off))
+
+/* PCI ops */
+static inline u32 pci_cfg_read_32bit(struct pci_bus *bus, unsigned int devfn,
+	int where)
+{
+	u32 data;
+	u32 *cfgaddr;
+
+	cfgaddr = (u32 *)(pci_config_base +
+			pci_cfg_addr(bus->number, devfn, where & ~3));
+	data = *cfgaddr;
+	return cpu_to_le32(data);
+}
+
+static inline void pci_cfg_write_32bit(struct pci_bus *bus, unsigned int devfn,
+	int where, u32 data)
+{
+	u32 *cfgaddr;
+
+	cfgaddr = (u32 *)(pci_config_base +
+			pci_cfg_addr(bus->number, devfn, where & ~3));
+	*cfgaddr = cpu_to_le32(data);
+}
+
+static int nlm_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+	int where, int size, u32 *val)
+{
+	u32 data;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	data = pci_cfg_read_32bit(bus, devfn, where);
+
+	if (size == 1)
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (data >> ((where & 3) << 3)) & 0xffff;
+	else
+		*val = data;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+
+static int nlm_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+		int where, int size, u32 val)
+{
+	u32 data;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	data = pci_cfg_read_32bit(bus, devfn, where);
+
+	if (size == 1)
+		data = (data & ~(0xff << ((where & 3) << 3))) |
+			(val << ((where & 3) << 3));
+	else if (size == 2)
+		data = (data & ~(0xffff << ((where & 3) << 3))) |
+			(val << ((where & 3) << 3));
+	else
+		data = val;
+
+	pci_cfg_write_32bit(bus, devfn, where, data);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops nlm_pci_ops = {
+	.read  = nlm_pcibios_read,
+	.write = nlm_pcibios_write
+};
+
+static struct resource nlm_pci_mem_resource = {
+	.name           = "XLR PCI MEM",
+	.start          = 0xd0000000UL,	/* 256MB PCI mem @ 0xd000_0000 */
+	.end            = 0xdfffffffUL,
+	.flags          = IORESOURCE_MEM,
+};
+
+static struct resource nlm_pci_io_resource = {
+	.name           = "XLR IO MEM",
+	.start          = 0x10000000UL,	/* 16MB PCI IO @ 0x1000_0000 */
+	.end            = 0x100fffffUL,
+	.flags          = IORESOURCE_IO,
+};
+
+struct pci_controller nlm_pci_controller = {
+	.index          = 0,
+	.pci_ops        = &nlm_pci_ops,
+	.mem_resource   = &nlm_pci_mem_resource,
+	.mem_offset     = 0x00000000UL,
+	.io_resource    = &nlm_pci_io_resource,
+	.io_offset      = 0x00000000UL,
+};
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	if (!nlm_chip_is_xls())
+		return	PIC_PCIX_IRQ;	/* for XLR just one IRQ*/
+
+	/*
+	 * For XLS PCIe, there is an IRQ per Link, find out which
+	 * link the device is on to assign interrupts
+	*/
+	if (dev->bus->self == NULL)
+		return 0;
+
+	switch	(dev->bus->self->devfn) {
+	case 0x0:
+		return PIC_PCIE_LINK0_IRQ;
+	case 0x8:
+		return PIC_PCIE_LINK1_IRQ;
+	case 0x10:
+		if (nlm_chip_is_xls_b())
+			return PIC_PCIE_XLSB0_LINK2_IRQ;
+		else
+			return PIC_PCIE_LINK2_IRQ;
+	case 0x18:
+		if (nlm_chip_is_xls_b())
+			return PIC_PCIE_XLSB0_LINK3_IRQ;
+		else
+			return PIC_PCIE_LINK3_IRQ;
+	}
+	WARN(1, "Unexpected devfn %d\n", dev->bus->self->devfn);
+	return 0;
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static int __init pcibios_init(void)
+{
+	/* PSB assigns PCI resources */
+	pci_probe_only = 1;
+	pci_config_base = ioremap(DEFAULT_PCI_CONFIG_BASE, 16 << 20);
+
+	/* Extend IO port for memory mapped io */
+	ioport_resource.start =  0;
+	ioport_resource.end   = ~0;
+
+	set_io_port_base(CKSEG1);
+	nlm_pci_controller.io_map_base = CKSEG1;
+
+	pr_info("Registering XLR/XLS PCIX/PCIE Controller.\n");
+	register_pci_controller(&nlm_pci_controller);
+
+	return 0;
+}
+
+arch_initcall(pcibios_init);
+
+struct pci_fixup pcibios_fixups[] = {
+	{0}
+};
-- 
1.7.1


-- 
Jayachandran C.
jayachandranc@netlogicmicro.com                  (Netlogic Microsystems)
