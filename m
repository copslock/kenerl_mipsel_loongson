Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:26:19 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:35364 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992615AbeAESZXFDoBs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 19:25:23 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 02/15] clk: ingenic: Fix recalc_rate for clocks with fixed divider
Date:   Fri,  5 Jan 2018 19:25:00 +0100
Message-Id: <20180105182513.16248-3-paul@crapouillou.net>
In-Reply-To: <20180105182513.16248-1-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net>
 <20180105182513.16248-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1515176722; bh=HcLymhcsGnPNscx4L955AmxE8fYSTdDhYJR9lHWcZKw=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MSAZNU4cuTe473J26xs+EN+EOBh5Ql8Nc+ZKw19uUwd+zmSmf26MJLqRvzQHYPBZFMz0v8kxpHVZ2rYcczDJ0r0bqwSEfD/1h0eN9JlTfljOQ3ABunlcOzNeKXhms/yFTl3GoPOpEOkbyjtFyHNiUONQuoNwKjjwVsR1XSNXZ8w=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61923
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

Previously, the clocks with a fixed divider would report their rate
as being the same as the one of their parent, independently of the
divider in use. This commit fixes this behaviour.

This went unnoticed as neither the jz4740 nor the jz4780 CGU code
have clocks with fixed dividers yet.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/ingenic/cgu.c | 2 ++
 1 file changed, 2 insertions(+)

 v2: No changes
 v3: No changes
 v4: No changes
 v5: No changes
 v6: No changes

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index ab393637f7b0..a2e73a6d60fd 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -328,6 +328,8 @@ ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 		div *= clk_info->div.div;
 
 		rate /= div;
+	} else if (clk_info->type & CGU_CLK_FIXDIV) {
+		rate /= clk_info->fixdiv.div;
 	}
 
 	return rate;
-- 
2.11.0
