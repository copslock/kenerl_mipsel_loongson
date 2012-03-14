Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:42:59 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34420 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903735Ab2CNJkT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:40:19 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6372423C00D9;
        Wed, 14 Mar 2012 10:09:31 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, juhosg@openwrt.org
Subject: [PATCH v2 07/13] MIPS: ath79: add IRQ handling code for AR934X
Date:   Wed, 14 Mar 2012 11:45:25 +0100
Message-Id: <1331721931-4334-8-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
References: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
v2: - no changes

 arch/mips/ath79/irq.c                          |   55 +++++++++++++++++++++++-
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   25 +++++++++++
 arch/mips/include/asm/mach-ath79/irq.h         |    6 ++-
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 9f87ade..90d09fc 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -1,10 +1,11 @@
 /*
  *  Atheros AR71xx/AR724x/AR913x specific interrupt handling
  *
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
  *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
- *  Parts of this file are based on Atheros' 2.6.15 BSP
+ *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
@@ -129,7 +130,7 @@ static void __init ath79_misc_irq_init(void)
 
 	if (soc_is_ar71xx() || soc_is_ar913x())
 		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
-	else if (soc_is_ar724x() || soc_is_ar933x())
+	else if (soc_is_ar724x() || soc_is_ar933x() || soc_is_ar934x())
 		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
 	else
 		BUG();
@@ -143,6 +144,39 @@ static void __init ath79_misc_irq_init(void)
 	irq_set_chained_handler(ATH79_CPU_IRQ_MISC, ath79_misc_irq_handler);
 }
 
+static void ar934x_ip2_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+{
+	u32 status;
+
+	disable_irq_nosync(irq);
+
+	status = ath79_reset_rr(AR934X_RESET_REG_PCIE_WMAC_INT_STATUS);
+
+	if (status & AR934X_PCIE_WMAC_INT_PCIE_ALL) {
+		ath79_ddr_wb_flush(AR934X_DDR_REG_FLUSH_PCIE);
+		generic_handle_irq(ATH79_IP2_IRQ(0));
+	} else if (status & AR934X_PCIE_WMAC_INT_WMAC_ALL) {
+		ath79_ddr_wb_flush(AR934X_DDR_REG_FLUSH_WMAC);
+		generic_handle_irq(ATH79_IP2_IRQ(1));
+	} else {
+		spurious_interrupt();
+	}
+
+	enable_irq(irq);
+}
+
+static void ar934x_ip2_irq_init(void)
+{
+	int i;
+
+	for (i = ATH79_IP2_IRQ_BASE;
+	     i < ATH79_IP2_IRQ_BASE + ATH79_IP2_IRQ_COUNT; i++)
+		irq_set_chip_and_handler(i, &dummy_irq_chip,
+					 handle_level_irq);
+
+	irq_set_chained_handler(ATH79_CPU_IRQ_IP2, ar934x_ip2_irq_dispatch);
+}
+
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned long pending;
@@ -202,6 +236,11 @@ static void ar933x_ip2_handler(void)
 	do_IRQ(ATH79_CPU_IRQ_IP2);
 }
 
+static void ar934x_ip2_handler(void)
+{
+	do_IRQ(ATH79_CPU_IRQ_IP2);
+}
+
 static void ar71xx_ip3_handler(void)
 {
 	ath79_ddr_wb_flush(AR71XX_DDR_REG_FLUSH_USB);
@@ -226,6 +265,12 @@ static void ar933x_ip3_handler(void)
 	do_IRQ(ATH79_CPU_IRQ_USB);
 }
 
+static void ar934x_ip3_handler(void)
+{
+	ath79_ddr_wb_flush(AR934X_DDR_REG_FLUSH_USB);
+	do_IRQ(ATH79_CPU_IRQ_USB);
+}
+
 void __init arch_init_irq(void)
 {
 	if (soc_is_ar71xx()) {
@@ -240,6 +285,9 @@ void __init arch_init_irq(void)
 	} else if (soc_is_ar933x()) {
 		ath79_ip2_handler = ar933x_ip2_handler;
 		ath79_ip3_handler = ar933x_ip3_handler;
+	} else if (soc_is_ar934x()) {
+		ath79_ip2_handler = ar934x_ip2_handler;
+		ath79_ip3_handler = ar934x_ip3_handler;
 	} else {
 		BUG();
 	}
@@ -247,4 +295,7 @@ void __init arch_init_irq(void)
 	cp0_perfcount_irq = ATH79_MISC_IRQ_PERFC;
 	mips_cpu_irq_init();
 	ath79_misc_irq_init();
+
+	if (soc_is_ar934x())
+		ar934x_ip2_irq_init();
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 1a9234b..d6af4eb 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -92,6 +92,12 @@
 #define AR933X_DDR_REG_FLUSH_USB	0x84
 #define AR933X_DDR_REG_FLUSH_WMAC	0x88
 
+#define AR934X_DDR_REG_FLUSH_GE0	0x9c
+#define AR934X_DDR_REG_FLUSH_GE1	0xa0
+#define AR934X_DDR_REG_FLUSH_USB	0xa4
+#define AR934X_DDR_REG_FLUSH_PCIE	0xa8
+#define AR934X_DDR_REG_FLUSH_WMAC	0xac
+
 /*
  * PLL block
  */
@@ -222,6 +228,7 @@
 #define AR933X_RESET_REG_BOOTSTRAP		0xac
 
 #define AR934X_RESET_REG_BOOTSTRAP		0xb0
+#define AR934X_RESET_REG_PCIE_WMAC_INT_STATUS	0xac
 
 #define MISC_INT_ETHSW			BIT(12)
 #define MISC_INT_TIMER4			BIT(10)
@@ -295,6 +302,24 @@
 #define AR934X_BOOTSTRAP_SDRAM_DISABLED	BIT(1)
 #define AR934X_BOOTSTRAP_DDR1		BIT(0)
 
+#define AR934X_PCIE_WMAC_INT_WMAC_MISC		BIT(0)
+#define AR934X_PCIE_WMAC_INT_WMAC_TX		BIT(1)
+#define AR934X_PCIE_WMAC_INT_WMAC_RXLP		BIT(2)
+#define AR934X_PCIE_WMAC_INT_WMAC_RXHP		BIT(3)
+#define AR934X_PCIE_WMAC_INT_PCIE_RC		BIT(4)
+#define AR934X_PCIE_WMAC_INT_PCIE_RC0		BIT(5)
+#define AR934X_PCIE_WMAC_INT_PCIE_RC1		BIT(6)
+#define AR934X_PCIE_WMAC_INT_PCIE_RC2		BIT(7)
+#define AR934X_PCIE_WMAC_INT_PCIE_RC3		BIT(8)
+#define AR934X_PCIE_WMAC_INT_WMAC_ALL \
+	(AR934X_PCIE_WMAC_INT_WMAC_MISC | AR934X_PCIE_WMAC_INT_WMAC_TX | \
+	 AR934X_PCIE_WMAC_INT_WMAC_RXLP | AR934X_PCIE_WMAC_INT_WMAC_RXHP)
+
+#define AR934X_PCIE_WMAC_INT_PCIE_ALL \
+	(AR934X_PCIE_WMAC_INT_PCIE_RC | AR934X_PCIE_WMAC_INT_PCIE_RC0 | \
+	 AR934X_PCIE_WMAC_INT_PCIE_RC1 | AR934X_PCIE_WMAC_INT_PCIE_RC2 | \
+	 AR934X_PCIE_WMAC_INT_PCIE_RC3)
+
 #define REV_ID_MAJOR_MASK		0xfff0
 #define REV_ID_MAJOR_AR71XX		0x00a0
 #define REV_ID_MAJOR_AR913X		0x00b0
diff --git a/arch/mips/include/asm/mach-ath79/irq.h b/arch/mips/include/asm/mach-ath79/irq.h
index 6ae2646..0968f69 100644
--- a/arch/mips/include/asm/mach-ath79/irq.h
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -10,7 +10,7 @@
 #define __ASM_MACH_ATH79_IRQ_H
 
 #define MIPS_CPU_IRQ_BASE	0
-#define NR_IRQS			46
+#define NR_IRQS			48
 
 #define ATH79_MISC_IRQ_BASE	8
 #define ATH79_MISC_IRQ_COUNT	32
@@ -19,6 +19,10 @@
 #define ATH79_PCI_IRQ_COUNT	6
 #define ATH79_PCI_IRQ(_x)	(ATH79_PCI_IRQ_BASE + (_x))
 
+#define ATH79_IP2_IRQ_BASE	(ATH79_PCI_IRQ_BASE + ATH79_PCI_IRQ_COUNT)
+#define ATH79_IP2_IRQ_COUNT	2
+#define ATH79_IP2_IRQ(_x)	(ATH79_IP2_IRQ_BASE + (_x))
+
 #define ATH79_CPU_IRQ_IP2	(MIPS_CPU_IRQ_BASE + 2)
 #define ATH79_CPU_IRQ_USB	(MIPS_CPU_IRQ_BASE + 3)
 #define ATH79_CPU_IRQ_GE0	(MIPS_CPU_IRQ_BASE + 4)
-- 
1.7.2.1
