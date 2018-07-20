Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 14:26:23 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:47204 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993883AbeGTMYPNIzw5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 14:24:15 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH V2 19/25] MIPS: ath79: drop legacy IRQ code
Date:   Fri, 20 Jul 2018 13:58:36 +0200
Message-Id: <20180720115842.8406-20-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64980
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

With the target now being fully OF based, we can drop the legacy IRQ code.
All IRQs are now handled via the new irqchip drivers.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/Makefile                 |   2 +-
 arch/mips/ath79/irq.c                    | 169 -------------------------------
 arch/mips/ath79/setup.c                  |   6 ++
 arch/mips/include/asm/mach-ath79/ath79.h |   4 -
 4 files changed, 7 insertions(+), 174 deletions(-)
 delete mode 100644 arch/mips/ath79/irq.c

diff --git a/arch/mips/ath79/Makefile b/arch/mips/ath79/Makefile
index fcc382cfc770..d8bd9b821ac9 100644
--- a/arch/mips/ath79/Makefile
+++ b/arch/mips/ath79/Makefile
@@ -8,7 +8,7 @@
 # under the terms of the GNU General Public License version 2 as published
 # by the Free Software Foundation.
 
-obj-y	:= prom.o setup.o irq.o common.o clock.o
+obj-y	:= prom.o setup.o common.o clock.o
 
 obj-$(CONFIG_EARLY_PRINTK)		+= early_printk.o
 obj-$(CONFIG_PCI)			+= pci.o
diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
deleted file mode 100644
index 2dfff1f19004..000000000000
--- a/arch/mips/ath79/irq.c
+++ /dev/null
@@ -1,169 +0,0 @@
-/*
- *  Atheros AR71xx/AR724x/AR913x specific interrupt handling
- *
- *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
- *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
- *
- *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irqchip.h>
-#include <linux/of_irq.h>
-
-#include <asm/irq_cpu.h>
-#include <asm/mipsregs.h>
-
-#include <asm/mach-ath79/ath79.h>
-#include <asm/mach-ath79/ar71xx_regs.h>
-#include "common.h"
-#include "machtypes.h"
-
-
-static void ar934x_ip2_irq_dispatch(struct irq_desc *desc)
-{
-	u32 status;
-
-	status = ath79_reset_rr(AR934X_RESET_REG_PCIE_WMAC_INT_STATUS);
-
-	if (status & AR934X_PCIE_WMAC_INT_PCIE_ALL) {
-		ath79_ddr_wb_flush(3);
-		generic_handle_irq(ATH79_IP2_IRQ(0));
-	} else if (status & AR934X_PCIE_WMAC_INT_WMAC_ALL) {
-		ath79_ddr_wb_flush(4);
-		generic_handle_irq(ATH79_IP2_IRQ(1));
-	} else {
-		spurious_interrupt();
-	}
-}
-
-static void ar934x_ip2_irq_init(void)
-{
-	int i;
-
-	for (i = ATH79_IP2_IRQ_BASE;
-	     i < ATH79_IP2_IRQ_BASE + ATH79_IP2_IRQ_COUNT; i++)
-		irq_set_chip_and_handler(i, &dummy_irq_chip,
-					 handle_level_irq);
-
-	irq_set_chained_handler(ATH79_CPU_IRQ(2), ar934x_ip2_irq_dispatch);
-}
-
-static void qca955x_ip2_irq_dispatch(struct irq_desc *desc)
-{
-	u32 status;
-
-	status = ath79_reset_rr(QCA955X_RESET_REG_EXT_INT_STATUS);
-	status &= QCA955X_EXT_INT_PCIE_RC1_ALL | QCA955X_EXT_INT_WMAC_ALL;
-
-	if (status == 0) {
-		spurious_interrupt();
-		return;
-	}
-
-	if (status & QCA955X_EXT_INT_PCIE_RC1_ALL) {
-		/* TODO: flush DDR? */
-		generic_handle_irq(ATH79_IP2_IRQ(0));
-	}
-
-	if (status & QCA955X_EXT_INT_WMAC_ALL) {
-		/* TODO: flush DDR? */
-		generic_handle_irq(ATH79_IP2_IRQ(1));
-	}
-}
-
-static void qca955x_ip3_irq_dispatch(struct irq_desc *desc)
-{
-	u32 status;
-
-	status = ath79_reset_rr(QCA955X_RESET_REG_EXT_INT_STATUS);
-	status &= QCA955X_EXT_INT_PCIE_RC2_ALL |
-		  QCA955X_EXT_INT_USB1 |
-		  QCA955X_EXT_INT_USB2;
-
-	if (status == 0) {
-		spurious_interrupt();
-		return;
-	}
-
-	if (status & QCA955X_EXT_INT_USB1) {
-		/* TODO: flush DDR? */
-		generic_handle_irq(ATH79_IP3_IRQ(0));
-	}
-
-	if (status & QCA955X_EXT_INT_USB2) {
-		/* TODO: flush DDR? */
-		generic_handle_irq(ATH79_IP3_IRQ(1));
-	}
-
-	if (status & QCA955X_EXT_INT_PCIE_RC2_ALL) {
-		/* TODO: flush DDR? */
-		generic_handle_irq(ATH79_IP3_IRQ(2));
-	}
-}
-
-static void qca955x_irq_init(void)
-{
-	int i;
-
-	for (i = ATH79_IP2_IRQ_BASE;
-	     i < ATH79_IP2_IRQ_BASE + ATH79_IP2_IRQ_COUNT; i++)
-		irq_set_chip_and_handler(i, &dummy_irq_chip,
-					 handle_level_irq);
-
-	irq_set_chained_handler(ATH79_CPU_IRQ(2), qca955x_ip2_irq_dispatch);
-
-	for (i = ATH79_IP3_IRQ_BASE;
-	     i < ATH79_IP3_IRQ_BASE + ATH79_IP3_IRQ_COUNT; i++)
-		irq_set_chip_and_handler(i, &dummy_irq_chip,
-					 handle_level_irq);
-
-	irq_set_chained_handler(ATH79_CPU_IRQ(3), qca955x_ip3_irq_dispatch);
-}
-
-void __init arch_init_irq(void)
-{
-	unsigned irq_wb_chan2 = -1;
-	unsigned irq_wb_chan3 = -1;
-	bool misc_is_ar71xx;
-
-	if (mips_machtype == ATH79_MACH_GENERIC_OF) {
-		irqchip_init();
-		return;
-	}
-
-	if (soc_is_ar71xx() || soc_is_ar724x() ||
-	    soc_is_ar913x() || soc_is_ar933x()) {
-		irq_wb_chan2 = 3;
-		irq_wb_chan3 = 2;
-	} else if (soc_is_ar934x()) {
-		irq_wb_chan3 = 2;
-	}
-
-	ath79_cpu_irq_init(irq_wb_chan2, irq_wb_chan3);
-
-	if (soc_is_ar71xx() || soc_is_ar913x())
-		misc_is_ar71xx = true;
-	else if (soc_is_ar724x() ||
-		 soc_is_ar933x() ||
-		 soc_is_ar934x() ||
-		 soc_is_qca955x())
-		misc_is_ar71xx = false;
-	else
-		BUG();
-	ath79_misc_irq_init(
-		ath79_reset_base + AR71XX_RESET_REG_MISC_INT_STATUS,
-		ATH79_CPU_IRQ(6), ATH79_MISC_IRQ_BASE, misc_is_ar71xx);
-
-	if (soc_is_ar934x())
-		ar934x_ip2_irq_init();
-	else if (soc_is_qca955x())
-		qca955x_irq_init();
-}
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 4c7a93f4039a..a8c1cca07461 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/of_fdt.h>
+#include <linux/irqchip.h>
 
 #include <asm/bootinfo.h>
 #include <asm/idle.h>
@@ -311,6 +312,11 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = cpu_clk_rate / 2;
 }
 
+void __init arch_init_irq(void)
+{
+	irqchip_init();
+}
+
 static int __init ath79_setup(void)
 {
 	if  (mips_machtype == ATH79_MACH_GENERIC_OF)
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index 73dcd63b8243..47e8827e9564 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -178,8 +178,4 @@ static inline u32 ath79_reset_rr(unsigned reg)
 void ath79_device_reset_set(u32 mask);
 void ath79_device_reset_clear(u32 mask);
 
-void ath79_cpu_irq_init(unsigned irq_wb_chan2, unsigned irq_wb_chan3);
-void ath79_misc_irq_init(void __iomem *regs, int irq,
-			int irq_base, bool is_ar71xx);
-
 #endif /* __ASM_MACH_ATH79_H */
-- 
2.11.0
