Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 15:45:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12365 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012535AbbHFNolNUSlI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 15:44:41 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 540DF576F620E;
        Thu,  6 Aug 2015 14:44:32 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 14:44:35 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 6 Aug 2015 14:44:34 +0100
From:   Govindraj Raja <govindraj.raja@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-clk@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Michael Turquette" <mturquette@baylibre.com>
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
Subject: [PATCH 4/6] clk: pistachio: Set operating mode in .set_rate
Date:   Thu, 6 Aug 2015 14:43:32 +0100
Message-ID: <1438868614-7672-5-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438868614-7672-1-git-send-email-govindraj.raja@imgtec.com>
References: <1438868614-7672-1-git-send-email-govindraj.raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48682
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

This commit sets operating mode of fractional pll based on
the value of the fractional divider. Currently it assumes that
the pll will always be configured in fractional mode which may not be
the case. This may result in the wrong output frequency.

Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
---
 drivers/clk/pistachio/clk-pll.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
index 8802b2e..eb91748 100644
--- a/drivers/clk/pistachio/clk-pll.c
+++ b/drivers/clk/pistachio/clk-pll.c
@@ -112,6 +112,20 @@ static inline u32 pll_frac_get_mode(struct clk_hw *hw)
 	return val ? PLL_MODE_INT : PLL_MODE_FRAC;
 }
 
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
@@ -245,6 +259,12 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
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
 
-- 
1.9.1
