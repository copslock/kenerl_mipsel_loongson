Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:01:28 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:34967
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990432AbeCLV7hSVMvf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:37 +0100
Received: by mail-qk0-x243.google.com with SMTP id s188so13253340qkb.2
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LpeJNDIrxTNXum12i6k3vaUqafcdTuwV4bnLteYB6Iw=;
        b=wtYDYWfcgwMY+qWzGxRdXKvVXDpIFPqdyW4FtOKZ8nz2R4e/meYJBbUc0G4sVjAE0U
         kgALEuHj2piUTUM2/4vMYuTGDWprwLpigbTJdF5DhOVhwjr8l5ovs4oXbnPkVDD4jik0
         DvGruEHSI19Jk0Gglgwkv8irMgvgsdhwkPs/tu5GWhCfApyCENMot5eHrF+DGqD2pOxl
         uI+uapZ/LeRQEfqiH9Ped1ADPxJb4C88eUxEHUfNajD+DB9qgIVbErl8pPIoGS/MD+Nt
         8nG4LtLmCWHV7AFWjiLLn1G/pgCqQK0K2MqgxsFTDEtWxz61dDERe8fTosS9Km0BGnuJ
         k80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LpeJNDIrxTNXum12i6k3vaUqafcdTuwV4bnLteYB6Iw=;
        b=YHPbQzoaqrgoEJAFpT+VhtWVJhtTzv+DmHD7/hiW/YT6aVuqKZ2Ot3yv/JIpVh6LBZ
         uG0L0JyJgV0o/1ki93HQU+0XywzMfrjIqjnksx6AoKl87yf5qWL28KvYKHAxEfK5dQ7I
         wg6uXTKDwslO08pNAdvhRPjBr3ynfGpTqUursCqNPNOA9goDtRzZMHWEHRZbAGu172jS
         X6+0WatNIVhfAxviQUisKA38hA/MneQg2qEU/0u+R/++HWhKqFgwaUGauqbldHECXpCj
         c1GFyr+EqU9n7SGTpRJKX6gwvbWYh6VjLBcBdywu1jwsjNH9mxLQuKSudZkGdeFfm8D2
         FnYw==
X-Gm-Message-State: AElRT7ErWok/O5ZgqzTyJYfDIQt3cQVF4JaA1GYuSxQmL2Wt9rhovBFH
        dubGj/MFHPKS2L7/E3AdbsJQIg==
X-Google-Smtp-Source: AG47ELsNiw5LXu4HdqXTO2piwGcH1+At47zfyujSX2hnwro/973Rkg8rWBciqBeo9S3jKMSj/hPN1w==
X-Received: by 10.55.170.16 with SMTP id t16mr9402724qke.300.1520891971542;
        Mon, 12 Mar 2018 14:59:31 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:30 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH v2 08/14] mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
Date:   Mon, 12 Mar 2018 18:55:48 -0300
Message-Id: <20180312215554.20770-9-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62939
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

From: Alex Smith <alex.smith@imgtec.com>

The maximum clock rate can be overridden by DT. The clock rate should
be set to the DT-specified value rather than the constant JZ_MMC_CLK_RATE
when this is done. If the maximum clock rate is not set by DT then
mmc->f_max will be set to JZ_MMC_CLK_RATE.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 drivers/mmc/host/jz4740_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 03757cc55f52..aa635b458d2c 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -825,7 +825,7 @@ static int jz4740_mmc_set_clock_rate(struct jz4740_mmc_host *host, int rate)
 	int real_rate;
 
 	jz4740_mmc_clock_disable(host);
-	clk_set_rate(host->clk, JZ_MMC_CLK_RATE);
+	clk_set_rate(host->clk, host->mmc->f_max);
 
 	real_rate = clk_get_rate(host->clk);
 
-- 
2.16.2
