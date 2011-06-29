Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 00:14:05 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:33464 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491195Ab1F2WMU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2011 00:12:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 8FDDF8BD5;
        Thu, 30 Jun 2011 00:12:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QDOypij3fAZc; Thu, 30 Jun 2011 00:12:15 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-251-103.ewe-ip-backbone.de [91.97.251.103])
        by hauke-m.de (Postfix) with ESMTPSA id A83FD8BD6;
        Thu, 30 Jun 2011 00:12:08 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-wireless@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org
Cc:     mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC v3 04/13] bcma: add SOC bus
Date:   Thu, 30 Jun 2011 00:11:49 +0200
Message-Id: <1309385518-12097-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1309385518-12097-1-git-send-email-hauke@hauke-m.de>
References: <1309385518-12097-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24411

This patch adds support for using bcma on an embedded bus. An embedded
system like the bcm4716 could register this bus and it searches for the
bcma cores then.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/Kconfig          |    5 +
 drivers/bcma/Makefile         |    1 +
 drivers/bcma/host_soc.c       |  178 +++++++++++++++++++++++++++++++++++++++++
 drivers/bcma/main.c           |    1 +
 drivers/bcma/scan.c           |   24 +++++-
 include/linux/bcma/bcma.h     |    4 +
 include/linux/bcma/bcma_soc.h |   16 ++++
 7 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bcma/host_soc.c
 create mode 100644 include/linux/bcma/bcma_soc.h

diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
index 83e9adf..fc5c02f 100644
--- a/drivers/bcma/Kconfig
+++ b/drivers/bcma/Kconfig
@@ -27,6 +27,11 @@ config BCMA_HOST_PCI
 	bool "Support for BCMA on PCI-host bus"
 	depends on BCMA_HOST_PCI_POSSIBLE
 
+config BCMA_HOST_SOC
+	bool
+	depends on BCMA && MIPS
+	default n
+
 config BCMA_DEBUG
 	bool "BCMA debugging"
 	depends on BCMA
diff --git a/drivers/bcma/Makefile b/drivers/bcma/Makefile
index cde0182..e2aaa41 100644
--- a/drivers/bcma/Makefile
+++ b/drivers/bcma/Makefile
@@ -2,6 +2,7 @@ bcma-y					+= main.o scan.o core.o sprom.o
 bcma-y					+= driver_chipcommon.o driver_chipcommon_pmu.o
 bcma-y					+= driver_pci.o
 bcma-$(CONFIG_BCMA_HOST_PCI)		+= host_pci.o
+bcma-$(CONFIG_BCMA_HOST_SOC)		+= host_soc.o
 obj-$(CONFIG_BCMA)			+= bcma.o
 
 ccflags-$(CONFIG_BCMA_DEBUG)		:= -DDEBUG
diff --git a/drivers/bcma/host_soc.c b/drivers/bcma/host_soc.c
new file mode 100644
index 0000000..a6fe724
--- /dev/null
+++ b/drivers/bcma/host_soc.c
@@ -0,0 +1,178 @@
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
+
+	/* iomap only first core. We have to read some register on this core
+	 * to scan the bus.
+	 */
+	bus->mmio = ioremap(BCMA_ADDR_BASE, BCMA_CORE_SIZE * 1);
+	if (!bus->mmio)
+		return -ENOMEM;
+
+	/* Host specific */
+	bus->hosttype = BCMA_HOSTTYPE_SOC;
+	bus->ops = &bcma_host_soc_ops;
+
+	/* Register */
+	return bcma_bus_early_register(bus, &soc->core_cc, &soc->core_mips);
+}
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index bc4c974..58ded75 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -95,6 +95,7 @@ static int bcma_register_cores(struct bcma_bus *bus)
 			break;
 		case BCMA_HOSTTYPE_NONE:
 		case BCMA_HOSTTYPE_SDIO:
+		case BCMA_HOSTTYPE_SOC:
 			break;
 		}
 
diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index bf9f806..202edc8 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -337,6 +337,14 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
 			}
 		}
 	}
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC) {
+		core->io_addr = ioremap(core->addr, BCMA_CORE_SIZE);
+		if (!core->io_addr)
+			return -ENOMEM;
+		core->io_wrap = ioremap(core->wrap, BCMA_CORE_SIZE);
+		if (!core->io_wrap)
+			return -ENOMEM;
+	}
 	return 0;
 }
 
@@ -369,7 +377,13 @@ int bcma_bus_scan(struct bcma_bus *bus)
 	bcma_init_bus(bus);
 
 	erombase = bcma_scan_read32(bus, 0, BCMA_CC_EROM);
-	eromptr = bus->mmio;
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC) {
+		eromptr = ioremap(erombase, BCMA_CORE_SIZE);
+		if (!eromptr)
+			return -ENOMEM;
+	} else
+		eromptr = bus->mmio;
+
 	eromend = eromptr + BCMA_CORE_SIZE / sizeof(u32);
 
 	bcma_scan_switch_core(bus, erombase);
@@ -417,7 +431,13 @@ int __init bcma_bus_scan_early(struct bcma_bus *bus,
 	int err, core_num = 0;
 
 	erombase = bcma_scan_read32(bus, 0, BCMA_CC_EROM);
-	eromptr = bus->mmio;
+	if (bus->hosttype == BCMA_HOSTTYPE_SOC) {
+		eromptr = ioremap(erombase, BCMA_CORE_SIZE);
+		if (!eromptr)
+			return -ENOMEM;
+	} else
+		eromptr = bus->mmio;
+
 	eromend = eromptr + BCMA_CORE_SIZE / sizeof(u32);
 
 	bcma_scan_switch_core(bus, erombase);
diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
index c473448..db4ec30 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -17,6 +17,7 @@ enum bcma_hosttype {
 	BCMA_HOSTTYPE_NONE,
 	BCMA_HOSTTYPE_PCI,
 	BCMA_HOSTTYPE_SDIO,
+	BCMA_HOSTTYPE_SOC,
 };
 
 struct bcma_chipinfo {
@@ -133,6 +134,9 @@ struct bcma_device {
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
