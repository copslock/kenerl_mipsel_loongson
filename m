Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 16:48:21 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:40470 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994633AbeAPPsOR0DeE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 16:48:14 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 01/14] clk: ingenic: Use const pointer to clk_ops in struct
Date:   Tue, 16 Jan 2018 16:47:51 +0100
Message-Id: <20180116154804.21150-2-paul@crapouillou.net>
In-Reply-To: <20180116154804.21150-1-paul@crapouillou.net>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1516117693; bh=xU0W4IcfEHlghqACArgkEqvOCwwpW5uN6VfkJzgxPTE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YfPdBCrwaK+JG5IO2TAZcjDW245xO0p5GhYnTauhk67BlJbcg3ZsVSoDRYnPVBsDsAjDUwQtLG1WbxN3mVB3owCAoPxpsleS1NX6SjKIz0OXj69TvOnxQGLcMhrxqmfuuLNGGdsKIP9Lr4hB2ctbM0zp20mpgdKaprCvntjPueY=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62176
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

The CGU common code does not modify the pointed clk_ops structure, so it
should be marked as const.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/ingenic/cgu.h        | 2 +-
 drivers/clk/ingenic/jz4780-cgu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

 v2: New patch in this series
 v3: No change
 v4: No change
 v5: No change
 v6: No change
 v7: No change

diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index e78b586536ea..f1527cf75b3f 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -120,7 +120,7 @@ struct ingenic_cgu_gate_info {
  * @clk_ops: custom clock operation callbacks
  */
 struct ingenic_cgu_custom_info {
-	struct clk_ops *clk_ops;
+	const struct clk_ops *clk_ops;
 };
 
 /**
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index ac3585ed8228..6427be117ff1 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -203,7 +203,7 @@ static int jz4780_otg_phy_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	return 0;
 }
 
-static struct clk_ops jz4780_otg_phy_ops = {
+static const struct clk_ops jz4780_otg_phy_ops = {
 	.get_parent = jz4780_otg_phy_get_parent,
 	.set_parent = jz4780_otg_phy_set_parent,
 
-- 
2.11.0
