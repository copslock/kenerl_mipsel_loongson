Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 08:40:05 +0100 (CET)
Received: from mxhk.zte.com.cn ([63.217.80.70]:29270 "EHLO mxhk.zte.com.cn"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S23990850AbeJaHj6i6yPi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2018 08:39:58 +0100
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
	by Forcepoint Email with ESMTPS id 2D17A2FBE1B380C802BF;
	Wed, 31 Oct 2018 15:39:57 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
	by mse01.zte.com.cn with ESMTP id w9V7dsCK016007;
	Wed, 31 Oct 2018 15:39:54 +0800 (GMT-8)
	(envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018103115401643-7800137 ;
          Wed, 31 Oct 2018 15:40:16 +0800 
From:	Yi Wang <wang.yi59@zte.com.cn>
To:	paul.burton@mips.com, sboyd@kernel.org
Cc:	mturquette@baylibre.com, linux-mips@linux-mips.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
Subject: [PATCH v3 2/2] clk: boston: unregister clks on failure in clk_boston_setup()
Date:	Wed, 31 Oct 2018 15:41:42 +0800
Message-Id: <1540971702-3133-3-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540971702-3133-1-git-send-email-wang.yi59@zte.com.cn>
References: <1540971702-3133-1-git-send-email-wang.yi59@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-31 15:40:16,
	Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-31 15:39:46,
	Serialize complete at 2018-10-31 15:39:46
X-MAIL:	mse01.zte.com.cn w9V7dsCK016007
Return-Path: <wang.yi59@zte.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wang.yi59@zte.com.cn
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

The registered clks should unregister when something wrong happens
before going out in function clk_boston_setup().

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 drivers/clk/imgtec/clk-boston.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
index f5d54a6..dddda45 100644
--- a/drivers/clk/imgtec/clk-boston.c
+++ b/drivers/clk/imgtec/clk-boston.c
@@ -73,31 +73,39 @@ static void __init clk_boston_setup(struct device_node *np)
 	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
-		goto error;
+		goto fail_input;
 	}
 	onecell->hws[BOSTON_CLK_INPUT] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw));
-		goto error;
+		goto fail_sys;
 	}
 	onecell->hws[BOSTON_CLK_SYS] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw));
-		goto error;
+		goto fail_cpu;
 	}
 	onecell->hws[BOSTON_CLK_CPU] = hw;
 
 	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell);
-	if (err)
+	if (err) {
 		pr_err("failed to add DT provider: %d\n", err);
+		goto fail_clk_add;
+	}
 
 	return;
 
-error:
+fail_clk_add:
+	clk_hw_unregister_fixed_rate(onecell->hws[BOSTON_CLK_CPU]);
+fail_cpu:
+	clk_hw_unregister_fixed_rate(onecell->hws[BOSTON_CLK_SYS]);
+fail_sys:
+	clk_hw_unregister_fixed_rate(onecell->hws[BOSTON_CLK_INPUT]);
+fail_input:
 	kfree(onecell);
 }
 
-- 
1.8.3.1
