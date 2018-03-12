Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:01:56 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:35847
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeCLV7nSJsYf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:43 +0100
Received: by mail-qk0-x244.google.com with SMTP id d206so13244441qkb.3
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a1nTvLl2ek3rZB1tufeF+M4HtL3gpc9/+MWxFzobtyQ=;
        b=u9R44rObUkfv1SUsj1A/W3BcTYNd9sEEAtlIUJ6IDtFPMo3JPLcnnCY1WNWKXnFa6y
         ZD/5/hOGh8aVFBYrh5TG05oTtTDprAnYacX5gSGuy3RlUBPSne0huczMZw4nH4Venv8p
         5QnoEv/XAjiPFmv/QKRvXHKr3H/d6o48EzMnQrRytGClgXuqboG9XFiqh5qUZX16D7ai
         xUeHWq9nZOpSMpPQ7G+C6/v3x57l8RmCAN/iNSear1mK3TENNGbJWJ+ET4a1BBNrMzYC
         9DB9SfLTTLntraf6sEVlTv4kAlfpT128X1mb4cM4f/BbXsHKsDv17sIgUQ2GNs4cpBR5
         800g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a1nTvLl2ek3rZB1tufeF+M4HtL3gpc9/+MWxFzobtyQ=;
        b=S7qrBxgMuFj0vVxucxV60zjS3Yo4i53u9+kESC7md+0LI4rf7cN3F5p4m5EN8VZzDJ
         Wzvb7gNfb1I8F/tuNCw0XrzlFTjIFnC/FVu0/fZ2a03WDQkU48CuHAM6rG7sljCwv+c6
         Df+FqhfYOu1IBX6bNGmc7LBwPFnz/Ju/An33hNynB6gjaZzXXDUbarfeG/sIprozlXsu
         qZq/Detm58kFdKc25uxnim8XQ4uQds0z/xj5gGmom0EyAFhBHGUZ34saG43nimPO4XeU
         GlPB0Qw/X3Xfy7TrosiE+/N08r6jT3bQYhElhrIfcUMzxhfU8iKYLJG+CXr9jz5/vI7F
         8/7A==
X-Gm-Message-State: AElRT7F9Giyiu7XZ5QTbxA0sELDWU036i4KX9yDIi0BG/JLc/IJgS+pt
        zenP3Q8hKo1SwC5YyZZBLcbsPg==
X-Google-Smtp-Source: AG47ELtUyqfoHiLBL6acXeCK9LwihY178VCgwGvmt34C/ogFPFXn6XJCFxVBLR1wS7hVcNORav+Cnw==
X-Received: by 10.55.192.151 with SMTP id v23mr10004259qkv.83.1520891977437;
        Mon, 12 Mar 2018 14:59:37 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:36 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 10/14] mmc: jz4740: Use dma_request_chan()
Date:   Mon, 12 Mar 2018 18:55:50 -0300
Message-Id: <20180312215554.20770-11-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62941
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

From: Ezequiel Garcia <ezequiel@collabora.co.uk>

Replace dma_request_channel() with dma_request_chan(),
which also supports probing from the devicetree.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index c3ec8e662706..37183fe32ef8 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -225,31 +225,23 @@ static void jz4740_mmc_release_dma_channels(struct jz4740_mmc_host *host)
 
 static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
 {
-	dma_cap_mask_t mask;
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	host->dma_tx = dma_request_channel(mask, NULL, host);
-	if (!host->dma_tx) {
+	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
+	if (IS_ERR(host->dma_tx)) {
 		dev_err(mmc_dev(host->mmc), "Failed to get dma_tx channel\n");
-		return -ENODEV;
+		return PTR_ERR(host->dma_tx);
 	}
 
-	host->dma_rx = dma_request_channel(mask, NULL, host);
-	if (!host->dma_rx) {
+	host->dma_rx = dma_request_chan(mmc_dev(host->mmc), "rx");
+	if (IS_ERR(host->dma_rx)) {
 		dev_err(mmc_dev(host->mmc), "Failed to get dma_rx channel\n");
-		goto free_master_write;
+		dma_release_channel(host->dma_tx);
+		return PTR_ERR(host->dma_rx);
 	}
 
 	/* Initialize DMA pre request cookie */
 	host->next_data.cookie = 1;
 
 	return 0;
-
-free_master_write:
-	dma_release_channel(host->dma_tx);
-	return -ENODEV;
 }
 
 static inline struct dma_chan *jz4740_mmc_get_dma_chan(struct jz4740_mmc_host *host,
-- 
2.16.2
