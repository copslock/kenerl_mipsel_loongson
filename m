Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 23:46:31 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:46096 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994772AbeHIVpFHda-J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 23:45:05 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 09/24] watchdog: jz4740: Use regmap provided by TCU driver
Date:   Thu,  9 Aug 2018 23:43:59 +0200
Message-Id: <20180809214414.20905-10-paul@crapouillou.net>
In-Reply-To: <20180809214414.20905-1-paul@crapouillou.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533851104; bh=87ziouG9OPvJJj8X32FDe4hrWYE2Ha95FkDCkgxH2qE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jN4KungcSnXbjCw+EwjsmxZuoZ8XgSWKjtdtCt/eKPMyWxC+l6aEdOesaOGs9OVz6BzQMXiKNxqXMMtg9aU3ex2Xs6IdNXqgfz0XbMmDzRV5gjK/ZYTBRo+WovDTg1T9a6i5UmbfNDaMDOpF6RJqsWFFwDpPPbTD+sdeyZKl1h0=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65516
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

Since we broke the ABI by changing the clock, the driver was also
updated to use the regmap provided by the TCU driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/watchdog/jz4740_wdt.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

 v6: New patch

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 1d504ecf45e1..0f54306aee25 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -13,6 +13,7 @@
  *
  */
 
+#include <linux/mfd/ingenic-tcu.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -25,10 +26,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
-
-#define JZ_REG_WDT_TIMER_DATA     0x0
-#define JZ_REG_WDT_COUNTER_ENABLE 0x4
-#define JZ_REG_WDT_TIMER_COUNTER  0x8
+#include <linux/regmap.h>
 
 #define DEFAULT_HEARTBEAT 5
 #define MAX_HEARTBEAT     2048
@@ -48,7 +46,7 @@ MODULE_PARM_DESC(heartbeat,
 
 struct jz4740_wdt_drvdata {
 	struct watchdog_device wdt;
-	void __iomem *base;
+	struct regmap *map;
 	struct clk *clk;
 	unsigned long clk_rate;
 };
@@ -57,7 +55,7 @@ static int jz4740_wdt_ping(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 	return 0;
 }
 
@@ -67,12 +65,12 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
 
-	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 
-	writew((u16)timeout_value, drvdata->base + JZ_REG_WDT_TIMER_DATA);
-	writew(0x0, drvdata->base + JZ_REG_WDT_TIMER_COUNTER);
+	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
 
-	writeb(0x1, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
 
 	wdt_dev->timeout = new_timeout;
 	return 0;
@@ -96,7 +94,7 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
 
-	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
+	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
 	clk_disable_unprepare(drvdata->clk);
 
 	return 0;
@@ -138,7 +136,6 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct jz4740_wdt_drvdata *drvdata;
 	struct watchdog_device *jz4740_wdt;
-	struct resource	*res;
 	long rate;
 	int ret;
 
@@ -174,10 +171,11 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(jz4740_wdt, nowayout);
 	watchdog_set_drvdata(jz4740_wdt, drvdata);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(drvdata->base))
-		return PTR_ERR(drvdata->base);
+	drvdata->map = dev_get_regmap(dev->parent, NULL);
+	if (!drvdata->map) {
+		dev_err(dev, "regmap not found\n");
+		return -EINVAL;
+	}
 
 	ret = devm_watchdog_register_device(&pdev->dev, &drvdata->wdt);
 	if (ret < 0)
-- 
2.11.0
