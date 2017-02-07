Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:18:19 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:34060 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992255AbdBGGORnCqnr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2017 07:14:17 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 7F4093416A9;
        Tue,  7 Feb 2017 06:14:10 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>,
        Stanislaw Skowronek <skylark@unaligned.org>,
        Johannes Dickgreber <tanzy@gmx.de>
Subject: [PATCH 10/12] MIPS: BRIDGE: Overhaul pci-bridge.c driver
Date:   Tue,  7 Feb 2017 01:13:54 -0500
Message-Id: <20170207061356.8270-11-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Rewrite the BRIDGE code in pci-bridge.c to address a number of issues:
 - Partially re-write to support platform_driver in the future
 - Use the new access structs from the bridge.h overhaul
 - Handle several BRIDGE WARs found in old IA64 code from 2.4/2.5
 - Document what the driver is doing during probe
 - Update copyrights

A lot of the changes are built up over the years from the IP30 patch
series as well as other contributions, along with work done on the
IP27 code that will be part of a forth-coming patch series.

There are several temporary pieces of code left that are needed by the
current IP27 code to boot correctly under these changes.  They will
be removed in the future with the IP27 "mega update" patch series and
this driver will become a full platform_driver module.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Cc: Stanislaw Skowronek <skylark@unaligned.org>
Cc: Johannes Dickgreber <tanzy@gmx.de>
---
 arch/mips/pci/pci-bridge.c | 307 +++++++++++++++++++++--------------
 1 file changed, 186 insertions(+), 121 deletions(-)

diff --git a/arch/mips/pci/pci-bridge.c b/arch/mips/pci/pci-bridge.c
index 0f09eafa5e3a..28b0eb5b844e 100644
--- a/arch/mips/pci/pci-bridge.c
+++ b/arch/mips/pci/pci-bridge.c
@@ -3,162 +3,236 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2003 Christoph Hellwig (hch@lst.de)
- * Copyright (C) 1999, 2000, 04 Ralf Baechle (ralf@linux-mips.org)
- * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * arch/mips/pci/pci-bridge.c
+ * platform_driver for SGI BRIDGE/XBRIDGE (and in the future, SGI PIC) ASICs.
+ *
+ * Originally called pci-ip27.c, which is:
+ *   Copyright (C) 2003 Christoph Hellwig (hch@lst.de)
+ *   Copyright (C) 1999, 2000, 04 Ralf Baechle (ralf@linux-mips.org)
+ *   Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ *
+ * Modifications sourced from pci-ip30.c in the IP30 patchset are:
+ *   Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@unaligned.org>
+ *   Copyright (C) 2009 Johannes Dickgreber <tanzy@gmx.de>
+ *   Copyright (C) 2016 Joshua Kinard <kumba@gentoo.org>
+ *
+ * Functions/info/insight sourced from old IA64 code are:
+ *   Copyright (C) 1992 - 1997, 2000-2002 Silicon Graphics, Inc.
+ *                 All rights reserved.
  */
+
 #include <linux/kernel.h>
-#include <linux/export.h>
 #include <linux/pci.h>
-#include <linux/smp.h>
-#include <asm/sn/arch.h>
-#include <asm/pci/bridge.h>
+#include <linux/platform_device.h>
+
 #include <asm/paccess.h>
-#include <asm/sn/intr.h>
-#include <asm/sn/sn0/hub.h>
+#include <asm/pci/bridge.h>
+#include <asm/xtalk/xtalk.h>
 
-/*
- * Max #PCI busses we can handle; ie, max #PCI bridges.
- */
-#define MAX_PCI_BUSSES		40
+#if defined(CONFIG_SGI_IP27)
+#include <asm/mach-ip27/pcibr.h>
+#else
+#error "Unknown CONFIG_SGI_IP??"
+#endif
 
-/*
- * Max #PCI devices (like scsi controllers) we handle on a bus.
- */
-#define MAX_DEVICES_PER_PCIBUS	8
+/* Increments for each additional bridge. */
+static int num_bridges;
 
+
+/* XXX: Temporary until the IP27 "mega update". */
 /*
  * XXX: No kmalloc available when we do our crosstalk scan,
- *	we should try to move it later in the boot process.
+ *     we should try to move it later in the boot process.
  */
-static struct bridge_controller bridges[MAX_PCI_BUSSES];
+static struct bridge_controller bridges[PCIBR_MAX_NUM_PCIBUS];
 
-/*
- * Translate from irq to software PCI bus number and PCI slot.
+/**
+ * bridge_probe - probes a BRIDGE chip and configures it.
+ * @nasid: NUMA Address Space Identifier.
+ * @widget_id: s8 value of this BRIDGE's xtalk widget ID.
+ * @masterwid: widget ID of HUB.
+ *
+ * Always returns '0'.
  */
-struct bridge_controller *irq_to_bridge[MAX_PCI_BUSSES * MAX_DEVICES_PER_PCIBUS];
-int irq_to_slot[MAX_PCI_BUSSES * MAX_DEVICES_PER_PCIBUS];
-
-extern struct pci_ops bridge_pci_ops;
-
-int bridge_probe(nasid_t nasid, int widget_id, int masterwid)
+int
+bridge_probe(nasid_t nasid, int widget_id, int masterwid)
 {
+	u32 slot, reg;
+	u32 wid_ctrl; /* BRIDGE WAR */
 	unsigned long offset = NODE_OFFSET(nasid);
 	struct bridge_controller *bc;
-	static int num_bridges = 0;
-	bridge_t *bridge;
-	int slot;
-
-	pci_set_flags(PCI_PROBE_ONLY);
 
-	printk("a bridge\n");
-
-	/* XXX: kludge alert.. */
+	/* XXX: Temporary until the IP27 "mega update". */
+	bc = &bridges[num_bridges];
 	if (!num_bridges)
 		ioport_resource.end = ~0UL;
 
-	bc = &bridges[num_bridges];
-
-	bc->pc.pci_ops		= &bridge_pci_ops;
-	bc->pc.mem_resource	= &bc->mem;
-	bc->pc.io_resource	= &bc->io;
-
-	bc->pc.index		= num_bridges;
+	/* Set bridge_controller parameters. */
+	bc->pc.pci_ops = &bridge_pci_ops;
+	bc->pc.mem_resource = &bc->mem;
+	bc->pc.mem_offset = offset;
+	bc->pc.io_resource = &bc->io;
+	bc->pc.io_offset = offset;
+	bc->pc.busn_resource = &bc->busn;
+	bc->pc.busn_offset = offset;
+	bc->pc.index = num_bridges;
+	bc->pc.io_map_base = NODE_SWIN_BASE(nasid, widget_id);
+
+	bc->mem.name = "Bridge MEM";
+	bc->mem.start = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_MEM);
+	bc->mem.end = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_IO - 1);
+	bc->mem.flags = IORESOURCE_MEM;
+
+	bc->io.name = "Bridge IO";
+	bc->io.start = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_IO);
+	bc->io.end = (NODE_SWIN_BASE(nasid, widget_id) + PCIBR_OFFSET_END - 1);
+	bc->io.flags = IORESOURCE_IO;
+
+	bc->busn.name = "Bridge BUSN";
+	bc->busn.start = num_bridges;
+	bc->busn.end = 255;
+	bc->busn.flags = IORESOURCE_BUS;
 
-	bc->mem.name		= "Bridge PCI MEM";
-	bc->pc.mem_offset	= offset;
-	bc->mem.start		= 0;
-	bc->mem.end		= ~0UL;
-	bc->mem.flags		= IORESOURCE_MEM;
-
-	bc->io.name		= "Bridge IO MEM";
-	bc->pc.io_offset	= offset;
-	bc->io.start		= 0UL;
-	bc->io.end		= ~0UL;
-	bc->io.flags		= IORESOURCE_IO;
-
-	bc->irq_cpu = smp_processor_id();
 	bc->widget_id = widget_id;
 	bc->nasid = nasid;
+	bc->baddr = ((u64)masterwid << PCI64_ATTR_TARG_SHFT);
+
+	/* XXX: Kill */
+	bc->irq_cpu = smp_processor_id();
 
-	bc->baddr = (u64)masterwid << 60 | PCI64_ATTR_BAR;
+	/*
+	 * Point to this bridge
+	 */
+	bc->bridge = (struct bridge_widget __iomem *)
+		RAW_NODE_SWIN_BASE(nasid, widget_id);
 
 	/*
-	 * point to this bridge
+	 * On BRIDGEs prior to Rev D, set the PCI_RETRY_CNT to zero to avoid
+	 * dropping stores (WAR #475347).
+	 * Sourced from Linux-2.5.70/arch/ia64/sn/io/sn1/pcibr.c
 	 */
-	bridge = (bridge_t *) RAW_NODE_SWIN_BASE(nasid, widget_id);
+	if (XWIDGET_REV_NUM(bridge_read_reg(bc, b_wid_id)) < BRIDGE_REV_D) {
+		reg = bridge_read_reg(bc, b_pci_bus_timo);
+		bridge_write_reg((reg & ~(BRIDGE_BUS_PCI_RETRY_MASK)), bc,
+				 b_pci_bus_timo);
+	}
 
 	/*
 	 * Clear all pending interrupts.
 	 */
-	bridge->b_int_rst_stat = BRIDGE_IRR_ALL_CLR;
+	bridge_write_reg(BRIDGE_IRR_ALL_CLR, bc, b_int_reset_stat);
 
 	/*
 	 * Until otherwise set up, assume all interrupts are from slot 0
 	 */
-	bridge->b_int_device = 0x0;
+	bridge_write_reg(0, bc, b_int_device);
+
+	/* Configure BRIDGE widget control ... */
+	wid_ctrl = bridge_read_reg(bc, b_wid_ctrl);
 
 	/*
-	 * swap pio's to pci mem and io space (big windows)
+	 * IP27 & IP35 need I/O and Mem swapping enabled.
+	 * IP30 needs it disabled.
 	 */
-	bridge->b_wid_control |= BRIDGE_CTRL_IO_SWAP |
-				 BRIDGE_CTRL_MEM_SWAP;
+	wid_ctrl |= (BRIDGE_CTRL_IO_SWAP | BRIDGE_CTRL_MEM_SWAP);
+
+	/* Set the BRIDGE PAGE_SIZE */
 #ifdef CONFIG_PAGE_SIZE_4KB
-	bridge->b_wid_control &= ~BRIDGE_CTRL_PAGE_SIZE;
+	wid_ctrl &= ~BRIDGE_CTRL_PAGE_SIZE;
 #else /* 16kB or larger */
-	bridge->b_wid_control |= BRIDGE_CTRL_PAGE_SIZE;
+	wid_ctrl |= BRIDGE_CTRL_PAGE_SIZE;
 #endif
 
 	/*
-	 * Hmm...  IRIX sets additional bits in the address which
-	 * are documented as reserved in the bridge docs.
+	 * Another BRIDGE WAR, read the BRIDGE widget control register
+	 * back after writing it to avoid an invalid address bug.
+	 */
+	bridge_write_reg(wid_ctrl, bc, b_wid_ctrl);
+	wid_ctrl = bridge_read_reg(bc, b_wid_ctrl);
+
+	/*
+	 * Set per-device properties.
+	 *
+	 * XXX: Setup per-slot configuration at some point.  Different devices
+	 * need different properties.
 	 */
-	bridge->b_wid_int_upper = 0x8000 | (masterwid << 16);
-	bridge->b_wid_int_lower = 0x01800090;	/* PI_INT_PEND_MOD off*/
-	bridge->b_dir_map = (masterwid << 20);	/* DMA */
-	bridge->b_int_enable = 0;
+	for (slot = 0; slot < BRIDGE_MAX_DEVS; slot++) {
+		reg = bridge_read_reg(bc, b_device(slot));
+		reg &= ~BRIDGE_DEV_PAGE_CHK_DIS;
+		reg |= (BRIDGE_DEV_ERR_LOCK_EN | BRIDGE_DEV_D64_BITS);
 
-	for (slot = 0; slot < 8; slot ++) {
-		bridge->b_device[slot].reg |= BRIDGE_DEV_SWAP_DIR;
+		bridge_write_reg(reg, bc, b_device(slot));
 		bc->pci_int[slot] = -1;
 	}
-	bridge->b_wid_tflush;	  /* wait until Bridge PIO complete */
 
-	bc->base = bridge;
-
-	register_pci_controller(&bc->pc);
+	/* Configure direct-mapped DMA */
+	reg = (masterwid << BRIDGE_DIRMAP_W_ID_SHFT);
+	bridge_write_reg(reg, bc, b_dir_map);
 
+	/*
+	 * Route all PCI bridge interrupts to the appropriate ASIC responsible
+	 * for handling IRQs (HUB in IP27, HEART in IP30, BEDROCK in IP35).
+	 * The actual IRQ support and masking is done elsewhere.
+	 */
+	/*
+	 * XXX: IRIX sets additional bits (0x8000) in the address which are
+	 * marked as reserved in the BRIDGE docs.
+	 */
+	bridge_write_reg(((masterwid << WIDGET_TARGET_ID_SHFT) | 0x8000), bc,
+			 b_wid_int_upper);
+	bridge_write_reg(PCIBR_XIO_SEES_HUB, bc, b_wid_int_lower);
+	bridge_write_reg(BRIDGE_COSMIC_INT_DEV, bc, b_int_device);
+	bridge_write_reg(0, bc, b_int_mode);
+	reg = bridge_read_reg(bc, b_int_enable);
+	bridge_write_reg((reg | BRIDGE_ISR_ERRORS), bc, b_int_enable);
+
+	/* Wait until Bridge PIO completes. */
+	BRIDGE_FLUSH(bc);
+
+	/* Increment number of discovered BRIDGE/XBRIDGE widgets. */
 	num_bridges++;
 
+	register_pci_controller(&bc->pc);
+
 	return 0;
 }
 
+/**
+ * bridge_alloc_irq - allocate the next available IRQ for a BRIDGE slot.
+ * @dev: pointer to struct pci_dev of PCI device info.
+ *
+ * Casts dev->bus->sysdata to struct bridge_controller and returns the
+ * outcome of the platform_data-defined 'alloc_irq' function.
+ */
+inline int
+bridge_alloc_irq(struct pci_dev *dev)
+{
+	const struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
+
+	if (bc->alloc_irq)
+		return bc->alloc_irq(dev);
+
+	return -1;
+}
+
 /*
  * All observed requests have pin == 1. We could have a global here, that
  * gets incremented and returned every time - unfortunately, pci_map_irq
  * may be called on the same device over and over, and need to return the
  * same value. On O2000, pin can be 0 or 1, and PCI slots can be [0..7].
  *
- * A given PCI device, in general, should be able to intr any of the cpus
- * on any one of the hubs connected to its xbow.
+ * A given PCI device, in general, should be able to interrupt any of the
+ * cpus on any one of the HUBs or HEART connected to its xbow.
  */
-int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+int __init
+pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	return 0;
 }
 
-static inline struct pci_dev *bridge_root_dev(struct pci_dev *dev)
-{
-	while (dev->bus->parent) {
-		/* Move up the chain of bridges. */
-		dev = dev->bus->self;
-	}
-
-	return dev;
-}
-
 /* Do platform specific device initialization at pci_enable_device() time */
-int pcibios_plat_dev_init(struct pci_dev *dev)
+int
+pcibios_plat_dev_init(struct pci_dev *dev)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
 	struct pci_dev *rdev = bridge_root_dev(dev);
@@ -182,42 +256,35 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
 	return 0;
 }
 
-/*
- * Device might live on a subordinate PCI bus.	XXX Walk up the chain of buses
- * to find the slot number in sense of the bridge device register.
- * XXX This also means multiple devices might rely on conflicting bridge
- * settings.
- */
-
-static inline void pci_disable_swapping(struct pci_dev *dev)
+static void
+bridge_disable_swapping_dma(struct pci_dev *dev)
 {
-	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
-	bridge_t *bridge = bc->base;
+	u32 reg;
 	int slot = PCI_SLOT(dev->devfn);
-
-	/* Turn off byte swapping */
-	bridge->b_device[slot].reg &= ~BRIDGE_DEV_SWAP_DIR;
-	bridge->b_widget.w_tflush;	/* Flush */
-}
-
-static inline void pci_enable_swapping(struct pci_dev *dev)
-{
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
-	bridge_t *bridge = bc->base;
-	int slot = PCI_SLOT(dev->devfn);
 
-	/* Turn on byte swapping */
-	bridge->b_device[slot].reg |= BRIDGE_DEV_SWAP_DIR;
-	bridge->b_widget.w_tflush;	/* Flush */
+	/* Turn off byte swapping */
+	reg = bridge_read_reg(bc, b_device(slot));
+	reg &= ~(BRIDGE_DEV_DEV_SWAP | BRIDGE_DEV_SWAP_PMU |
+		 BRIDGE_DEV_SWAP_DIR);
+	bridge_write_reg(reg, bc, b_device(slot));
+	BRIDGE_FLUSH(bc);
 }
 
-static void pci_fixup_ioc3(struct pci_dev *d)
-{
-	pci_disable_swapping(d);
-}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
+			bridge_disable_swapping_dma);
 
+/* XXX: Temporarily defined here until the IP27 "mega update". */
 #ifdef CONFIG_NUMA
-int pcibus_to_node(struct pci_bus *bus)
+/**
+ * pcibus_to_node - fetch the nasid that the passed struct pci_bus lives on.
+ * @bus: struct pci_bus pointer for a given PCI bus.
+ *
+ * casts bus->sysdata to struct bridge_controller and returns the nasid
+ * member that references the specific node this PCI bus lives on.
+ */
+int
+pcibus_to_node(struct pci_bus *bus)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
 
@@ -226,5 +293,3 @@ int pcibus_to_node(struct pci_bus *bus)
 EXPORT_SYMBOL(pcibus_to_node);
 #endif /* CONFIG_NUMA */
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
-	pci_fixup_ioc3);
-- 
2.11.1
