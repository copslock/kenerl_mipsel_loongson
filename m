Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 14:24:56 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:47140 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993488AbeGTMX6w11G2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 14:23:58 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 13/25] MIPS: ath79: add helpers for setting clocks and expose the ref clock
Date:   Fri, 20 Jul 2018 13:58:30 +0200
Message-Id: <20180720115842.8406-14-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64973
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

Preparation for transitioning the legacy clock setup code over
to OF.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/clock.c               | 128 ++++++++++++++++++----------------
 include/dt-bindings/clock/ath79-clk.h |   3 +-
 2 files changed, 68 insertions(+), 63 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index cf9158e3c2d9..50bc3b01a4c4 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -37,20 +37,46 @@ static struct clk_onecell_data clk_data = {
 	.clk_num = ARRAY_SIZE(clks),
 };
 
-static struct clk *__init ath79_add_sys_clkdev(
-	const char *id, unsigned long rate)
+static const char * const clk_names[ATH79_CLK_END] = {
+	[ATH79_CLK_CPU] = "cpu",
+	[ATH79_CLK_DDR] = "ddr",
+	[ATH79_CLK_AHB] = "ahb",
+	[ATH79_CLK_REF] = "ref",
+};
+
+static const char * __init ath79_clk_name(int type)
 {
-	struct clk *clk;
-	int err;
+	BUG_ON(type >= ARRAY_SIZE(clk_names) || !clk_names[type]);
+	return clk_names[type];
+}
 
-	clk = clk_register_fixed_rate(NULL, id, NULL, 0, rate);
+static void __init __ath79_set_clk(int type, const char *name, struct clk *clk)
+{
 	if (IS_ERR(clk))
-		panic("failed to allocate %s clock structure", id);
+		panic("failed to allocate %s clock structure", clk_names[type]);
 
-	err = clk_register_clkdev(clk, id, NULL);
-	if (err)
-		panic("unable to register %s clock device", id);
+	clks[type] = clk;
+	clk_register_clkdev(clk, name, NULL);
+}
 
+static struct clk * __init ath79_set_clk(int type, unsigned long rate)
+{
+	const char *name = ath79_clk_name(type);
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, name, NULL, 0, rate);
+	__ath79_set_clk(type, name, clk);
+	return clk;
+}
+
+static struct clk * __init ath79_set_ff_clk(int type, const char *parent,
+					    unsigned int mult, unsigned int div)
+{
+	const char *name = ath79_clk_name(type);
+	struct clk *clk;
+
+	clk = clk_register_fixed_factor(NULL, name, parent, 0, mult, div);
+	__ath79_set_clk(type, name, clk);
 	return clk;
 }
 
@@ -80,27 +106,15 @@ static void __init ar71xx_clocks_init(void)
 	div = (((pll >> AR71XX_AHB_DIV_SHIFT) & AR71XX_AHB_DIV_MASK) + 1) * 2;
 	ahb_rate = cpu_rate / div;
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
-static struct clk * __init ath79_reg_ffclk(const char *name,
-		const char *parent_name, unsigned int mult, unsigned int div)
-{
-	struct clk *clk;
-
-	clk = clk_register_fixed_factor(NULL, name, parent_name, 0, mult, div);
-	if (IS_ERR(clk))
-		panic("failed to allocate %s clock structure", name);
-
-	return clk;
-}
-
 static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 {
 	u32 pll;
@@ -114,24 +128,19 @@ static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 	ddr_div = ((pll >> AR724X_DDR_DIV_SHIFT) & AR724X_DDR_DIV_MASK) + 1;
 	ahb_div = (((pll >> AR724X_AHB_DIV_SHIFT) & AR724X_AHB_DIV_MASK) + 1) * 2;
 
-	clks[ATH79_CLK_CPU] = ath79_reg_ffclk("cpu", "ref", mult, div);
-	clks[ATH79_CLK_DDR] = ath79_reg_ffclk("ddr", "ref", mult, div * ddr_div);
-	clks[ATH79_CLK_AHB] = ath79_reg_ffclk("ahb", "ref", mult, div * ahb_div);
+	ath79_set_ff_clk(ATH79_CLK_CPU, "ref", mult, div);
+	ath79_set_ff_clk(ATH79_CLK_DDR, "ref", mult, div * ddr_div);
+	ath79_set_ff_clk(ATH79_CLK_AHB, "ref", mult, div * ahb_div);
 }
 
 static void __init ar724x_clocks_init(void)
 {
 	struct clk *ref_clk;
 
-	ref_clk = ath79_add_sys_clkdev("ref", AR724X_BASE_FREQ);
+	ref_clk = ath79_set_clk(ATH79_CLK_REF, AR724X_BASE_FREQ);
 
 	ar724x_clk_init(ref_clk, ath79_pll_base);
 
-	/* just make happy plat_time_init() from arch/mips/ath79/setup.c */
-	clk_register_clkdev(clks[ATH79_CLK_CPU], "cpu", NULL);
-	clk_register_clkdev(clks[ATH79_CLK_DDR], "ddr", NULL);
-	clk_register_clkdev(clks[ATH79_CLK_AHB], "ahb", NULL);
-
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
 }
@@ -186,12 +195,12 @@ static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
 		     AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK) + 1;
 	}
 
-	clks[ATH79_CLK_CPU] = ath79_reg_ffclk("cpu", "ref",
-					ninit_mul, ref_div * out_div * cpu_div);
-	clks[ATH79_CLK_DDR] = ath79_reg_ffclk("ddr", "ref",
-					ninit_mul, ref_div * out_div * ddr_div);
-	clks[ATH79_CLK_AHB] = ath79_reg_ffclk("ahb", "ref",
-					ninit_mul, ref_div * out_div * ahb_div);
+	ath79_set_ff_clk(ATH79_CLK_CPU, "ref", ninit_mul,
+			 ref_div * out_div * cpu_div);
+	ath79_set_ff_clk(ATH79_CLK_DDR, "ref", ninit_mul,
+			 ref_div * out_div * ddr_div);
+	ath79_set_ff_clk(ATH79_CLK_AHB, "ref", ninit_mul,
+			 ref_div * out_div * ahb_div);
 }
 
 static void __init ar933x_clocks_init(void)
@@ -206,15 +215,10 @@ static void __init ar933x_clocks_init(void)
 	else
 		ref_rate = (25 * 1000 * 1000);
 
-	ref_clk = ath79_add_sys_clkdev("ref", ref_rate);
+	ref_clk = ath79_set_clk(ATH79_CLK_REF, ref_rate);
 
 	ar9330_clk_init(ref_clk, ath79_pll_base);
 
-	/* just make happy plat_time_init() from arch/mips/ath79/setup.c */
-	clk_register_clkdev(clks[ATH79_CLK_CPU], "cpu", NULL);
-	clk_register_clkdev(clks[ATH79_CLK_DDR], "ddr", NULL);
-	clk_register_clkdev(clks[ATH79_CLK_AHB], "ahb", NULL);
-
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
 }
@@ -344,10 +348,10 @@ static void __init ar934x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -431,10 +435,10 @@ static void __init qca953x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -516,10 +520,10 @@ static void __init qca955x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -620,10 +624,10 @@ static void __init qca956x_clocks_init(void)
 	else
 		ahb_rate = cpu_pll / (postdiv + 1);
 
-	ath79_add_sys_clkdev("ref", ref_rate);
-	ath79_add_sys_clkdev("cpu", cpu_rate);
-	ath79_add_sys_clkdev("ddr", ddr_rate);
-	ath79_add_sys_clkdev("ahb", ahb_rate);
+	ath79_set_clk(ATH79_CLK_REF, ref_rate);
+	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
+	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
+	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
 	clk_add_alias("wdt", NULL, "ref", NULL);
 	clk_add_alias("uart", NULL, "ref", NULL);
diff --git a/include/dt-bindings/clock/ath79-clk.h b/include/dt-bindings/clock/ath79-clk.h
index 27359ad83904..262d7c5eb248 100644
--- a/include/dt-bindings/clock/ath79-clk.h
+++ b/include/dt-bindings/clock/ath79-clk.h
@@ -13,7 +13,8 @@
 #define ATH79_CLK_CPU		0
 #define ATH79_CLK_DDR		1
 #define ATH79_CLK_AHB		2
+#define ATH79_CLK_REF		3
 
-#define ATH79_CLK_END		3
+#define ATH79_CLK_END		4
 
 #endif /* __DT_BINDINGS_ATH79_CLK_H */
-- 
2.11.0
