Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Aug 2017 00:23:49 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:33669 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994962AbdHSWUJuSMti (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Aug 2017 00:20:09 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 44E02490FA;
        Sun, 20 Aug 2017 00:20:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 90UR5bZotO0t; Sun, 20 Aug 2017 00:19:52 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v10 04/16] watchdog: lantiq: access boot cause register through regmap
Date:   Sun, 20 Aug 2017 00:18:11 +0200
Message-Id: <20170819221823.13850-5-hauke@hauke-m.de>
In-Reply-To: <20170819221823.13850-1-hauke@hauke-m.de>
References: <20170819221823.13850-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This patch avoids accessing the function ltq_reset_cause() and directly
accesses the register given over the syscon interface. The syscon
interface will be implemented for the xway SoCs for the falcon SoCs the
ltq_reset_cause() function never worked, because a wrong offset was used.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Guenter Roeck <linux@reck-us.net>
---
 drivers/watchdog/lantiq_wdt.c | 74 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index e0823677d8c1..7f43cefa0eae 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -4,6 +4,7 @@
  *  by the Free Software Foundation.
  *
  *  Copyright (C) 2010 John Crispin <john@phrozen.org>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
  *  Based on EP93xx wdt driver
  */
 
@@ -17,9 +18,20 @@
 #include <linux/uaccess.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <lantiq_soc.h>
 
+#define LTQ_XRX_RCU_RST_STAT		0x0014
+#define LTQ_XRX_RCU_RST_STAT_WDT	BIT(31)
+
+/* CPU0 Reset Source Register */
+#define LTQ_FALCON_SYS1_CPU0RS		0x0060
+/* reset cause mask */
+#define LTQ_FALCON_SYS1_CPU0RS_MASK	0x0007
+#define LTQ_FALCON_SYS1_CPU0RS_WDT	0x02
+
 /*
  * Section 3.4 of the datasheet
  * The password sequence protects the WDT control register from unintended
@@ -186,16 +198,70 @@ static struct miscdevice ltq_wdt_miscdev = {
 	.fops	= &ltq_wdt_fops,
 };
 
+typedef int (*ltq_wdt_bootstatus_set)(struct platform_device *pdev);
+
+static int ltq_wdt_bootstatus_xrx(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *rcu_regmap;
+	u32 val;
+	int err;
+
+	rcu_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
+	if (IS_ERR(rcu_regmap))
+		return PTR_ERR(rcu_regmap);
+
+	err = regmap_read(rcu_regmap, LTQ_XRX_RCU_RST_STAT, &val);
+	if (err)
+		return err;
+
+	if (val & LTQ_XRX_RCU_RST_STAT_WDT)
+		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+
+	return 0;
+}
+
+static int ltq_wdt_bootstatus_falcon(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *rcu_regmap;
+	u32 val;
+	int err;
+
+	rcu_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+						     "lantiq,rcu");
+	if (IS_ERR(rcu_regmap))
+		return PTR_ERR(rcu_regmap);
+
+	err = regmap_read(rcu_regmap, LTQ_FALCON_SYS1_CPU0RS, &val);
+	if (err)
+		return err;
+
+	if ((val & LTQ_FALCON_SYS1_CPU0RS_MASK) == LTQ_FALCON_SYS1_CPU0RS_WDT)
+		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+
+	return 0;
+}
+
 static int
 ltq_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct clk *clk;
+	ltq_wdt_bootstatus_set ltq_wdt_bootstatus_set;
+	int ret;
 
 	ltq_wdt_membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ltq_wdt_membase))
 		return PTR_ERR(ltq_wdt_membase);
 
+	ltq_wdt_bootstatus_set = of_device_get_match_data(&pdev->dev);
+	if (ltq_wdt_bootstatus_set) {
+		ret = ltq_wdt_bootstatus_set(pdev);
+		if (ret)
+			return ret;
+	}
+
 	/* we do not need to enable the clock as it is always running */
 	clk = clk_get_io();
 	if (IS_ERR(clk)) {
@@ -205,10 +271,6 @@ ltq_wdt_probe(struct platform_device *pdev)
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	/* find out if the watchdog caused the last reboot */
-	if (ltq_reset_cause() == LTQ_RST_CAUSE_WDTRST)
-		ltq_wdt_bootstatus = WDIOF_CARDRESET;
-
 	dev_info(&pdev->dev, "Init done\n");
 	return misc_register(&ltq_wdt_miscdev);
 }
@@ -222,7 +284,9 @@ ltq_wdt_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ltq_wdt_match[] = {
-	{ .compatible = "lantiq,wdt" },
+	{ .compatible = "lantiq,wdt", .data = NULL},
+	{ .compatible = "lantiq,xrx100-wdt", .data = ltq_wdt_bootstatus_xrx },
+	{ .compatible = "lantiq,falcon-wdt", .data = ltq_wdt_bootstatus_falcon },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ltq_wdt_match);
-- 
2.11.0
