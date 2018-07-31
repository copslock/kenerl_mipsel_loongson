Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 15:48:20 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:46778 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993097AbeGaNr7b7IlP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jul 2018 15:47:59 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 858CA20765; Tue, 31 Jul 2018 15:47:52 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5BB2D20799;
        Tue, 31 Jul 2018 15:47:42 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 2/6] i2c: designware: move #ifdef CONFIG_OF to the top
Date:   Tue, 31 Jul 2018 15:47:36 +0200
Message-Id: <20180731134740.441-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731134740.441-1-alexandre.belloni@bootlin.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Move the #ifdef CONFIG_OF section to the top of the file, after the ACPI
section so functions defined there can be used in dw_i2c_plat_probe.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 00bf62f77c47..ba142d7c0e05 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -157,6 +157,14 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
 }
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id dw_i2c_of_match[] = {
+	{ .compatible = "snps,designware-i2c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
+#endif
+
 static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 {
 	struct i2c_timings *t = &dev->timings;
@@ -391,14 +399,6 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id dw_i2c_of_match[] = {
-	{ .compatible = "snps,designware-i2c", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
-#endif
-
 #ifdef CONFIG_PM_SLEEP
 static int dw_i2c_plat_prepare(struct device *dev)
 {
-- 
2.18.0
