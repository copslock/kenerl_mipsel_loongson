Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 23:02:38 +0200 (CEST)
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47134 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994584AbeC1VCI6JTYC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 23:02:08 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id C2C27275F0A
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v4 02/15] mmc: jz4740: Fix error exit path in driver's probe
Date:   Wed, 28 Mar 2018 18:00:44 -0300
Message-Id: <20180328210057.31148-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180328210057.31148-1-ezequiel@collabora.com>
References: <20180328210057.31148-1-ezequiel@collabora.com>
Return-Path: <ezequiel@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@collabora.com
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

From: Paul Cercueil <paul@crapouillou.net>

Currently, if jz4740_mmc_request_gpios() fails, the driver
tries to release DMA resources. This is wrong because DMA
is requested at a later stage.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
[Ezequiel: cleanup commit message]
Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index a0168e9e4fce..97727cd34fc1 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1006,7 +1006,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 
 	ret = jz4740_mmc_request_gpios(mmc, pdev);
 	if (ret)
-		goto err_release_dma;
+		goto err_free_host;
 
 	mmc->ops = &jz4740_mmc_ops;
 	mmc->f_min = JZ_MMC_CLK_RATE / 128;
@@ -1038,16 +1038,17 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	jz4740_mmc_clock_disable(host);
 	timer_setup(&host->timeout_timer, jz4740_mmc_timeout, 0);
 
-	host->use_dma = true;
-	if (host->use_dma && jz4740_mmc_acquire_dma_channels(host) != 0)
-		host->use_dma = false;
+	ret = jz4740_mmc_acquire_dma_channels(host);
+	if (ret == -EPROBE_DEFER)
+		goto err_free_irq;
+	host->use_dma = !ret;
 
 	platform_set_drvdata(pdev, host);
 	ret = mmc_add_host(mmc);
 
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add mmc host: %d\n", ret);
-		goto err_free_irq;
+		goto err_release_dma;
 	}
 	dev_info(&pdev->dev, "JZ SD/MMC card driver registered\n");
 
@@ -1057,13 +1058,13 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 
 	return 0;
 
+err_release_dma:
+	if (host->use_dma)
+		jz4740_mmc_release_dma_channels(host);
 err_free_irq:
 	free_irq(host->irq, host);
 err_free_gpios:
 	jz4740_mmc_free_gpios(pdev);
-err_release_dma:
-	if (host->use_dma)
-		jz4740_mmc_release_dma_channels(host);
 err_free_host:
 	mmc_free_host(mmc);
 
-- 
2.16.2
