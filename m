Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:22:59 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:40532 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990432AbeENGWXeAH-O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 08:22:23 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mathieu Malaterre <malat@debian.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 4/8] watchdog: JZ4740: Drop module remove function
Date:   Thu, 10 May 2018 20:47:47 +0200
Message-Id: <20180510184751.13416-4-paul@crapouillou.net>
In-Reply-To: <20180510184751.13416-1-paul@crapouillou.net>
References: <20180510184751.13416-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1525978105; bh=5mIewojUX8aQ5nd9AkvTY9dhQJaG6ywPTi2lZn/AN8E=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GVr2nG0rjww+2YVMd6BJ42oDclMV8ZGMxnPamvElA0v+fFDHPuoqMlxwfofvhQpw43Xu6F7rRyCzsOYLHrIIE+SgLIaSqYN7+G7oyB8hPYnn2rQlb8yaDSaQQm5LjTXB14GZpvPG3yv6Ql0xAHTKDYSh/2oPrnSYDaHt2iNdNLM=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63910
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/jz4740_wdt.c | 8 --------
 1 file changed, 8 deletions(-)

 v2: New patch in this series
 v3: No change

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index b8b015a7d045..ec4d99a830ba 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -206,16 +206,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
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
