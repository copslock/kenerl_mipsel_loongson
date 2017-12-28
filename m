Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 14:58:12 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:48998 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990493AbdL1N4wFBk35 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 14:56:52 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 04/15] clk: ingenic: Add code to enable/disable PLLs
Date:   Thu, 28 Dec 2017 14:56:23 +0100
Message-Id: <20171228135634.30000-5-paul@crapouillou.net>
In-Reply-To: <20171228135634.30000-1-paul@crapouillou.net>
References: <20170702163016.6714-2-paul@crapouillou.net>
 <20171228135634.30000-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514469411; bh=T55H2JZlPEyn8rsHOL1obCnWPJFaauantp41PHF4K4w=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=wBKUaWGaspjgKxYEwxUmN4C/8ldLwXH12PazBGk41qZPrj6c8D2rH80n8zysdsW3OzPC4WqT3DeIFWu7Ea2EG78RKXKtuOH7ZpT5+T/xCkEvL3Ce9x8MrxC5Cqe7DrWUkDOFW2iGVRgaDFZYk/pvBC2OMoSLgBeOIxKcaph9jFw=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

This commit permits the PLLs to be dynamically enabled and disabled when
their children clocks are enabled and disabled.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 89 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 15 deletions(-)

 v2: No change
 v3: No change
 v4: No change

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 381c4a17a1fc..56a712c9075f 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -107,9 +107,6 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	if (bypass)
 		return parent_rate;
 
-	if (!enable)
-		return 0;
-
 	for (od = 0; od < pll_info->od_max; od++) {
 		if (pll_info->od_encoding[od] == od_enc)
 			break;
@@ -153,17 +150,25 @@ ingenic_pll_calc(const struct ingenic_cgu_clk_info *clk_info,
 	return div_u64((u64)parent_rate * m, n * od);
 }
 
-static long
-ingenic_pll_round_rate(struct clk_hw *hw, unsigned long req_rate,
-		       unsigned long *prate)
+static inline const struct ingenic_cgu_clk_info *to_clk_info(
+		struct ingenic_clk *ingenic_clk)
 {
-	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
 	const struct ingenic_cgu_clk_info *clk_info;
 
 	clk_info = &cgu->clock_info[ingenic_clk->idx];
 	BUG_ON(clk_info->type != CGU_CLK_PLL);
 
+	return clk_info;
+}
+
+static long
+ingenic_pll_round_rate(struct clk_hw *hw, unsigned long req_rate,
+		       unsigned long *prate)
+{
+	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
+
 	return ingenic_pll_calc(clk_info, req_rate, *prate, NULL, NULL, NULL);
 }
 
@@ -171,19 +176,14 @@ static int
 ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 		     unsigned long parent_rate)
 {
-	const unsigned timeout = 100;
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
-	const struct ingenic_cgu_clk_info *clk_info;
-	const struct ingenic_cgu_pll_info *pll_info;
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
+	const struct ingenic_cgu_pll_info *pll_info = &clk_info->pll;
 	unsigned long rate, flags;
-	unsigned m, n, od, i;
+	unsigned int m, n, od;
 	u32 ctl;
 
-	clk_info = &cgu->clock_info[ingenic_clk->idx];
-	BUG_ON(clk_info->type != CGU_CLK_PLL);
-	pll_info = &clk_info->pll;
-
 	rate = ingenic_pll_calc(clk_info, req_rate, parent_rate,
 			       &m, &n, &od);
 	if (rate != req_rate)
@@ -202,6 +202,26 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	ctl &= ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
 	ctl |= pll_info->od_encoding[od - 1] << pll_info->od_shift;
 
+	writel(ctl, cgu->base + pll_info->reg);
+	spin_unlock_irqrestore(&cgu->lock, flags);
+
+	return 0;
+}
+
+static int ingenic_pll_enable(struct clk_hw *hw)
+{
+	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	struct ingenic_cgu *cgu = ingenic_clk->cgu;
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
+	const struct ingenic_cgu_pll_info *pll_info = &clk_info->pll;
+	const unsigned int timeout = 100;
+	unsigned long flags;
+	unsigned int i;
+	u32 ctl;
+
+	spin_lock_irqsave(&cgu->lock, flags);
+	ctl = readl(cgu->base + pll_info->reg);
+
 	ctl &= ~BIT(pll_info->bypass_bit);
 	ctl |= BIT(pll_info->enable_bit);
 
@@ -223,10 +243,48 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	return 0;
 }
 
+static void ingenic_pll_disable(struct clk_hw *hw)
+{
+	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	struct ingenic_cgu *cgu = ingenic_clk->cgu;
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
+	const struct ingenic_cgu_pll_info *pll_info = &clk_info->pll;
+	unsigned long flags;
+	u32 ctl;
+
+	spin_lock_irqsave(&cgu->lock, flags);
+	ctl = readl(cgu->base + pll_info->reg);
+
+	ctl &= ~BIT(pll_info->enable_bit);
+
+	writel(ctl, cgu->base + pll_info->reg);
+	spin_unlock_irqrestore(&cgu->lock, flags);
+}
+
+static int ingenic_pll_is_enabled(struct clk_hw *hw)
+{
+	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
+	struct ingenic_cgu *cgu = ingenic_clk->cgu;
+	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
+	const struct ingenic_cgu_pll_info *pll_info = &clk_info->pll;
+	unsigned long flags;
+	u32 ctl;
+
+	spin_lock_irqsave(&cgu->lock, flags);
+	ctl = readl(cgu->base + pll_info->reg);
+	spin_unlock_irqrestore(&cgu->lock, flags);
+
+	return !!(ctl & BIT(pll_info->enable_bit));
+}
+
 static const struct clk_ops ingenic_pll_ops = {
 	.recalc_rate = ingenic_pll_recalc_rate,
 	.round_rate = ingenic_pll_round_rate,
 	.set_rate = ingenic_pll_set_rate,
+
+	.enable = ingenic_pll_enable,
+	.disable = ingenic_pll_disable,
+	.is_enabled = ingenic_pll_is_enabled,
 };
 
 /*
@@ -601,6 +659,7 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 		}
 	} else if (caps & CGU_CLK_PLL) {
 		clk_init.ops = &ingenic_pll_ops;
+		clk_init.flags |= CLK_SET_RATE_GATE;
 
 		caps &= ~CGU_CLK_PLL;
 
-- 
2.11.0
