Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 14:52:50 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:37256 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990425AbdL3NveFvk10 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 14:51:34 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/8] watchdog: JZ4740: Drop module remove function
Date:   Sat, 30 Dec 2017 14:51:04 +0100
Message-Id: <20171230135108.6834-4-paul@crapouillou.net>
In-Reply-To: <20171230135108.6834-1-paul@crapouillou.net>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514641893; bh=WOmD+OwLc3lFPkXz+p/dBuTtVvS3ZibFAew1o5sro8U=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BvfGmSjf/89d3o0J1byPeP6XQX+hQ0IVDmJvMsxG0UfCcTOTYbhopW5ynDsBpT/FJRNYA6xhsFOQAHB9B/peXTv3BeSNwbz94oHfNm0/hlWlM3VF4hzYSzzmcSeAXjDOqexzHnXmEjgsY1RMih1zR3OEyyq9JNm5PC5ogdvLcBs=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61781
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

When the watchdog was configured for nowayout, and after the
userspace watchdog daemon closed the dev node without sending the
magic character, unloading this module stopped the watchdog
hardware, which was clearly a problem.

Besides, unloading the module is not possible when the userspace
watchdog daemon is running, so it's safe to assume that we don't
need to stop the watchdog hardware in the jz4740_wdt_remove()
function.

For this reason, the jz4740_wdt_remove() function can then be
dropped alltogether.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/watchdog/jz4740_wdt.c | 8 --------
 1 file changed, 8 deletions(-)

 v2: New patch in this series

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index fa7f49a3212c..02b9b8e946a2 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -205,16 +205,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int jz4740_wdt_remove(struct platform_device *pdev)
-{
-	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
-
-	return jz4740_wdt_stop(&drvdata->wdt);
-}
-
 static struct platform_driver jz4740_wdt_driver = {
 	.probe = jz4740_wdt_probe,
-	.remove = jz4740_wdt_remove,
 	.driver = {
 		.name = "jz4740-wdt",
 		.of_match_table = of_match_ptr(jz4740_wdt_of_matches),
-- 
2.11.0
