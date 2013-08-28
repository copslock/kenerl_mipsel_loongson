Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Aug 2013 10:43:39 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55254 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819313Ab3H1IlxdCIXL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Aug 2013 10:41:53 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 74BB0280861;
        Wed, 28 Aug 2013 10:41:19 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 28 Aug 2013 10:41:19 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 5/6] MIPS: ath79: use local variables for clock rates
Date:   Wed, 28 Aug 2013 10:41:46 +0200
Message-Id: <1377679307-429-6-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
References: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37701
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

Use local variables for ref, cpu, ddr and ahb
rates in SoC specific clock init functions.

The patch has no functional changes, it is
an interim change in preparation of the next
patch.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/clock.c |  158 +++++++++++++++++++++++++++++++----------------
 1 file changed, 106 insertions(+), 52 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index ebd4340..375cb77 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -40,25 +40,34 @@ static struct clk ath79_uart_clk;
 
 static void __init ar71xx_clocks_init(void)
 {
+	unsigned long ref_rate;
+	unsigned long cpu_rate;
+	unsigned long ddr_rate;
+	unsigned long ahb_rate;
 	u32 pll;
 	u32 freq;
 	u32 div;
 
-	ath79_ref_clk.rate = AR71XX_BASE_FREQ;
+	ref_rate = AR71XX_BASE_FREQ;
 
 	pll = ath79_pll_rr(AR71XX_PLL_REG_CPU_CONFIG);
 
 	div = ((pll >> AR71XX_PLL_DIV_SHIFT) & AR71XX_PLL_DIV_MASK) + 1;
-	freq = div * ath79_ref_clk.rate;
+	freq = div * ref_rate;
 
 	div = ((pll >> AR71XX_CPU_DIV_SHIFT) & AR71XX_CPU_DIV_MASK) + 1;
-	ath79_cpu_clk.rate = freq / div;
+	cpu_rate = freq / div;
 
 	div = ((pll >> AR71XX_DDR_DIV_SHIFT) & AR71XX_DDR_DIV_MASK) + 1;
-	ath79_ddr_clk.rate = freq / div;
+	ddr_rate = freq / div;
 
 	div = (((pll >> AR71XX_AHB_DIV_SHIFT) & AR71XX_AHB_DIV_MASK) + 1) * 2;
-	ath79_ahb_clk.rate = ath79_cpu_clk.rate / div;
+	ahb_rate = cpu_rate / div;
+
+	ath79_ref_clk.rate = ref_rate;
+	ath79_cpu_clk.rate = cpu_rate;
+	ath79_ddr_clk.rate = ddr_rate;
+	ath79_ahb_clk.rate = ahb_rate;
 
 	ath79_wdt_clk.rate = ath79_ahb_clk.rate;
 	ath79_uart_clk.rate = ath79_ahb_clk.rate;
@@ -66,26 +75,35 @@ static void __init ar71xx_clocks_init(void)
 
 static void __init ar724x_clocks_init(void)
 {
+	unsigned long ref_rate;
+	unsigned long cpu_rate;
+	unsigned long ddr_rate;
+	unsigned long ahb_rate;
 	u32 pll;
 	u32 freq;
 	u32 div;
 
-	ath79_ref_clk.rate = AR724X_BASE_FREQ;
+	ref_rate = AR724X_BASE_FREQ;
 	pll = ath79_pll_rr(AR724X_PLL_REG_CPU_CONFIG);
 
 	div = ((pll >> AR724X_PLL_DIV_SHIFT) & AR724X_PLL_DIV_MASK);
-	freq = div * ath79_ref_clk.rate;
+	freq = div * ref_rate;
 
 	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK);
 	freq *= div;
 
-	ath79_cpu_clk.rate = freq;
+	cpu_rate = freq;
 
 	div = ((pll >> AR724X_DDR_DIV_SHIFT) & AR724X_DDR_DIV_MASK) + 1;
-	ath79_ddr_clk.rate = freq / div;
+	ddr_rate = freq / div;
 
 	div = (((pll >> AR724X_AHB_DIV_SHIFT) & AR724X_AHB_DIV_MASK) + 1) * 2;
-	ath79_ahb_clk.rate = ath79_cpu_clk.rate / div;
+	ahb_rate = cpu_rate / div;
+
+	ath79_ref_clk.rate = ref_rate;
+	ath79_cpu_clk.rate = cpu_rate;
+	ath79_ddr_clk.rate = ddr_rate;
+	ath79_ahb_clk.rate = ahb_rate;
 
 	ath79_wdt_clk.rate = ath79_ahb_clk.rate;
 	ath79_uart_clk.rate = ath79_ahb_clk.rate;
@@ -93,23 +111,32 @@ static void __init ar724x_clocks_init(void)
 
 static void __init ar913x_clocks_init(void)
 {
+	unsigned long ref_rate;
+	unsigned long cpu_rate;
+	unsigned long ddr_rate;
+	unsigned long ahb_rate;
 	u32 pll;
 	u32 freq;
 	u32 div;
 
-	ath79_ref_clk.rate = AR913X_BASE_FREQ;
+	ref_rate = AR913X_BASE_FREQ;
 	pll = ath79_pll_rr(AR913X_PLL_REG_CPU_CONFIG);
 
 	div = ((pll >> AR913X_PLL_DIV_SHIFT) & AR913X_PLL_DIV_MASK);
-	freq = div * ath79_ref_clk.rate;
+	freq = div * ref_rate;
 
-	ath79_cpu_clk.rate = freq;
+	cpu_rate = freq;
 
 	div = ((pll >> AR913X_DDR_DIV_SHIFT) & AR913X_DDR_DIV_MASK) + 1;
-	ath79_ddr_clk.rate = freq / div;
+	ddr_rate = freq / div;
 
 	div = (((pll >> AR913X_AHB_DIV_SHIFT) & AR913X_AHB_DIV_MASK) + 1) * 2;
-	ath79_ahb_clk.rate = ath79_cpu_clk.rate / div;
+	ahb_rate = cpu_rate / div;
+
+	ath79_ref_clk.rate = ref_rate;
+	ath79_cpu_clk.rate = cpu_rate;
+	ath79_ddr_clk.rate = ddr_rate;
+	ath79_ahb_clk.rate = ahb_rate;
 
 	ath79_wdt_clk.rate = ath79_ahb_clk.rate;
 	ath79_uart_clk.rate = ath79_ahb_clk.rate;
@@ -117,6 +144,10 @@ static void __init ar913x_clocks_init(void)
 
 static void __init ar933x_clocks_init(void)
 {
+	unsigned long ref_rate;
+	unsigned long cpu_rate;
+	unsigned long ddr_rate;
+	unsigned long ahb_rate;
 	u32 clock_ctrl;
 	u32 cpu_config;
 	u32 freq;
@@ -124,21 +155,21 @@ static void __init ar933x_clocks_init(void)
 
 	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
 	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
-		ath79_ref_clk.rate = (40 * 1000 * 1000);
+		ref_rate = (40 * 1000 * 1000);
 	else
-		ath79_ref_clk.rate = (25 * 1000 * 1000);
+		ref_rate = (25 * 1000 * 1000);
 
 	clock_ctrl = ath79_pll_rr(AR933X_PLL_CLOCK_CTRL_REG);
 	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
-		ath79_cpu_clk.rate = ath79_ref_clk.rate;
-		ath79_ahb_clk.rate = ath79_ref_clk.rate;
-		ath79_ddr_clk.rate = ath79_ref_clk.rate;
+		cpu_rate = ref_rate;
+		ahb_rate = ref_rate;
+		ddr_rate = ref_rate;
 	} else {
 		cpu_config = ath79_pll_rr(AR933X_PLL_CPU_CONFIG_REG);
 
 		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
 		    AR933X_PLL_CPU_CONFIG_REFDIV_MASK;
-		freq = ath79_ref_clk.rate / t;
+		freq = ref_rate / t;
 
 		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_NINT_SHIFT) &
 		    AR933X_PLL_CPU_CONFIG_NINT_MASK;
@@ -153,17 +184,22 @@ static void __init ar933x_clocks_init(void)
 
 		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_CPU_DIV_SHIFT) &
 		     AR933X_PLL_CLOCK_CTRL_CPU_DIV_MASK) + 1;
-		ath79_cpu_clk.rate = freq / t;
+		cpu_rate = freq / t;
 
 		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_DDR_DIV_SHIFT) &
 		      AR933X_PLL_CLOCK_CTRL_DDR_DIV_MASK) + 1;
-		ath79_ddr_clk.rate = freq / t;
+		ddr_rate = freq / t;
 
 		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT) &
 		     AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK) + 1;
-		ath79_ahb_clk.rate = freq / t;
+		ahb_rate = freq / t;
 	}
 
+	ath79_ref_clk.rate = ref_rate;
+	ath79_cpu_clk.rate = cpu_rate;
+	ath79_ddr_clk.rate = ddr_rate;
+	ath79_ahb_clk.rate = ahb_rate;
+
 	ath79_wdt_clk.rate = ath79_ahb_clk.rate;
 	ath79_uart_clk.rate = ath79_ref_clk.rate;
 }
@@ -190,6 +226,10 @@ static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
 
 static void __init ar934x_clocks_init(void)
 {
+	unsigned long ref_rate;
+	unsigned long cpu_rate;
+	unsigned long ddr_rate;
+	unsigned long ahb_rate;
 	u32 pll, out_div, ref_div, nint, nfrac, frac, clk_ctrl, postdiv;
 	u32 cpu_pll, ddr_pll;
 	u32 bootstrap;
@@ -199,9 +239,9 @@ static void __init ar934x_clocks_init(void)
 
 	bootstrap = ath79_reset_rr(AR934X_RESET_REG_BOOTSTRAP);
 	if (bootstrap & AR934X_BOOTSTRAP_REF_CLK_40)
-		ath79_ref_clk.rate = 40 * 1000 * 1000;
+		ref_rate = 40 * 1000 * 1000;
 	else
-		ath79_ref_clk.rate = 25 * 1000 * 1000;
+		ref_rate = 25 * 1000 * 1000;
 
 	pll = __raw_readl(dpll_base + AR934X_SRIF_CPU_DPLL2_REG);
 	if (pll & AR934X_SRIF_DPLL2_LOCAL_PLL) {
@@ -227,7 +267,7 @@ static void __init ar934x_clocks_init(void)
 		frac = 1 << 6;
 	}
 
-	cpu_pll = ar934x_get_pll_freq(ath79_ref_clk.rate, ref_div, nint,
+	cpu_pll = ar934x_get_pll_freq(ref_rate, ref_div, nint,
 				      nfrac, frac, out_div);
 
 	pll = __raw_readl(dpll_base + AR934X_SRIF_DDR_DPLL2_REG);
@@ -254,7 +294,7 @@ static void __init ar934x_clocks_init(void)
 		frac = 1 << 10;
 	}
 
-	ddr_pll = ar934x_get_pll_freq(ath79_ref_clk.rate, ref_div, nint,
+	ddr_pll = ar934x_get_pll_freq(ref_rate, ref_div, nint,
 				      nfrac, frac, out_div);
 
 	clk_ctrl = ath79_pll_rr(AR934X_PLL_CPU_DDR_CLK_CTRL_REG);
@@ -263,31 +303,36 @@ static void __init ar934x_clocks_init(void)
 		  AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_POST_DIV_MASK;
 
 	if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_CPU_PLL_BYPASS)
-		ath79_cpu_clk.rate = ath79_ref_clk.rate;
+		cpu_rate = ref_rate;
 	else if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_CPUCLK_FROM_CPUPLL)
-		ath79_cpu_clk.rate = cpu_pll / (postdiv + 1);
+		cpu_rate = cpu_pll / (postdiv + 1);
 	else
-		ath79_cpu_clk.rate = ddr_pll / (postdiv + 1);
+		cpu_rate = ddr_pll / (postdiv + 1);
 
 	postdiv = (clk_ctrl >> AR934X_PLL_CPU_DDR_CLK_CTRL_DDR_POST_DIV_SHIFT) &
 		  AR934X_PLL_CPU_DDR_CLK_CTRL_DDR_POST_DIV_MASK;
 
 	if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_DDR_PLL_BYPASS)
-		ath79_ddr_clk.rate = ath79_ref_clk.rate;
+		ddr_rate = ref_rate;
 	else if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_DDRCLK_FROM_DDRPLL)
-		ath79_ddr_clk.rate = ddr_pll / (postdiv + 1);
+		ddr_rate = ddr_pll / (postdiv + 1);
 	else
-		ath79_ddr_clk.rate = cpu_pll / (postdiv + 1);
+		ddr_rate = cpu_pll / (postdiv + 1);
 
 	postdiv = (clk_ctrl >> AR934X_PLL_CPU_DDR_CLK_CTRL_AHB_POST_DIV_SHIFT) &
 		  AR934X_PLL_CPU_DDR_CLK_CTRL_AHB_POST_DIV_MASK;
 
 	if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_AHB_PLL_BYPASS)
-		ath79_ahb_clk.rate = ath79_ref_clk.rate;
+		ahb_rate = ref_rate;
 	else if (clk_ctrl & AR934X_PLL_CPU_DDR_CLK_CTRL_AHBCLK_FROM_DDRPLL)
-		ath79_ahb_clk.rate = ddr_pll / (postdiv + 1);
+		ahb_rate = ddr_pll / (postdiv + 1);
 	else
-		ath79_ahb_clk.rate = cpu_pll / (postdiv + 1);
+		ahb_rate = cpu_pll / (postdiv + 1);
+
+	ath79_ref_clk.rate = ref_rate;
+	ath79_cpu_clk.rate = cpu_rate;
+	ath79_ddr_clk.rate = ddr_rate;
+	ath79_ahb_clk.rate = ahb_rate;
 
 	ath79_wdt_clk.rate = ath79_ref_clk.rate;
 	ath79_uart_clk.rate = ath79_ref_clk.rate;
@@ -297,15 +342,19 @@ static void __init ar934x_clocks_init(void)
 
 static void __init qca955x_clocks_init(void)
 {
+	unsigned long ref_rate;
+	unsigned long cpu_rate;
+	unsigned long ddr_rate;
+	unsigned long ahb_rate;
 	u32 pll, out_div, ref_div, nint, frac, clk_ctrl, postdiv;
 	u32 cpu_pll, ddr_pll;
 	u32 bootstrap;
 
 	bootstrap = ath79_reset_rr(QCA955X_RESET_REG_BOOTSTRAP);
 	if (bootstrap &	QCA955X_BOOTSTRAP_REF_CLK_40)
-		ath79_ref_clk.rate = 40 * 1000 * 1000;
+		ref_rate = 40 * 1000 * 1000;
 	else
-		ath79_ref_clk.rate = 25 * 1000 * 1000;
+		ref_rate = 25 * 1000 * 1000;
 
 	pll = ath79_pll_rr(QCA955X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA955X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
@@ -317,8 +366,8 @@ static void __init qca955x_clocks_init(void)
 	frac = (pll >> QCA955X_PLL_CPU_CONFIG_NFRAC_SHIFT) &
 	       QCA955X_PLL_CPU_CONFIG_NFRAC_MASK;
 
-	cpu_pll = nint * ath79_ref_clk.rate / ref_div;
-	cpu_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 6));
+	cpu_pll = nint * ref_rate / ref_div;
+	cpu_pll += frac * ref_rate / (ref_div * (1 << 6));
 	cpu_pll /= (1 << out_div);
 
 	pll = ath79_pll_rr(QCA955X_PLL_DDR_CONFIG_REG);
@@ -331,8 +380,8 @@ static void __init qca955x_clocks_init(void)
 	frac = (pll >> QCA955X_PLL_DDR_CONFIG_NFRAC_SHIFT) &
 	       QCA955X_PLL_DDR_CONFIG_NFRAC_MASK;
 
-	ddr_pll = nint * ath79_ref_clk.rate / ref_div;
-	ddr_pll += frac * ath79_ref_clk.rate / (ref_div * (1 << 10));
+	ddr_pll = nint * ref_rate / ref_div;
+	ddr_pll += frac * ref_rate / (ref_div * (1 << 10));
 	ddr_pll /= (1 << out_div);
 
 	clk_ctrl = ath79_pll_rr(QCA955X_PLL_CLK_CTRL_REG);
@@ -341,31 +390,36 @@ static void __init qca955x_clocks_init(void)
 		  QCA955X_PLL_CLK_CTRL_CPU_POST_DIV_MASK;
 
 	if (clk_ctrl & QCA955X_PLL_CLK_CTRL_CPU_PLL_BYPASS)
-		ath79_cpu_clk.rate = ath79_ref_clk.rate;
+		cpu_rate = ref_rate;
 	else if (clk_ctrl & QCA955X_PLL_CLK_CTRL_CPUCLK_FROM_CPUPLL)
-		ath79_cpu_clk.rate = ddr_pll / (postdiv + 1);
+		cpu_rate = ddr_pll / (postdiv + 1);
 	else
-		ath79_cpu_clk.rate = cpu_pll / (postdiv + 1);
+		cpu_rate = cpu_pll / (postdiv + 1);
 
 	postdiv = (clk_ctrl >> QCA955X_PLL_CLK_CTRL_DDR_POST_DIV_SHIFT) &
 		  QCA955X_PLL_CLK_CTRL_DDR_POST_DIV_MASK;
 
 	if (clk_ctrl & QCA955X_PLL_CLK_CTRL_DDR_PLL_BYPASS)
-		ath79_ddr_clk.rate = ath79_ref_clk.rate;
+		ddr_rate = ref_rate;
 	else if (clk_ctrl & QCA955X_PLL_CLK_CTRL_DDRCLK_FROM_DDRPLL)
-		ath79_ddr_clk.rate = cpu_pll / (postdiv + 1);
+		ddr_rate = cpu_pll / (postdiv + 1);
 	else
-		ath79_ddr_clk.rate = ddr_pll / (postdiv + 1);
+		ddr_rate = ddr_pll / (postdiv + 1);
 
 	postdiv = (clk_ctrl >> QCA955X_PLL_CLK_CTRL_AHB_POST_DIV_SHIFT) &
 		  QCA955X_PLL_CLK_CTRL_AHB_POST_DIV_MASK;
 
 	if (clk_ctrl & QCA955X_PLL_CLK_CTRL_AHB_PLL_BYPASS)
-		ath79_ahb_clk.rate = ath79_ref_clk.rate;
+		ahb_rate = ref_rate;
 	else if (clk_ctrl & QCA955X_PLL_CLK_CTRL_AHBCLK_FROM_DDRPLL)
-		ath79_ahb_clk.rate = ddr_pll / (postdiv + 1);
+		ahb_rate = ddr_pll / (postdiv + 1);
 	else
-		ath79_ahb_clk.rate = cpu_pll / (postdiv + 1);
+		ahb_rate = cpu_pll / (postdiv + 1);
+
+	ath79_ref_clk.rate = ref_rate;
+	ath79_cpu_clk.rate = cpu_rate;
+	ath79_ddr_clk.rate = ddr_rate;
+	ath79_ahb_clk.rate = ahb_rate;
 
 	ath79_wdt_clk.rate = ath79_ref_clk.rate;
 	ath79_uart_clk.rate = ath79_ref_clk.rate;
-- 
1.7.10
