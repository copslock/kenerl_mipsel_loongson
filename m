Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 18:21:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51309 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012332AbbHGQU6jal6x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 18:20:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 5892E5ACC85B5;
        Fri,  7 Aug 2015 17:20:49 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 7 Aug
 2015 17:20:52 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 7 Aug 2015 17:20:51 +0100
From:   Govindraj Raja <govindraj.raja@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        Govindraj Raja <govindraj.raja@imgtec.com>
Subject: [PATCH v2 1/4] clk: pistachio: Fix 32bit integer overflows
Date:   Fri, 7 Aug 2015 17:20:10 +0100
Message-ID: <1438964413-18876-2-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438964413-18876-1-git-send-email-govindraj.raja@imgtec.com>
References: <1438964413-18876-1-git-send-email-govindraj.raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: govindraj.raja@imgtec.com
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

From: Zdenko Pulitika <zdenko.pulitika@imgtec.com>

This commit fixes 32bit integer overflows throughout the pll driver
(i.e. wherever the result of integer multiplication may exceed the
range of u32).

One of the functions affected by this problem is .recalc_rate. It
returns incorrect rate for some pll settings (not for all though)
which in turn results in the incorrect rate setup of pll's child
clocks.

Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
---
 drivers/clk/pistachio/clk-pll.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
index e17dada..68066ef 100644
--- a/drivers/clk/pistachio/clk-pll.c
+++ b/drivers/clk/pistachio/clk-pll.c
@@ -88,12 +88,10 @@ static inline void pll_lock(struct pistachio_clk_pll *pll)
 		cpu_relax();
 }
 
-static inline u32 do_div_round_closest(u64 dividend, u32 divisor)
+static inline u64 do_div_round_closest(u64 dividend, u64 divisor)
 {
 	dividend += divisor / 2;
-	do_div(dividend, divisor);
-
-	return dividend;
+	return div64_u64(dividend, divisor);
 }
 
 static inline struct pistachio_clk_pll *to_pistachio_pll(struct clk_hw *hw)
@@ -173,7 +171,7 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
 	struct pistachio_pll_rate_table *params;
 	int enabled = pll_gf40lp_frac_is_enabled(hw);
-	u32 val, vco, old_postdiv1, old_postdiv2;
+	u64 val, vco, old_postdiv1, old_postdiv2;
 	const char *name = __clk_get_name(hw->clk);
 
 	if (rate < MIN_OUTPUT_FRAC || rate > MAX_OUTPUT_FRAC)
@@ -183,17 +181,17 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!params || !params->refdiv)
 		return -EINVAL;
 
-	vco = params->fref * params->fbdiv / params->refdiv;
+	vco = div64_u64(params->fref * params->fbdiv, params->refdiv);
 	if (vco < MIN_VCO_FRAC_FRAC || vco > MAX_VCO_FRAC_FRAC)
-		pr_warn("%s: VCO %u is out of range %lu..%lu\n", name, vco,
+		pr_warn("%s: VCO %llu is out of range %lu..%lu\n", name, vco,
 			MIN_VCO_FRAC_FRAC, MAX_VCO_FRAC_FRAC);
 
-	val = params->fref / params->refdiv;
+	val = div64_u64(params->fref, params->refdiv);
 	if (val < MIN_PFD)
-		pr_warn("%s: PFD %u is too low (min %lu)\n",
+		pr_warn("%s: PFD %llu is too low (min %lu)\n",
 			name, val, MIN_PFD);
 	if (val > vco / 16)
-		pr_warn("%s: PFD %u is too high (max %u)\n",
+		pr_warn("%s: PFD %llu is too high (max %llu)\n",
 			name, val, vco / 16);
 
 	val = pll_readl(pll, PLL_CTRL1);
@@ -237,8 +235,7 @@ static unsigned long pll_gf40lp_frac_recalc_rate(struct clk_hw *hw,
 						 unsigned long parent_rate)
 {
 	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
-	u32 val, prediv, fbdiv, frac, postdiv1, postdiv2;
-	u64 rate = parent_rate;
+	u64 val, prediv, fbdiv, frac, postdiv1, postdiv2, rate;
 
 	val = pll_readl(pll, PLL_CTRL1);
 	prediv = (val >> PLL_CTRL1_REFDIV_SHIFT) & PLL_CTRL1_REFDIV_MASK;
@@ -251,6 +248,7 @@ static unsigned long pll_gf40lp_frac_recalc_rate(struct clk_hw *hw,
 		PLL_FRAC_CTRL2_POSTDIV2_MASK;
 	frac = (val >> PLL_FRAC_CTRL2_FRAC_SHIFT) & PLL_FRAC_CTRL2_FRAC_MASK;
 
+	rate = parent_rate;
 	rate *= (fbdiv << 24) + frac;
 	rate = do_div_round_closest(rate, (prediv * postdiv1 * postdiv2) << 24);
 
@@ -325,12 +323,12 @@ static int pll_gf40lp_laint_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!params || !params->refdiv)
 		return -EINVAL;
 
-	vco = params->fref * params->fbdiv / params->refdiv;
+	vco = div_u64(params->fref * params->fbdiv, params->refdiv);
 	if (vco < MIN_VCO_LA || vco > MAX_VCO_LA)
 		pr_warn("%s: VCO %u is out of range %lu..%lu\n", name, vco,
 			MIN_VCO_LA, MAX_VCO_LA);
 
-	val = params->fref / params->refdiv;
+	val = div_u64(params->fref, params->refdiv);
 	if (val < MIN_PFD)
 		pr_warn("%s: PFD %u is too low (min %lu)\n",
 			name, val, MIN_PFD);
-- 
1.9.1
