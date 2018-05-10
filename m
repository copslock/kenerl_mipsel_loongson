Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:24:07 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:40582 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990444AbeENGW2rLLEO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 08:22:28 +0200
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
Subject: [PATCH v3 1/8] watchdog: JZ4740: Disable clock after stopping counter
Date:   Thu, 10 May 2018 20:47:44 +0200
Message-Id: <20180510184751.13416-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1525978090; bh=1Jh2aRtSugJI0ust70Bl28je/me+OuaTKCbRrDR5MiU=; h=From:To:Cc:Subject:Date:Message-Id; b=nBpXckX4pYSm2NPVBIBRhjpiYrDOHsbBUQNXEzy+eHhqZzYq+Jrs4PjBs2VodgFwrG04nSQsYtaCjB/kOgGIjJRRgzWIvLulHbHV4FMycdyXYRYpAduuP4xAz/IxZBrcqS3K9tiobzcig2g6POOMMm3XsrEvKs/YpmdfTOJL29E=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63915
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

Previously, the clock was disabled first, which makes the watchdog
component insensitive to register writes.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/jz4740_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 v2: No change
 v3: No change

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index aafbeb96561b..55c9a1f26498 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -124,8 +124,8 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	jz4740_timer_disable_watchdog();
 	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+	jz4740_timer_disable_watchdog();
 
 	return 0;
 }
-- 
2.11.0
