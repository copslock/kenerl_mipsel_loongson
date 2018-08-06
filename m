Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2018 20:54:44 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:45208 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994662AbeHFSyVnC3Ms (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Aug 2018 20:54:21 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 042A7207D4; Mon,  6 Aug 2018 20:54:15 +0200 (CEST)
Received: from localhost (LPuteaux-656-1-243-71.w82-127.abo.wanadoo.fr [82.127.120.71])
        by mail.bootlin.com (Postfix) with ESMTPSA id B4F9A2072D;
        Mon,  6 Aug 2018 20:54:14 +0200 (CEST)
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
Subject: [PATCH v3 2/6] i2c: designware: move #ifdef CONFIG_OF to the top
Date:   Mon,  6 Aug 2018 20:54:08 +0200
Message-Id: <20180806185412.7210-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65433
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index d117c120730d..1bcaab777a2e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -156,6 +156,14 @@ static inline int dw_i2c_acpi_configure(struct platform_device *pdev)
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
@@ -390,14 +398,6 @@ static int dw_i2c_plat_remove(struct platform_device *pdev)
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
