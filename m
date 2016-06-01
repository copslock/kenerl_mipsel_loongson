Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jun 2016 23:55:28 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:60746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041641AbcFAVz0pPpeR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Jun 2016 23:55:26 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F327861372; Wed,  1 Jun 2016 21:55:24 +0000 (UTC)
Received: from sboyd-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1600E600DD;
        Wed,  1 Jun 2016 21:55:22 +0000 (UTC)
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] clk: microchip: Remove CLK_IS_ROOT
Date:   Wed,  1 Jun 2016 14:55:21 -0700
Message-Id: <20160601215521.31309-1-sboyd@codeaurora.org>
X-Mailer: git-send-email 2.8.2.311.gee88674
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53715
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

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Purna Chandra Mandal <purna.mandal@microchip.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

I'm going to send this to Linus tomorrow or Friday so we can finally
remove this flag entirely.

 drivers/clk/microchip/clk-pic32mzda.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/microchip/clk-pic32mzda.c b/drivers/clk/microchip/clk-pic32mzda.c
index 020a29acc5b0..51f54380474b 100644
--- a/drivers/clk/microchip/clk-pic32mzda.c
+++ b/drivers/clk/microchip/clk-pic32mzda.c
@@ -180,15 +180,15 @@ static int pic32mzda_clk_probe(struct platform_device *pdev)
 
 	/* register fixed rate clocks */
 	clks[POSCCLK] = clk_register_fixed_rate(&pdev->dev, "posc_clk", NULL,
-						CLK_IS_ROOT, 24000000);
+						0, 24000000);
 	clks[FRCCLK] =  clk_register_fixed_rate(&pdev->dev, "frc_clk", NULL,
-						CLK_IS_ROOT, 8000000);
+						0, 8000000);
 	clks[BFRCCLK] = clk_register_fixed_rate(&pdev->dev, "bfrc_clk", NULL,
-						CLK_IS_ROOT, 8000000);
+						0, 8000000);
 	clks[LPRCCLK] = clk_register_fixed_rate(&pdev->dev, "lprc_clk", NULL,
-						CLK_IS_ROOT, 32000);
+						0, 32000);
 	clks[UPLLCLK] = clk_register_fixed_rate(&pdev->dev, "usbphy_clk", NULL,
-						CLK_IS_ROOT, 24000000);
+						0, 24000000);
 	/* fixed rate (optional) clock */
 	if (of_find_property(np, "microchip,pic32mzda-sosc", NULL)) {
 		pr_info("pic32-clk: dt requests SOSC.\n");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
