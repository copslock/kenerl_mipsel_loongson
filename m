Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 16:48:02 +0200 (CEST)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:63114 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842568AbaGWOhe0h0Pf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 16:37:34 +0200
Received: by mail-wg0-f45.google.com with SMTP id x12so1272233wgg.28
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MYChJCZmWVAzluIlEJN4EI5fb+HIjaZi0QEwxf0fTcw=;
        b=shDtzETH7oP9dSpajCFBQqg8wHc+qW65ocAEznCs1hK+2NZujhb1aiYrj/eHfcneQe
         zf5iYXM8W4BosqA3DomHKRsSX0fnEphXs7069ZU1UiYDPtUtye178S49t3sa76QXpv8P
         hytp6Pb/0UMDrE57QwJMKbdX4IikiQvxIlZuDQxEjrChLWT8Dao0PNjUJhzUlX1rZI03
         05VDc0Y5vN5w2GsACVqd2NLaEGXrnwqEwaWbKp1VTfOA8K69lRLbqymnCTWK2QLZAKN9
         R3YD015rHmE/9Glegz8w64pNa/DrQ9Z5VU3T1gxFU68KUvKHfg/s8gPo1VLHt64IHJZm
         IgtQ==
X-Received: by 10.194.191.162 with SMTP id gz2mr2336642wjc.89.1406126244094;
        Wed, 23 Jul 2014 07:37:24 -0700 (PDT)
Received: from localhost.localdomain (p57A349C7.dip0.t-ipconnect.de. [87.163.73.199])
        by mx.google.com with ESMTPSA id ex4sm10196560wic.2.2014.07.23.07.37.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 07:37:23 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 09/10] MIPS: Alchemy: au1xmmc: use clk framework
Date:   Wed, 23 Jul 2014 16:36:56 +0200
Message-Id: <1406126217-471265-10-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
References: <1406126217-471265-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Use the clock framework to get the peripheral clock rate to
correctly set the MMC/SD bus clock divider.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/mmc/host/au1xmmc.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 2988e9d..9c9f6af 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -32,6 +32,7 @@
  * (the low to high transition will not occur).
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -118,6 +119,7 @@ struct au1xmmc_host {
 	struct au1xmmc_platform_data *platdata;
 	struct platform_device *pdev;
 	struct resource *ioarea;
+	struct clk *clk;
 };
 
 /* Status flags used by the host structure */
@@ -597,17 +599,10 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 
 static void au1xmmc_set_clock(struct au1xmmc_host *host, int rate)
 {
-	unsigned int pbus = get_au1x00_speed();
-	unsigned int divisor;
+	unsigned int pbus = clk_get_rate(host->clk);
+	unsigned int divisor = ((pbus / rate) / 2) - 1;
 	u32 config;
 
-	/* From databook:
-	 * divisor = ((((cpuclock / sbus_divisor) / 2) / mmcclock) / 2) - 1
-	 */
-	pbus /= ((alchemy_rdsys(AU1000_SYS_POWERCTRL) & 0x3) + 2);
-	pbus /= 2;
-	divisor = ((pbus / rate) / 2) - 1;
-
 	config = __raw_readl(HOST_CONFIG(host));
 
 	config &= ~(SD_CONFIG_DIV);
@@ -1030,6 +1025,16 @@ static int au1xmmc_probe(struct platform_device *pdev)
 		goto out3;
 	}
 
+	host->clk = clk_get(&pdev->dev, ALCHEMY_PERIPH_CLK);
+	if (IS_ERR(host->clk)) {
+		dev_err(&pdev->dev, "cannot find clock\n");
+		goto out_irq;
+	}
+	if (clk_prepare_enable(host->clk)) {
+		dev_err(&pdev->dev, "cannot enable clock\n");
+		goto out_clk;
+	}
+
 	host->status = HOST_S_IDLE;
 
 	/* board-specific carddetect setup, if any */
@@ -1106,7 +1111,10 @@ out5:
 	if (host->platdata && host->platdata->cd_setup &&
 	    !(mmc->caps & MMC_CAP_NEEDS_POLL))
 		host->platdata->cd_setup(mmc, 0);
-
+out_clk:
+	clk_disable_unprepare(host->clk);
+	clk_put(host->clk);
+out_irq:
 	free_irq(host->irq, host);
 out3:
 	iounmap((void *)host->iobase);
@@ -1148,6 +1156,9 @@ static int au1xmmc_remove(struct platform_device *pdev)
 
 		au1xmmc_set_power(host, 0);
 
+		clk_disable_unprepare(host->clk);
+		clk_put(host->clk);
+
 		free_irq(host->irq, host);
 		iounmap((void *)host->iobase);
 		release_resource(host->ioarea);
-- 
2.0.1
