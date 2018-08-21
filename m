Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 19:19:48 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:46688 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994709AbeHURRIE1z0D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 19:17:08 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 10/24] watchdog: jz4740: Avoid starting watchdog in set_timeout
Date:   Tue, 21 Aug 2018 19:16:21 +0200
Message-Id: <20180821171635.22740-11-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1534871826; bh=tBIxg5wGqomJKe9TZsyGLBfl5Hk6jZE8QDCNVIndQ3s=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nC5RlNo3b+tcMvfjXb4jCFGETVw4/9gJboBH04Hel9NQUgAJbSyOYrulpbh/kDJ/yB+pumsX5pxl+e8HmdnEieZ6h20x45YItuUhDl4iq6V3aexBvLH2BBMru9PfwQg428W1nzm1NF3w31VDnYwVYBBb36mvwwF0ciXn3DE4A/g=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65696
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

Previously the jz4740_wdt_set_timeout() function was starting the timer
unconditionally, even if it was stopped when that function was entered.

Now, the timer will be restarted only if it was already running before
this function is called.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Notes:
     v6: New patch
    
     v7: No change

 drivers/watchdog/jz4740_wdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 0f54306aee25..45d9495170e5 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -64,13 +64,15 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
+	u32 tcer;
 
+	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
 	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 
 	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
 	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 
-	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, tcer & TCU_WDT_TCER_TCEN);
 
 	wdt_dev->timeout = new_timeout;
 	return 0;
@@ -86,6 +88,7 @@ static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
 		return ret;
 
 	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
 
 	return 0;
 }
-- 
2.11.0
