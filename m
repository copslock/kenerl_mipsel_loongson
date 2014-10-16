Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 22:01:39 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:37465
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011633AbaJPUBVLBRGX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 22:01:21 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] watchdog: rt2880_wdt: minor clean up
Date:   Thu, 16 Oct 2014 22:01:05 +0200
Message-Id: <1413489665-52342-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1413489665-52342-1-git-send-email-blogic@openwrt.org>
References: <1413489665-52342-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Replace device_reset() with devm_reset_control_get() + reset_control_deassert().
Make use of watchdog_init_timeout() instead of setting the timeout manually.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/watchdog/rt2880_wdt.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index d92c2d5..d2cd2bd 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -45,6 +45,7 @@
 static struct clk *rt288x_wdt_clk;
 static unsigned long rt288x_wdt_freq;
 static void __iomem *rt288x_wdt_base;
+static struct reset_control *rt288x_wdt_reset;
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -151,16 +152,18 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(rt288x_wdt_clk))
 		return PTR_ERR(rt288x_wdt_clk);
 
-	device_reset(&pdev->dev);
+	rt288x_wdt_reset = devm_reset_control_get(&pdev->dev, NULL);
+	if (!IS_ERR(rt288x_wdt_reset))
+		reset_control_deassert(rt288x_wdt_reset);
 
 	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
 
 	rt288x_wdt_dev.dev = &pdev->dev;
 	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
-
 	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
-	rt288x_wdt_dev.timeout = rt288x_wdt_dev.max_timeout;
 
+	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
+			      &pdev->dev);
 	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
 
 	ret = watchdog_register_device(&rt288x_wdt_dev);
-- 
1.7.10.4
