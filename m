Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 05:43:11 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:37359 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009471AbaJJDnJcs550 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 05:43:09 +0200
Received: by mail-pa0-f43.google.com with SMTP id lf10so914105pab.16
        for <multiple recipients>; Thu, 09 Oct 2014 20:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PRcF2GaJD/0EaCpYOrl2iE112nQ6x1hMBeCxOtOobC0=;
        b=u6qAYTAPt5478KKc4rh3Os0zLzI2oSWLO8g+AwuzF/0JPNWpQaNOvnx72Stf4/EHwg
         QoiwKDsId6+iJFFmXuL4alekdWMPyMYwBftkwbRorUSaQlBVJVoVnTGroPhBnWrY1Ovi
         9rd22Hn+pkedAtwwaurqBbrwrSkXIejW1kb2ZqIY9O01u9/dqJzh42pDi5UGj6Sg4hwC
         50IGa0ISyFkDYJk0BKfUxM2LGf9ofxzrNYur2xp37NX/hwlajV8FaSAEEpXhI8n54wgu
         uxHIRX006bKvweQKEQ7vhx8XveHY00sL9hfhA4FqXgfI7ZCyQ2HguK+WB51s1Q0qT1Xt
         nQdg==
X-Received: by 10.66.152.41 with SMTP id uv9mr2207246pab.25.1412912583490;
        Thu, 09 Oct 2014 20:43:03 -0700 (PDT)
Received: from localhost.localdomain ([171.213.62.98])
        by mx.google.com with ESMTPSA id x13sm1941007pdk.22.2014.10.09.20.43.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Oct 2014 20:43:02 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@linaro.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 5/6] clk: ls1x: Update relationship among all clocks
Date:   Fri, 10 Oct 2014 11:42:51 +0800
Message-Id: <1412912571-6151-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

 - Add clock lookups for APB devices.
 - Update clock relationship to make it more exact and clear.
                                 _____
         _______________________|     |
 OSC ___/                       | MUX |___ XXX CLK
        \___ PLL ___ XXX DIV ___|     |
                                |_____|

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/clk/clk-ls1x.c | 109 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 80 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
index f20b750..ca80103 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/clk-ls1x.c
@@ -15,7 +15,8 @@
 
 #include <loongson1.h>
 
-#define OSC	33
+#define OSC		(33 * 1000000)
+#define DIV_APB		2
 
 static DEFINE_SPINLOCK(_lock);
 
@@ -29,13 +30,12 @@ static void ls1x_pll_clk_disable(struct clk_hw *hw)
 }
 
 static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
-					     unsigned long parent_rate)
+					  unsigned long parent_rate)
 {
 	u32 pll, rate;
 
 	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
-	rate = ((12 + (pll & 0x3f)) * 1000000) +
-		((((pll >> 8) & 0x3ff) * 1000000) >> 10);
+	rate = 12 + (pll & 0x3f) + (((pll >> 8) & 0x3ff) >> 10);
 	rate *= OSC;
 	rate >>= 1;
 
@@ -48,8 +48,10 @@ static const struct clk_ops ls1x_pll_clk_ops = {
 	.recalc_rate = ls1x_pll_recalc_rate,
 };
 
-static struct clk * __init clk_register_pll(struct device *dev,
-	 const char *name, const char *parent_name, unsigned long flags)
+static struct clk *__init clk_register_pll(struct device *dev,
+					   const char *name,
+					   const char *parent_name,
+					   unsigned long flags)
 {
 	struct clk_hw *hw;
 	struct clk *clk;
@@ -78,34 +80,83 @@ static struct clk * __init clk_register_pll(struct device *dev,
 	return clk;
 }
 
+static const char const *cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
+static const char const *ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
+static const char const *dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
+
 void __init ls1x_clk_init(void)
 {
 	struct clk *clk;
 
-	clk = clk_register_pll(NULL, "pll_clk", NULL, CLK_IS_ROOT);
-	clk_prepare_enable(clk);
-
-	clk = clk_register_divider(NULL, "cpu_clk", "pll_clk",
-			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_CPU_SHIFT,
-			DIV_CPU_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_prepare_enable(clk);
-	clk_register_clkdev(clk, "cpu", NULL);
-
-	clk = clk_register_divider(NULL, "dc_clk", "pll_clk",
-			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-			DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_prepare_enable(clk);
-	clk_register_clkdev(clk, "dc", NULL);
-
-	clk = clk_register_divider(NULL, "ahb_clk", "pll_clk",
-			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
-			DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_prepare_enable(clk);
-	clk_register_clkdev(clk, "ahb", NULL);
+	clk = clk_register_fixed_rate(NULL, "osc_33m_clk", NULL, CLK_IS_ROOT,
+				      OSC);
+	clk_register_clkdev(clk, "osc_33m_clk", NULL);
+
+	/* clock derived from 33 MHz OSC clk */
+	clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk", 0);
+	clk_register_clkdev(clk, "pll_clk", NULL);
+
+	/* clock derived from PLL clk */
+	/*                                 _____
+	 *         _______________________|     |
+	 * OSC ___/                       | MUX |___ CPU CLK
+	 *        \___ PLL ___ CPU DIV ___|     |
+	 *                                |_____|
+	 */
+	clk = clk_register_divider(NULL, "cpu_clk_div", "pll_clk",
+				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
+				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
+				   CLK_DIVIDER_ONE_BASED |
+				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
+	clk_register_clkdev(clk, "cpu_clk_div", NULL);
+	clk = clk_register_mux(NULL, "cpu_clk", cpu_parents,
+			       ARRAY_SIZE(cpu_parents),
+			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
+			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
+	clk_register_clkdev(clk, "cpu_clk", NULL);
+
+	/*                                 _____
+	 *         _______________________|     |
+	 * OSC ___/                       | MUX |___ DC  CLK
+	 *        \___ PLL ___ DC  DIV ___|     |
+	 *                                |_____|
+	 */
+	clk = clk_register_divider(NULL, "dc_clk_div", "pll_clk",
+				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
+				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+	clk_register_clkdev(clk, "dc_clk_div", NULL);
+	clk = clk_register_mux(NULL, "dc_clk", dc_parents,
+			       ARRAY_SIZE(dc_parents),
+			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
+			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
+	clk_register_clkdev(clk, "dc_clk", NULL);
+
+	/*                                 _____
+	 *         _______________________|     |
+	 * OSC ___/                       | MUX |___ DDR CLK
+	 *        \___ PLL ___ DDR DIV ___|     |
+	 *                                |_____|
+	 */
+	clk = clk_register_divider(NULL, "ahb_clk_div", "pll_clk",
+				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
+				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
+				   &_lock);
+	clk_register_clkdev(clk, "ahb_clk_div", NULL);
+	clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
+			       ARRAY_SIZE(ahb_parents),
+			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
+			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
+	clk_register_clkdev(clk, "ahb_clk", NULL);
 	clk_register_clkdev(clk, "stmmaceth", NULL);
 
-	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1, 2);
-	clk_prepare_enable(clk);
-	clk_register_clkdev(clk, "apb", NULL);
+	/* clock derived from AHB clk */
+	/* APB clk is always half of the AHB clk */
+	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
+					DIV_APB);
+	clk_register_clkdev(clk, "apb_clk", NULL);
+	clk_register_clkdev(clk, "ls1x_i2c", NULL);
+	clk_register_clkdev(clk, "ls1x_pwmtimer", NULL);
+	clk_register_clkdev(clk, "ls1x_spi", NULL);
+	clk_register_clkdev(clk, "ls1x_wdt", NULL);
 	clk_register_clkdev(clk, "serial8250", NULL);
 }
-- 
1.9.1
