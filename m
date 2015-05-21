Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 02:03:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31266 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006702AbbEVADU3RiQu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 02:03:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E59D46EBECC8E;
        Fri, 22 May 2015 01:03:12 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 01:02:12 +0100
Received: from laptop.hh.imgtec.org (10.100.200.44) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 01:02:10 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        "Mike Turquette" <mturquette@linaro.org>, <sboyd@codeaurora.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        <cernekee@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 3/9] clk: pistachio: Implement PLL rate adjustment
Date:   Thu, 21 May 2015 20:57:37 -0300
Message-ID: <1432252663-31318-4-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.44]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

This commit implements small rate changes to the fractional PLL.
This is done using the PLL frac parameter. The .set_rate function
first finds the parameters associated to the closest nominal rate.

Then the new rate is set, using parameters from the table entry,
except for the frac parameter, which is calculated from the rate
using the fractional PLL rate formula.

Using .round_rate, the driver guarantees that only rates near
a table nominal rate is applied. To this extent, add two parameters
fout_min and fout_max, which allows to define the allowed rate
adjustment.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/clk/pistachio/clk-pll.c | 48 +++++++++++++++++++++++++++++++----------
 drivers/clk/pistachio/clk.h     |  2 ++
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
index f12d520..cf000bb 100644
--- a/drivers/clk/pistachio/clk-pll.c
+++ b/drivers/clk/pistachio/clk-pll.c
@@ -90,29 +90,50 @@ static struct pistachio_pll_rate_table *
 pll_get_params(struct pistachio_clk_pll *pll, unsigned long fref,
 	       unsigned long fout)
 {
-	unsigned int i;
+	unsigned int i, best;
+	unsigned long err, best_err = ~0;
 
 	for (i = 0; i < pll->nr_rates; i++) {
-		if (pll->rates[i].fref == fref && pll->rates[i].fout == fout)
-			return &pll->rates[i];
+		err = abs(pll->rates[i].fout - fout);
+		if (pll->rates[i].fref == fref && err < best_err) {
+			best = i;
+			best_err = err;
+		}
 	}
 
-	return NULL;
+	return &pll->rates[best];
 }
 
 static long pll_round_rate(struct clk_hw *hw, unsigned long rate,
 			   unsigned long *parent_rate)
 {
 	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
-	unsigned int i;
+	unsigned int i, best;
+	unsigned long err, best_err = ~0;
 
 	for (i = 0; i < pll->nr_rates; i++) {
-		if (i > 0 && pll->rates[i].fref == *parent_rate &&
-		    pll->rates[i].fout <= rate)
-			return pll->rates[i - 1].fout;
+		err = abs(pll->rates[i].fout - rate);
+		if (pll->rates[i].fref == *parent_rate && err < best_err) {
+			best = i;
+			best_err = err;
+		}
 	}
 
-	return pll->rates[0].fout;
+	/* Make sure fout_{min,max} parameters have sane values */
+	if (!pll->rates[best].fout_min)
+		pll->rates[best].fout_min = pll->rates[best].fout;
+	if (!pll->rates[best].fout_max)
+		pll->rates[best].fout_max = pll->rates[best].fout;
+
+	/*
+	 * If the chosen rate is within the maximum allowed PLL adjustment
+	 * then we accept it.
+	 * Otherwise, just return the closest nominal table rate.
+	 */
+	if (rate <= pll->rates[best].fout_max &&
+	    rate >= pll->rates[best].fout_min)
+		return rate;
+	return pll->rates[best].fout;
 }
 
 static int pll_gf40lp_frac_enable(struct clk_hw *hw)
@@ -158,12 +179,17 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
 	struct pistachio_pll_rate_table *params;
 	int enabled = pll_gf40lp_frac_is_enabled(hw);
-	u32 val;
+	u32 val, frac;
 
 	params = pll_get_params(pll, parent_rate, rate);
 	if (!params)
 		return -EINVAL;
 
+	/* Calculate the frac parameter */
+	frac = rate * params->refdiv * params->postdiv1 * params->postdiv2;
+	frac -= (params->fbdiv * parent_rate);
+	frac = do_div_round_closest((u64)frac << 24, parent_rate);
+
 	val = pll_readl(pll, PLL_CTRL1);
 	val &= ~((PLL_CTRL1_REFDIV_MASK << PLL_CTRL1_REFDIV_SHIFT) |
 		 (PLL_CTRL1_FBDIV_MASK << PLL_CTRL1_FBDIV_SHIFT));
@@ -177,7 +203,7 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 		  PLL_FRAC_CTRL2_POSTDIV1_SHIFT) |
 		 (PLL_FRAC_CTRL2_POSTDIV2_MASK <<
 		  PLL_FRAC_CTRL2_POSTDIV2_SHIFT));
-	val |= (params->frac << PLL_FRAC_CTRL2_FRAC_SHIFT) |
+	val |= (frac << PLL_FRAC_CTRL2_FRAC_SHIFT) |
 		(params->postdiv1 << PLL_FRAC_CTRL2_POSTDIV1_SHIFT) |
 		(params->postdiv2 << PLL_FRAC_CTRL2_POSTDIV2_SHIFT);
 	pll_writel(pll, val, PLL_CTRL2);
diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
index 52fabbc..ea48d15 100644
--- a/drivers/clk/pistachio/clk.h
+++ b/drivers/clk/pistachio/clk.h
@@ -97,6 +97,8 @@ struct pistachio_fixed_factor {
 struct pistachio_pll_rate_table {
 	unsigned long fref;
 	unsigned long fout;
+	unsigned long fout_min;
+	unsigned long fout_max;
 	unsigned int refdiv;
 	unsigned int fbdiv;
 	unsigned int postdiv1;
-- 
2.3.3
