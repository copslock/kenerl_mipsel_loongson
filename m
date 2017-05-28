Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2017 20:44:32 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:40221 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993967AbdE1SkeVUSc8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2017 20:40:34 +0200
Received: from hauke-desktop.lan (p2003008628351B0030562F5E961CEEA9.dip0.t-ipconnect.de [IPv6:2003:86:2835:1b00:3056:2f5e:961c:eea9])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 5D100100248;
        Sun, 28 May 2017 20:40:27 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 04/16] watchdog: lantiq: access boot cause register through regmap
Date:   Sun, 28 May 2017 20:39:54 +0200
Message-Id: <20170528184006.31668-5-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170528184006.31668-1-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58048
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
 drivers/watchdog/lantiq_wdt.c | 45 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index e0823677d8c1..c9ad8100ec3c 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -4,6 +4,7 @@
  *  by the Free Software Foundation.
  *
  *  Copyright (C) 2010 John Crispin <john@phrozen.org>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
  *  Based on EP93xx wdt driver
  */
 
@@ -17,6 +18,8 @@
 #include <linux/uaccess.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <lantiq_soc.h>
 
@@ -186,6 +189,40 @@ static struct miscdevice ltq_wdt_miscdev = {
 	.fops	= &ltq_wdt_fops,
 };
 
+static void ltq_set_wdt_bootstatus(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *rcu_regmap;
+	u32 status_reg_offset;
+	u32 status_reg_mask;
+	u32 val;
+	int err;
+
+	rcu_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
+	if (IS_ERR_OR_NULL(rcu_regmap))
+		return;
+
+	err = device_property_read_u32(dev, "offset-status",
+				       &status_reg_offset);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
+		return;
+	}
+
+	err = device_property_read_u32(dev, "mask-status", &status_reg_mask);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
+		return;
+	}
+
+	err = regmap_read(rcu_regmap, status_reg_offset, &val);
+	if (err)
+		return;
+
+	if (val & status_reg_mask)
+		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+}
+
 static int
 ltq_wdt_probe(struct platform_device *pdev)
 {
@@ -205,9 +242,7 @@ ltq_wdt_probe(struct platform_device *pdev)
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	/* find out if the watchdog caused the last reboot */
-	if (ltq_reset_cause() == LTQ_RST_CAUSE_WDTRST)
-		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+	ltq_set_wdt_bootstatus(pdev);
 
 	dev_info(&pdev->dev, "Init done\n");
 	return misc_register(&ltq_wdt_miscdev);
@@ -222,7 +257,9 @@ ltq_wdt_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ltq_wdt_match[] = {
-	{ .compatible = "lantiq,wdt" },
+	{ .compatible = "lantiq,wdt"},
+	{ .compatible = "lantiq,wdt-xrx100"},
+	{ .compatible = "lantiq,wdt-falcon"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ltq_wdt_match);
-- 
2.11.0
