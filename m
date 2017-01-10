Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 00:38:40 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:47825 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993871AbdAJXidZ9k37 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 00:38:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From; bh=cOQ9n6zvmGhqdotDLXYVY004DCDqQGrVIqJpG3nUhr4=; b=CvaoGcCtjN0gPf
        LhVXjNiAXjczC5OkgysV0dP2GrEUEndKpOd2/dDaVdFNz1/o/firgtsZjRYI+scJNmnWi7kfEjbW6
        VfOtTzOHIABRlTCaEgfuba9TGXW2TW4R5idRbFuvgxrHcMySXqlKZZS65hazGn4TaTjWM4OAWGxFq
        uqdVf7vV6wHRPb4sU6Kh9yIRWrBprcCEF6uf3yoZqR6mnJBzqNWDJYUkYJVCAuWuW2kKv/dMRmr/7
        V8Yrh2ICCn0jZdx8OGASRny6oCU1lKZCAYc90nQO5Ru0SB3vRu2+E/3+QtUebRkLne0vu+67u9rjS
        LEZKVtajTfyzTr5lY7Yg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41140 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1cR5zm-0037f6-FM; Tue, 10 Jan 2017 23:38:26 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 26/62] watchdog: loongson1_wdt: Convert to use device managed functions
Date:   Tue, 10 Jan 2017 15:34:43 -0800
Message-Id: <1484091325-9199-27-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Replace 'goto l; ... l: return e;' with 'return e;'
- Replace 'val = e; return val;' with 'return e;'
- Drop assignments to otherwise unused variables
- Replace 'if (e) { return expr; }' with 'if (e) return expr;'
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Keguang Zhang <keguang.zhang@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/loongson1_wdt.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index 3aee50c64a36..36f0c7e02745 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -109,12 +109,15 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "clk enable failed\n");
 		return err;
 	}
+	err = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       drvdata->clk);
+	if (err)
+		return err;
 
 	clk_rate = clk_get_rate(drvdata->clk);
-	if (!clk_rate) {
-		err = -EINVAL;
-		goto err0;
-	}
+	if (!clk_rate)
+		return -EINVAL;
 	drvdata->clk_rate = clk_rate;
 
 	ls1x_wdt = &drvdata->wdt;
@@ -129,35 +132,19 @@ static int ls1x_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(ls1x_wdt, nowayout);
 	watchdog_set_drvdata(ls1x_wdt, drvdata);
 
-	err = watchdog_register_device(&drvdata->wdt);
+	err = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register watchdog device\n");
-		goto err0;
+		return err;
 	}
 
-	platform_set_drvdata(pdev, drvdata);
-
 	dev_info(&pdev->dev, "Loongson1 Watchdog driver registered\n");
 
 	return 0;
-err0:
-	clk_disable_unprepare(drvdata->clk);
-	return err;
-}
-
-static int ls1x_wdt_remove(struct platform_device *pdev)
-{
-	struct ls1x_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&drvdata->wdt);
-	clk_disable_unprepare(drvdata->clk);
-
-	return 0;
 }
 
 static struct platform_driver ls1x_wdt_driver = {
 	.probe = ls1x_wdt_probe,
-	.remove = ls1x_wdt_remove,
 	.driver = {
 		.name = "ls1x-wdt",
 	},
-- 
2.7.4
