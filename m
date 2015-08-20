Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2015 15:47:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47640 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012310AbbHTNrXlUOej (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Aug 2015 15:47:23 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 01461F2F0A307;
        Thu, 20 Aug 2015 14:47:15 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 20 Aug
 2015 14:47:17 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 20 Aug 2015 14:47:17 +0100
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
Subject: [PATCH v5 2/4] clk: pistachio: Fix override of clk-pll settings from boot loader
Date:   Thu, 20 Aug 2015 14:45:53 +0100
Message-ID: <1440078355-8828-3-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1440078355-8828-1-git-send-email-govindraj.raja@imgtec.com>
References: <1440078355-8828-1-git-send-email-govindraj.raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48969
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

PLL enable callbacks are overriding PLL mode (int/frac) and
Noise reduction (on/off) settings set by the boot loader which
results in the incorrect clock rate.

PLL mode and noise reduction are defined by the DSMPD and DACPD bits
of the PLL control register. PLL .enable() callbacks enable PLL
by deasserting all power-down bits of the PLL control register,
including DSMPD and DACPD bits, which is not necessary since
these bits don't actually enable/disable PLL.

This commit fixes the problem by removing DSMPD and DACPD bits
from the "PLL enable" mask.

Reviewed-by: Andrew Bresitcker <abrestic@chromium.org>
Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
---
 drivers/clk/pistachio/clk-pll.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
index 68066ef..9a38a2b 100644
--- a/drivers/clk/pistachio/clk-pll.c
+++ b/drivers/clk/pistachio/clk-pll.c
@@ -134,8 +134,7 @@ static int pll_gf40lp_frac_enable(struct clk_hw *hw)
 	u32 val;
 
 	val = pll_readl(pll, PLL_CTRL3);
-	val &= ~(PLL_FRAC_CTRL3_PD | PLL_FRAC_CTRL3_DACPD |
-		 PLL_FRAC_CTRL3_DSMPD | PLL_FRAC_CTRL3_FOUTPOSTDIVPD |
+	val &= ~(PLL_FRAC_CTRL3_PD | PLL_FRAC_CTRL3_FOUTPOSTDIVPD |
 		 PLL_FRAC_CTRL3_FOUT4PHASEPD | PLL_FRAC_CTRL3_FOUTVCOPD);
 	pll_writel(pll, val, PLL_CTRL3);
 
@@ -277,7 +276,7 @@ static int pll_gf40lp_laint_enable(struct clk_hw *hw)
 	u32 val;
 
 	val = pll_readl(pll, PLL_CTRL1);
-	val &= ~(PLL_INT_CTRL1_PD | PLL_INT_CTRL1_DSMPD |
+	val &= ~(PLL_INT_CTRL1_PD |
 		 PLL_INT_CTRL1_FOUTPOSTDIVPD | PLL_INT_CTRL1_FOUTVCOPD);
 	pll_writel(pll, val, PLL_CTRL1);
 
-- 
1.9.1
