Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:24:07 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:58196 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992553AbeFYRXrR3qej (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:23:47 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 22/25] MIPS: ath79: drop legacy pci code
Date:   Mon, 25 Jun 2018 19:15:46 +0200
Message-Id: <20180625171549.4618-23-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625171549.4618-1-john@phrozen.org>
References: <20180625171549.4618-1-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

With the target now being fully OF based, we can drop the legacy pci
platform code. The only bits that we need to keep is the fixup code
which we move to its own code file.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/Makefile    |   1 -
 arch/mips/ath79/pci.c       | 273 --------------------------------------------
 arch/mips/ath79/pci.h       |  35 ------
 arch/mips/pci/Makefile      |   1 +
 arch/mips/pci/fixup-ath79.c |  21 ++++
 5 files changed, 22 insertions(+), 309 deletions(-)
 delete mode 100644 arch/mips/ath79/pci.c
 delete mode 100644 arch/mips/ath79/pci.h
 create mode 100644 arch/mips/pci/fixup-ath79.c

diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index ab8e26fe7446..bd0c9b8b1b5b 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -11,7 +11,6 @@
 obj-y	:= prom.o setup.o common.o clock.o
 
 obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
-obj-$(CONFIG_PCI)			+= pci.o
 
 #
 # Devices
diff --git a/arch/mips/ath79/pci.c b/arch/mips/ath79/pci.c
deleted file mode 100644
index b816cb4a25ff..000000000000
--- a/arch/mips/ath79/pci.c
+++ /dev/null
@@ -1,273 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X specific PCI setup code
- *
- *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  Parts of this file are based on Atheros' 2.6.15 BSP
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/resource.h>
-#include <linux/platform_device.h>
-#include <asm/mach-ath79/ar71xx_regs.h>
-#include <asm/mach-ath79/ath79.h>
-#include <asm/mach-ath79/irq.h>
-#include "pci.h"
-
-static int (*ath79_pci_plat_dev_init)(struct pci_dev *dev);
-static const struct ath79_pci_irq *ath79_pci_irq_map;
-static unsigned ath79_pci_nr_irqs;
-
-static const struct ath79_pci_irq ar71xx_pci_irq_map[] = {
-	{
-		.slot	= 17,
-		.pin	= 1,
-		.irq	= ATH79_PCI_IRQ(0),
-	}, {
-		.slot	= 18,
-		.pin	= 1,
-		.irq	= ATH79_PCI_IRQ(1),
-	}, {
-		.slot	= 19,
-		.pin	= 1,
-		.irq	= ATH79_PCI_IRQ(2),
-	}
-};
-
-static const struct ath79_pci_irq ar724x_pci_irq_map[] = {
-	{
-		.slot	= 0,
-		.pin	= 1,
-		.irq	= ATH79_PCI_IRQ(0),
-	}
-};
-
-static const struct ath79_pci_irq qca955x_pci_irq_map[] = {
-	{
-		.bus	= 0,
-		.slot	= 0,
-		.pin	= 1,
-		.irq	= ATH79_PCI_IRQ(0),
-	},
-	{
-		.bus	= 1,
-		.slot	= 0,
-		.pin	= 1,
-		.irq	= ATH79_PCI_IRQ(1),
-	},
-};
-
-int pcibios_map_irq(const struct pci_dev *dev, uint8_t slot, uint8_t pin)
-{
-	int irq = -1;
-	int i;
-
-	if (ath79_pci_nr_irqs == 0 ||
-	    ath79_pci_irq_map == NULL) {
-		if (soc_is_ar71xx()) {
-			ath79_pci_irq_map = ar71xx_pci_irq_map;
-			ath79_pci_nr_irqs = ARRAY_SIZE(ar71xx_pci_irq_map);
-		} else if (soc_is_ar724x() ||
-			   soc_is_ar9342() ||
-			   soc_is_ar9344()) {
-			ath79_pci_irq_map = ar724x_pci_irq_map;
-			ath79_pci_nr_irqs = ARRAY_SIZE(ar724x_pci_irq_map);
-		} else if (soc_is_qca955x()) {
-			ath79_pci_irq_map = qca955x_pci_irq_map;
-			ath79_pci_nr_irqs = ARRAY_SIZE(qca955x_pci_irq_map);
-		} else {
-			pr_crit("pci %s: invalid irq map\n",
-				pci_name((struct pci_dev *) dev));
-			return irq;
-		}
-	}
-
-	for (i = 0; i < ath79_pci_nr_irqs; i++) {
-		const struct ath79_pci_irq *entry;
-
-		entry = &ath79_pci_irq_map[i];
-		if (entry->bus == dev->bus->number &&
-		    entry->slot == slot &&
-		    entry->pin == pin) {
-			irq = entry->irq;
-			break;
-		}
-	}
-
-	if (irq < 0)
-		pr_crit("pci %s: no irq found for pin %u\n",
-			pci_name((struct pci_dev *) dev), pin);
-	else
-		pr_info("pci %s: using irq %d for pin %u\n",
-			pci_name((struct pci_dev *) dev), irq, pin);
-
-	return irq;
-}
-
-int pcibios_plat_dev_init(struct pci_dev *dev)
-{
-	if (ath79_pci_plat_dev_init)
-		return ath79_pci_plat_dev_init(dev);
-
-	return 0;
-}
-
-void __init ath79_pci_set_irq_map(unsigned nr_irqs,
-				  const struct ath79_pci_irq *map)
-{
-	ath79_pci_nr_irqs = nr_irqs;
-	ath79_pci_irq_map = map;
-}
-
-void __init ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *dev))
-{
-	ath79_pci_plat_dev_init = func;
-}
-
-static struct platform_device *
-ath79_register_pci_ar71xx(void)
-{
-	struct platform_device *pdev;
-	struct resource res[4];
-
-	memset(res, 0, sizeof(res));
-
-	res[0].name = "cfg_base";
-	res[0].flags = IORESOURCE_MEM;
-	res[0].start = AR71XX_PCI_CFG_BASE;
-	res[0].end = AR71XX_PCI_CFG_BASE + AR71XX_PCI_CFG_SIZE - 1;
-
-	res[1].flags = IORESOURCE_IRQ;
-	res[1].start = ATH79_CPU_IRQ(2);
-	res[1].end = ATH79_CPU_IRQ(2);
-
-	res[2].name = "io_base";
-	res[2].flags = IORESOURCE_IO;
-	res[2].start = 0;
-	res[2].end = 0;
-
-	res[3].name = "mem_base";
-	res[3].flags = IORESOURCE_MEM;
-	res[3].start = AR71XX_PCI_MEM_BASE;
-	res[3].end = AR71XX_PCI_MEM_BASE + AR71XX_PCI_MEM_SIZE - 1;
-
-	pdev = platform_device_register_simple("ar71xx-pci", -1,
-					       res, ARRAY_SIZE(res));
-	return pdev;
-}
-
-static struct platform_device *
-ath79_register_pci_ar724x(int id,
-			  unsigned long cfg_base,
-			  unsigned long ctrl_base,
-			  unsigned long crp_base,
-			  unsigned long mem_base,
-			  unsigned long mem_size,
-			  unsigned long io_base,
-			  int irq)
-{
-	struct platform_device *pdev;
-	struct resource res[6];
-
-	memset(res, 0, sizeof(res));
-
-	res[0].name = "cfg_base";
-	res[0].flags = IORESOURCE_MEM;
-	res[0].start = cfg_base;
-	res[0].end = cfg_base + AR724X_PCI_CFG_SIZE - 1;
-
-	res[1].name = "ctrl_base";
-	res[1].flags = IORESOURCE_MEM;
-	res[1].start = ctrl_base;
-	res[1].end = ctrl_base + AR724X_PCI_CTRL_SIZE - 1;
-
-	res[2].flags = IORESOURCE_IRQ;
-	res[2].start = irq;
-	res[2].end = irq;
-
-	res[3].name = "mem_base";
-	res[3].flags = IORESOURCE_MEM;
-	res[3].start = mem_base;
-	res[3].end = mem_base + mem_size - 1;
-
-	res[4].name = "io_base";
-	res[4].flags = IORESOURCE_IO;
-	res[4].start = io_base;
-	res[4].end = io_base;
-
-	res[5].name = "crp_base";
-	res[5].flags = IORESOURCE_MEM;
-	res[5].start = crp_base;
-	res[5].end = crp_base + AR724X_PCI_CRP_SIZE - 1;
-
-	pdev = platform_device_register_simple("ar724x-pci", id,
-					       res, ARRAY_SIZE(res));
-	return pdev;
-}
-
-int __init ath79_register_pci(void)
-{
-	struct platform_device *pdev = NULL;
-
-	if (soc_is_ar71xx()) {
-		pdev = ath79_register_pci_ar71xx();
-	} else if (soc_is_ar724x()) {
-		pdev = ath79_register_pci_ar724x(-1,
-						 AR724X_PCI_CFG_BASE,
-						 AR724X_PCI_CTRL_BASE,
-						 AR724X_PCI_CRP_BASE,
-						 AR724X_PCI_MEM_BASE,
-						 AR724X_PCI_MEM_SIZE,
-						 0,
-						 ATH79_CPU_IRQ(2));
-	} else if (soc_is_ar9342() ||
-		   soc_is_ar9344()) {
-		u32 bootstrap;
-
-		bootstrap = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
-		if ((bootstrap & AR934X_BOOTSTRAP_PCIE_RC) == 0)
-			return -ENODEV;
-
-		pdev = ath79_register_pci_ar724x(-1,
-						 AR724X_PCI_CFG_BASE,
-						 AR724X_PCI_CTRL_BASE,
-						 AR724X_PCI_CRP_BASE,
-						 AR724X_PCI_MEM_BASE,
-						 AR724X_PCI_MEM_SIZE,
-						 0,
-						 ATH79_IP2_IRQ(0));
-	} else if (soc_is_qca9558()) {
-		pdev = ath79_register_pci_ar724x(0,
-						 QCA955X_PCI_CFG_BASE0,
-						 QCA955X_PCI_CTRL_BASE0,
-						 QCA955X_PCI_CRP_BASE0,
-						 QCA955X_PCI_MEM_BASE0,
-						 QCA955X_PCI_MEM_SIZE,
-						 0,
-						 ATH79_IP2_IRQ(0));
-
-		pdev = ath79_register_pci_ar724x(1,
-						 QCA955X_PCI_CFG_BASE1,
-						 QCA955X_PCI_CTRL_BASE1,
-						 QCA955X_PCI_CRP_BASE1,
-						 QCA955X_PCI_MEM_BASE1,
-						 QCA955X_PCI_MEM_SIZE,
-						 1,
-						 ATH79_IP3_IRQ(2));
-	} else {
-		/* No PCI support */
-		return -ENODEV;
-	}
-
-	if (!pdev)
-		pr_err("unable to register PCI controller device\n");
-
-	return pdev ? 0 : -ENODEV;
-}
diff --git a/arch/mips/ath79/pci.h b/arch/mips/ath79/pci.h
deleted file mode 100644
index 1d00a3803c37..000000000000
--- a/arch/mips/ath79/pci.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- *  Atheros AR71XX/AR724X PCI support
- *
- *  Copyright (C) 2011 René Bolldorf <xsecute@googlemail.com>
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#ifndef _ATH79_PCI_H
-#define _ATH79_PCI_H
-
-struct ath79_pci_irq {
-	int	bus;
-	u8	slot;
-	u8	pin;
-	int	irq;
-};
-
-#ifdef CONFIG_PCI
-void ath79_pci_set_irq_map(unsigned nr_irqs, const struct ath79_pci_irq *map);
-void ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *dev));
-int ath79_register_pci(void);
-#else
-static inline void
-ath79_pci_set_irq_map(unsigned nr_irqs, const struct ath79_pci_irq *map) {}
-static inline void
-ath79_pci_set_plat_dev_init(int (*func)(struct pci_dev *)) {}
-static inline int ath79_register_pci(void) { return 0; }
-#endif
-
-#endif /* _ATH79_PCI_H */
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 8185a2bfaf09..c4f976593061 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_MIPS_PCI_VIRTIO)	+= pci-virtio-guest.o
 #
 # These are still pretty much in the old state, watch, go blind.
 #
+obj-$(CONFIG_ATH79)		+= fixup-ath79.o
 obj-$(CONFIG_LASAT)		+= pci-lasat.o
 obj-$(CONFIG_MIPS_COBALT)	+= fixup-cobalt.o
 obj-$(CONFIG_LEMOTE_FULOONG2E)	+= fixup-fuloong2e.o ops-loongson2.o
diff --git a/arch/mips/pci/fixup-ath79.c b/arch/mips/pci/fixup-ath79.c
new file mode 100644
index 000000000000..9e651a4af05e
--- /dev/null
+++ b/arch/mips/pci/fixup-ath79.c
@@ -0,0 +1,21 @@
+/*
+ *  Copyright (C) 2018 John Crispin <john@phrozen.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#include <linux/pci.h>
+//#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return of_irq_parse_and_map_pci(dev, slot, pin);
+}
-- 
2.11.0
