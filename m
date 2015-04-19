Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 14:31:25 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:56461 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011783AbbDSMazsZUG1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 14:30:55 +0200
Received: from localhost.localdomain (unknown [85.177.79.58])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id 110F89400B3;
        Sun, 19 Apr 2015 14:28:34 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] MIPS: ath79: Improve the DDR controller interface
Date:   Sun, 19 Apr 2015 14:30:03 +0200
Message-Id: <1429446604-15403-5-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429446604-15403-1-git-send-email-albeu@free.fr>
References: <1429446604-15403-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

The DDR controller need to be used by the IRQ controller to flush
the write buffer of some devices before running the IRQ handler.
It is also used by the PCI controller to setup the PCI memory windows.

The current interface used to access the DDR controller doesn't
provides any useful abstraction and simply rely on a shared global
pointer.

Replace this by a simple API to setup the PCI memory windows and use
the write buffer flush independently of the SoC type. That remove the
need for the shared global pointer, simplify the IRQ handler code.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
v2: * Updated ath79_ddr_set_pci_windows() after dropping the buggy PCI
      "fix" patch.
---
 arch/mips/ath79/common.c                 |  35 +++++++-
 arch/mips/ath79/common.h                 |   1 +
 arch/mips/ath79/irq.c                    | 147 +++++++------------------------
 arch/mips/ath79/setup.c                  |   3 +-
 arch/mips/include/asm/mach-ath79/ath79.h |   3 +-
 arch/mips/pci/pci-ar71xx.c               |  10 +--
 6 files changed, 71 insertions(+), 128 deletions(-)

diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
index eb3966c..3cedd1f 100644
--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -38,11 +38,27 @@ unsigned int ath79_soc_rev;
 void __iomem *ath79_pll_base;
 void __iomem *ath79_reset_base;
 EXPORT_SYMBOL_GPL(ath79_reset_base);
-void __iomem *ath79_ddr_base;
+static void __iomem *ath79_ddr_base;
+static void __iomem *ath79_ddr_wb_flush_base;
+static void __iomem *ath79_ddr_pci_win_base;
+
+void ath79_ddr_ctrl_init(void)
+{
+	ath79_ddr_base = ioremap_nocache(AR71XX_DDR_CTRL_BASE,
+					 AR71XX_DDR_CTRL_SIZE);
+	if (soc_is_ar71xx() || soc_is_ar934x()) {
+		ath79_ddr_wb_flush_base = ath79_ddr_base + 0x9c;
+		ath79_ddr_pci_win_base = ath79_ddr_base + 0x7c;
+	} else {
+		ath79_ddr_wb_flush_base = ath79_ddr_base + 0x7c;
+		ath79_ddr_pci_win_base = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(ath79_ddr_ctrl_init);
 
 void ath79_ddr_wb_flush(u32 reg)
 {
-	void __iomem *flush_reg = ath79_ddr_base + reg;
+	void __iomem *flush_reg = ath79_ddr_wb_flush_base + reg;
 
 	/* Flush the DDR write buffer. */
 	__raw_writel(0x1, flush_reg);
@@ -56,6 +72,21 @@ void ath79_ddr_wb_flush(u32 reg)
 }
 EXPORT_SYMBOL_GPL(ath79_ddr_wb_flush);
 
+void ath79_ddr_set_pci_windows(void)
+{
+	BUG_ON(!ath79_ddr_pci_win_base);
+
+	__raw_writel(AR71XX_PCI_WIN0_OFFS, ath79_ddr_pci_win_base + 0);
+	__raw_writel(AR71XX_PCI_WIN1_OFFS, ath79_ddr_pci_win_base + 1);
+	__raw_writel(AR71XX_PCI_WIN2_OFFS, ath79_ddr_pci_win_base + 2);
+	__raw_writel(AR71XX_PCI_WIN3_OFFS, ath79_ddr_pci_win_base + 3);
+	__raw_writel(AR71XX_PCI_WIN4_OFFS, ath79_ddr_pci_win_base + 4);
+	__raw_writel(AR71XX_PCI_WIN5_OFFS, ath79_ddr_pci_win_base + 5);
+	__raw_writel(AR71XX_PCI_WIN6_OFFS, ath79_ddr_pci_win_base + 6);
+	__raw_writel(AR71XX_PCI_WIN7_OFFS, ath79_ddr_pci_win_base + 7);
+}
+EXPORT_SYMBOL_GPL(ath79_ddr_set_pci_windows);
+
 void ath79_device_reset_set(u32 mask)
 {
 	unsigned long flags;
diff --git a/arch/mips/ath79/common.h b/arch/mips/ath79/common.h
index c39de61..e5ea712 100644
--- a/arch/mips/ath79/common.h
+++ b/arch/mips/ath79/common.h
@@ -22,6 +22,7 @@
 void ath79_clocks_init(void);
 unsigned long ath79_get_sys_clk_rate(const char *id);
 
+void ath79_ddr_ctrl_init(void);
 void ath79_ddr_wb_flush(unsigned int reg);
 
 void ath79_gpio_function_enable(u32 mask);
diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
index 6adae36..2c3991a 100644
--- a/arch/mips/ath79/irq.c
+++ b/arch/mips/ath79/irq.c
@@ -24,9 +24,6 @@
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
 
-static void (*ath79_ip2_handler)(void);
-static void (*ath79_ip3_handler)(void);
-
 static void ath79_misc_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	void __iomem *base = ath79_reset_base;
@@ -129,10 +126,10 @@ static void ar934x_ip2_irq_dispatch(unsigned int irq, struct irq_desc *desc)
 	status = ath79_reset_rr(AR934X_RESET_REG_PCIE_WMAC_INT_STATUS);
 
 	if (status & AR934X_PCIE_WMAC_INT_PCIE_ALL) {
-		ath79_ddr_wb_flush(AR934X_DDR_REG_FLUSH_PCIE);
+		ath79_ddr_wb_flush(3);
 		generic_handle_irq(ATH79_IP2_IRQ(0));
 	} else if (status & AR934X_PCIE_WMAC_INT_WMAC_ALL) {
-		ath79_ddr_wb_flush(AR934X_DDR_REG_FLUSH_WMAC);
+		ath79_ddr_wb_flush(4);
 		generic_handle_irq(ATH79_IP2_IRQ(1));
 	} else {
 		spurious_interrupt();
@@ -235,128 +232,50 @@ static void qca955x_irq_init(void)
 	irq_set_chained_handler(ATH79_CPU_IRQ(3), qca955x_ip3_irq_dispatch);
 }
 
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned long pending;
-
-	pending = read_c0_status() & read_c0_cause() & ST0_IM;
-
-	if (pending & STATUSF_IP7)
-		do_IRQ(ATH79_CPU_IRQ(7));
-
-	else if (pending & STATUSF_IP2)
-		ath79_ip2_handler();
-
-	else if (pending & STATUSF_IP4)
-		do_IRQ(ATH79_CPU_IRQ(4));
-
-	else if (pending & STATUSF_IP5)
-		do_IRQ(ATH79_CPU_IRQ(5));
-
-	else if (pending & STATUSF_IP3)
-		ath79_ip3_handler();
-
-	else if (pending & STATUSF_IP6)
-		do_IRQ(ATH79_CPU_IRQ(6));
-
-	else
-		spurious_interrupt();
-}
-
 /*
  * The IP2/IP3 lines are tied to a PCI/WMAC/USB device. Drivers for
  * these devices typically allocate coherent DMA memory, however the
  * DMA controller may still have some unsynchronized data in the FIFO.
  * Issue a flush in the handlers to ensure that the driver sees
  * the update.
+ *
+ * This array map the interrupt lines to the DDR write buffer channels.
  */
 
-static void ath79_default_ip2_handler(void)
-{
-	do_IRQ(ATH79_CPU_IRQ(2));
-}
-
-static void ath79_default_ip3_handler(void)
-{
-	do_IRQ(ATH79_CPU_IRQ(3));
-}
-
-static void ar71xx_ip2_handler(void)
-{
-	ath79_ddr_wb_flush(AR71XX_DDR_REG_FLUSH_PCI);
-	do_IRQ(ATH79_CPU_IRQ(2));
-}
-
-static void ar724x_ip2_handler(void)
-{
-	ath79_ddr_wb_flush(AR724X_DDR_REG_FLUSH_PCIE);
-	do_IRQ(ATH79_CPU_IRQ(2));
-}
-
-static void ar913x_ip2_handler(void)
-{
-	ath79_ddr_wb_flush(AR913X_DDR_REG_FLUSH_WMAC);
-	do_IRQ(ATH79_CPU_IRQ(2));
-}
-
-static void ar933x_ip2_handler(void)
-{
-	ath79_ddr_wb_flush(AR933X_DDR_REG_FLUSH_WMAC);
-	do_IRQ(ATH79_CPU_IRQ(2));
-}
-
-static void ar71xx_ip3_handler(void)
-{
-	ath79_ddr_wb_flush(AR71XX_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ(3));
-}
-
-static void ar724x_ip3_handler(void)
-{
-	ath79_ddr_wb_flush(AR724X_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ(3));
-}
-
-static void ar913x_ip3_handler(void)
-{
-	ath79_ddr_wb_flush(AR913X_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ(3));
-}
-
-static void ar933x_ip3_handler(void)
-{
-	ath79_ddr_wb_flush(AR933X_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ(3));
-}
-
-static void ar934x_ip3_handler(void)
-{
-	ath79_ddr_wb_flush(AR934X_DDR_REG_FLUSH_USB);
-	do_IRQ(ATH79_CPU_IRQ(3));
+static unsigned irq_wb_chan[8] = {
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned long pending;
+	int irq;
+
+	pending = read_c0_status() & read_c0_cause() & ST0_IM;
+
+	if (!pending) {
+		spurious_interrupt();
+		return;
+	}
+
+	pending >>= CAUSEB_IP;
+	while (pending) {
+		irq = fls(pending) - 1;
+		if (irq < ARRAY_SIZE(irq_wb_chan) && irq_wb_chan[irq] != -1)
+			ath79_ddr_wb_flush(irq_wb_chan[irq]);
+		do_IRQ(MIPS_CPU_IRQ_BASE + irq);
+		pending &= ~BIT(irq);
+	}
 }
 
 void __init arch_init_irq(void)
 {
-	if (soc_is_ar71xx()) {
-		ath79_ip2_handler = ar71xx_ip2_handler;
-		ath79_ip3_handler = ar71xx_ip3_handler;
-	} else if (soc_is_ar724x()) {
-		ath79_ip2_handler = ar724x_ip2_handler;
-		ath79_ip3_handler = ar724x_ip3_handler;
-	} else if (soc_is_ar913x()) {
-		ath79_ip2_handler = ar913x_ip2_handler;
-		ath79_ip3_handler = ar913x_ip3_handler;
-	} else if (soc_is_ar933x()) {
-		ath79_ip2_handler = ar933x_ip2_handler;
-		ath79_ip3_handler = ar933x_ip3_handler;
+	if (soc_is_ar71xx() || soc_is_ar724x() ||
+	    soc_is_ar913x() || soc_is_ar933x()) {
+		irq_wb_chan[2] = 3;
+		irq_wb_chan[3] = 2;
 	} else if (soc_is_ar934x()) {
-		ath79_ip2_handler = ath79_default_ip2_handler;
-		ath79_ip3_handler = ar934x_ip3_handler;
-	} else if (soc_is_qca955x()) {
-		ath79_ip2_handler = ath79_default_ip2_handler;
-		ath79_ip3_handler = ath79_default_ip3_handler;
-	} else {
-		BUG();
+		irq_wb_chan[3] = 2;
 	}
 
 	mips_cpu_irq_init();
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 7fc8397..74f1af7 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -200,8 +200,7 @@ void __init plat_mem_setup(void)
 					   AR71XX_RESET_SIZE);
 	ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
 					 AR71XX_PLL_SIZE);
-	ath79_ddr_base = ioremap_nocache(AR71XX_DDR_CTRL_BASE,
-					 AR71XX_DDR_CTRL_SIZE);
+	ath79_ddr_ctrl_init();
 
 	ath79_detect_sys_type();
 	detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
diff --git a/arch/mips/include/asm/mach-ath79/ath79.h b/arch/mips/include/asm/mach-ath79/ath79.h
index 1557934..4eee221 100644
--- a/arch/mips/include/asm/mach-ath79/ath79.h
+++ b/arch/mips/include/asm/mach-ath79/ath79.h
@@ -115,7 +115,8 @@ static inline int soc_is_qca955x(void)
 	return soc_is_qca9556() || soc_is_qca9558();
 }
 
-extern void __iomem *ath79_ddr_base;
+void ath79_ddr_set_pci_windows(void);
+
 extern void __iomem *ath79_pll_base;
 extern void __iomem *ath79_reset_base;
 
diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index 9e62ad3..72764d8 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -326,15 +326,7 @@ static void ar71xx_pci_reset(void)
 	ath79_device_reset_clear(AR71XX_RESET_PCI_BUS | AR71XX_RESET_PCI_CORE);
 	mdelay(100);
 
-	__raw_writel(AR71XX_PCI_WIN0_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN0);
-	__raw_writel(AR71XX_PCI_WIN1_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN1);
-	__raw_writel(AR71XX_PCI_WIN2_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN2);
-	__raw_writel(AR71XX_PCI_WIN3_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN3);
-	__raw_writel(AR71XX_PCI_WIN4_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN4);
-	__raw_writel(AR71XX_PCI_WIN5_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN5);
-	__raw_writel(AR71XX_PCI_WIN6_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN6);
-	__raw_writel(AR71XX_PCI_WIN7_OFFS, ddr_base + AR71XX_DDR_REG_PCI_WIN7);
-
+	ath79_ddr_set_pci_windows();
 	mdelay(100);
 }
 
-- 
2.0.0
