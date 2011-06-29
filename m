Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 00:14:28 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:33472 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491197Ab1F2WMX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2011 00:12:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id DA9618BD6;
        Thu, 30 Jun 2011 00:12:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TNbqsB7Wrumt; Thu, 30 Jun 2011 00:12:17 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-251-103.ewe-ip-backbone.de [91.97.251.103])
        by hauke-m.de (Postfix) with ESMTPSA id 6FA778BD7;
        Thu, 30 Jun 2011 00:12:09 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-wireless@vger.kernel.org, zajec5@gmail.com,
        linux-mips@linux-mips.org
Cc:     mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC v3 05/13] bcma: add mips driver
Date:   Thu, 30 Jun 2011 00:11:50 +0200
Message-Id: <1309385518-12097-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1309385518-12097-1-git-send-email-hauke@hauke-m.de>
References: <1309385518-12097-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 30548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24412

This adds a mips driver to bcma. This is only found on embedded
devices. For now the driver just initializes the irqs used on this
system.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/Kconfig                  |   11 ++-
 drivers/bcma/Makefile                 |    1 +
 drivers/bcma/driver_mips.c            |  233 +++++++++++++++++++++++++++++++++
 drivers/bcma/main.c                   |   19 +++
 include/linux/bcma/bcma.h             |    2 +
 include/linux/bcma/bcma_driver_mips.h |   49 +++++++
 6 files changed, 314 insertions(+), 1 deletions(-)
 create mode 100644 drivers/bcma/driver_mips.c
 create mode 100644 include/linux/bcma/bcma_driver_mips.h

diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
index fc5c02f..0bd0a26 100644
--- a/drivers/bcma/Kconfig
+++ b/drivers/bcma/Kconfig
@@ -29,9 +29,18 @@ config BCMA_HOST_PCI
 
 config BCMA_HOST_SOC
 	bool
-	depends on BCMA && MIPS
+	depends on BCMA_DRIVER_MIPS
 	default n
 
+config BCMA_DRIVER_MIPS
+	bool "BCMA Broadcom MIPS core driver"
+	depends on BCMA && MIPS
+	help
+	  Driver for the Broadcom MIPS core attached to Broadcom specific
+	  Advanced Microcontroller Bus.
+
+	  If unsure, say N
+
 config BCMA_DEBUG
 	bool "BCMA debugging"
 	depends on BCMA
diff --git a/drivers/bcma/Makefile b/drivers/bcma/Makefile
index e2aaa41..3bb24f5 100644
--- a/drivers/bcma/Makefile
+++ b/drivers/bcma/Makefile
@@ -1,6 +1,7 @@
 bcma-y					+= main.o scan.o core.o sprom.o
 bcma-y					+= driver_chipcommon.o driver_chipcommon_pmu.o
 bcma-y					+= driver_pci.o
+bcma-$(CONFIG_BCMA_DRIVER_MIPS)		+= driver_mips.o
 bcma-$(CONFIG_BCMA_HOST_PCI)		+= host_pci.o
 bcma-$(CONFIG_BCMA_HOST_SOC)		+= host_soc.o
 obj-$(CONFIG_BCMA)			+= bcma.o
diff --git a/drivers/bcma/driver_mips.c b/drivers/bcma/driver_mips.c
new file mode 100644
index 0000000..605bb08
--- /dev/null
+++ b/drivers/bcma/driver_mips.c
@@ -0,0 +1,233 @@
+/*
+ * Broadcom specific AMBA
+ * Broadcom MIPS32 74K core driver
+ *
+ * Copyright 2009, Broadcom Corporation
+ * Copyright 2006, 2007, Michael Buesch <mb@bu3sch.de>
+ * Copyright 2010, Bernhard Loos <bernhardloos@googlemail.com>
+ * Copyright 2011, Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+#include "bcma_private.h"
+
+#include <linux/bcma/bcma.h>
+
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/time.h>
+
+/* The 47162a0 hangs when reading its registers */
+static inline bool bcma_core_mips_bcm47162a0_quirk(struct bcma_device *dev)
+{
+	return dev->bus->chipinfo.id == 47162 && dev->bus->chipinfo.rev == 0 &&
+	       dev->id.id == BCMA_CORE_MIPS_74K;
+}
+
+static inline u32 mips_read32(struct bcma_drv_mips *mcore,
+			      u16 offset)
+{
+	return bcma_read32(mcore->core, offset);
+}
+
+static inline void mips_write32(struct bcma_drv_mips *mcore,
+				u16 offset,
+				u32 value)
+{
+	bcma_write32(mcore->core, offset, value);
+}
+
+static const u32 ipsflag_irq_mask[] = {
+	0,
+	BCMA_MIPS_IPSFLAG_IRQ1,
+	BCMA_MIPS_IPSFLAG_IRQ2,
+	BCMA_MIPS_IPSFLAG_IRQ3,
+	BCMA_MIPS_IPSFLAG_IRQ4,
+};
+
+static const u32 ipsflag_irq_shift[] = {
+	0,
+	BCMA_MIPS_IPSFLAG_IRQ1_SHIFT,
+	BCMA_MIPS_IPSFLAG_IRQ2_SHIFT,
+	BCMA_MIPS_IPSFLAG_IRQ3_SHIFT,
+	BCMA_MIPS_IPSFLAG_IRQ4_SHIFT,
+};
+
+static u32 bcma_core_mips_irqflag(struct bcma_device *dev)
+{
+	u32 flag;
+
+	if (bcma_core_mips_bcm47162a0_quirk(dev))
+		return dev->core_index;
+	flag = bcma_aread32(dev, BCMA_MIPS_OOBSELOUTA30);
+
+	return flag & 0x1F;
+}
+
+
+/* Get the MIPS IRQ assignment for a specified device.
+ * If unassigned, 0 is returned.
+ */
+unsigned int bcma_core_mips_irq(struct bcma_device *dev)
+{
+	struct bcma_device *mdev = dev->bus->drv_mips.core;
+	u32 irqflag;
+	unsigned int irq;
+
+	irqflag = bcma_core_mips_irqflag(dev);
+
+	for (irq = 1; irq <= 4; irq++)
+		if (bcma_read32(mdev, BCMA_MIPS_MIPS74K_INTMASK(irq)) &
+		    (1 << irqflag))
+			return irq;
+
+	return 0;
+}
+EXPORT_SYMBOL(bcma_core_mips_irq);
+
+static void bcma_core_mips_set_irq(struct bcma_device *dev, unsigned int irq)
+{
+	unsigned int oldirq = bcma_core_mips_irq(dev);
+	struct bcma_bus *bus = dev->bus;
+	struct bcma_device *mdev = bus->drv_mips.core;
+	u32 irqflag;
+
+	irqflag = bcma_core_mips_irqflag(dev);
+	BUG_ON(oldirq == 6);
+
+	dev->irq = irq + 2;
+
+	/* clear the old irq */
+	if (oldirq == 0)
+		bcma_write32(mdev, BCMA_MIPS_MIPS74K_INTMASK(0),
+			    bcma_read32(mdev, BCMA_MIPS_MIPS74K_INTMASK(0)) &
+			    ~(1 << irqflag));
+	else
+		bcma_write32(mdev, BCMA_MIPS_MIPS74K_INTMASK(irq), 0);
+
+	/* assign the new one */
+	if (irq == 0) {
+		bcma_write32(mdev, BCMA_MIPS_MIPS74K_INTMASK(0),
+			    bcma_read32(mdev, BCMA_MIPS_MIPS74K_INTMASK(0)) |
+			    (1 << irqflag));
+	} else {
+		u32 oldirqflag = bcma_read32(mdev,
+					     BCMA_MIPS_MIPS74K_INTMASK(irq));
+		if (oldirqflag) {
+			struct bcma_device *core;
+
+			/* backplane irq line is in use, find out who uses
+			 * it and set user to irq 0
+			 */
+			list_for_each_entry_reverse(core, &bus->cores, list) {
+				if ((1 << bcma_core_mips_irqflag(core)) ==
+				    oldirqflag) {
+					bcma_core_mips_set_irq(core, 0);
+					break;
+				}
+			}
+		}
+		bcma_write32(mdev, BCMA_MIPS_MIPS74K_INTMASK(irq),
+			     1 << irqflag);
+	}
+
+	pr_info("set_irq: core 0x%04x, irq %d => %d\n",
+		dev->id.id, oldirq + 2, irq + 2);
+}
+
+static void bcma_core_mips_print_irq(struct bcma_device *dev, unsigned int irq)
+{
+	int i;
+	static const char *irq_name[] = {"2(S)", "3", "4", "5", "6", "D", "I"};
+	printk(KERN_INFO KBUILD_MODNAME ": core 0x%04x, irq :", dev->id.id);
+	for (i = 0; i <= 6; i++)
+		printk(" %s%s", irq_name[i], i == irq ? "*" : " ");
+	printk("\n");
+}
+
+static void bcma_core_mips_dump_irq(struct bcma_bus *bus)
+{
+	struct bcma_device *core;
+
+	list_for_each_entry_reverse(core, &bus->cores, list) {
+		bcma_core_mips_print_irq(core, bcma_core_mips_irq(core));
+	}
+}
+
+static void bcma_core_mips_flash_detect(struct bcma_drv_mips *mcore)
+{
+	struct bcma_bus *bus = mcore->core->bus;
+
+	mcore->flash_buswidth = 2;
+	if (bus->drv_cc.core) {
+		mcore->flash_window = 0x1c000000;
+		mcore->flash_window_size = 0x02000000;
+		switch (bus->drv_cc.capabilities & BCMA_CC_CAP_FLASHT) {
+		case BCMA_CC_FLASHT_STSER:
+		case BCMA_CC_FLASHT_ATSER:
+			pr_err("Serial flash not supported.\n");
+			break;
+		case BCMA_CC_FLASHT_PARA:
+			if ((bcma_read32(bus->drv_cc.core, BCMA_CC_FLASH_CFG) &
+			     BCMA_CC_OTPS) == 0)
+				mcore->flash_buswidth = 1;
+			break;
+		}
+	} else {
+		mcore->flash_window = 0x1fc00000;
+		mcore->flash_window_size = 0x00400000;
+	}
+}
+
+void bcma_core_mips_init(struct bcma_drv_mips *mcore)
+{
+	struct bcma_bus *bus;
+	struct bcma_device *core;
+	bus = mcore->core->bus;
+
+	pr_info("Initializing MIPS core...\n");
+
+	if (!mcore->setup_done)
+		mcore->assigned_irqs = 1;
+
+	/* Assign IRQs to all cores on the bus */
+	list_for_each_entry_reverse(core, &bus->cores, list) {
+		int mips_irq;
+		if (core->irq)
+			continue;
+
+		mips_irq = bcma_core_mips_irq(core);
+		if (mips_irq > 4)
+			core->irq = 0;
+		else
+			core->irq = mips_irq + 2;
+		if (core->irq > 5)
+			continue;
+		switch (core->id.id) {
+		case BCMA_CORE_PCI:
+		case BCMA_CORE_PCIE:
+		case BCMA_CORE_ETHERNET:
+		case BCMA_CORE_ETHERNET_GBIT:
+		case BCMA_CORE_MAC_GBIT:
+		case BCMA_CORE_80211:
+		case BCMA_CORE_USB20_HOST:
+			/* These devices get their own IRQ line if available,
+			 * the rest goes on IRQ0
+			 */
+			if (mcore->assigned_irqs <= 4)
+				bcma_core_mips_set_irq(core,
+						       mcore->assigned_irqs++);
+			break;
+		}
+	}
+	pr_info("IRQ reconfiguration done\n");
+	bcma_core_mips_dump_irq(bus);
+
+	if (mcore->setup_done)
+		return;
+
+	bcma_core_mips_flash_detect(mcore);
+	mcore->setup_done = true;
+}
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 58ded75..7dd0b16 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -80,6 +80,7 @@ static int bcma_register_cores(struct bcma_bus *bus)
 		case BCMA_CORE_CHIPCOMMON:
 		case BCMA_CORE_PCI:
 		case BCMA_CORE_PCIE:
+		case BCMA_CORE_MIPS_74K:
 			continue;
 		}
 
@@ -141,6 +142,15 @@ int bcma_bus_register(struct bcma_bus *bus)
 		bcma_core_chipcommon_init(&bus->drv_cc);
 	}
 
+#ifdef CONFIG_BCMA_DRIVER_MIPS
+	/* Init MIPS core */
+	core = bcma_find_core(bus, BCMA_CORE_MIPS_74K);
+	if (core) {
+		bus->drv_mips.core = core;
+		bcma_core_mips_init(&bus->drv_mips);
+	}
+#endif
+
 	/* Init PCIE core */
 	core = bcma_find_core(bus, BCMA_CORE_PCIE);
 	if (core) {
@@ -208,6 +218,15 @@ int __init bcma_bus_early_register(struct bcma_bus *bus,
 		bcma_core_chipcommon_init(&bus->drv_cc);
 	}
 
+#ifdef CONFIG_BCMA_DRIVER_MIPS
+	/* Init MIPS core */
+	core = bcma_find_core(bus, BCMA_CORE_MIPS_74K);
+	if (core) {
+		bus->drv_mips.core = core;
+		bcma_core_mips_init(&bus->drv_mips);
+	}
+#endif
+
 	pr_info("Early bus registered\n");
 
 	return 0;
diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
index db4ec30..6d962f2 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -6,6 +6,7 @@
 
 #include <linux/bcma/bcma_driver_chipcommon.h>
 #include <linux/bcma/bcma_driver_pci.h>
+#include <linux/bcma/bcma_driver_mips.h>
 #include <linux/ssb/ssb.h> /* SPROM sharing */
 
 #include "bcma_regs.h"
@@ -193,6 +194,7 @@ struct bcma_bus {
 
 	struct bcma_drv_cc drv_cc;
 	struct bcma_drv_pci drv_pci;
+	struct bcma_drv_mips drv_mips;
 
 	/* We decided to share SPROM struct with SSB as long as we do not need
 	 * any hacks for BCMA. This simplifies drivers code. */
diff --git a/include/linux/bcma/bcma_driver_mips.h b/include/linux/bcma/bcma_driver_mips.h
new file mode 100644
index 0000000..f19b21a
--- /dev/null
+++ b/include/linux/bcma/bcma_driver_mips.h
@@ -0,0 +1,49 @@
+#ifndef LINUX_BCMA_DRIVER_MIPS_H_
+#define LINUX_BCMA_DRIVER_MIPS_H_
+
+#define BCMA_MIPS_IPSFLAG		0x0F08
+/* which sbflags get routed to mips interrupt 1 */
+#define	 BCMA_MIPS_IPSFLAG_IRQ1		0x0000003F
+#define	 BCMA_MIPS_IPSFLAG_IRQ1_SHIFT	0
+/* which sbflags get routed to mips interrupt 2 */
+#define	 BCMA_MIPS_IPSFLAG_IRQ2		0x00003F00
+#define	 BCMA_MIPS_IPSFLAG_IRQ2_SHIFT	8
+/* which sbflags get routed to mips interrupt 3 */
+#define	 BCMA_MIPS_IPSFLAG_IRQ3		0x003F0000
+#define	 BCMA_MIPS_IPSFLAG_IRQ3_SHIFT	16
+/* which sbflags get routed to mips interrupt 4 */
+#define	 BCMA_MIPS_IPSFLAG_IRQ4		0x3F000000
+#define	 BCMA_MIPS_IPSFLAG_IRQ4_SHIFT	24
+
+/* MIPS 74K core registers */
+#define BCMA_MIPS_MIPS74K_CORECTL	0x0000
+#define BCMA_MIPS_MIPS74K_EXCEPTBASE	0x0004
+#define BCMA_MIPS_MIPS74K_BIST		0x000C
+#define BCMA_MIPS_MIPS74K_INTMASK_INT0	0x0014
+#define BCMA_MIPS_MIPS74K_INTMASK(int) \
+	((int) * 4 + BCMA_MIPS_MIPS74K_INTMASK_INT0)
+#define BCMA_MIPS_MIPS74K_NMIMASK	0x002C
+#define BCMA_MIPS_MIPS74K_GPIOSEL	0x0040
+#define BCMA_MIPS_MIPS74K_GPIOOUT	0x0044
+#define BCMA_MIPS_MIPS74K_GPIOEN	0x0048
+#define BCMA_MIPS_MIPS74K_CLKCTLST	0x01E0
+
+#define BCMA_MIPS_OOBSELOUTA30		0x100
+
+struct bcma_device;
+
+struct bcma_drv_mips {
+	struct bcma_device *core;
+	u8 setup_done:1;
+	unsigned int assigned_irqs;
+
+	u8 flash_buswidth;
+	u32 flash_window;
+	u32 flash_window_size;
+};
+
+extern void bcma_core_mips_init(struct bcma_drv_mips *mcore);
+
+extern unsigned int bcma_core_mips_irq(struct bcma_device *dev);
+
+#endif /* LINUX_BCMA_DRIVER_MIPS_H_ */
-- 
1.7.4.1
