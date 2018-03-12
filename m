Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 22:59:51 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:35843
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990409AbeCLV7TfI83f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:19 +0100
Received: by mail-qk0-x244.google.com with SMTP id d206so13243423qkb.3
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4zS8DuZCgSWAbMqUw73qy9vbhinaH2w0oSvOpcS3KjU=;
        b=O2XKyuYEZToOpksBcDvVYE9L8PY5xm2fXa831q0mosGVHXkF6Uir54046ccPxb0sGX
         eM6TfCRNmtFXSyR9x+vShVU058wKbwmmkz9HO1px90FbuMlKS0HrsS1h/LmwF/vTOj96
         e76wAfG6zTy7cMtBnNI7Tf8d0V4y9wyjUs2y32/J21KLnLXeRY+W/WZhfCk5jqAEarsx
         uhYckusTXvyWpcBL2PHp9n1KtemM4FESmC79tpwbeAAZoCzEZr9BWoID3IbQog95irtx
         UH1VQWvRmdFiLKxxFOVimzdxASl8MiJ9uGq/2U1x/CRbv1uySDTiNIFzPJQ5/m+qfZCn
         mP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4zS8DuZCgSWAbMqUw73qy9vbhinaH2w0oSvOpcS3KjU=;
        b=P8LVEhqF4W64nndtvxBDrLIqgakwFr5y2xniCsDm17MsZ4/ZM/xyf5koC/JCB3/MiF
         mIiP7xDKRNkeRsV0PokLaKs6+SarysHwd/9HRR9QSt6KwQELE6O4h9KjO7tHX1c0MbLZ
         zNwDsPSf/vrgH7X2di9VdYlfDuPHn2HvLxbI8oinWIawb1LsbqVC2FAQncl2riu0suwL
         i2b/NWr39NxoLfzVR6Ews6ThH9Zr5Koo5NyyX3VIoiZcDR+JYfxyclLlKOgBtQynrKkw
         /TkXlH+pM4j/oX7u4ibYiSFJ6GDP0Xa23NB0+9bNzUxcl9it1jgkzUF5a/snamelp5Tf
         6h2A==
X-Gm-Message-State: AElRT7FioXnwZC+uMy4YDsQUBIuxEbBB7UYlvbCwi8lYuAlsNNqISKBc
        SlW0wREH6z+AYBOLW0Q4UfPsuQ==
X-Google-Smtp-Source: AG47ELsW6CaTEkGWzCKaxJwPopdRPk6/RmwzYlrcx18MWLt/wrA3l9Df9kZojXvMfsD1BrcoffmSGA==
X-Received: by 10.55.175.6 with SMTP id y6mr14113641qke.32.1520891953827;
        Mon, 12 Mar 2018 14:59:13 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:13 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 02/14] mmc: jz4740: Fix error exit path in driver's probe
Date:   Mon, 12 Mar 2018 18:55:42 -0300
Message-Id: <20180312215554.20770-3-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62933
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
