Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 04:37:45 +0100 (CET)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36402 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007122AbcCQDexKcp0p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 04:34:53 +0100
Received: by mail-lf0-f65.google.com with SMTP id h198so2226412lfh.3
        for <linux-mips@linux-mips.org>; Wed, 16 Mar 2016 20:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nN1l/7USReyV9WX0stmissXP63rzGCc7lHaUzJCbRr0=;
        b=BoC+TyVd1Ip/FSp3V/eL1A7HqZQ01hJ2plh8dMkiZLN0lFQb1NVnmCcIJvIfKxQ8tP
         VTrI2hVO0x9TanZ1Zqm08ws+JEeDTgI8jj/LQcWUbZzioQ10T3a6nvvfTu2iYTXWDade
         apPn4J1zR88AK4g2enSgqBuj7LCXRenRTQkWB9Xd48l6HyC6LoBSeHsAXgISybuDFayr
         lDna1zIg1syzG9vsDlu417r2vm+HDNI6E8PUJQQ8mZyLTVFICSF3VqpMYcPUwkQDN3pG
         oWxiCn5gus12Mcy1ATHxXrfBjbLOaMEPQtVeFCFJsZAuarArJwySOIgAWSuyoGRnmVd5
         Z8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nN1l/7USReyV9WX0stmissXP63rzGCc7lHaUzJCbRr0=;
        b=NVaxOArlmCh+asg2WBoCy5/yOcLp17JFGHhRrcp/NNY00fUcktD1vfFskweFqxeSIY
         Yt2Gvfun/iD+F9eSa/bfdvSErleiLAZGhb7515AVOV8lLahs81w+3iCrcWP89gmazl3w
         CgyBQw8sSbgYLQ3A13hemq312zD2wjy48dH1zTL0xfexhSAgOd7aKJUrbEKeCeAJhVHw
         uOAfqq3Nk0rj5yasbtaEO1H+3qejjAst7KLakRbsTGsDcNZRHZKp0Ca1+fDSr+AtXh6Q
         sVXvE0D40/VaswhLvIMBgeEcwab30znf90bhf5l72WcYnZQmW0VoGNatf8kuIs1CbUUY
         xM9Q==
X-Gm-Message-State: AD7BkJJXbyxp21S0mQoniLIBTkkaY6La0/jZkhd8zecSAcz0qklN0pnvRAdCf4PeX3ieoQ==
X-Received: by 10.25.218.196 with SMTP id r187mr2790422lfg.6.1458185687906;
        Wed, 16 Mar 2016 20:34:47 -0700 (PDT)
Received: from localhost.localdomain (ppp109-252-26-173.pppoe.spdop.ru. [109.252.26.173])
        by smtp.gmail.com with ESMTPSA id gp6sm1026698lbc.44.2016.03.16.20.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 20:34:46 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 11/18] MIPS: ath79: update devicetree clock support for AR9331
Date:   Thu, 17 Mar 2016 06:34:18 +0300
Message-Id: <1458185665-4521-12-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
References: <1458185665-4521-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52625
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
 arch/mips/ath79/clock.c | 120 +++++++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 46 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 79fb8b4..3cfc5ec 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -137,15 +137,68 @@ static void __init ar724x_clocks_init(void)
 	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
+static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
+{
+	u32 clock_ctrl;
+	u32 ref_div;
+	u32 ninit_mul;
+	u32 out_div;
+
+	u32 cpu_div;
+	u32 ddr_div;
+	u32 ahb_div;
+
+	clock_ctrl = __raw_readl(pll_base + AR933X_PLL_CLOCK_CTRL_REG);
+	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
+		ref_div = 1;
+		ninit_mul = 1;
+		out_div = 1;
+
+		cpu_div = 1;
+		ddr_div = 1;
+		ahb_div = 1;
+	} else {
+		u32 cpu_config;
+		u32 t;
+
+		cpu_config = __raw_readl(pll_base + AR933X_PLL_CPU_CONFIG_REG);
+
+		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
+		    AR933X_PLL_CPU_CONFIG_REFDIV_MASK;
+		ref_div = t;
+
+		ninit_mul = (cpu_config >> AR933X_PLL_CPU_CONFIG_NINT_SHIFT) &
+		    AR933X_PLL_CPU_CONFIG_NINT_MASK;
+
+		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
+		    AR933X_PLL_CPU_CONFIG_OUTDIV_MASK;
+		if (t == 0)
+			t = 1;
+
+		out_div = (1 << t);
+
+		cpu_div = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_CPU_DIV_SHIFT) &
+		     AR933X_PLL_CLOCK_CTRL_CPU_DIV_MASK) + 1;
+
+		ddr_div = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_DDR_DIV_SHIFT) &
+		      AR933X_PLL_CLOCK_CTRL_DDR_DIV_MASK) + 1;
+
+		ahb_div = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT) &
+		     AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK) + 1;
+	}
+
+	clks[ATH79_CLK_CPU] = ath79_reg_ffclk("cpu", "ref",
+					ninit_mul, ref_div * out_div * cpu_div);
+	clks[ATH79_CLK_DDR] = ath79_reg_ffclk("ddr", "ref",
+					ninit_mul, ref_div * out_div * ddr_div);
+	clks[ATH79_CLK_AHB] = ath79_reg_ffclk("ahb", "ref",
+					ninit_mul, ref_div * out_div * ahb_div);
+}
+
 static void __init ar933x_clocks_init(void)
 {
+	struct clk *ref_clk;
 	unsigned long ref_rate;
-	unsigned long cpu_rate;
-	unsigned long ddr_rate;
-	unsigned long ahb_rate;
-	u32 clock_ctrl;
-	u32 cpu_config;
-	u32 freq;
 	u32 t;
 
 	t = ath79_reset_rr(AR933X_RESET_REG_BOOTSTRAP);
@@ -154,46 +207,14 @@ static void __init ar933x_clocks_init(void)
 	else
 		ref_rate = (25 * 1000 * 1000);
 
-	clock_ctrl = ath79_pll_rr(AR933X_PLL_CLOCK_CTRL_REG);
-	if (clock_ctrl & AR933X_PLL_CLOCK_CTRL_BYPASS) {
-		cpu_rate = ref_rate;
-		ahb_rate = ref_rate;
-		ddr_rate = ref_rate;
-	} else {
-		cpu_config = ath79_pll_rr(AR933X_PLL_CPU_CONFIG_REG);
+	ref_clk = ath79_add_sys_clkdev("ref", ref_rate);
 
-		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_REFDIV_SHIFT) &
-		    AR933X_PLL_CPU_CONFIG_REFDIV_MASK;
-		freq = ref_rate / t;
+	ar9330_clk_init(ref_clk, ath79_pll_base);
 
-		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_NINT_SHIFT) &
-		    AR933X_PLL_CPU_CONFIG_NINT_MASK;
-		freq *= t;
-
-		t = (cpu_config >> AR933X_PLL_CPU_CONFIG_OUTDIV_SHIFT) &
-		    AR933X_PLL_CPU_CONFIG_OUTDIV_MASK;
-		if (t == 0)
-			t = 1;
-
-		freq >>= t;
-
-		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_CPU_DIV_SHIFT) &
-		     AR933X_PLL_CLOCK_CTRL_CPU_DIV_MASK) + 1;
-		cpu_rate = freq / t;
-
-		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_DDR_DIV_SHIFT) &
-		      AR933X_PLL_CLOCK_CTRL_DDR_DIV_MASK) + 1;
-		ddr_rate = freq / t;
-
-		t = ((clock_ctrl >> AR933X_PLL_CLOCK_CTRL_AHB_DIV_SHIFT) &
-		     AR933X_PLL_CLOCK_CTRL_AHB_DIV_MASK) + 1;
-		ahb_rate = freq / t;
-	}
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
 	clk_add_alias("uart", NULL, "ref", NULL);
@@ -460,7 +481,6 @@ static void __init ath79_clocks_init_dt(struct device_node *np)
 
 CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9330, "qca,ar9330-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
 
@@ -482,7 +502,14 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
 		goto err_clk;
 	}
 
-	ar724x_clk_init(ref_clk, pll_base);
+	if (of_device_is_compatible(np, "qca,ar9130-pll"))
+		ar724x_clk_init(ref_clk, pll_base);
+	else if (of_device_is_compatible(np, "qca,ar9330-pll"))
+		ar9330_clk_init(ref_clk, pll_base);
+	else {
+		pr_err("%s: could not find any appropriate clk_init()\n", dnfn);
+		goto err_clk;
+	}
 
 	if (of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data)) {
 		pr_err("%s: could not register clk provider\n", dnfn);
@@ -498,4 +525,5 @@ err:
 	return;
 }
 CLK_OF_DECLARE(ar9130_clk, "qca,ar9130-pll", ath79_clocks_init_dt_ng);
+CLK_OF_DECLARE(ar9330_clk, "qca,ar9330-pll", ath79_clocks_init_dt_ng);
 #endif
-- 
2.7.0
