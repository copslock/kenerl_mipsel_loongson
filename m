Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:26:42 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:35524 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992828AbeAESZYa2r7s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 19:25:24 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 03/15] clk: ingenic: support PLLs with no bypass bit
Date:   Fri,  5 Jan 2018 19:25:01 +0100
Message-Id: <20180105182513.16248-4-paul@crapouillou.net>
In-Reply-To: <20180105182513.16248-1-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1515176723; bh=KQPyfQGdEGveaYLlUj76jMZJlTQ9TrflV72ZwAYp2MI=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lJhexNDnRKnug7nc4OfNk6AtCGkSufMIr58W+tFY4fcZS4sPye9fKcEViCfNQxLcCQr3Qlff0lQB/Njn+lBHqYZhg2qddoWGzK+f/F647XrfwxPFiR24F1Zcr1F1UiWf96ZmLcBBrhhAgsUwGkrRxWUDMSDbmhzO/hhQJowv62M=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61924
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
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/ingenic/cgu.c | 3 ++-
 drivers/clk/ingenic/cgu.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

 v2: No change
 v3: No change
 v4: No change
 v5: No change
 v6: No change

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index a2e73a6d60fd..381c4a17a1fc 100644
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
index f1527cf75b3f..9da34910bd80 100644
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
