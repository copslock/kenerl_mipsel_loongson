Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2015 19:04:17 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:32854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010750AbbGaREPZsvuV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2015 19:04:15 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3FDFE140AEE;
        Fri, 31 Jul 2015 17:04:12 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 2FA31140AE8; Fri, 31 Jul 2015 17:04:12 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3AD70140AEE;
        Fri, 31 Jul 2015 17:04:11 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 09/26] MIPS: alchemy: Convert to clk_hw based provider APIs
Date:   Fri, 31 Jul 2015 10:03:49 -0700
Message-Id: <1438362246-6664-10-git-send-email-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.3.0.rc1.33.g42e4583
In-Reply-To: <1438362246-6664-1-git-send-email-sboyd@codeaurora.org>
References: <1438362246-6664-1-git-send-email-sboyd@codeaurora.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

We're removing struct clk from the clk provider API, so switch
this code to using the clk_hw based provider APIs.

Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/mips/alchemy/common/clock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 5a62b18b8500..bd34f4093cd9 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -394,7 +394,7 @@ static int alchemy_clk_fgcs_detr(struct clk_hw *hw,
 				 struct clk_rate_request *req,
 				 int scale, int maxdiv)
 {
-	struct clk *pc, *bpc, *free;
+	struct clk_hw *pc, *bpc, *free;
 	long tdv, tpr, pr, nr, br, bpr, diff, lastdiff;
 	int j;
 
@@ -408,7 +408,7 @@ static int alchemy_clk_fgcs_detr(struct clk_hw *hw,
 	 * the one that gets closest to but not over the requested rate.
 	 */
 	for (j = 0; j < 7; j++) {
-		pc = clk_get_parent_by_index(hw->clk, j);
+		pc = clk_hw_get_parent_by_index(hw, j);
 		if (!pc)
 			break;
 
@@ -416,12 +416,12 @@ static int alchemy_clk_fgcs_detr(struct clk_hw *hw,
 		 * XXX: we would actually want clk_has_active_children()
 		 * but this is a good-enough approximation for now.
 		 */
-		if (!__clk_is_prepared(pc)) {
+		if (!clk_hw_is_prepared(pc)) {
 			if (!free)
 				free = pc;
 		}
 
-		pr = clk_get_rate(pc);
+		pr = clk_hw_get_rate(pc);
 		if (pr < req->rate)
 			continue;
 
@@ -451,7 +451,7 @@ static int alchemy_clk_fgcs_detr(struct clk_hw *hw,
 			tpr = req->rate * j;
 			if (tpr < 0)
 				break;
-			pr = clk_round_rate(free, tpr);
+			pr = clk_hw_round_rate(free, tpr);
 
 			tdv = alchemy_calc_div(req->rate, pr, scale, maxdiv,
 					       NULL);
@@ -474,7 +474,7 @@ static int alchemy_clk_fgcs_detr(struct clk_hw *hw,
 		return br;
 
 	req->best_parent_rate = bpr;
-	req->best_parent_hw = __clk_get_hw(bpc);
+	req->best_parent_hw = bpc;
 	req->rate = br;
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
