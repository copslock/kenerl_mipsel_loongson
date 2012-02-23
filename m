Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:20:53 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:57492 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903762Ab2BWQUE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:20:04 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH V2 12/14] WDT: MIPS: lantiq: convert watchdog driver to clkdev api
Date:   Thu, 23 Feb 2012 17:03:11 +0100
Message-Id: <1330012993-13510-12-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
References: <1330012993-13510-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Refrence the IO region clock via its new access function.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/lantiq_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 9c8b10c..fa4866b 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -206,7 +206,7 @@ ltq_wdt_probe(struct platform_device *pdev)
 	}
 
 	/* we do not need to enable the clock as it is always running */
-	clk = clk_get(&pdev->dev, "io");
+	clk = clk_get_io();
 	WARN_ON(!clk);
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
-- 
1.7.7.1
