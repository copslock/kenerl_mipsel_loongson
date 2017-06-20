Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 17:19:15 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:36686 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdFTPTHJv1ai (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 17:19:07 +0200
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
Subject: [PATCH v2 01/17] clk: ingenic: Use const pointer to clk_ops in struct
Date:   Tue, 20 Jun 2017 17:18:39 +0200
Message-Id: <20170620151855.19399-1-paul@crapouillou.net>
In-Reply-To: <20170607200439.24450-2-paul@crapouillou.net>
References: <20170607200439.24450-2-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58691
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
---
 drivers/clk/ingenic/cgu.h        | 2 +-
 drivers/clk/ingenic/jz4780-cgu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

 v2: New patch in this series

diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index 09700b2c555d..da448b0cac18 100644
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
index b35d6d9dd5aa..a21698fb202c 100644
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
