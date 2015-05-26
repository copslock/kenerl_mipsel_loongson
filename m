Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 00:08:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18505 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007054AbbEZWIZm62Sl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 00:08:25 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 694C2E00C4407;
        Tue, 26 May 2015 23:08:17 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 26 May
 2015 23:05:16 +0100
Received: from laptop.hh.imgtec.org (10.100.200.175) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 26 May
 2015 23:05:15 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        "Mike Turquette" <mturquette@linaro.org>, <sboyd@codeaurora.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, <cernekee@chromium.org>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 2/3] clk: pistachio: Lock the PLL when enabled upon rate change
Date:   Tue, 26 May 2015 19:01:08 -0300
Message-ID: <1432677669-29581-3-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1432677669-29581-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432677669-29581-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.175]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47683
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

Currently, when the rate is changed, the driver makes sure the
PLL is enabled before doing so. This is done because the PLL
cannot be locked while disabled. Once locked, the drivers
returns the PLL to its previous enable/disable state.

This is a bit cumbersome, and can be simplified.

This commit reworks the .set_rate() functions for the integer
and fractional PLLs. Upon rate change, the PLL is now locked
only if it's already enabled.

Also, the driver locks the PLL on .enable(). This makes sure
the PLL is locked when enabled, and not locked when disabled.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/clk/pistachio/clk-pll.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
index 9ce1be7..f12d520 100644
--- a/drivers/clk/pistachio/clk-pll.c
+++ b/drivers/clk/pistachio/clk-pll.c
@@ -130,6 +130,8 @@ static int pll_gf40lp_frac_enable(struct clk_hw *hw)
 	val &= ~PLL_FRAC_CTRL4_BYPASS;
 	pll_writel(pll, val, PLL_CTRL4);
 
+	pll_lock(pll);
+
 	return 0;
 }
 
@@ -155,17 +157,13 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
 	struct pistachio_pll_rate_table *params;
-	bool was_enabled;
+	int enabled = pll_gf40lp_frac_is_enabled(hw);
 	u32 val;
 
 	params = pll_get_params(pll, parent_rate, rate);
 	if (!params)
 		return -EINVAL;
 
-	was_enabled = pll_gf40lp_frac_is_enabled(hw);
-	if (!was_enabled)
-		pll_gf40lp_frac_enable(hw);
-
 	val = pll_readl(pll, PLL_CTRL1);
 	val &= ~((PLL_CTRL1_REFDIV_MASK << PLL_CTRL1_REFDIV_SHIFT) |
 		 (PLL_CTRL1_FBDIV_MASK << PLL_CTRL1_FBDIV_SHIFT));
@@ -184,10 +182,8 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 		(params->postdiv2 << PLL_FRAC_CTRL2_POSTDIV2_SHIFT);
 	pll_writel(pll, val, PLL_CTRL2);
 
-	pll_lock(pll);
-
-	if (!was_enabled)
-		pll_gf40lp_frac_disable(hw);
+	if (enabled)
+		pll_lock(pll);
 
 	return 0;
 }
@@ -246,6 +242,8 @@ static int pll_gf40lp_laint_enable(struct clk_hw *hw)
 	val &= ~PLL_INT_CTRL2_BYPASS;
 	pll_writel(pll, val, PLL_CTRL2);
 
+	pll_lock(pll);
+
 	return 0;
 }
 
@@ -271,17 +269,13 @@ static int pll_gf40lp_laint_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
 	struct pistachio_pll_rate_table *params;
-	bool was_enabled;
+	int enabled = pll_gf40lp_laint_is_enabled(hw);
 	u32 val;
 
 	params = pll_get_params(pll, parent_rate, rate);
 	if (!params)
 		return -EINVAL;
 
-	was_enabled = pll_gf40lp_laint_is_enabled(hw);
-	if (!was_enabled)
-		pll_gf40lp_laint_enable(hw);
-
 	val = pll_readl(pll, PLL_CTRL1);
 	val &= ~((PLL_CTRL1_REFDIV_MASK << PLL_CTRL1_REFDIV_SHIFT) |
 		 (PLL_CTRL1_FBDIV_MASK << PLL_CTRL1_FBDIV_SHIFT) |
@@ -293,10 +287,8 @@ static int pll_gf40lp_laint_set_rate(struct clk_hw *hw, unsigned long rate,
 		(params->postdiv2 << PLL_INT_CTRL1_POSTDIV2_SHIFT);
 	pll_writel(pll, val, PLL_CTRL1);
 
-	pll_lock(pll);
-
-	if (!was_enabled)
-		pll_gf40lp_laint_disable(hw);
+	if (enabled)
+		pll_lock(pll);
 
 	return 0;
 }
-- 
2.3.3
