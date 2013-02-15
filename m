Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 15:39:41 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:58586 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827506Ab3BOOibdCss5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 15:38:31 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b1Dcv167nEEL; Fri, 15 Feb 2013 15:38:20 +0100 (CET)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5BCAF2801AE;
        Fri, 15 Feb 2013 15:38:20 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: [PATCH 03/11] MIPS: ath79: add clock setup code for the QCA955X SoCs
Date:   Fri, 15 Feb 2013 15:38:17 +0100
Message-Id: <1360939105-23591-4-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 35756
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

The patch adds code to get various clock frequencies
from the PLLs used in the QCA955x SoCs.

Cc: Rodriguez, Luis <rodrigue@qca.qualcomm.com>
Cc: Giori, Kathy <kgiori@qca.qualcomm.com>
Cc: QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/clock.c                        |   78 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   39 ++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 579f452..555e603 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -295,6 +295,82 @@ static void __init ar934x_clocks_init(void)
 	iounmap(dpll_base);
 }
 
+static void __init qca955x_clocks_init(void)
+{
+	u32 pll, out_div, ref_div, nint, frac, clk_ctrl, postdiv;
+	u32 cpu_pll, ddr_pll;
+	u32 bootstrap;
+
+	bootstrap = ath79_reset_rr(QCA955X_RESET_REG_BOOTSTRAP);
+	if (bootstrap &	QCA955X_BOOTSTRAP_REF_CLK_40)
+		ath79_ref_clk.rate = 40 * 1000 * 1000;
+	else
+		ath79_ref_clk.rate = 25 * 1000 * 1000;
+
+	pll = ath79_pll_rr(QCA955X_PLL_CPU_CONFIG_REG);
+	out_div = (pll >> QCA955X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
+		  QCA955X_PLL_CPU_CONFIG_OUTDIV_MASK;
+	ref_div = (pll >> QCA955X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
+		  QCA955X_PLL_CPU_CONFIG_REFDIV_MASK;
+	nint = (pll >> QCA955X_PLL_CPU_CONFIG_NINT_SHIFT) &
+	       QCA955X_PLL_CPU_CONFIG_NINT_MASK;
+	frac = (pll >> QCA955X_PLL_CPU_CONFIG_NFRAC_SHIFT) &
+	       QCA955X_PLL_CPU_CONFIG_NFRAC_MASK;
+
+	cpu_pll = nint * ath79_ref_clk.rate / ref_div;
+	cpu_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 6));
+	cpu_pll /= (1 << out_div);
+
+	pll = ath79_pll_rr(QCA955X_PLL_DDR_CONFIG_REG);
+	out_div = (pll >> QCA955X_PLL_DDR_CONFIG_OUTDIV_SHIFT) &
+		  QCA955X_PLL_DDR_CONFIG_OUTDIV_MASK;
+	ref_div = (pll >> QCA955X_PLL_DDR_CONFIG_REFDIV_SHIFT) &
+		  QCA955X_PLL_DDR_CONFIG_REFDIV_MASK;
+	nint = (pll >> QCA955X_PLL_DDR_CONFIG_NINT_SHIFT) &
+	       QCA955X_PLL_DDR_CONFIG_NINT_MASK;
+	frac = (pll >> QCA955X_PLL_DDR_CONFIG_NFRAC_SHIFT) &
+	       QCA955X_PLL_DDR_CONFIG_NFRAC_MASK;
+
+	ddr_pll = nint * ath79_ref_clk.rate / ref_div;
+	ddr_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 10));
+	ddr_pll /= (1 << out_div);
+
+	clk_ctrl = ath79_pll_rr(QCA955X_PLL_CLK_CTRL_REG);
+
+	postdiv = (clk_ctrl >> QCA955X_PLL_CLK_CTRL_CPU_POST_DIV_SHIFT) &
+		  QCA955X_PLL_CLK_CTRL_CPU_POST_DIV_MASK;
+
+	if (clk_ctrl & QCA955X_PLL_CLK_CTRL_CPU_PLL_BYPASS)
+		ath79_cpu_clk.rate = ath79_ref_clk.rate;
+	else if (clk_ctrl & QCA955X_PLL_CLK_CTRL_CPUCLK_FROM_CPUPLL)
+		ath79_cpu_clk.rate = ddr_pll / (postdiv + 1);
+	else
+		ath79_cpu_clk.rate = cpu_pll / (postdiv + 1);
+
+	postdiv = (clk_ctrl >> QCA955X_PLL_CLK_CTRL_DDR_POST_DIV_SHIFT) &
+		  QCA955X_PLL_CLK_CTRL_DDR_POST_DIV_MASK;
+
+	if (clk_ctrl & QCA955X_PLL_CLK_CTRL_DDR_PLL_BYPASS)
+		ath79_ddr_clk.rate = ath79_ref_clk.rate;
+	else if (clk_ctrl & QCA955X_PLL_CLK_CTRL_DDRCLK_FROM_DDRPLL)
+		ath79_ddr_clk.rate = cpu_pll / (postdiv + 1);
+	else
+		ath79_ddr_clk.rate = ddr_pll / (postdiv + 1);
+
+	postdiv = (clk_ctrl >> QCA955X_PLL_CLK_CTRL_AHB_POST_DIV_SHIFT) &
+		  QCA955X_PLL_CLK_CTRL_AHB_POST_DIV_MASK;
+
+	if (clk_ctrl & QCA955X_PLL_CLK_CTRL_AHB_PLL_BYPASS)
+		ath79_ahb_clk.rate = ath79_ref_clk.rate;
+	else if (clk_ctrl & QCA955X_PLL_CLK_CTRL_AHBCLK_FROM_DDRPLL)
+		ath79_ahb_clk.rate = ddr_pll / (postdiv + 1);
+	else
+		ath79_ahb_clk.rate = cpu_pll / (postdiv + 1);
+
+	ath79_wdt_clk.rate = ath79_ref_clk.rate;
+	ath79_uart_clk.rate = ath79_ref_clk.rate;
+}
+
 void __init ath79_clocks_init(void)
 {
 	if (soc_is_ar71xx())
@@ -307,6 +383,8 @@ void __init ath79_clocks_init(void)
 		ar933x_clocks_init();
 	else if (soc_is_ar934x())
 		ar934x_clocks_init();
+	else if (soc_is_qca955x())
+		qca955x_clocks_init();
 	else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 63a9f2b..7b00e12 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -225,6 +225,41 @@
 #define AR934X_PLL_CPU_DDR_CLK_CTRL_DDRCLK_FROM_DDRPLL	BIT(21)
 #define AR934X_PLL_CPU_DDR_CLK_CTRL_AHBCLK_FROM_DDRPLL	BIT(24)
 
+#define QCA955X_PLL_CPU_CONFIG_REG		0x00
+#define QCA955X_PLL_DDR_CONFIG_REG		0x04
+#define QCA955X_PLL_CLK_CTRL_REG		0x08
+
+#define QCA955X_PLL_CPU_CONFIG_NFRAC_SHIFT	0
+#define QCA955X_PLL_CPU_CONFIG_NFRAC_MASK	0x3f
+#define QCA955X_PLL_CPU_CONFIG_NINT_SHIFT	6
+#define QCA955X_PLL_CPU_CONFIG_NINT_MASK	0x3f
+#define QCA955X_PLL_CPU_CONFIG_REFDIV_SHIFT	12
+#define QCA955X_PLL_CPU_CONFIG_REFDIV_MASK	0x1f
+#define QCA955X_PLL_CPU_CONFIG_OUTDIV_SHIFT	19
+#define QCA955X_PLL_CPU_CONFIG_OUTDIV_MASK	0x3
+
+#define QCA955X_PLL_DDR_CONFIG_NFRAC_SHIFT	0
+#define QCA955X_PLL_DDR_CONFIG_NFRAC_MASK	0x3ff
+#define QCA955X_PLL_DDR_CONFIG_NINT_SHIFT	10
+#define QCA955X_PLL_DDR_CONFIG_NINT_MASK	0x3f
+#define QCA955X_PLL_DDR_CONFIG_REFDIV_SHIFT	16
+#define QCA955X_PLL_DDR_CONFIG_REFDIV_MASK	0x1f
+#define QCA955X_PLL_DDR_CONFIG_OUTDIV_SHIFT	23
+#define QCA955X_PLL_DDR_CONFIG_OUTDIV_MASK	0x7
+
+#define QCA955X_PLL_CLK_CTRL_CPU_PLL_BYPASS		BIT(2)
+#define QCA955X_PLL_CLK_CTRL_DDR_PLL_BYPASS		BIT(3)
+#define QCA955X_PLL_CLK_CTRL_AHB_PLL_BYPASS		BIT(4)
+#define QCA955X_PLL_CLK_CTRL_CPU_POST_DIV_SHIFT		5
+#define QCA955X_PLL_CLK_CTRL_CPU_POST_DIV_MASK		0x1f
+#define QCA955X_PLL_CLK_CTRL_DDR_POST_DIV_SHIFT		10
+#define QCA955X_PLL_CLK_CTRL_DDR_POST_DIV_MASK		0x1f
+#define QCA955X_PLL_CLK_CTRL_AHB_POST_DIV_SHIFT		15
+#define QCA955X_PLL_CLK_CTRL_AHB_POST_DIV_MASK		0x1f
+#define QCA955X_PLL_CLK_CTRL_CPUCLK_FROM_CPUPLL		BIT(20)
+#define QCA955X_PLL_CLK_CTRL_DDRCLK_FROM_DDRPLL		BIT(21)
+#define QCA955X_PLL_CLK_CTRL_AHBCLK_FROM_DDRPLL		BIT(24)
+
 /*
  * USB_CONFIG block
  */
@@ -264,6 +299,8 @@
 #define AR934X_RESET_REG_BOOTSTRAP		0xb0
 #define AR934X_RESET_REG_PCIE_WMAC_INT_STATUS	0xac
 
+#define QCA955X_RESET_REG_BOOTSTRAP		0xb0
+
 #define MISC_INT_ETHSW			BIT(12)
 #define MISC_INT_TIMER4			BIT(10)
 #define MISC_INT_TIMER3			BIT(9)
@@ -341,6 +378,8 @@
 #define AR934X_BOOTSTRAP_SDRAM_DISABLED	BIT(1)
 #define AR934X_BOOTSTRAP_DDR1		BIT(0)
 
+#define QCA955X_BOOTSTRAP_REF_CLK_40	BIT(4)
+
 #define AR934X_PCIE_WMAC_INT_WMAC_MISC		BIT(0)
 #define AR934X_PCIE_WMAC_INT_WMAC_TX		BIT(1)
 #define AR934X_PCIE_WMAC_INT_WMAC_RXLP		BIT(2)
-- 
1.7.10
