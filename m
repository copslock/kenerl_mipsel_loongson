Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:16:00 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:45202
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994819AbeCIPNiBqyvw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:38 +0100
Received: by mail-qt0-x243.google.com with SMTP id v90so10996359qte.12
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZrCntVUNeFt0a2bUYBjSw52np+TQR8HvjSsH9wvhVg=;
        b=uRQESoIMQWl+f6p523F/EpDCDdry1RrJh7gZC1JjykBgeqK6BkhJQWkYcVV0vCsELF
         jii1ZxP68mK2e4/pQx2F2AmBktQvgcFLOyLzlF/eJXq1dwrIH8exq4uhUPLZKSs3A7KH
         ZURhFzZiQOgK6GKTfrtASEKfGWwUrnodrdcRGaCDYZ0enSh8qslBiFUw8cjAe3tJaVxv
         H8trXvn4JPgPVPMFNUyCyg7DTrobp+t/0QY52RrXwrSTnPA3l1WhwiqlikT3Fp+vaV9t
         V+G+4bzUPQ+pMnj44ootXpQC4yJ/T7Vir79pW5ad/7ZBe4p2AOwzHPYo5TYuCNbzem9z
         qabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZrCntVUNeFt0a2bUYBjSw52np+TQR8HvjSsH9wvhVg=;
        b=H5rLf7Y/bywXxdxzUghAgTN+ynCWNZikNiqYZPXaCFF5RWgdN2tn1GkfE0uH1NHbds
         6NnjaLS/o6eSqXya1ocyBKGd5+xy0yeyT21eiB4z53ppqGev22Ova7W6d8TADwzaaP74
         nVsS9fMp1LiUb+Fv4v4SwPiWLxs4mrZLksnkwEhzSPWYrBJKwbdTf6WnhaHwBSwFWjOj
         5pFeavCuAacGlE8hOH+fCF3qzpCkrSg9pRMYXMcNG1ut/j2AOfc53J/Ko6u2x/QJcW2T
         3x0PyESjmgotzefWvsMDWthkj4W/wMdMwQmrY0yfmKYWcKbgA+gLmQcR4ltzuZyQU2UG
         Dd7A==
X-Gm-Message-State: AElRT7ER+NAJE7ZQmM2bGKTgfs17Y7E+i7OHAZaOQxjhiQstVDt41Rif
        IPxYuE1PERAJtH2k/9+bo4hWLw==
X-Google-Smtp-Source: AG47ELtA+38PxF2ZJbH9bFyOL7CKZbVUzc9R4gNJKaek1YSYtmS882J2FNFTqKPZhmh5HdeeJnTgTw==
X-Received: by 10.200.52.73 with SMTP id v9mr46434888qtb.66.1520608412155;
        Fri, 09 Mar 2018 07:13:32 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:31 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 10/14] mmc: jz4740: Use dma_request_chan()
Date:   Fri,  9 Mar 2018 12:12:15 -0300
Message-Id: <20180309151219.18723-11-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62887
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

Replace dma_request_channel() with dma_request_chan(),
which also supports probing from the devicetree.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mmc/host/jz4740_mmc.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 55587d798d47..01016e5cdddc 100644
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
