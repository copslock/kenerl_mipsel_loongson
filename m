Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:35:22 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:33968
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeCUT3K1tHdZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:29:10 +0100
Received: by mail-qt0-x241.google.com with SMTP id l25so6504434qtj.1
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a1nTvLl2ek3rZB1tufeF+M4HtL3gpc9/+MWxFzobtyQ=;
        b=sNTTKnC7SQ4/yXI8rDXqgxWtb2rilyAkJv5VLzyK9iKxERtQ5R78DnZWj5JyrwN0I+
         u8XDO4hsc99meUW2FGt/fUCMCHv5vLqm23mhOH9mFOUsdoQUZV+azL3QWv3zzcpqo6aH
         nC0kzga7J0cVQJzWQvo+eQg71OUHYI9h7ZJrrJWx/n18x92TSEYUeKdf3N2vTBY6iY9r
         gsFf9+75D7xvBlCZDDERFg35YXaIM4I7fWP/RKPVWFtr9zj3wiD2SGVD9XPMiR/mUBsA
         5xTbY2fmm3BGy5HqfAu8lJWAYFCyYhJyyI4ukUdtCA1k7nrzO5ieQFE6ewevI/dvMq9W
         U2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a1nTvLl2ek3rZB1tufeF+M4HtL3gpc9/+MWxFzobtyQ=;
        b=HfH3oqahH4T6PsIPrwcfTka0tI9Xn7lQEhnUEM+rXpD4pEBLvMtBc8Omyv7yM47NEJ
         Z3Nz5rRtD8Li2jNVAYInSzP3KASJfrjrEcuBUJiCmvxMxBlskufxFV5+7RZLDSyM+kiM
         T26jlVX9N9H3pvZggADLUvJ6VaB9J0dKcUFUJMKm4w/cpYG24vEePWM5/7i5ps00xl5f
         5W/ItGDHfRD+aDMoE+e2nVpt98ooc6g0TNe+t64AnJefcLo6Clnh+3oe6BnzBEpDyICZ
         cuQIYM7wGT6NJ2wE3hxR50cOqvv/SY+UehrhkJ+jIH9OJSEgXw4D2IAw2XpuXmstEaad
         2UEQ==
X-Gm-Message-State: AElRT7H7Lj2uHeOS3BCAGgSE9HjsToeeIXo4UrJgnj7fC8GBtQqUYUgc
        r9jOv4PH962xIVgjpNiBfRDgig==
X-Google-Smtp-Source: AIpwx490bfBpQTWUI6+hmhzZMK8Qn7yIyySkLsOqRZR3UewqWHQsEsyjAI5lmYZswNnPFkBbZHsDdg==
X-Received: by 10.200.7.4 with SMTP id g4mr2916605qth.218.1521660544745;
        Wed, 21 Mar 2018 12:29:04 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:29:04 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH 10/14] mmc: jz4740: Use dma_request_chan()
Date:   Wed, 21 Mar 2018 16:27:37 -0300
Message-Id: <20180321192741.25872-11-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63133
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
