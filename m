Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 15:34:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3556 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007967AbbFBNeDKV4G4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 15:34:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1DD35A426F161;
        Mon,  1 Jun 2015 22:45:52 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 1 Jun
 2015 22:45:55 +0100
Received: from laptop.hh.imgtec.org (10.100.200.209) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Mon, 1 Jun
 2015 22:45:53 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Mike Turquette <mturquette@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        "Kevin Cernekee" <cernekee@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v2] clk: pistachio: Add sanity checks on PLL configuration
Date:   Mon, 1 Jun 2015 18:42:28 -0300
Message-ID: <1433194948-22789-1-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.209]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47791
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

From: Kevin Cernekee <cernekee@chromium.org>

When setting the PLL rates, check that:

 - VCO is within range
 - PFD is within range
 - PLL is disabled when postdiv is changed
 - postdiv2 <= postdiv1

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
Changes from v1:
 * Rebased on Ralf's mips-linux-next-test branch.

 drivers/clk/pistachio/clk-pll.c | 83 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
index f12d520..e17dada 100644
--- a/drivers/clk/pistachio/clk-pll.c
+++ b/drivers/clk/pistachio/clk-pll.c
@@ -6,9 +6,12 @@
  * version 2, as published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/printk.h>
 #include <linux/slab.h>
 
 #include "clk.h"
@@ -50,6 +53,18 @@
 #define PLL_CTRL4			0x10
 #define PLL_FRAC_CTRL4_BYPASS		BIT(28)
 
+#define MIN_PFD				9600000UL
+#define MIN_VCO_LA			400000000UL
+#define MAX_VCO_LA			1600000000UL
+#define MIN_VCO_FRAC_INT		600000000UL
+#define MAX_VCO_FRAC_INT		1600000000UL
+#define MIN_VCO_FRAC_FRAC		600000000UL
+#define MAX_VCO_FRAC_FRAC		2400000000UL
+#define MIN_OUTPUT_LA			8000000UL
+#define MAX_OUTPUT_LA			1600000000UL
+#define MIN_OUTPUT_FRAC			12000000UL
+#define MAX_OUTPUT_FRAC			1600000000UL
+
 struct pistachio_clk_pll {
 	struct clk_hw hw;
 	void __iomem *base;
@@ -158,12 +173,29 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
 	struct pistachio_pll_rate_table *params;
 	int enabled = pll_gf40lp_frac_is_enabled(hw);
-	u32 val;
+	u32 val, vco, old_postdiv1, old_postdiv2;
+	const char *name = __clk_get_name(hw->clk);
+
+	if (rate < MIN_OUTPUT_FRAC || rate > MAX_OUTPUT_FRAC)
+		return -EINVAL;
 
 	params = pll_get_params(pll, parent_rate, rate);
-	if (!params)
+	if (!params || !params->refdiv)
 		return -EINVAL;
 
+	vco = params->fref * params->fbdiv / params->refdiv;
+	if (vco < MIN_VCO_FRAC_FRAC || vco > MAX_VCO_FRAC_FRAC)
+		pr_warn("%s: VCO %u is out of range %lu..%lu\n", name, vco,
+			MIN_VCO_FRAC_FRAC, MAX_VCO_FRAC_FRAC);
+
+	val = params->fref / params->refdiv;
+	if (val < MIN_PFD)
+		pr_warn("%s: PFD %u is too low (min %lu)\n",
+			name, val, MIN_PFD);
+	if (val > vco / 16)
+		pr_warn("%s: PFD %u is too high (max %u)\n",
+			name, val, vco / 16);
+
 	val = pll_readl(pll, PLL_CTRL1);
 	val &= ~((PLL_CTRL1_REFDIV_MASK << PLL_CTRL1_REFDIV_SHIFT) |
 		 (PLL_CTRL1_FBDIV_MASK << PLL_CTRL1_FBDIV_SHIFT));
@@ -172,6 +204,19 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 	pll_writel(pll, val, PLL_CTRL1);
 
 	val = pll_readl(pll, PLL_CTRL2);
+
+	old_postdiv1 = (val >> PLL_FRAC_CTRL2_POSTDIV1_SHIFT) &
+		       PLL_FRAC_CTRL2_POSTDIV1_MASK;
+	old_postdiv2 = (val >> PLL_FRAC_CTRL2_POSTDIV2_SHIFT) &
+		       PLL_FRAC_CTRL2_POSTDIV2_MASK;
+	if (enabled &&
+	    (params->postdiv1 != old_postdiv1 ||
+	     params->postdiv2 != old_postdiv2))
+		pr_warn("%s: changing postdiv while PLL is enabled\n", name);
+
+	if (params->postdiv2 > params->postdiv1)
+		pr_warn("%s: postdiv2 should not exceed postdiv1\n", name);
+
 	val &= ~((PLL_FRAC_CTRL2_FRAC_MASK << PLL_FRAC_CTRL2_FRAC_SHIFT) |
 		 (PLL_FRAC_CTRL2_POSTDIV1_MASK <<
 		  PLL_FRAC_CTRL2_POSTDIV1_SHIFT) |
@@ -270,13 +315,43 @@ static int pll_gf40lp_laint_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct pistachio_clk_pll *pll = to_pistachio_pll(hw);
 	struct pistachio_pll_rate_table *params;
 	int enabled = pll_gf40lp_laint_is_enabled(hw);
-	u32 val;
+	u32 val, vco, old_postdiv1, old_postdiv2;
+	const char *name = __clk_get_name(hw->clk);
+
+	if (rate < MIN_OUTPUT_LA || rate > MAX_OUTPUT_LA)
+		return -EINVAL;
 
 	params = pll_get_params(pll, parent_rate, rate);
-	if (!params)
+	if (!params || !params->refdiv)
 		return -EINVAL;
 
+	vco = params->fref * params->fbdiv / params->refdiv;
+	if (vco < MIN_VCO_LA || vco > MAX_VCO_LA)
+		pr_warn("%s: VCO %u is out of range %lu..%lu\n", name, vco,
+			MIN_VCO_LA, MAX_VCO_LA);
+
+	val = params->fref / params->refdiv;
+	if (val < MIN_PFD)
+		pr_warn("%s: PFD %u is too low (min %lu)\n",
+			name, val, MIN_PFD);
+	if (val > vco / 16)
+		pr_warn("%s: PFD %u is too high (max %u)\n",
+			name, val, vco / 16);
+
 	val = pll_readl(pll, PLL_CTRL1);
+
+	old_postdiv1 = (val >> PLL_INT_CTRL1_POSTDIV1_SHIFT) &
+		       PLL_INT_CTRL1_POSTDIV1_MASK;
+	old_postdiv2 = (val >> PLL_INT_CTRL1_POSTDIV2_SHIFT) &
+		       PLL_INT_CTRL1_POSTDIV2_MASK;
+	if (enabled &&
+	    (params->postdiv1 != old_postdiv1 ||
+	     params->postdiv2 != old_postdiv2))
+		pr_warn("%s: changing postdiv while PLL is enabled\n", name);
+
+	if (params->postdiv2 > params->postdiv1)
+		pr_warn("%s: postdiv2 should not exceed postdiv1\n", name);
+
 	val &= ~((PLL_CTRL1_REFDIV_MASK << PLL_CTRL1_REFDIV_SHIFT) |
 		 (PLL_CTRL1_FBDIV_MASK << PLL_CTRL1_FBDIV_SHIFT) |
 		 (PLL_INT_CTRL1_POSTDIV1_MASK << PLL_INT_CTRL1_POSTDIV1_SHIFT) |
-- 
2.3.3
