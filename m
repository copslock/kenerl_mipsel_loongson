Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 11:39:52 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:36954 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901165Ab2BQKdm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 11:33:42 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 9/9] WDT: MIPS: lantiq: convert watchdog driver to clkdev api
Date:   Fri, 17 Feb 2012 11:33:20 +0100
Message-Id: <1329474800-20979-10-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org>
X-archive-position: 32453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Update from old pmu_{dis,en}able() to ckldev api.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
---
This patch should go via MIPS with the rest of the series.

 drivers/watchdog/lantiq_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 9c8b10c..05646b8 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -206,7 +206,7 @@ ltq_wdt_probe(struct platform_device *pdev)
 	}
 
 	/* we do not need to enable the clock as it is always running */
-	clk = clk_get(&pdev->dev, "io");
+	clk = clk_get_sys("io", NULL);
 	WARN_ON(!clk);
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
-- 
1.7.7.1
