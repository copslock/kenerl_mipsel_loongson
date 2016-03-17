Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:36:56 +0100 (CET)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34846 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007069AbcCQDetTJxvp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:49 +0100
Received: by mail-lb0-f194.google.com with SMTP id wn5so4260991lbb.2
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DdHciL0fsVwSyfM7+0Oj+zude6uz7Yj/xhVnGA0Oypc=;
        b=BbW5MRp/t84Qn6aEjwPy4/AdYjlLPQIk6tsuh92Fy6Imj73HdDpubC8NSHqyaWva8w
         /MyyW+vQO8BzD53sJsP/1dWmDFkUmytyqhTfAA5EirP2tY+eBOpgoYJ8AaBXflgFyHqw
         zVXPQhu/h4nvbFpIj1R0otbrPcGDnD3Vo5JAR45vZBJijDDO2QTzuSkgW7zRLCyQbKdM
         KyR0TCO1vgDm82vQo4zuAorgHVf3RG7QUsP0F/seGsqkAFCcoh/uopyIWnKBotkok6Tq
         DJ8M9VbYbPGWZeo3/oUPxZBAH+T0iT9R1a8F/8AMxP5303Xbnkzve6r3si3gZxl4Znh5
         kYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DdHciL0fsVwSyfM7+0Oj+zude6uz7Yj/xhVnGA0Oypc=;
        b=PlQlHsn9f1UHBi1dZTx+PmzwOeSJy4c6ejl7vvE4fQGv8YmbEg/grOD9fwcqA6s4Z+
         42Lua/V5/YlVTgXx5fKm5MoR0uCpa687un94fTq/F4BGoWk/01SOvaqaF07RhDpB+Pn8
         7UxggTfsyATwFNpMeVxUyP6XvqlKsYl/IlWt1Crcz8wH3RQuDwkzYpAzwRpObh8POuv9
         RAr2/LEtGHaQa19pYwql2Kc8QeUAP/0g5ZFdrxD6Ty27/Ccj3FqiECbJhg7lAbTjnNKZ
         8dsvyIFwfXG+UoXgpgJ5juPenHBFiJljj60+QBCyNl/foc7DiDujeDCsIOeY0ak+y4c1
         AhPA==
X-Gm-Message-State: AD7BkJKvcVBnAZPqGexRxCRuMNv8lYSLuUmcu4sDU3B4XimIP4Wu1qjnqFe4JIe1pNogcQ==
X-Received: by 10.112.134.202 with SMTP id pm10mr2641980lbb.36.1458185683937;
        Wed, 16 Mar 2016 20:34:43 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:42 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 08/18] MIPS: ath79: update devicetree clock support for AR9132
Date:   Thu, 17 Mar 2016 06:34:15 +0300
Message-Id: <1458185665-4521-9-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Current ath79 clock.c code does not read reference clock and
pll setup from devicetree. E.g. you can set any clock rate value
in board DTS but it will have no effect on the real clk calculation.

This patch fixes some AR9132 devicetree clock support defects:

  * clk initialization function ath79_clocks_init_dt_ng()
    is introduced; it actually gets pll block base register
    address and reference clock from devicetree;
  * pll register parsing code is moved to the separate
    ar724x_clk_init() function; this function
    can be called from platform code or from devicetree code.

Also mips_hpt_frequency value is set from dt, so the appropriate
clock parameter is added to the cpu@0 devicetree node.

The same approach can be used for adding AR9331 devicetree support.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
---
 arch/mips/ath79/clock.c            | 104 ++++++++++++++++++++++++++-----------
 arch/mips/ath79/setup.c            |  36 +++++++++++++
 arch/mips/boot/dts/qca/ar9132.dtsi |   1 +
 3 files changed, 112 insertions(+), 29 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index c3a94ea..79fb8b4 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -18,6 +18,8 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 #include <dt-bindings/clock/ath79-clk.h>
 
 #include <asm/div64.h>
@@ -25,6 +27,7 @@
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
+#include "machtypes.h"
 
 #define AR71XX_BASE_FREQ	40000000
 #define AR724X_BASE_FREQ	40000000
@@ -87,37 +90,48 @@ static void __init ar71xx_clocks_init(void)
 	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
+static struct clk * __init ath79_reg_ffclk(const char *name,
+		const char *parent_name, unsigned int mult, unsigned int div)
+{
+	struct clk *clk;
+
+	clk = clk_register_fixed_factor(NULL, name, parent_name, 0, mult, div);
+	if (!clk)
+		panic("failed to allocate %s clock structure", name);
+
+	return clk;
+}
+
+static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
+{
+	u32 pll;
+	u32 mult, div, ddr_div, ahb_div;
+
+	pll = __raw_readl(pll_base + AR724X_PLL_REG_CPU_CONFIG);
+
+	mult = ((pll >> AR724X_PLL_FB_SHIFT) & AR724X_PLL_FB_MASK);
+	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK) * 2;
+
+	ddr_div = ((pll >> AR724X_DDR_DIV_SHIFT) & AR724X_DDR_DIV_MASK) + 1;
+	ahb_div = (((pll >> AR724X_AHB_DIV_SHIFT) & AR724X_AHB_DIV_MASK) + 1) * 2;
+
+	clks[ATH79_CLK_CPU] = ath79_reg_ffclk("cpu", "ref", mult, div);
+	clks[ATH79_CLK_DDR] = ath79_reg_ffclk("ddr", "ref", mult, div * ddr_div);
+	clks[ATH79_CLK_AHB] = ath79_reg_ffclk("ahb", "ref", mult, div * ahb_div);
+}
+
 static void __init ar724x_clocks_init(void)
 {
-	unsigned long ref_rate;
-	unsigned long cpu_rate;
-	unsigned long ddr_rate;
-	unsigned long ahb_rate;
-	u32 pll;
-	u32 freq;
-	u32 div;
+	struct clk *ref_clk;
 
-	ref_rate = AR724X_BASE_FREQ;
-	pll = ath79_pll_rr(AR724X_PLL_REG_CPU_CONFIG);
+	ref_clk = ath79_add_sys_clkdev("ref", AR724X_BASE_FREQ);
 
-	div = ((pll >> AR724X_PLL_FB_SHIFT) & AR724X_PLL_FB_MASK);
-	freq = div * ref_rate;
+	ar724x_clk_init(ref_clk, ath79_pll_base);
 
-	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK) * 2;
-	freq /= div;
-
-	cpu_rate = freq;
-
-	div = ((pll >> AR724X_DDR_DIV_SHIFT) & AR724X_DDR_DIV_MASK) + 1;
-	ddr_rate = freq / div;
-
-	div = (((pll >> AR724X_AHB_DIV_SHIFT) & AR724X_AHB_DIV_MASK) + 1) * 2;
-	ahb_rate = cpu_rate / div;
-
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
+	/* just make happy plat_time_init() from arch/mips/ath79/setup.c */
+	clk_register_clkdev(clks[ATH79_CLK_CPU], "cpu", NULL);
+	clk_register_clkdev(clks[ATH79_CLK_DDR], "ddr", NULL);
+	clk_register_clkdev(clks[ATH79_CLK_AHB], "ahb", NULL);
 
 	clk_add_alias("wdt", NULL, "ahb", NULL);
 	clk_add_alias("uart", NULL, "ahb", NULL);
@@ -420,8 +434,6 @@ void __init ath79_clocks_init(void)
 		qca955x_clocks_init();
 	else
 		BUG();
-
-	of_clk_init(NULL);
 }
 
 unsigned long __init
@@ -448,8 +460,42 @@ static void __init ath79_clocks_init_dt(struct device_node *np)
 
 CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9130, "qca,ar9130-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9330, "qca,ar9330-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
+
+static void __init ath79_clocks_init_dt_ng(struct device_node *np)
+{
+	struct clk *ref_clk;
+	void __iomem *pll_base;
+	const char *dnfn = of_node_full_name(np);
+
+	ref_clk = of_clk_get(np, 0);
+	if (IS_ERR(ref_clk)) {
+		pr_err("%s: of_clk_get failed\n", dnfn);
+		goto err;
+	}
+
+	pll_base = of_iomap(np, 0);
+	if (!pll_base) {
+		pr_err("%s: can't map pll registers\n", dnfn);
+		goto err_clk;
+	}
+
+	ar724x_clk_init(ref_clk, pll_base);
+
+	if (of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data)) {
+		pr_err("%s: could not register clk provider\n", dnfn);
+		goto err_clk;
+	}
+
+	return;
+
+err_clk:
+	clk_put(ref_clk);
+
+err:
+	return;
+}
+CLK_OF_DECLARE(ar9130_clk, "qca,ar9130-pll", ath79_clocks_init_dt_ng);
 #endif
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 99ab4bb..61e3a59 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -17,6 +17,7 @@
 #include <linux/bootmem.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/of_platform.h>
 #include <linux/of_fdt.h>
 
@@ -221,6 +222,36 @@ void __init plat_mem_setup(void)
 	pm_power_off = ath79_halt;
 }
 
+static void __init ath79_of_plat_time_init(void)
+{
+	struct device_node *np;
+	struct clk *clk;
+	unsigned long cpu_clk_rate;
+
+	of_clk_init(NULL);
+
+	np = of_get_cpu_node(0, NULL);
+	if (!np) {
+		pr_err("Failed to get CPU node\n");
+		return;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
+		return;
+	}
+
+	cpu_clk_rate = clk_get_rate(clk);
+
+	pr_info("CPU clock: %lu.%03lu MHz\n",
+		cpu_clk_rate / 1000000, (cpu_clk_rate / 1000) % 1000);
+
+	mips_hpt_frequency = cpu_clk_rate / 2;
+
+	clk_put(clk);
+}
+
 void __init plat_time_init(void)
 {
 	unsigned long cpu_clk_rate;
@@ -228,6 +259,11 @@ void __init plat_time_init(void)
 	unsigned long ddr_clk_rate;
 	unsigned long ref_clk_rate;
 
+	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
+		ath79_of_plat_time_init();
+		return;
+	}
+
 	ath79_clocks_init();
 
 	cpu_clk_rate = ath79_get_sys_clk_rate("cpu");
diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 2f9a3ee..302f0a8 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -13,6 +13,7 @@
 		cpu@0 {
 			device_type = "cpu";
 			compatible = "mips,mips24Kc";
+			clocks = <&pll ATH79_CLK_CPU>;
 			reg = <0>;
 		};
 	};
-- 
2.7.0
