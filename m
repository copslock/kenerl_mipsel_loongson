Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2015 11:33:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40496 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012269AbbHRJc7RH9vv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Aug 2015 11:32:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ABD339D029065;
        Tue, 18 Aug 2015 10:32:51 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 18 Aug
 2015 10:32:53 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 18 Aug 2015 10:32:52 +0100
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
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>
Subject: [PATCH v4 3/4] clk: pistachio: Fix PLL rate calculation in integer mode
Date:   Tue, 18 Aug 2015 10:32:16 +0100
Message-ID: <1439890337-13803-4-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1439890337-13803-1-git-send-email-govindraj.raja@imgtec.com>
References: <1439890337-13803-1-git-send-email-govindraj.raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48935
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

.recalc_rate callback for the fractional PLL doesn't take operating
mode into account when calculating PLL rate. This results in
the incorrect PLL rates when PLL is operating in integer mode.

Operating mode of fractional PLL is based on the value of the
fractional divider. Currently it assumes that the PLL will always
be configured in fractional mode which may not be
the case. This may result in the wrong output frequency.

Also vco was calculated based on the current operating mode which
makes no sense because .set_rate is setting operating mode. Instead,
vco should be calculated using PLL settings that are about to be set.

Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
---
 drivers/clk/pistachio/clk-pll.c | 46 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
index 9a38a2b..5554fa4 100644
--- a/drivers/clk/pistachio/clk-pll.c
+++ b/drivers/clk/pistachio/clk-pll.c
@@ -65,6 +65,10 @@
 #define MIN_OUTPUT_FRAC			12000000UL
 #define MAX_OUTPUT_FRAC			1600000000UL
 
+/* Fractional PLL operating modes */
+#define PLL_MODE_INT			1
+#define PLL_MODE_FRAC			0
+
 struct pistachio_clk_pll {
 	struct clk_hw hw;
 	void __iomem *base;
@@ -99,6 +103,29 @@ static inline struct pistachio_clk_pll *to_pistachio_pll(struct clk_hw *hw)
 	return container_of(hw, struct pistachio_clk_pll, hw);
 }
 
+static inline u32 pll_frac_get_mode(struct clk_hw *hw)
+{
+	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
+	u32 val;
+
+	val = pll_readl(pll, PLL_CTRL3) & PLL_FRAC_CTRL3_DSMPD;
+	return val ? PLL_MODE_INT : PLL_MODE_FRAC;
+}
+
+static inline void pll_frac_set_mode(struct clk_hw *hw, u32 mode)
+{
+	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
+	u32 val;
+
+	val = pll_readl(pll, PLL_CTRL3);
+	if (mode == PLL_MODE_INT)
+		val |= PLL_FRAC_CTRL3_DSMPD | PLL_FRAC_CTRL3_DACPD;
+	else
+		val &= ~(PLL_FRAC_CTRL3_DSMPD | PLL_FRAC_CTRL3_DACPD);
+
+	pll_writel(pll, val, PLL_CTRL3);
+}
+
 static struct pistachio_pll_rate_table *
 pll_get_params(struct pistachio_clk_pll *pll, unsigned long fref,
 	       unsigned long fout)
@@ -180,7 +207,11 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!params || !params->refdiv)
 		return -EINVAL;
 
-	vco = div64_u64(params->fref * params->fbdiv, params->refdiv);
+	/* calculate vco */
+	vco = params->fref;
+	vco *= (params->fbdiv << 24) + params->frac;
+	vco = div64_u64(vco, params->refdiv << 24);
+
 	if (vco < MIN_VCO_FRAC_FRAC || vco > MAX_VCO_FRAC_FRAC)
 		pr_warn("%s: VCO %llu is out of range %lu..%lu\n", name, vco,
 			MIN_VCO_FRAC_FRAC, MAX_VCO_FRAC_FRAC);
@@ -224,6 +255,12 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 		(params->postdiv2 << PLL_FRAC_CTRL2_POSTDIV2_SHIFT);
 	pll_writel(pll, val, PLL_CTRL2);
 
+	/* set operating mode */
+	if (params->frac)
+		pll_frac_set_mode(hw, PLL_MODE_FRAC);
+	else
+		pll_frac_set_mode(hw, PLL_MODE_INT);
+
 	if (enabled)
 		pll_lock(pll);
 
@@ -247,8 +284,13 @@ static unsigned long pll_gf40lp_frac_recalc_rate(struct clk_hw *hw,
 		PLL_FRAC_CTRL2_POSTDIV2_MASK;
 	frac = (val >> PLL_FRAC_CTRL2_FRAC_SHIFT) & PLL_FRAC_CTRL2_FRAC_MASK;
 
+	/* get operating mode (int/frac) and calculate rate accordingly */
 	rate = parent_rate;
-	rate *= (fbdiv << 24) + frac;
+	if (pll_frac_get_mode(hw) == PLL_MODE_FRAC)
+		rate *= (fbdiv << 24) + frac;
+	else
+		rate *= (fbdiv << 24);
+
 	rate = do_div_round_closest(rate, (prediv * postdiv1 * postdiv2) << 24);
 
 	return rate;
-- 
1.9.1
