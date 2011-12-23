Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 19:28:48 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:46092 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903631Ab1LWS0O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2011 19:26:14 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 535E623C008D;
        Fri, 23 Dec 2011 19:26:13 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 06/16] MIPS: ath79: rework IP2/IP3 interrupt handling
Date:   Fri, 23 Dec 2011 19:25:32 +0100
Message-Id: <1324664742-3648-7-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
References: <1324664742-3648-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19093

The current implementation assumes that flushing the
DDR writeback buffer is required for IP2/IP3 interrupts,
however this is not true for all SoCs.

Use SoC specific IP2/IP3 handlers instead of flushing
the buffers in the dispatcher code.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
---
 arch/mips/ath79/irq.c |   92 ++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 1b073de..9f87ade 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -1,7 +1,7 @@
 /*
  *  Atheros AR71xx/AR724x/AR913x specific interrupt handling
  *
- *  Copyright (C) 2008-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  *  Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
  *
  *  Parts of this file are based on Atheros' 2.6.15 BSP
@@ -23,8 +23,8 @@
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
 
-static unsigned int ath79_ip2_flush_reg;
-static unsigned int ath79_ip3_flush_reg;
+static void (*ath79_ip2_handler)(void);
+static void (*ath79_ip3_handler)(void);
 
 static void ath79_misc_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
@@ -152,10 +152,8 @@ asmlinkage void plat_irq_dispatch(void)
 	if (pending & STATUSF_IP7)
 		do_IRQ(ATH79_CPU_IRQ_TIMER);
 
-	else if (pending & STATUSF_IP2) {
-		ath79_ddr_wb_flush(ath79_ip2_flush_reg);
-		do_IRQ(ATH79_CPU_IRQ_IP2);
-	}
+	else if (pending & STATUSF_IP2)
+		ath79_ip2_handler();
 
 	else if (pending & STATUSF_IP4)
 		do_IRQ(ATH79_CPU_IRQ_GE0);
@@ -163,10 +161,8 @@ asmlinkage void plat_irq_dispatch(void)
 	else if (pending & STATUSF_IP5)
 		do_IRQ(ATH79_CPU_IRQ_GE1);
 
-	else if (pending & STATUSF_IP3) {
-		ath79_ddr_wb_flush(ath79_ip3_flush_reg);
-		do_IRQ(ATH79_CPU_IRQ_USB);
-	}
+	else if (pending & STATUSF_IP3)
+		ath79_ip3_handler();
 
 	else if (pending & STATUSF_IP6)
 		do_IRQ(ATH79_CPU_IRQ_MISC);
@@ -175,22 +171,78 @@ asmlinkage void plat_irq_dispatch(void)
 		spurious_interrupt();
 }
 
+/*
+ * The IP2/IP3 lines are tied to a PCI/WMAC/USB device. Drivers for
+ * these devices typically allocate coherent DMA memory, however the
+ * DMA controller may still have some unsynchronized data in the FIFO.
+ * Issue a flush in the handlers to ensure that the driver sees
+ * the update.
+ */
+static void ar71xx_ip2_handler(void)
+{
+	ath79_ddr_wb_flush(AR71XX_DDR_REG_FLUSH_PCI);
+	do_IRQ(ATH79_CPU_IRQ_IP2);
+}
+
+static void ar724x_ip2_handler(void)
+{
+	ath79_ddr_wb_flush(AR724X_DDR_REG_FLUSH_PCIE);
+	do_IRQ(ATH79_CPU_IRQ_IP2);
+}
+
+static void ar913x_ip2_handler(void)
+{
+	ath79_ddr_wb_flush(AR913X_DDR_REG_FLUSH_WMAC);
+	do_IRQ(ATH79_CPU_IRQ_IP2);
+}
+
+static void ar933x_ip2_handler(void)
+{
+	ath79_ddr_wb_flush(AR933X_DDR_REG_FLUSH_WMAC);
+	do_IRQ(ATH79_CPU_IRQ_IP2);
+}
+
+static void ar71xx_ip3_handler(void)
+{
+	ath79_ddr_wb_flush(AR71XX_DDR_REG_FLUSH_USB);
+	do_IRQ(ATH79_CPU_IRQ_USB);
+}
+
+static void ar724x_ip3_handler(void)
+{
+	ath79_ddr_wb_flush(AR724X_DDR_REG_FLUSH_USB);
+	do_IRQ(ATH79_CPU_IRQ_USB);
+}
+
+static void ar913x_ip3_handler(void)
+{
+	ath79_ddr_wb_flush(AR913X_DDR_REG_FLUSH_USB);
+	do_IRQ(ATH79_CPU_IRQ_USB);
+}
+
+static void ar933x_ip3_handler(void)
+{
+	ath79_ddr_wb_flush(AR933X_DDR_REG_FLUSH_USB);
+	do_IRQ(ATH79_CPU_IRQ_USB);
+}
+
 void __init arch_init_irq(void)
 {
 	if (soc_is_ar71xx()) {
-		ath79_ip2_flush_reg = AR71XX_DDR_REG_FLUSH_PCI;
-		ath79_ip3_flush_reg = AR71XX_DDR_REG_FLUSH_USB;
+		ath79_ip2_handler = ar71xx_ip2_handler;
+		ath79_ip3_handler = ar71xx_ip3_handler;
 	} else if (soc_is_ar724x()) {
-		ath79_ip2_flush_reg = AR724X_DDR_REG_FLUSH_PCIE;
-		ath79_ip3_flush_reg = AR724X_DDR_REG_FLUSH_USB;
+		ath79_ip2_handler = ar724x_ip2_handler;
+		ath79_ip3_handler = ar724x_ip3_handler;
 	} else if (soc_is_ar913x()) {
-		ath79_ip2_flush_reg = AR913X_DDR_REG_FLUSH_WMAC;
-		ath79_ip3_flush_reg = AR913X_DDR_REG_FLUSH_USB;
+		ath79_ip2_handler = ar913x_ip2_handler;
+		ath79_ip3_handler = ar913x_ip3_handler;
 	} else if (soc_is_ar933x()) {
-		ath79_ip2_flush_reg = AR933X_DDR_REG_FLUSH_WMAC;
-		ath79_ip3_flush_reg = AR933X_DDR_REG_FLUSH_USB;
-	} else
+		ath79_ip2_handler = ar933x_ip2_handler;
+		ath79_ip3_handler = ar933x_ip3_handler;
+	} else {
 		BUG();
+	}
 
 	cp0_perfcount_irq = ATH79_MISC_IRQ_PERFC;
 	mips_cpu_irq_init();
-- 
1.7.2.1
