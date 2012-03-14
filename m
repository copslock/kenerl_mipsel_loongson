Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2012 10:41:46 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:34357 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903728Ab2CNJkL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Mar 2012 10:40:11 +0100
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A8CB223C00CC;
        Wed, 14 Mar 2012 10:09:30 +0100 (CET)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        mcgrof@infradead.org, juhosg@openwrt.org
Subject: [PATCH v2 04/13] MIPS: ath79: add clock initialization code for AR934X
Date:   Wed, 14 Mar 2012 11:45:22 +0100
Message-Id: <1331721931-4334-5-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
References: <1331721931-4334-1-git-send-email-juhosg@openwrt.org>
X-archive-position: 32697
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

 arch/mips/ath79/clock.c                        |   81 ++++++++++++++++++++++++
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h |   53 +++++++++++++++
 2 files changed, 134 insertions(+), 0 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 54d0eb4..b91ad3e 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -1,8 +1,11 @@
 /*
  *  Atheros AR71XX/AR724X/AR913X common routines
  *
+ *  Copyright (C) 2010-2011 Jaiganesh Narayanan <jnarayanan@atheros.com>
  *  Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
  *
+ *  Parts of this file are based on Atheros' 2.6.15/2.6.31 BSP
+ *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
@@ -163,6 +166,82 @@ static void __init ar933x_clocks_init(void)
 	ath79_uart_clk.rate = ath79_ref_clk.rate;
 }
 
+static void __init ar934x_clocks_init(void)
+{
+	u32 pll, out_div, ref_div, nint, frac, clk_ctrl, postdiv;
+	u32 cpu_pll, ddr_pll;
+	u32 bootstrap;
+
+	bootstrap = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
+	if (bootstrap &	AR934X_BOOTSTRAP_REF_CLK_40)
+		ath79_ref_clk.rate = 40 * 1000 * 1000;
+	else
+		ath79_ref_clk.rate = 25 * 1000 * 1000;
+
+	pll = ath79_pll_rr(AR934X_PLL_CPU_CONFIG_REG);
+	out_div = (pll >> AR934X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
+		  AR934X_PLL_CPU_CONFIG_OUTDIV_MASK;
+	ref_div = (pll >> AR934X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
+		  AR934X_PLL_CPU_CONFIG_REFDIV_MASK;
+	nint = (pll >> AR934X_PLL_CPU_CONFIG_NINT_SHIFT) &
+	       AR934X_PLL_CPU_CONFIG_NINT_MASK;
+	frac = (pll >> AR934X_PLL_CPU_CONFIG_NFRAC_SHIFT) &
+	       AR934X_PLL_CPU_CONFIG_NFRAC_MASK;
+
+	cpu_pll = nint * ath79_ref_clk.rate / ref_div;
+	cpu_pll += frac * ath79_ref_clk.rate / (ref_div * (2 << 6));
+	cpu_pll /= (1 << out_div);
+
+	pll = ath79_pll_rr(AR934X_PLL_DDR_CONFIG_REG);
+	out_div = (pll >> AR934X_PLL_DDR_CONFIG_OUTDIV_SHIFT) &
+		  AR934X_PLL_DDR_CONFIG_OUTDIV_MASK;
+	ref_div = (pll >> AR934X_PLL_DDR_CONFIG_REFDIV_SHIFT) &
+		  AR934X_PLL_DDR_CONFIG_REFDIV_MASK;
+	nint = (pll >> AR934X_PLL_DDR_CONFIG_NINT_SHIFT) &
+	       AR934X_PLL_DDR_CONFIG_NINT_MASK;
+	frac = (pll >> AR934X_PLL_DDR_CONFIG_NFRAC_SHIFT) &
+	       AR934X_PLL_DDR_CONFIG_NFRAC_MASK;
+
+	ddr_pll = nint * ath79_ref_clk.rate / ref_div;
+	ddr_pll += frac * ath79_ref_clk.rate / (ref_div * (2 << 10));
+	ddr_pll /= (1 << out_div);
+
+	clk_ctrl = ath79_pll_rr(AR934X_PLL_CPU_DDR_CLK_CTRL_REG);
+
+	postdiv = (clk_ctrl >> AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_POST_DIV_SHIFT) &
+		  AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_POST_DIV_MASK;
+
+	if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_PLL_BYPASS)
+		ath79_cpu_clk.rate = ath79_ref_clk.rate;
+	else if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_CPUCLK_FROM_CPUPLL)
+		ath79_cpu_clk.rate = cpu_pll / (postdiv + 1);
+	else
+		ath79_cpu_clk.rate = ddr_pll / (postdiv + 1);
+
+	postdiv = (clk_ctrl >> AR934X_PLL_CPU_DDR_CLK_CTRL_DDR_POST_DIV_SHIFT) &
+		  AR934X_PLL_CPU_DDR_CLK_CTRL_DDR_POST_DIV_MASK;
+
+	if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_DDR_PLL_BYPASS)
+		ath79_ddr_clk.rate = ath79_ref_clk.rate;
+	else if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_DDRCLK_FROM_DDRPLL)
+		ath79_ddr_clk.rate = ddr_pll / (postdiv + 1);
+	else
+		ath79_ddr_clk.rate = cpu_pll / (postdiv + 1);
+
+	postdiv = (clk_ctrl >> AR934X_PLL_CPU_DDR_CLK_CTRL_AHB_POST_DIV_SHIFT) &
+		  AR934X_PLL_CPU_DDR_CLK_CTRL_AHB_POST_DIV_MASK;
+
+	if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_AHB_PLL_BYPASS)
+		ath79_ahb_clk.rate = ath79_ref_clk.rate;
+	else if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_AHBCLK_FROM_DDRPLL)
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
@@ -173,6 +252,8 @@ void __init ath79_clocks_init(void)
 		ar913x_clocks_init();
 	else if (soc_is_ar933x())
 		ar933x_clocks_init();
+	else if (soc_is_ar934x())
+		ar934x_clocks_init();
 	else
 		BUG();
 
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index 4e3c55d..bc1c345 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -151,6 +151,41 @@
 #define AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT	15
 #define AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK	0x7
 
+#define AR934X_PLL_CPU_CONFIG_REG		0x00
+#define AR934X_PLL_DDR_CONFIG_REG		0x04
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_REG		0x08
+
+#define AR934X_PLL_CPU_CONFIG_NFRAC_SHIFT	0
+#define AR934X_PLL_CPU_CONFIG_NFRAC_MASK	0x3f
+#define AR934X_PLL_CPU_CONFIG_NINT_SHIFT	6
+#define AR934X_PLL_CPU_CONFIG_NINT_MASK		0x3f
+#define AR934X_PLL_CPU_CONFIG_REFDIV_SHIFT	12
+#define AR934X_PLL_CPU_CONFIG_REFDIV_MASK	0x1f
+#define AR934X_PLL_CPU_CONFIG_OUTDIV_SHIFT	19
+#define AR934X_PLL_CPU_CONFIG_OUTDIV_MASK	0x3
+
+#define AR934X_PLL_DDR_CONFIG_NFRAC_SHIFT	0
+#define AR934X_PLL_DDR_CONFIG_NFRAC_MASK	0x3ff
+#define AR934X_PLL_DDR_CONFIG_NINT_SHIFT	10
+#define AR934X_PLL_DDR_CONFIG_NINT_MASK		0x3f
+#define AR934X_PLL_DDR_CONFIG_REFDIV_SHIFT	16
+#define AR934X_PLL_DDR_CONFIG_REFDIV_MASK	0x1f
+#define AR934X_PLL_DDR_CONFIG_OUTDIV_SHIFT	23
+#define AR934X_PLL_DDR_CONFIG_OUTDIV_MASK	0x7
+
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_PLL_BYPASS	BIT(2)
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_DDR_PLL_BYPASS	BIT(3)
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_AHB_PLL_BYPASS	BIT(4)
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_POST_DIV_SHIFT	5
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_POST_DIV_MASK	0x1f
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_DDR_POST_DIV_SHIFT	10
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_DDR_POST_DIV_MASK	0x1f
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_AHB_POST_DIV_SHIFT	15
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_AHB_POST_DIV_MASK	0x1f
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_CPUCLK_FROM_CPUPLL	BIT(20)
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_DDRCLK_FROM_DDRPLL	BIT(21)
+#define AR934X_PLL_CPU_DDR_CLK_CTRL_AHBCLK_FROM_DDRPLL	BIT(24)
+
 /*
  * USB_CONFIG block
  */
@@ -186,6 +221,8 @@
 #define AR933X_RESET_REG_RESET_MODULE		0x1c
 #define AR933X_RESET_REG_BOOTSTRAP		0xac
 
+#define AR934X_RESET_REG_BOOTSTRAP		0xb0
+
 #define MISC_INT_ETHSW			BIT(12)
 #define MISC_INT_TIMER4			BIT(10)
 #define MISC_INT_TIMER3			BIT(9)
@@ -242,6 +279,22 @@
 
 #define AR933X_BOOTSTRAP_REF_CLK_40	BIT(0)
 
+#define AR934X_BOOTSTRAP_SW_OPTION8	BIT(23)
+#define AR934X_BOOTSTRAP_SW_OPTION7	BIT(22)
+#define AR934X_BOOTSTRAP_SW_OPTION6	BIT(21)
+#define AR934X_BOOTSTRAP_SW_OPTION5	BIT(20)
+#define AR934X_BOOTSTRAP_SW_OPTION4	BIT(19)
+#define AR934X_BOOTSTRAP_SW_OPTION3	BIT(18)
+#define AR934X_BOOTSTRAP_SW_OPTION2	BIT(17)
+#define AR934X_BOOTSTRAP_SW_OPTION1	BIT(16)
+#define AR934X_BOOTSTRAP_USB_MODE_DEVICE BIT(7)
+#define AR934X_BOOTSTRAP_PCIE_RC	BIT(6)
+#define AR934X_BOOTSTRAP_EJTAG_MODE	BIT(5)
+#define AR934X_BOOTSTRAP_REF_CLK_40	BIT(4)
+#define AR934X_BOOTSTRAP_BOOT_FROM_SPI	BIT(2)
+#define AR934X_BOOTSTRAP_SDRAM_DISABLED	BIT(1)
+#define AR934X_BOOTSTRAP_DDR1		BIT(0)
+
 #define REV_ID_MAJOR_MASK		0xfff0
 #define REV_ID_MAJOR_AR71XX		0x00a0
 #define REV_ID_MAJOR_AR913X		0x00b0
-- 
1.7.2.1
