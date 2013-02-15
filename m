Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 20:54:08 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:55371 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827653Ab3BOTyHwjMhE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 20:54:07 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3W8qwxor1pwT; Fri, 15 Feb 2013 20:53:57 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6832A2801AE;
        Fri, 15 Feb 2013 20:53:55 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH v2 04/11] MIPS: ath79: add IRQ handling code for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 20:53:47 +0100
Message-Id: <1360958027-19399-1-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
X-archive-position: 35778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The IRQ routing in the QCA955x SoCs is slightly
different from the routing implemented in the
already supported SoCs.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
v2: fix typos
---
 arch/mips/ath79/irq.c                          |  110 ++++++++++++++++++++++--
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   32 +++++++
 arch/mips/include/asm/mach-ath79/irq.h         |    6 +-
 3 files changed, 140 insertions(+), 8 deletions(-)

diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index df88d49..9c0e176 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -103,7 +103,10 @@ static void __init ath79_misc_irq_init(void)
 
 	if (soc_is_ar71xx() || soc_is_ar913x())
 		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
-	else if (soc_is_ar724x() || soc_is_ar933x() || soc_is_ar934x())
+	else if (soc_is_ar724x() ||
+		 soc_is_ar933x() ||
+		 soc_is_ar934x() ||
+		 soc_is_qca955x())
 		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
 	else
 		BUG();
@@ -150,6 +153,88 @@ static void ar934x_ip2_irq_init(void)
 	irq_set_chained_handler(ATH79_CPU_IRQ(2), ar934x_ip2_irq_dispatch);
 }
 
+static void qca955x_ip2_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+{
+	u32 status;
+
+	disable_irq_nosync(irq);
+
+	status = ath79_reset_rr(QCA955X_RESET_REG_EXT_INT_STATUS);
+	status &= QCA955X_EXT_INT_PCIE_RC1_ALL | QCA955X_EXT_INT_WMAC_ALL;
+
+	if (status == 0) {
+		spurious_interrupt();
+		goto enable;
+	}
+
+	if (status & QCA955X_EXT_INT_PCIE_RC1_ALL) {
+		/* TODO: flush DDR? */
+		generic_handle_irq(ATH79_IP2_IRQ(0));
+	}
+
+	if (status & QCA955X_EXT_INT_WMAC_ALL) {
+		/* TODO: flush DDR? */
+		generic_handle_irq(ATH79_IP2_IRQ(1));
+	}
+
+enable:
+	enable_irq(irq);
+}
+
+static void qca955x_ip3_irq_dispatch(unsigned int irq, struct irq_desc *desc)
+{
+	u32 status;
+
+	disable_irq_nosync(irq);
+
+	status = ath79_reset_rr(QCA955X_RESET_REG_EXT_INT_STATUS);
+	status &= QCA955X_EXT_INT_PCIE_RC2_ALL |
+		  QCA955X_EXT_INT_USB1 |
+		  QCA955X_EXT_INT_USB2;
+
+	if (status == 0) {
+		spurious_interrupt();
+		goto enable;
+	}
+
+	if (status & QCA955X_EXT_INT_USB1) {
+		/* TODO: flush DDR? */
+		generic_handle_irq(ATH79_IP3_IRQ(0));
+	}
+
+	if (status & QCA955X_EXT_INT_USB2) {
+		/* TODO: flush DDR? */
+		generic_handle_irq(ATH79_IP3_IRQ(1));
+	}
+
+	if (status & QCA955X_EXT_INT_PCIE_RC2_ALL) {
+		/* TODO: flush DDR? */
+		generic_handle_irq(ATH79_IP3_IRQ(2));
+	}
+
+enable:
+	enable_irq(irq);
+}
+
+static void qca955x_irq_init(void)
+{
+	int i;
+
+	for (i = ATH79_IP2_IRQ_BASE;
+	     i < ATH79_IP2_IRQ_BASE + ATH79_IP2_IRQ_COUNT; i++)
+		irq_set_chip_and_handler(i, &dummy_irq_chip,
+					 handle_level_irq);
+
+	irq_set_chained_handler(ATH79_CPU_IRQ(2), qca955x_ip2_irq_dispatch);
+
+	for (i = ATH79_IP3_IRQ_BASE;
+	     i < ATH79_IP3_IRQ_BASE + ATH79_IP3_IRQ_COUNT; i++)
+		irq_set_chip_and_handler(i, &dummy_irq_chip,
+					 handle_level_irq);
+
+	irq_set_chained_handler(ATH79_CPU_IRQ(3), qca955x_ip3_irq_dispatch);
+}
+
 asmlinkage void plat_irq_dispatch(void)
 {
 	unsigned long pending;
@@ -185,6 +270,17 @@ asmlinkage void plat_irq_dispatch(void)
  * Issue a flush in the handlers to ensure that the driver sees
  * the update.
  */
+
+static void ath79_default_ip2_handler(void)
+{
+	do_IRQ(ATH79_CPU_IRQ(2));
+}
+
+static void ath79_default_ip3_handler(void)
+{
+	do_IRQ(ATH79_CPU_IRQ(3));
+}
+
 static void ar71xx_ip2_handler(void)
 {
 	ath79_ddr_wb_flush(AR71XX_DDR_REG_FLUSH_PCI);
@@ -209,11 +305,6 @@ static void ar933x_ip2_handler(void)
 	do_IRQ(ATH79_CPU_IRQ(2));
 }
 
-static void ar934x_ip2_handler(void)
-{
-	do_IRQ(ATH79_CPU_IRQ(2));
-}
-
 static void ar71xx_ip3_handler(void)
 {
 	ath79_ddr_wb_flush(AR71XX_DDR_REG_FLUSH_USB);
@@ -259,8 +350,11 @@ void __init arch_init_irq(void)
 		ath79_ip2_handler = ar933x_ip2_handler;
 		ath79_ip3_handler = ar933x_ip3_handler;
 	} else if (soc_is_ar934x()) {
-		ath79_ip2_handler = ar934x_ip2_handler;
+		ath79_ip2_handler = ath79_default_ip2_handler;
 		ath79_ip3_handler = ar934x_ip3_handler;
+	} else if (soc_is_qca955x()) {
+		ath79_ip2_handler = ath79_default_ip2_handler;
+		ath79_ip3_handler = ath79_default_ip3_handler;
 	} else {
 		BUG();
 	}
@@ -271,4 +365,6 @@ void __init arch_init_irq(void)
 
 	if (soc_is_ar934x())
 		ar934x_ip2_irq_init();
+	else if (soc_is_qca955x())
+		qca955x_irq_init();
 }
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 7b00e12..8782d8b 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -300,6 +300,7 @@
 #define AR934X_RESET_REG_PCIE_WMAC_INT_STATUS	0xac
 
 #define QCA955X_RESET_REG_BOOTSTRAP		0xb0
+#define QCA955X_RESET_REG_EXT_INT_STATUS	0xac
 
 #define MISC_INT_ETHSW			BIT(12)
 #define MISC_INT_TIMER4			BIT(10)
@@ -398,6 +399,37 @@
 	 AR934X_PCIE_WMAC_INT_PCIE_RC1 | AR934X_PCIE_WMAC_INT_PCIE_RC2 | \
 	 AR934X_PCIE_WMAC_INT_PCIE_RC3)
 
+#define QCA955X_EXT_INT_WMAC_MISC		BIT(0)
+#define QCA955X_EXT_INT_WMAC_TX			BIT(1)
+#define QCA955X_EXT_INT_WMAC_RXLP		BIT(2)
+#define QCA955X_EXT_INT_WMAC_RXHP		BIT(3)
+#define QCA955X_EXT_INT_PCIE_RC1		BIT(4)
+#define QCA955X_EXT_INT_PCIE_RC1_INT0		BIT(5)
+#define QCA955X_EXT_INT_PCIE_RC1_INT1		BIT(6)
+#define QCA955X_EXT_INT_PCIE_RC1_INT2		BIT(7)
+#define QCA955X_EXT_INT_PCIE_RC1_INT3		BIT(8)
+#define QCA955X_EXT_INT_PCIE_RC2		BIT(12)
+#define QCA955X_EXT_INT_PCIE_RC2_INT0		BIT(13)
+#define QCA955X_EXT_INT_PCIE_RC2_INT1		BIT(14)
+#define QCA955X_EXT_INT_PCIE_RC2_INT2		BIT(15)
+#define QCA955X_EXT_INT_PCIE_RC2_INT3		BIT(16)
+#define QCA955X_EXT_INT_USB1			BIT(24)
+#define QCA955X_EXT_INT_USB2			BIT(28)
+
+#define QCA955X_EXT_INT_WMAC_ALL \
+	(QCA955X_EXT_INT_WMAC_MISC | QCA955X_EXT_INT_WMAC_TX | \
+	 QCA955X_EXT_INT_WMAC_RXLP | QCA955X_EXT_INT_WMAC_RXHP)
+
+#define QCA955X_EXT_INT_PCIE_RC1_ALL \
+	(QCA955X_EXT_INT_PCIE_RC1 | QCA955X_EXT_INT_PCIE_RC1_INT0 | \
+	 QCA955X_EXT_INT_PCIE_RC1_INT1 | QCA955X_EXT_INT_PCIE_RC1_INT2 | \
+	 QCA955X_EXT_INT_PCIE_RC1_INT3)
+
+#define QCA955X_EXT_INT_PCIE_RC2_ALL \
+	(QCA955X_EXT_INT_PCIE_RC2 | QCA955X_EXT_INT_PCIE_RC2_INT0 | \
+	 QCA955X_EXT_INT_PCIE_RC2_INT1 | QCA955X_EXT_INT_PCIE_RC2_INT2 | \
+	 QCA955X_EXT_INT_PCIE_RC2_INT3)
+
 #define REV_ID_MAJOR_MASK		0xfff0
 #define REV_ID_MAJOR_AR71XX		0x00a0
 #define REV_ID_MAJOR_AR913X		0x00b0
diff --git a/arch/mips/include/asm/mach-ath79/irq.h b/arch/mips/include/asm/mach-ath79/irq.h
index 23e2bba..5c9ca76 100644
--- a/arch/mips/include/asm/mach-ath79/irq.h
+++ b/arch/mips/include/asm/mach-ath79/irq.h
@@ -10,7 +10,7 @@
 #define __ASM_MACH_ATH79_IRQ_H
 
 #define MIPS_CPU_IRQ_BASE	0
-#define NR_IRQS			48
+#define NR_IRQS			51
 
 #define ATH79_CPU_IRQ(_x)	(MIPS_CPU_IRQ_BASE + (_x))
 
@@ -26,6 +26,10 @@
 #define ATH79_IP2_IRQ_COUNT	2
 #define ATH79_IP2_IRQ(_x)	(ATH79_IP2_IRQ_BASE + (_x))
 
+#define ATH79_IP3_IRQ_BASE	(ATH79_IP2_IRQ_BASE + ATH79_IP2_IRQ_COUNT)
+#define ATH79_IP3_IRQ_COUNT     3
+#define ATH79_IP3_IRQ(_x)       (ATH79_IP3_IRQ_BASE + (_x))
+
 #include_next <irq.h>
 
 #endif /* __ASM_MACH_ATH79_IRQ_H */
-- 
1.7.10
