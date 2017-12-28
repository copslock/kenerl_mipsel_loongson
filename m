Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 17:30:02 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:49782 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990491AbdL1Q3zw9KTB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 17:29:55 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/7] watchdog: jz4740: Use devm_* functions
Date:   Thu, 28 Dec 2017 17:29:34 +0100
Message-Id: <20171228162939.3928-3-paul@crapouillou.net>
In-Reply-To: <20171228162939.3928-1-paul@crapouillou.net>
References: <20171228162939.3928-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514478595; bh=0LCQgJeJdOOl48LVOgXZfty4XB0LiVihNWT92Eo225w=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EqY54d7u0COdJ/R+16C/S1UuM2NVpm6LQdjLeyS8+/Fw8hCrXrN/xqvdPZsv9AK81vbZZCtdiYD2ZJ0XnzIfIoahBsiI1289GLl+pikNj8iKYxhltgNhusBKdLPrwNe8n/KEcsnRL+h1EHX0iGXXiT6QU53ljpTUuLYqPrXBop8=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61666
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

- Use devm_clk_get instead of clk_get
- Use devm_watchdog_register_device instead of watchdog_register_device

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/watchdog/jz4740_wdt.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 6955deb100ef..92d6ca8ceb49 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -178,40 +178,29 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(drvdata->base)) {
-		ret = PTR_ERR(drvdata->base);
-		goto err_out;
-	}
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
 
-	drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
+	drvdata->rtc_clk = devm_clk_get(&pdev->dev, "rtc");
 	if (IS_ERR(drvdata->rtc_clk)) {
 		dev_err(&pdev->dev, "cannot find RTC clock\n");
-		ret = PTR_ERR(drvdata->rtc_clk);
-		goto err_out;
+		return PTR_ERR(drvdata->rtc_clk);
 	}
 
-	ret = watchdog_register_device(&drvdata->wdt);
+	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
 	if (ret < 0)
-		goto err_disable_clk;
+		return ret;
 
 	platform_set_drvdata(pdev, drvdata);
-	return 0;
 
-err_disable_clk:
-	clk_put(drvdata->rtc_clk);
-err_out:
-	return ret;
+	return 0;
 }
 
 static int jz4740_wdt_remove(struct platform_device *pdev)
 {
 	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
 
-	jz4740_wdt_stop(&drvdata->wdt);
-	watchdog_unregister_device(&drvdata->wdt);
-	clk_put(drvdata->rtc_clk);
-
-	return 0;
+	return jz4740_wdt_stop(&drvdata->wdt);
 }
 
 static struct platform_driver jz4740_wdt_driver = {
-- 
2.11.0
