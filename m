Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 09:16:29 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1278 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901169Ab2D3HQX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 09:16:23 +0200
Received: from [10.9.200.133] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 30 Apr 2012 00:16:11 -0700
X-Server-Uuid: B730DE51-FC43-4C83-941F-F1F78A914BDD
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 30 Apr 2012 00:15:25 -0700
Received: from hqcas01.netlogicmicro.com (unknown [10.65.50.14]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id A3BEC9F9F5; Mon, 30
 Apr 2012 00:16:03 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas01.netlogicmicro.com (10.65.50.14) with Microsoft SMTP Server id
 14.1.339.1; Mon, 30 Apr 2012 00:16:02 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@netlogicmicro.com>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 11/12 UPDATED] MIPS: Netlogic: XLP PCIe controller
 support.
Date:   Mon, 30 Apr 2012 12:45:46 +0530
Message-ID: <1335770147-2139-1-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1335618738-4679-12-git-send-email-jayachandranc@netlogicmicro.com>
References: <1335618738-4679-12-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 6380E3B13E025211995-02-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Ganesan Ramalingam <ganesanr@netlogicmicro.com>

Adds support for the XLP on-chip PCIe controller. On XLP, the
on-chip devices(including the 4 PCIe links) appear in the PCIe
configuration space of the XLP as PCI devices.

The changes are to initialize and register the PCIe controller,
enable hardware byte swap in the PCIe IO and MEM space, and to
enable PCIe interrupts.

Signed-off-by: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
[ The patch has been updated to call pci_set_flags(PCI_PROBE_ONLY)
instead of using global pci_probe_only. Needed after commit 2909060]

 arch/mips/Kconfig                               |    1 -
 arch/mips/include/asm/netlogic/xlp-hal/iomap.h  |    3 +
 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h |   76 +++++++
 arch/mips/include/asm/netlogic/xlp-hal/xlp.h    |    8 +-
 arch/mips/netlogic/xlp/nlm_hal.c                |   16 ++
 arch/mips/pci/Makefile                          |    1 +
 arch/mips/pci/pci-xlp.c                         |  247 +++++++++++++++++++++++
 7 files changed, 349 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
 create mode 100644 arch/mips/pci/pci-xlp.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3811dd..db465fb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -794,7 +794,6 @@ config NLM_XLP_BOARD
 	select SYS_HAS_CPU_XLP
 	select SYS_SUPPORTS_SMP
 	select HW_HAS_PCI
-	select SWAP_IO_SPACE
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select 64BIT_PHYS_ADDR
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
index 86cc339..ece86f1 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/iomap.h
@@ -36,6 +36,9 @@
 #define __NLM_HAL_IOMAP_H__
 
 #define XLP_DEFAULT_IO_BASE             0x18000000
+#define XLP_DEFAULT_PCI_ECFG_BASE	XLP_DEFAULT_IO_BASE
+#define XLP_DEFAULT_PCI_CFG_BASE	0x1c000000
+
 #define NMI_BASE			0xbfc00000
 #define	XLP_IO_CLK			133333333
 
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h b/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
new file mode 100644
index 0000000..66c323d
--- /dev/null
+++ b/arch/mips/include/asm/netlogic/xlp-hal/pcibus.h
@@ -0,0 +1,76 @@
+/*
+ * Copyright (c) 2003-2012 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
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
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+ * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
+ * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __NLM_HAL_PCIBUS_H__
+#define	__NLM_HAL_PCIBUS_H__
+
+/* PCIE Memory and IO regions */
+#define	PCIE_MEM_BASE			0xd0000000ULL
+#define	PCIE_MEM_LIMIT			0xdfffffffULL
+#define	PCIE_IO_BASE			0x14000000ULL
+#define	PCIE_IO_LIMIT			0x15ffffffULL
+
+#define	PCIE_BRIDGE_CMD			0x1
+#define	PCIE_BRIDGE_MSI_CAP		0x14
+#define	PCIE_BRIDGE_MSI_ADDRL		0x15
+#define	PCIE_BRIDGE_MSI_ADDRH		0x16
+#define	PCIE_BRIDGE_MSI_DATA		0x17
+
+/* XLP Global PCIE configuration space registers */
+#define	PCIE_BYTE_SWAP_MEM_BASE		0x247
+#define	PCIE_BYTE_SWAP_MEM_LIM		0x248
+#define	PCIE_BYTE_SWAP_IO_BASE		0x249
+#define	PCIE_BYTE_SWAP_IO_LIM		0x24A
+#define	PCIE_MSI_STATUS			0x25A
+#define	PCIE_MSI_EN			0x25B
+#define	PCIE_INT_EN0			0x261
+
+/* PCIE_MSI_EN */
+#define	PCIE_MSI_VECTOR_INT_EN		0xFFFFFFFF
+
+/* PCIE_INT_EN0 */
+#define	PCIE_MSI_INT_EN			(1 << 9)
+
+#ifndef __ASSEMBLY__
+
+#define	nlm_read_pcie_reg(b, r)		nlm_read_reg(b, r)
+#define	nlm_write_pcie_reg(b, r, v)	nlm_write_reg(b, r, v)
+#define	nlm_get_pcie_base(node, inst)	\
+			nlm_pcicfg_base(XLP_IO_PCIE_OFFSET(node, inst))
+#define	nlm_get_pcie_regbase(node, inst)	\
+			(nlm_get_pcie_base(node, inst) + XLP_IO_PCI_HDRSZ)
+
+int xlp_pcie_link_irt(int link);
+#endif
+#endif /* __NLM_HAL_PCIBUS_H__ */
diff --git a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
index 1540588..dc6e98e 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/xlp.h
@@ -35,8 +35,12 @@
 #ifndef _NLM_HAL_XLP_H
 #define _NLM_HAL_XLP_H
 
-#define PIC_UART_0_IRQ           17
-#define PIC_UART_1_IRQ           18
+#define PIC_UART_0_IRQ			17
+#define PIC_UART_1_IRQ			18
+#define PIC_PCIE_LINK_0_IRQ		19
+#define PIC_PCIE_LINK_1_IRQ		20
+#define PIC_PCIE_LINK_2_IRQ		21
+#define PIC_PCIE_LINK_3_IRQ		22
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index 9428e71..3a4a172 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -69,6 +69,14 @@ int nlm_irq_to_irt(int irq)
 		return PIC_IRT_UART_0_INDEX;
 	case PIC_UART_1_IRQ:
 		return PIC_IRT_UART_1_INDEX;
+	case PIC_PCIE_LINK_0_IRQ:
+	       return PIC_IRT_PCIE_LINK_0_INDEX;
+	case PIC_PCIE_LINK_1_IRQ:
+	       return PIC_IRT_PCIE_LINK_1_INDEX;
+	case PIC_PCIE_LINK_2_IRQ:
+	       return PIC_IRT_PCIE_LINK_2_INDEX;
+	case PIC_PCIE_LINK_3_IRQ:
+	       return PIC_IRT_PCIE_LINK_3_INDEX;
 	default:
 		return -1;
 	}
@@ -81,6 +89,14 @@ int nlm_irt_to_irq(int irt)
 		return PIC_UART_0_IRQ;
 	case PIC_IRT_UART_1_INDEX:
 		return PIC_UART_1_IRQ;
+	case PIC_IRT_PCIE_LINK_0_INDEX:
+	       return PIC_PCIE_LINK_0_IRQ;
+	case PIC_IRT_PCIE_LINK_1_INDEX:
+	       return PIC_PCIE_LINK_1_IRQ;
+	case PIC_IRT_PCIE_LINK_2_INDEX:
+	       return PIC_PCIE_LINK_2_IRQ;
+	case PIC_IRT_PCIE_LINK_3_INDEX:
+	       return PIC_PCIE_LINK_3_IRQ;
 	default:
 		return -1;
 	}
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index c3ac4b0..44cdf55 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_WR_PPMC)		+= fixup-wrppmc.o
 obj-$(CONFIG_MIKROTIK_RB532)	+= pci-rc32434.o ops-rc32434.o fixup-rc32434.o
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= pci-octeon.o pcie-octeon.o
 obj-$(CONFIG_CPU_XLR)		+= pci-xlr.o
+obj-$(CONFIG_CPU_XLP)		+= pci-xlp.o
 
 ifdef CONFIG_PCI_MSI
 obj-$(CONFIG_CPU_CAVIUM_OCTEON)	+= msi-octeon.o
diff --git a/arch/mips/pci/pci-xlp.c b/arch/mips/pci/pci-xlp.c
new file mode 100644
index 0000000..3e177e9
--- /dev/null
+++ b/arch/mips/pci/pci-xlp.c
@@ -0,0 +1,247 @@
+/*
+ * Copyright (c) 2003-2012 Broadcom Corporation
+ * All Rights Reserved
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the Broadcom
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
+ * THIS SOFTWARE IS PROVIDED BY BROADCOM ``AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL BROADCOM OR CONTRIBUTORS BE LIABLE
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
+#include <linux/msi.h>
+#include <linux/mm.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/console.h>
+
+#include <asm/io.h>
+
+#include <asm/netlogic/interrupt.h>
+#include <asm/netlogic/haldefs.h>
+
+#include <asm/netlogic/xlp-hal/iomap.h>
+#include <asm/netlogic/xlp-hal/pic.h>
+#include <asm/netlogic/xlp-hal/xlp.h>
+#include <asm/netlogic/xlp-hal/pcibus.h>
+#include <asm/netlogic/xlp-hal/bridge.h>
+
+static void *pci_config_base;
+
+#define	pci_cfg_addr(bus, devfn, off) (((bus) << 20) | ((devfn) << 12) | (off))
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
+	return data;
+}
+
+static inline void pci_cfg_write_32bit(struct pci_bus *bus, unsigned int devfn,
+	int where, u32 data)
+{
+	u32 *cfgaddr;
+
+	cfgaddr = (u32 *)(pci_config_base +
+			pci_cfg_addr(bus->number, devfn, where & ~3));
+	*cfgaddr = data;
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
+	.name           = "XLP PCI MEM",
+	.start          = 0xd0000000UL,	/* 256MB PCI mem @ 0xd000_0000 */
+	.end            = 0xdfffffffUL,
+	.flags          = IORESOURCE_MEM,
+};
+
+static struct resource nlm_pci_io_resource = {
+	.name           = "XLP IO MEM",
+	.start          = 0x14000000UL,	/* 64MB PCI IO @ 0x1000_0000 */
+	.end            = 0x17ffffffUL,
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
+static int get_irq_vector(const struct pci_dev *dev)
+{
+	/*
+	 * For XLP PCIe, there is an IRQ per Link, find out which
+	 * link the device is on to assign interrupts
+	*/
+	if (dev->bus->self == NULL)
+		return 0;
+
+	switch	(dev->bus->self->devfn) {
+	case 0x8:
+		return PIC_PCIE_LINK_0_IRQ;
+	case 0x9:
+		return PIC_PCIE_LINK_1_IRQ;
+	case 0xa:
+		return PIC_PCIE_LINK_2_IRQ;
+	case 0xb:
+		return PIC_PCIE_LINK_3_IRQ;
+	}
+	WARN(1, "Unexpected devfn %d\n", dev->bus->self->devfn);
+	return 0;
+}
+
+int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return get_irq_vector(dev);
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static int xlp_enable_pci_bswap(void)
+{
+	uint64_t pciebase, sysbase;
+	int node, i;
+	u32 reg;
+
+	/* Chip-0 so node set to 0 */
+	node = 0;
+	sysbase = nlm_get_bridge_regbase(node);
+	/*
+	 *  Enable byte swap in hardware. Program each link's PCIe SWAP regions
+	 * from the link's address ranges.
+	 */
+	for (i = 0; i < 4; i++) {
+		pciebase = nlm_pcicfg_base(XLP_IO_PCIE_OFFSET(node, i));
+		if (nlm_read_pci_reg(pciebase, 0) == 0xffffffff)
+			continue;
+
+		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEMEM_BASE0 + i);
+		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_MEM_BASE, reg);
+
+		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEMEM_LIMIT0 + i);
+		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_MEM_LIM, reg);
+
+		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_BASE0 + i);
+		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_BASE, reg);
+
+		reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_LIMIT0 + i);
+		nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_LIM, reg);
+	}
+	return 0;
+}
+
+static int __init pcibios_init(void)
+{
+	/* Firmware assigns PCI resources */
+	pci_set_flags(PCI_PROBE_ONLY);
+	pci_config_base = ioremap(XLP_DEFAULT_PCI_ECFG_BASE, 64 << 20);
+
+	/* Extend IO port for memory mapped io */
+	ioport_resource.start =  0;
+	ioport_resource.end   = ~0;
+
+	xlp_enable_pci_bswap();
+	set_io_port_base(CKSEG1);
+	nlm_pci_controller.io_map_base = CKSEG1;
+
+	register_pci_controller(&nlm_pci_controller);
+	pr_info("XLP PCIe Controller %pR%pR.\n", &nlm_pci_io_resource,
+		&nlm_pci_mem_resource);
+
+	return 0;
+}
+arch_initcall(pcibios_init);
-- 
1.7.9.5
