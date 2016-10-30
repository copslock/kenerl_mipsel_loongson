Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 00:04:42 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:47730 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992309AbcJ3XDFs4s2a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 00:03:05 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     rtc-linux@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Cc:     Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/7] rtc: rtc-jz4740: Add support for devicetree
Date:   Mon, 31 Oct 2016 00:02:43 +0100
Message-Id: <20161030230247.20538-4-paul@crapouillou.net>
In-Reply-To: <20161030230247.20538-1-paul@crapouillou.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1477868584; bh=+hJlG5b7oMO3UrV+uuuQJwJla1+fZIMbs+C9Hq/3+HU=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LYw/APoypkkncyQW/522j8sTEJat8E2mtXnumbQBvfvdsX7BEpXGh/lR+KOnnmkG44YIy87Lw0AbrUy0UkF35UUPci33FFl4CN8mNH3GgopkdHNvcIE0JBCbS4uYt1kfAOC55tPRAIo8zoaeOEF/81fzvglsg0xA3Mrdf+2PY8Q=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55601
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

See
Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
for a description of the bindings.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Maarten ter Huurne <maarten@treewalker.org>
---
 drivers/rtc/rtc-jz4740.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

v2: No change

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index c616efe..4213554 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -245,6 +246,13 @@ void jz4740_rtc_poweroff(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
 
+static const struct of_device_id jz4740_rtc_of_match[] = {
+	{ .compatible = "ingenic,jz4740-rtc", .data = (void *) ID_JZ4740 },
+	{ .compatible = "ingenic,jz4780-rtc", .data = (void *) ID_JZ4780 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4740_rtc_of_match);
+
 static int jz4740_rtc_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -252,12 +260,17 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	uint32_t scratchpad;
 	struct resource *mem;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
+	const struct of_device_id *of_id = of_match_device(
+			jz4740_rtc_of_match, &pdev->dev);
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
-	rtc->type = id->driver_data;
+	if (of_id)
+		rtc->type = (enum jz4740_rtc_type) of_id->data;
+	else
+		rtc->type = id->driver_data;
 
 	rtc->irq = platform_get_irq(pdev, 0);
 	if (rtc->irq < 0) {
@@ -345,6 +358,7 @@ static struct platform_driver jz4740_rtc_driver = {
 	.driver	 = {
 		.name  = "jz4740-rtc",
 		.pm    = JZ4740_RTC_PM_OPS,
+		.of_match_table = of_match_ptr(jz4740_rtc_of_match),
 	},
 	.id_table = jz4740_rtc_ids,
 };
-- 
2.9.3
