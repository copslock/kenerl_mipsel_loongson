Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:33:21 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:38161
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994690AbeCUT2r5RZIZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:28:47 +0100
Received: by mail-qt0-x243.google.com with SMTP id n12so6495946qtl.5
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zS8DuZCgSWAbMqUw73qy9vbhinaH2w0oSvOpcS3KjU=;
        b=rD24ludYE203WwX8pEHi+vlQl2HVuf5AU8fl4MnL1Tf4jxVJ1+uEX1wiNSQCFxfB3v
         cjDgq0+iTAlTlp6LXh29D4VkHX0d7YWPeZfaCLvYFxve9Dore06lUQ6kYLGc3BuQmyOL
         dFYEOxvfLCK6gUYiBMUrPFjD0dWgbYLKPLcDgVChnmcY2RRjKdWt9zSIdDxCc94ICFnd
         DNhjOUVmdE41+SIcldCBZqSvsg+Q/VP1/+IB9qjLK+d5Cq13Bm1v7FMlma26PsNxZr+X
         mniU9+YJ78dFZUBbkyYHOBl76z0E9y/W4Y5YNi3jWsuLL//Tkw8hRXIjU3NF61NKILpb
         if/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zS8DuZCgSWAbMqUw73qy9vbhinaH2w0oSvOpcS3KjU=;
        b=m7g1PbyhCirykbloXWZ7E0oNCwNprGZ8p4GTlwpkA3UiEw6wBMtCXm2DA9Ih6QA6W7
         QFL/gfJaqWJnUp1/q5WTjqRgf29ZdR7JtKF3yFTHZBZ+iUt7OtbpZRzp2ayFf21EWIO+
         Uk50dCnP+YM/oZn9YURPYw8rL+o5gYKfH3gjQ9ARe6SB/n3mrTUt/zDU6Yx5blZ81Xtl
         gxOlYzqKyVQojxdW8EdErOriaIQtjHeuF3Sfp0/RkjmtO6m8/aYmMCP3swHGxi0wvcNN
         b4OofUztjnd+RDENQEPrUopJNNQZKVOwLTkv9pyqzj3B8EkzzPe3Y1IIRCCu2LvBvAiA
         QldA==
X-Gm-Message-State: AElRT7H8i27uo/ETbIqEcce6yfTdrL6Ax8RDM2qBjI+yqZE7gea9ozkj
        alXz1cIqQmVDijIXYfrNWx5QvA==
X-Google-Smtp-Source: AG47ELtjk1A9DJVHGH7+R8ywXQzRvGpOvUFDb1Ml3ev0ZLnLIj5Tv4mKDp4edu9H8H5QGUyxgd7nXg==
X-Received: by 10.237.47.165 with SMTP id m34mr32168820qtd.178.1521660522198;
        Wed, 21 Mar 2018 12:28:42 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:28:41 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH 02/14] mmc: jz4740: Fix error exit path in driver's probe
Date:   Wed, 21 Mar 2018 16:27:29 -0300
Message-Id: <20180321192741.25872-3-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel@vanguardiasur.com.ar
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
