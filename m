Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 01:22:19 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:59033 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491815Ab1GVXUl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 01:20:41 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id C4ADD8C9E;
        Sat, 23 Jul 2011 01:20:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gdUZl0JCVKif; Sat, 23 Jul 2011 01:20:34 +0200 (CEST)
Received: from localhost.localdomain (dyndsl-085-016-164-032.ewe-ip-backbone.de [85.16.164.32])
        by hauke-m.de (Postfix) with ESMTPSA id 21B1C8C93;
        Sat, 23 Jul 2011 01:20:28 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     jonas.gorski@gmail.com, ralf@linux-mips.org, zajec5@gmail.com,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/11] bcma: add SOC bus
Date:   Sat, 23 Jul 2011 01:20:08 +0200
Message-Id: <1311376815-15755-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1311376815-15755-1-git-send-email-hauke@hauke-m.de>
References: <1311376815-15755-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 30682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16556

This patch adds support for using bcma on a Broadcom SoC as the system
bus. An SoC like the bcm4716 could register this bus and use it to
searches for the bcma cores and register the devices on this bus.

BCMA_HOSTTYPE_NONE was intended for SoCs at first but BCMA_HOSTTYPE_SOC
is a better name.

Acked-by: Rafał Miłecki <zajec5@gmail.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/Kconfig          |    4 +
 drivers/bcma/Makefile         |    1 +
 drivers/bcma/core.c           |    2 +
 drivers/bcma/driver_pci.c     |    9 ++-
 drivers/bcma/host_soc.c       |  183 +++++++++++++++++++++++++++++++++++++++++
 drivers/bcma/main.c           |    9 ++-
 drivers/bcma/scan.c           |   42 ++++++++-
 include/linux/bcma/bcma.h     |    5 +-
 include/linux/bcma/bcma_soc.h |   16 ++++
 9 files changed, 263 insertions(+), 8 deletions(-)
 create mode 100644 drivers/bcma/host_soc.c
 create mode 100644 include/linux/bcma/bcma_soc.h

diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
index ae0a02e..4a062f8 100644
--- a/drivers/bcma/Kconfig
+++ b/drivers/bcma/Kconfig
@@ -33,6 +33,10 @@ config BCMA_DRIVER_PCI_HOSTMODE
 	help
 	  PCI core hostmode operation (external PCI bus).
 
+config BCMA_HOST_SOC
+	bool
+	depends on BCMA && MIPS
+
 config BCMA_DEBUG
 	bool "BCMA debugging"
 	depends on BCMA
diff --git a/drivers/bcma/Makefile b/drivers/bcma/Makefile
index a2161cc..8dc730d 100644
--- a/drivers/bcma/Makefile
+++ b/drivers/bcma/Makefile
@@ -3,6 +3,7 @@ bcma-y					+= driver_chipcommon.o driver_chipcommon_pmu.o
 bcma-y					+= driver_pci.o
 bcma-$(CONFIG_BCMA_DRIVER_PCI_HOSTMODE)	+= driver_pci_host.o
 bcma-$(CONFIG_BCMA_HOST_PCI)		+= host_pci.o
+bcma-$(CONFIG_BCMA_HOST_SOC)		+= host_soc.o
 obj-$(CONFIG_BCMA)			+= bcma.o
 
 ccflags-$(CONFIG_BCMA_DEBUG)		:= -DDEBUG
diff --git a/drivers/bcma/core.c b/drivers/bcma/core.c
index 4a04a49..189a97b 100644
--- a/drivers/bcma/core.c
+++ b/drivers/bcma/core.c
@@ -110,6 +110,8 @@ EXPORT_SYMBOL_GPL(bcma_core_pll_ctl);
 u32 bcma_core_dma_translation(struct bcma_device *core)
 {
 	switch (core->bus->hosttype) {
+	case BCMA_HOSTTYPE_SOC:
+		return 0;
 	case BCMA_HOSTTYPE_PCI:
 		if (bcma_aread32(core, BCMA_IOST) & BCMA_IOST_DMA64)
 			return BCMA_DMA_TRANSLATION_DMA64_CMT;
diff --git a/drivers/bcma/driver_pci.c b/drivers/bcma/driver_pci.c
index bdd3bc9..1902cdb 100644
--- a/drivers/bcma/driver_pci.c
+++ b/drivers/bcma/driver_pci.c
@@ -208,7 +208,14 @@ int bcma_core_pci_irq_ctl(struct bcma_drv_pci *pc, struct bcma_device *core,
 {
 	struct pci_dev *pdev = pc->core->bus->host_pci;
 	u32 coremask, tmp;
-	int err;
+	int err = 0;
+
+	if (core->bus->hosttype != BCMA_HOSTTYPE_PCI) {
+		/* This bcma device is not on a PCI host-bus. So the IRQs are
+		 * not routed through the PCI core.
+		 * So we must not enable routing through the PCI core. */
+		goto out;
+	}
 
 	err = pci_read_config_dword(pdev, BCMA_PCI_IRQMASK, &tmp);
 	if (err)
diff --git a/drivers/bcma/host_soc.c b/drivers/bcma/host_soc.c
new file mode 100644
index 0000000..3c381fb
--- /dev/null
+++ b/drivers/bcma/host_soc.c
@@ -0,0 +1,183 @@
+/*
+ * Broadcom specific AMBA
+ * System on Chip (SoC) Host
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+#include "bcma_private.h"
+#include "scan.h"
+#include <linux/bcma/bcma.h>
+#include <linux/bcma/bcma_soc.h>
+
+static u8 bcma_host_soc_read8(struct bcma_device *core, u16 offset)
+{
+	return readb(core->io_addr + offset);
+}
+
+static u16 bcma_host_soc_read16(struct bcma_device *core, u16 offset)
+{
+	return readw(core->io_addr + offset);
+}
+
+static u32 bcma_host_soc_read32(struct bcma_device *core, u16 offset)
+{
+	return readl(core->io_addr + offset);
+}
+
+static void bcma_host_soc_write8(struct bcma_device *core, u16 offset,
+				 u8 value)
+{
+	writeb(value, core->io_addr + offset);
+}
+
+static void bcma_host_soc_write16(struct bcma_device *core, u16 offset,
+				 u16 value)
+{
+	writew(value, core->io_addr + offset);
+}
+
+static void bcma_host_soc_write32(struct bcma_device *core, u16 offset,
+				 u32 value)
+{
+	writel(value, core->io_addr + offset);
+}
+
+#ifdef CONFIG_BCMA_BLOCKIO
+static void bcma_host_soc_block_read(struct bcma_device *core, void *buffer,
+				     size_t count, u16 offset, u8 reg_width)
+{
+	void __iomem *addr = core->io_addr + offset;
+
+	switch (reg_width) {
+	case sizeof(u8): {
+		u8 *buf = buffer;
+
+		while (count) {
+			*buf = __raw_readb(addr);
+			buf++;
+			count--;
+		}
+		break;
+	}
+	case sizeof(u16): {
+		__le16 *buf = buffer;
+
+		WARN_ON(count & 1);
+		while (count) {
+			*buf = (__force __le16)__raw_readw(addr);
+			buf++;
+			count -= 2;
+		}
+		break;
+	}
+	case sizeof(u32): {
+		__le32 *buf = buffer;
+
+		WARN_ON(count & 3);
+		while (count) {
+			*buf = (__force __le32)__raw_readl(addr);
+			buf++;
+			count -= 4;
+		}
+		break;
+	}
+	default:
+		WARN_ON(1);
+	}
+}
+
+static void bcma_host_soc_block_write(struct bcma_device *core,
+				      const void *buffer,
+				      size_t count, u16 offset, u8 reg_width)
+{
+	void __iomem *addr = core->io_addr + offset;
+
+	switch (reg_width) {
+	case sizeof(u8): {
+		const u8 *buf = buffer;
+
+		while (count) {
+			__raw_writeb(*buf, addr);
+			buf++;
+			count--;
+		}
+		break;
+	}
+	case sizeof(u16): {
+		const __le16 *buf = buffer;
+
+		WARN_ON(count & 1);
+		while (count) {
+			__raw_writew((__force u16)(*buf), addr);
+			buf++;
+			count -= 2;
+		}
+		break;
+	}
+	case sizeof(u32): {
+		const __le32 *buf = buffer;
+
+		WARN_ON(count & 3);
+		while (count) {
+			__raw_writel((__force u32)(*buf), addr);
+			buf++;
+			count -= 4;
+		}
+		break;
+	}
+	default:
+		WARN_ON(1);
+	}
+}
+#endif /* CONFIG_BCMA_BLOCKIO */
+
+static u32 bcma_host_soc_aread32(struct bcma_device *core, u16 offset)
+{
+	return readl(core->io_wrap + offset);
+}
+
+static void bcma_host_soc_awrite32(struct bcma_device *core, u16 offset,
+				  u32 value)
+{
+	writel(value, core->io_wrap + offset);
+}
+
+const struct bcma_host_ops bcma_host_soc_ops = {
+	.read8		= bcma_host_soc_read8,
+	.read16		= bcma_host_soc_read16,
+	.read32		= bcma_host_soc_read32,
+	.write8		= bcma_host_soc_write8,
+	.write16	= bcma_host_soc_write16,
+	.write32	= bcma_host_soc_write32,
+#ifdef CONFIG_BCMA_BLOCKIO
+	.block_read	= bcma_host_soc_block_read,
+	.block_write	= bcma_host_soc_block_write,
+#endif
+	.aread32	= bcma_host_soc_aread32,
+	.awrite32	= bcma_host_soc_awrite32,
+};
+
+int __init bcma_host_soc_register(struct bcma_soc *soc)
+{
+	struct bcma_bus *bus = &soc->bus;
+	int err;
+
+	/* iomap only first core. We have to read some register on this core
+	 * to scan the bus.
+	 */
+	bus->mmio = ioremap_nocache(BCMA_ADDR_BASE, BCMA_CORE_SIZE * 1);
+	if (!bus->mmio)
+		return -ENOMEM;
+
+	/* Host specific */
+	bus->hosttype = BCMA_HOSTTYPE_SOC;
+	bus->ops = &bcma_host_soc_ops;
+
+	/* Register */
+	err = bcma_bus_early_register(bus, &soc->core_cc, &soc->core_mips);
+	if (err)
+		iounmap(bus->mmio);
+
+	return err;
+}
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 360a289..2648522 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -66,6 +66,10 @@ static struct bcma_device *bcma_find_core(struct bcma_bus *bus, u16 coreid)
 static void bcma_release_core_dev(struct device *dev)
 {
 	struct bcma_device *core = container_of(dev, struct bcma_device, dev);
+	if (core->io_addr)
+		iounmap(core->io_addr);
+	if (core->io_wrap)
+		iounmap(core->io_wrap);
 	kfree(core);
 }
 
@@ -93,7 +97,10 @@ static int bcma_register_cores(struct bcma_bus *bus)
 			core->dma_dev = &bus->host_pci->dev;
 			core->irq = bus->host_pci->irq;
 			break;
-		case BCMA_HOSTTYPE_NONE:
+		case BCMA_HOSTTYPE_SOC:
+			core->dev.dma_mask = &core->dev.coherent_dma_mask;
+			core->dma_dev = &core->dev;
+			break;
 		case BCMA_HOSTTYPE_SDIO:
 			break;
 		}
diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index bf9f806..0ea390f 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -337,6 +337,16 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
 			}
 		}
 	}
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC) {
+		core->io_addr = ioremap_nocache(core->addr, BCMA_CORE_SIZE);
+		if (!core->io_addr)
+			return -ENOMEM;
+		core->io_wrap = ioremap_nocache(core->wrap, BCMA_CORE_SIZE);
+		if (!core->io_wrap) {
+			iounmap(core->io_addr);
+			return -ENOMEM;
+		}
+	}
 	return 0;
 }
 
@@ -369,7 +379,14 @@ int bcma_bus_scan(struct bcma_bus *bus)
 	bcma_init_bus(bus);
 
 	erombase = bcma_scan_read32(bus, 0, BCMA_CC_EROM);
-	eromptr = bus->mmio;
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC) {
+		eromptr = ioremap_nocache(erombase, BCMA_CORE_SIZE);
+		if (!eromptr)
+			return -ENOMEM;
+	} else {
+		eromptr = bus->mmio;
+	}
+
 	eromend = eromptr + BCMA_CORE_SIZE / sizeof(u32);
 
 	bcma_scan_switch_core(bus, erombase);
@@ -404,6 +421,9 @@ int bcma_bus_scan(struct bcma_bus *bus)
 		list_add(&core->list, &bus->cores);
 	}
 
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC)
+		iounmap(eromptr);
+
 	return 0;
 }
 
@@ -414,10 +434,18 @@ int __init bcma_bus_scan_early(struct bcma_bus *bus,
 	u32 erombase;
 	u32 __iomem *eromptr, *eromend;
 
-	int err, core_num = 0;
+	int err = -ENODEV;
+	int core_num = 0;
 
 	erombase = bcma_scan_read32(bus, 0, BCMA_CC_EROM);
-	eromptr = bus->mmio;
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC) {
+		eromptr = ioremap_nocache(erombase, BCMA_CORE_SIZE);
+		if (!eromptr)
+			return -ENOMEM;
+	} else {
+		eromptr = bus->mmio;
+	}
+
 	eromend = eromptr + BCMA_CORE_SIZE / sizeof(u32);
 
 	bcma_scan_switch_core(bus, erombase);
@@ -447,8 +475,12 @@ int __init bcma_bus_scan_early(struct bcma_bus *bus,
 			core->id.class);
 
 		list_add(&core->list, &bus->cores);
-		return 0;
+		err = 0;
+		break;
 	}
 
-	return -ENODEV;
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC)
+		iounmap(eromptr);
+
+	return err;
 }
diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
index e31c9b4..c70cec5 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -14,9 +14,9 @@ struct bcma_device;
 struct bcma_bus;
 
 enum bcma_hosttype {
-	BCMA_HOSTTYPE_NONE,
 	BCMA_HOSTTYPE_PCI,
 	BCMA_HOSTTYPE_SDIO,
+	BCMA_HOSTTYPE_SOC,
 };
 
 struct bcma_chipinfo {
@@ -138,6 +138,9 @@ struct bcma_device {
 	u32 addr;
 	u32 wrap;
 
+	void __iomem *io_addr;
+	void __iomem *io_wrap;
+
 	void *drvdata;
 	struct list_head list;
 };
diff --git a/include/linux/bcma/bcma_soc.h b/include/linux/bcma/bcma_soc.h
new file mode 100644
index 0000000..4203c55
--- /dev/null
+++ b/include/linux/bcma/bcma_soc.h
@@ -0,0 +1,16 @@
+#ifndef LINUX_BCMA_SOC_H_
+#define LINUX_BCMA_SOC_H_
+
+#include <linux/bcma/bcma.h>
+
+struct bcma_soc {
+	struct bcma_bus bus;
+	struct bcma_device core_cc;
+	struct bcma_device core_mips;
+};
+
+int __init bcma_host_soc_register(struct bcma_soc *soc);
+
+int bcma_bus_register(struct bcma_bus *bus);
+
+#endif /* LINUX_BCMA_SOC_H_ */
-- 
1.7.4.1
