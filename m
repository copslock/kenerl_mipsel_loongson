Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:14:13 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:36768
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994812AbeCIPNUmF0Aw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:20 +0100
Received: by mail-qk0-x244.google.com with SMTP id d206so3989203qkb.3
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WOZhOqT7hWMIxR5bjG1pr/CL2J1ANP0Vt3Rv1rfKaas=;
        b=gtLa6WINEQP3G69TdoV/f6z6FQuU5oxilFIv8hmQSUpzCSLEnwqae9XF/rgv0RV8gi
         BNexcp5i8FsAPDtcnXIGjIbSDr/WbQZXiJ13ZrD6hKzuyLTNaAf5tqPqDEg4E5wVOS5I
         m/Hzq7ANQgysfFyKbOgUV4lpPQu+hVnwgWgt+4whE0amSrf0BW/x3oZmp9BgFburcTUM
         m8nY17uGc2SPb5dyZ8sI3idW2xDrkPGk+sIg/F+OZjne/sfXKcDQZdc3Ps1gFCsfonLN
         5WJ88pCwxbvJe3E/7qGX8TMVnD5KEqrGt+vPPLyHko26OyXnDfi68SInUJK4xC3LnSWL
         fyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WOZhOqT7hWMIxR5bjG1pr/CL2J1ANP0Vt3Rv1rfKaas=;
        b=tgojiZfQ2+MRIm9qlIwyRyRPWAOivjyCALHP5okibU0nj2zsMnkHCZMOjePp2VF/5B
         MowW4YTilPExVnk+9E1imTu5KGVQbafB0Hds1eiYlrcDSmAoDqv05CBafnD2YMvthPy3
         j8U8zIExPHH23rBFRi1pbQSk/5F6rjn5ZT2VJze3D8wtFS9El1sXmtbvN33siat9C4v6
         Gp9pNlLReC8hLs6fuAFDGYFdZkvpBCFzWthEBMmOLJ+ulGBKqQgZD63OC2siSLfTGmvD
         p85eGobi1GxuDypoQhpopRj2nFnWQVM7Ue4b/mv8DnQl+Pul81Lkk3wPMB281I+eIV3c
         8Trg==
X-Gm-Message-State: AElRT7GbI3SgvqQ+eYJkVgq29eOgHiNsxnPkmhkp5le5833Rh4XDOi7K
        6/NcZTGpaOH2iqgnO/zLDrmO/g==
X-Google-Smtp-Source: AG47ELsxEvwgKBIG95lbqkNXEyv2wc5pxEJ2XmOdmW9s1BPgjW1TRA9jO69tJk2LlRZgwGVmi5MFsg==
X-Received: by 10.55.161.134 with SMTP id k128mr42846417qke.295.1520608394883;
        Fri, 09 Mar 2018 07:13:14 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:14 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 03/14] mmc: jz4740: Fix error exit path in driver's probe
Date:   Fri,  9 Mar 2018 12:12:08 -0300
Message-Id: <20180309151219.18723-4-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62880
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
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mmc/host/jz4740_mmc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 5a85a3017711..636741ac9031 100644
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
