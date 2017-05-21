Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 May 2017 15:12:53 +0200 (CEST)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:54305 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993866AbdEUNJtwcsnB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 May 2017 15:09:49 +0200
Received: from hauke-desktop.lan (p2003008628380100610A1109F04F7762.dip0.t-ipconnect.de [IPv6:2003:86:2838:100:610a:1109:f04f:7762])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 7DBD31001D6;
        Sun, 21 May 2017 15:09:44 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 04/15] watchdog: lantiq: access boot cause register through regmap
Date:   Sun, 21 May 2017 15:09:07 +0200
Message-Id: <20170521130918.27446-5-hauke@hauke-m.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170521130918.27446-1-hauke@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57913
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
 drivers/watchdog/lantiq_wdt.c | 48 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index e0823677d8c1..d0447d8cabd0 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -4,6 +4,7 @@
  *  by the Free Software Foundation.
  *
  *  Copyright (C) 2010 John Crispin <john@phrozen.org>
+ *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
  *  Based on EP93xx wdt driver
  */
 
@@ -17,9 +18,14 @@
 #include <linux/uaccess.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <lantiq_soc.h>
 
+#define LTQ_RST_CAUSE_WDT_XRX		BIT(31)
+#define LTQ_RST_CAUSE_WDT_FALCON	0x02
+
 /*
  * Section 3.4 of the datasheet
  * The password sequence protects the WDT control register from unintended
@@ -186,6 +192,40 @@ static struct miscdevice ltq_wdt_miscdev = {
 	.fops	= &ltq_wdt_fops,
 };
 
+static void ltq_set_wdt_bootstatus(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct regmap *rcu_regmap;
+	u32 status_reg_offset;
+	u32 val;
+	int err;
+
+	rcu_regmap = syscon_regmap_lookup_by_phandle(np,
+						     "lantiq,rcu-syscon");
+	if (IS_ERR_OR_NULL(rcu_regmap))
+		return;
+
+	err = of_property_read_u32_index(np, "lantiq,rcu-syscon", 1,
+					 &status_reg_offset);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
+		return;
+	}
+
+	err = regmap_read(rcu_regmap, status_reg_offset, &val);
+	if (err)
+		return;
+
+	/* find out if the watchdog caused the last reboot */
+	if (of_device_is_compatible(np, "lantiq,wdt-xrx100")) {
+		if (val & LTQ_RST_CAUSE_WDT_XRX)
+			ltq_wdt_bootstatus = WDIOF_CARDRESET;
+	} else if  (of_device_is_compatible(np, "lantiq,wdt-falcon")) {
+		if ((val & 0x7) == LTQ_RST_CAUSE_WDT_FALCON)
+			ltq_wdt_bootstatus = WDIOF_CARDRESET;
+	}
+}
+
 static int
 ltq_wdt_probe(struct platform_device *pdev)
 {
@@ -205,9 +245,7 @@ ltq_wdt_probe(struct platform_device *pdev)
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
 
-	/* find out if the watchdog caused the last reboot */
-	if (ltq_reset_cause() == LTQ_RST_CAUSE_WDTRST)
-		ltq_wdt_bootstatus = WDIOF_CARDRESET;
+	ltq_set_wdt_bootstatus(pdev);
 
 	dev_info(&pdev->dev, "Init done\n");
 	return misc_register(&ltq_wdt_miscdev);
@@ -222,7 +260,9 @@ ltq_wdt_remove(struct platform_device *pdev)
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
