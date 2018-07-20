Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 14:24:37 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:47122 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993426AbeGTMXxPdZ6U (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 14:23:53 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 16/25] MIPS: ath79: make specifying the reference clock in DT optional
Date:   Fri, 20 Jul 2018 13:58:33 +0200
Message-Id: <20180720115842.8406-17-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64971
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

From: Felix Fietkau <nbd@nbd.name>

It can be autodetected for many SoCs using the strapping options.
If the clock is specified in DT, the autodetected value is ignored

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/clock.c | 84 +++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 984b3cdebd22..6262253622b3 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -80,6 +80,18 @@ static struct clk * __init ath79_set_ff_clk(int type, const char *parent,
 	return clk;
 }
 
+static unsigned long __init ath79_setup_ref_clk(unsigned long rate)
+{
+	struct clk *clk = clks[ATH79_CLK_REF];
+
+	if (clk)
+		rate = clk_get_rate(clk);
+	else
+		clk = ath79_set_clk(ATH79_CLK_REF, rate);
+
+	return rate;
+}
+
 static void __init ar71xx_clocks_init(void __iomem *pll_base)
 {
 	unsigned long ref_rate;
@@ -90,7 +102,7 @@ static void __init ar71xx_clocks_init(void __iomem *pll_base)
 	u32 freq;
 	u32 div;
 
-	ref_rate = AR71XX_BASE_FREQ;
+	ref_rate = ath79_setup_ref_clk(AR71XX_BASE_FREQ);
 
 	pll = __raw_readl(pll_base + AR71XX_PLL_REG_CPU_CONFIG);
 
@@ -106,16 +118,17 @@ static void __init ar71xx_clocks_init(void __iomem *pll_base)
 	div = (((pll >> AR71XX_AHB_DIV_SHIFT) & AR71XX_AHB_DIV_MASK) + 1) * 2;
 	ahb_rate = cpu_rate / div;
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 }
 
-static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
+static void __init ar724x_clocks_init(void __iomem *pll_base)
 {
-	u32 pll;
 	u32 mult, div, ddr_div, ahb_div;
+	u32 pll;
+
+	ath79_setup_ref_clk(AR71XX_BASE_FREQ);
 
 	pll = __raw_readl(pll_base + AR724X_PLL_REG_CPU_CONFIG);
 
@@ -130,17 +143,9 @@ static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 	ath79_set_ff_clk(ATH79_CLK_AHB, "ref", mult, div * ahb_div);
 }
 
-static void __init ar724x_clocks_init(void __iomem *pll_base)
-{
-	struct clk *ref_clk;
-
-	ref_clk = ath79_set_clk(ATH79_CLK_REF, AR724X_BASE_FREQ);
-
-	ar724x_clk_init(ref_clk, pll_base);
-}
-
-static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
+static void __init ar933x_clocks_init(void __iomem *pll_base)
 {
+	unsigned long ref_rate;
 	u32 clock_ctrl;
 	u32 ref_div;
 	u32 ninit_mul;
@@ -149,6 +154,15 @@ static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 	u32 cpu_div;
 	u32 ddr_div;
 	u32 ahb_div;
+	u32 t;
+
+	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
+	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
+		ref_rate = (40 * 1000 * 1000);
+	else
+		ref_rate = (25 * 1000 * 1000);
+
+	ath79_setup_ref_clk(ref_rate);
 
 	clock_ctrl = __raw_readl(pll_base + AR933X_PLL_CLOCK_CTRL_REG);
 	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
@@ -197,23 +211,6 @@ static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 			 ref_div * out_div * ahb_div);
 }
 
-static void __init ar933x_clocks_init(void __iomem *pll_base)
-{
-	struct clk *ref_clk;
-	unsigned long ref_rate;
-	u32 t;
-
-	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
-	if (t & AR933X_BOOTSTRAP_REF_CLK_40)
-		ref_rate = (40 * 1000 * 1000);
-	else
-		ref_rate = (25 * 1000 * 1000);
-
-	ref_clk = ath79_set_clk(ATH79_CLK_REF, ref_rate);
-
-	ar9330_clk_init(ref_clk, ath79_pll_base);
-}
-
 static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
 				      u32 frac, u32 out_div)
 {
@@ -253,6 +250,8 @@ static void __init ar934x_clocks_init(void __iomem *pll_base)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
+	ref_rate = ath79_setup_ref_clk(ref_rate);
+
 	pll = __raw_readl(dpll_base + AR934X_SRIF_CPU_DPLL2_REG);
 	if (pll & AR934X_SRIF_DPLL2_LOCAL_PLL) {
 		out_div = (pll >> AR934X_SRIF_DPLL2_OUTDIV_SHIFT) &
@@ -339,7 +338,6 @@ static void __init ar934x_clocks_init(void __iomem *pll_base)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
@@ -363,6 +361,8 @@ static void __init qca953x_clocks_init(void __iomem *pll_base)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
+	ref_rate = ath79_setup_ref_clk(ref_rate);
+
 	pll = __raw_readl(pll_base + QCA953X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA953X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 		  QCA953X_PLL_CPU_CONFIG_OUTDIV_MASK;
@@ -423,7 +423,6 @@ static void __init qca953x_clocks_init(void __iomem *pll_base)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
@@ -445,6 +444,8 @@ static void __init qca955x_clocks_init(void __iomem *pll_base)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
+	ref_rate = ath79_setup_ref_clk(ref_rate);
+
 	pll = __raw_readl(pll_base + QCA955X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA955X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 		  QCA955X_PLL_CPU_CONFIG_OUTDIV_MASK;
@@ -505,7 +506,6 @@ static void __init qca955x_clocks_init(void __iomem *pll_base)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
@@ -537,6 +537,8 @@ static void __init qca956x_clocks_init(void __iomem *pll_base)
 	else
 		ref_rate = 25 * 1000 * 1000;
 
+	ref_rate = ath79_setup_ref_clk(ref_rate);
+
 	pll = __raw_readl(pll_base + QCA956X_PLL_CPU_CONFIG_REG);
 	out_div = (pll >> QCA956X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
 		  QCA956X_PLL_CPU_CONFIG_OUTDIV_MASK;
@@ -606,7 +608,6 @@ static void __init qca956x_clocks_init(void __iomem *pll_base)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_set_clk(ATH79_CLK_REF, ref_rate);
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
@@ -682,10 +683,8 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 	void __iomem *pll_base;
 
 	ref_clk = of_clk_get(np, 0);
-	if (IS_ERR(ref_clk)) {
-		pr_err("%pOF: of_clk_get failed\n", np);
-		goto err;
-	}
+	if (!IS_ERR(ref_clk))
+		clks[ATH79_CLK_REF] = ref_clk;
 
 	pll_base = of_iomap(np, 0);
 	if (!pll_base) {
@@ -694,9 +693,9 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 	}
 
 	if (of_device_is_compatible(np, "qca,ar9130-pll"))
-		ar724x_clk_init(ref_clk, pll_base);
+		ar724x_clocks_init(pll_base);
 	else if (of_device_is_compatible(np, "qca,ar9330-pll"))
-		ar9330_clk_init(ref_clk, pll_base);
+		ar933x_clocks_init(pll_base);
 	else {
 		pr_err("%pOF: could not find any appropriate clk_init()\n", np);
 		goto err_iounmap;
@@ -714,9 +713,6 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 
 err_clk:
 	clk_put(ref_clk);
-
-err:
-	return;
 }
 CLK_OF_DECLARE(ar9130_clk, "qca,ar9130-pll", ath79_clocks_init_dt_ng);
 CLK_OF_DECLARE(ar9330_clk, "qca,ar9330-pll", ath79_clocks_init_dt_ng);
-- 
2.11.0
