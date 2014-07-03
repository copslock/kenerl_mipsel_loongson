Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 15:26:48 +0200 (CEST)
Received: from mail-we0-f179.google.com ([74.125.82.179]:36320 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861114AbaGCNXQdjPtp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 15:23:16 +0200
Received: by mail-we0-f179.google.com with SMTP id w62so231870wes.38
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4qVpPgKRiXsmSphh/iZsP3M12QB2fFBySXK1dwxw+rI=;
        b=sUjhTLKtR5Ccxr+FT4Gio9sgR1bjbdF1evSTptqWBGplPj9vrUn9wp1a2FvqhlVwXC
         p5cWDaDUDDdjp+PLC4hhis+ZUMuJGufRKgrSJV2KbezmlXzPBPiVtPgjh0LoYzRFVl4E
         rjmfIOLtPKliN+6xmoF+B9Tlr5llJDEhy77hIqMXXqgUEeGFgZHXpvs8FS3Q7pWE5y5I
         SJcuNeY5EV/OY2jeoCQYpaLXHv5jUiJFZ4R1a6LHREKGSaMNiInk4d1Q9DeXLgBRZKC9
         psP8RSRzia/m8f8Byalre8Wv2FBqfaE9Ri9fLm/24el3LnWa4ee0g21dRw8q2u//5J9h
         Ugqw==
X-Received: by 10.194.71.132 with SMTP id v4mr3241596wju.102.1404393791301;
        Thu, 03 Jul 2014 06:23:11 -0700 (PDT)
Received: from localhost.localdomain (p57A34891.dip0.t-ipconnect.de. [87.163.72.145])
        by mx.google.com with ESMTPSA id ev9sm67079017wic.24.2014.07.03.06.23.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jul 2014 06:23:10 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH v2 10/11] MIPS: Alchemy: au1xmmc: use clk framework
Date:   Thu,  3 Jul 2014 15:22:41 +0200
Message-Id: <1404393762-858019-11-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
References: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41005
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
index 1837309..0c0ed16 100644
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
@@ -596,17 +598,10 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 
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
-	pbus /= ((AU1X_RDSYS(AU1000_SYS_POWERCTRL) & 0x3) + 2);
-	pbus /= 2;
-	divisor = ((pbus / rate) / 2) - 1;
-
 	config = __raw_readl(HOST_CONFIG(host));
 
 	config &= ~(SD_CONFIG_DIV);
@@ -1029,6 +1024,16 @@ static int au1xmmc_probe(struct platform_device *pdev)
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
@@ -1105,7 +1110,10 @@ out5:
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
@@ -1147,6 +1155,9 @@ static int au1xmmc_remove(struct platform_device *pdev)
 
 		au1xmmc_set_power(host, 0);
 
+		clk_disable_unprepare(host->clk);
+		clk_put(host->clk);
+
 		free_irq(host->irq, host);
 		iounmap((void *)host->iobase);
 		release_resource(host->ioarea);
-- 
2.0.0
