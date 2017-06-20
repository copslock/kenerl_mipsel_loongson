Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 17:25:33 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:36978 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993906AbdFTPTivheDi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 17:19:38 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 03/17] clk: ingenic: support PLLs with no bypass bit
Date:   Tue, 20 Jun 2017 17:18:41 +0200
Message-Id: <20170620151855.19399-3-paul@crapouillou.net>
In-Reply-To: <20170620151855.19399-1-paul@crapouillou.net>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170620151855.19399-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58707
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

The second PLL of the JZ4770 does not have a bypass bit.
This commit makes it possible to support it with the current common CGU
code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 3 ++-
 drivers/clk/ingenic/cgu.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

 v2: No change

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index eb9002ccf3fc..75b083ba294c 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -100,7 +100,8 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	n += pll_info->n_offset;
 	od_enc = ctl >> pll_info->od_shift;
 	od_enc &= GENMASK(pll_info->od_bits - 1, 0);
-	bypass = !!(ctl & BIT(pll_info->bypass_bit));
+	bypass = !pll_info->no_bypass_bit &&
+		 !!(ctl & BIT(pll_info->bypass_bit));
 	enable = !!(ctl & BIT(pll_info->enable_bit));
 
 	if (bypass)
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index da448b0cac18..21420b455985 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -48,6 +48,7 @@
  * @bypass_bit: the index of the bypass bit in the PLL control register
  * @enable_bit: the index of the enable bit in the PLL control register
  * @stable_bit: the index of the stable bit in the PLL control register
+ * @no_bypass_bit: if set, the PLL has no bypass functionality
  */
 struct ingenic_cgu_pll_info {
 	unsigned reg;
@@ -58,6 +59,7 @@ struct ingenic_cgu_pll_info {
 	u8 bypass_bit;
 	u8 enable_bit;
 	u8 stable_bit;
+	bool no_bypass_bit;
 };
 
 /**
-- 
2.11.0
