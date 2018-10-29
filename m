Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2018 09:31:05 +0100 (CET)
Received: from mxhk.zte.com.cn ([63.217.80.70]:28244 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990398AbeJ2IbAzi8cd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Oct 2018 09:31:00 +0100
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E33D8BDDB8C53D2B23E1;
        Mon, 29 Oct 2018 16:30:52 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9T8Uiji044158;
        Mon, 29 Oct 2018 16:30:44 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018102916305119-7358926 ;
          Mon, 29 Oct 2018 16:30:51 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     paul.burton@mips.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: [PATCH v2] clk: boston: fix possible memory leak in clk_boston_setup()
Date:   Mon, 29 Oct 2018 16:31:47 +0800
Message-Id: <1540801907-31544-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-29 16:30:51,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-29 16:30:44,
        Serialize complete at 2018-10-29 16:30:44
X-MAIL: mse01.zte.com.cn w9T8Uiji044158
Return-Path: <wang.yi59@zte.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66970
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

'onecell' is malloced in clk_boston_setup(), but is not freed
before leaving from the error handling cases.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
v2: fix syntax issue in comment, thanks to  Sergei.

 drivers/clk/imgtec/clk-boston.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
index 15af423..f5d54a6 100644
--- a/drivers/clk/imgtec/clk-boston.c
+++ b/drivers/clk/imgtec/clk-boston.c
@@ -73,27 +73,32 @@ static void __init clk_boston_setup(struct device_node *np)
 	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
-		return;
+		goto error;
 	}
 	onecell->hws[BOSTON_CLK_INPUT] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw));
-		return;
+		goto error;
 	}
 	onecell->hws[BOSTON_CLK_SYS] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw));
-		return;
+		goto error;
 	}
 	onecell->hws[BOSTON_CLK_CPU] = hw;
 
 	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell);
 	if (err)
 		pr_err("failed to add DT provider: %d\n", err);
+
+	return;
+
+error:
+	kfree(onecell);
 }
 
 /*
-- 
1.8.3.1
