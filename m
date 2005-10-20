Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 08:03:57 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:47629 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133380AbVJTG7D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:59:03 +0100
Received: from 10.10.64.121 by mms1.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:58:51 -0700
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:58:49 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW11090; Wed, 19 Oct 2005 23:58:50 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28375 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:58:49
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6wnov008736 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:58:49 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6wnN24022 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:58:49 -0700
Date:	Wed, 19 Oct 2005 23:58:49 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 10/12] 1480-pci-support
Message-ID: <20051020065849.GJ23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F499FA10684624714-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

PCI support code for bcm1480 on-chip PCI-X bridge

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 arch/mips/pci/Makefile      |    1 
 arch/mips/pci/pci-bcm1480.c |  256 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+)

Index: lmo/arch/mips/pci/Makefile
===================================================================
--- lmo.orig/arch/mips/pci/Makefile	2005-10-19 22:34:07.000000000 -0700
+++ lmo/arch/mips/pci/Makefile	2005-10-19 22:34:13.000000000 -0700
@@ -46,6 +46,7 @@
 obj-$(CONFIG_SGI_IP27)		+= pci-ip27.o
 obj-$(CONFIG_SGI_IP32)		+= fixup-ip32.o ops-mace.o pci-ip32.o
 obj-$(CONFIG_SIBYTE_SB1250)	+= fixup-sb1250.o pci-sb1250.o
+obj-$(CONFIG_SIBYTE_BCM1x80)	+= pci-bcm1480.o
 obj-$(CONFIG_SNI_RM200_PCI)	+= fixup-sni.o ops-sni.o
 obj-$(CONFIG_TANBAC_TB0219)	+= fixup-tb0219.o
 obj-$(CONFIG_TANBAC_TB0226)	+= fixup-tb0226.o
Index: lmo/arch/mips/pci/pci-bcm1480.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lmo/arch/mips/pci/pci-bcm1480.c	2005-10-19 22:34:13.000000000 -0700
@@ -0,0 +1,256 @@
+/*
+ * Copyright (C) 2001,2002,2005 Broadcom Corporation
+ * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+/*
+ * BCM1x80/1x55-specific PCI support
+ *
+ * This module provides the glue between Linux's PCI subsystem
+ * and the hardware.  We basically provide glue for accessing
+ * configuration space, and set up the translation for I/O
+ * space accesses.
+ *
+ * To access configuration space, we use ioremap.  In the 32-bit
+ * kernel, this consumes either 4 or 8 page table pages, and 16MB of
+ * kernel mapped memory.  Hopefully neither of these should be a huge
+ * problem.
+ *
+ * XXX: AT THIS TIME, ONLY the NATIVE PCI-X INTERFACE IS SUPPORTED.
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/console.h>
+#include <linux/tty.h>
+
+#include <asm/sibyte/bcm1480_regs.h>
+#include <asm/sibyte/bcm1480_scd.h>
+#include <asm/sibyte/board.h>
+#include <asm/io.h>
+
+/*
+ * Macros for calculating offsets into config space given a device
+ * structure or dev/fun/reg
+ */
+#define CFGOFFSET(bus,devfn,where) (((bus)<<16)+((devfn)<<8)+(where))
+#define CFGADDR(bus,devfn,where)   CFGOFFSET((bus)->number,(devfn),where)
+
+static void *cfg_space;
+
+#define PCI_BUS_ENABLED	1
+#define LDT_BUS_ENABLED	2
+#define PCI_DEVICE_MODE	4
+
+static int bcm1480_bus_status = 0;
+
+#define PCI_BRIDGE_DEVICE  0
+#define LDT_BRIDGE_DEVICE  1
+
+/*
+ * Read/write 32-bit values in config space.
+ */
+static inline u32 READCFG32(u32 addr)
+{
+	return *(u32 *)(cfg_space + (addr&~3));
+}
+
+static inline void WRITECFG32(u32 addr, u32 data)
+{
+	*(u32 *)(cfg_space + (addr & ~3)) = data;
+}
+
+int pcibios_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return dev->irq;
+}
+
+/* Do platform specific device initialization at pci_enable_device() time */
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return 0;
+}
+
+/*
+ * Some checks before doing config cycles:
+ * In PCI Device Mode, hide everything on bus 0 except the LDT host
+ * bridge.  Otherwise, access is controlled by bridge MasterEn bits.
+ */
+static int bcm1480_pci_can_access(struct pci_bus *bus, int devfn)
+{
+	if (!(bcm1480_bus_status & (PCI_BUS_ENABLED | PCI_DEVICE_MODE)))
+		return 0;
+
+	if (bus->number == 0) {
+ 		if (bcm1480_bus_status & PCI_DEVICE_MODE)
+			return 0;
+		else
+			return 1;
+	} else
+		return 1;
+}
+
+/*
+ * Read/write access functions for various sizes of values
+ * in config space.  Return all 1's for disallowed accesses
+ * for a kludgy but adequate simulation of master aborts.
+ */
+
+static int bcm1480_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 * val)
+{
+	u32 data = 0;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (bcm1480_pci_can_access(bus, devfn))
+		data = READCFG32(CFGADDR(bus, devfn, where));
+	else
+		data = 0xFFFFFFFF;
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
+static int bcm1480_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 val)
+{
+	u32 cfgaddr = CFGADDR(bus, devfn, where);
+	u32 data = 0;
+
+	if ((size == 2) && (where & 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (where & 3))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (!bcm1480_pci_can_access(bus, devfn))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	data = READCFG32(cfgaddr);
+
+	if (size == 1)
+		data = (data & ~(0xff << ((where & 3) << 3))) |
+		    (val << ((where & 3) << 3));
+	else if (size == 2)
+		data = (data & ~(0xffff << ((where & 3) << 3))) |
+		    (val << ((where & 3) << 3));
+	else
+		data = val;
+
+	WRITECFG32(cfgaddr, data);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+struct pci_ops bcm1480_pci_ops = {
+	bcm1480_pcibios_read,
+	bcm1480_pcibios_write,
+};
+
+static struct resource bcm1480_mem_resource = {
+	.name	= "BCM1480 PCI MEM",
+	.start	= 0x40000000UL,
+	.end	= 0x5fffffffUL,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct resource bcm1480_io_resource = {
+	.name	= "BCM1480 PCI I/O",
+	.start	= 0x00000000UL,
+	.end	= 0x01ffffffUL,
+	.flags	= IORESOURCE_IO,
+};
+
+struct pci_controller bcm1480_controller = {
+	.pci_ops	= &bcm1480_pci_ops,
+	.mem_resource	= &bcm1480_mem_resource,
+	.io_resource	= &bcm1480_io_resource,
+};
+
+
+static int __init bcm1480_pcibios_init(void)
+{
+	uint32_t cmdreg;
+	uint64_t reg;
+	extern int pci_probe_only;
+
+	/* CFE will assign PCI resources */
+	pci_probe_only = 1;
+
+	/* Avoid ISA compat ranges.  */
+	PCIBIOS_MIN_IO = 0x00008000UL;
+	PCIBIOS_MIN_MEM = 0x01000000UL;
+
+	/* Set I/O resource limits.  */
+	ioport_resource.end = 0x01ffffffUL;	/* 32MB accessible by bcm1480 */
+	iomem_resource.end = 0xffffffffUL;	/* no HT support yet */
+
+	cfg_space = ioremap(A_BCM1480_PHYS_PCI_CFG_MATCH_BITS, 16*1024*1024);
+
+	/*
+	 * See if the PCI bus has been configured by the firmware.
+	 */
+	reg = *((volatile uint64_t *) IOADDR(A_SCD_SYSTEM_CFG));
+	if (!(reg & M_BCM1480_SYS_PCI_HOST)) {
+		bcm1480_bus_status |= PCI_DEVICE_MODE;
+	} else {
+		cmdreg = READCFG32(CFGOFFSET(0, PCI_DEVFN(PCI_BRIDGE_DEVICE, 0),
+					     PCI_COMMAND));
+		if (!(cmdreg & PCI_COMMAND_MASTER)) {
+			printk
+			    ("PCI: Skipping PCI probe.  Bus is not initialized.\n");
+			iounmap(cfg_space);
+			return 1; /* XXX */
+		}
+		bcm1480_bus_status |= PCI_BUS_ENABLED;
+	}
+
+	/*
+	 * Establish mappings in KSEG2 (kernel virtual) to PCI I/O
+	 * space.  Use "match bytes" policy to make everything look
+	 * little-endian.  So, you need to also set
+	 * CONFIG_SWAP_IO_SPACE, but this is the combination that
+	 * works correctly with most of Linux's drivers.
+	 * XXX ehs: Should this happen in PCI Device mode?
+	 */
+
+	set_io_port_base((unsigned long)
+		ioremap(A_BCM1480_PHYS_PCI_IO_MATCH_BYTES, 65536));
+	isa_slot_offset = (unsigned long)
+		ioremap(A_BCM1480_PHYS_PCI_MEM_MATCH_BYTES, 1024*1024);
+
+	register_pci_controller(&bcm1480_controller);
+
+#ifdef CONFIG_VGA_CONSOLE
+	take_over_console(&vga_con,0,MAX_NR_CONSOLES-1,1);
+#endif
+	return 0;
+}
+
+arch_initcall(bcm1480_pcibios_init);
