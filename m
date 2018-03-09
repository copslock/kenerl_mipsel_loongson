Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:15:15 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:41693
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994815AbeCIPNairuIw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:30 +0100
Received: by mail-qt0-x241.google.com with SMTP id j4so11026829qth.8
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xllkAR10+Ad4RnA3sI1ID2LFaDLBur6PdGcE7Y4hVrM=;
        b=f2UREu5Q75oQQcZ0TxOVNHpbf6isOJX1PoKoPA9uoDNjaJQoqP+GD66olm9DmfqSlZ
         zoZi3IphPFwEelA++XZw2SJ+uAOAnprOz3khIWZ7DWeTBBxqKZZLiA14mSV5o5lKKLVp
         AbgRNOsuKylCqZ89LEJU3yUHUhGFURfGCJ3M8iobMfiq/Z4NgPYKX10f7RB4hjDxTICs
         i5IZU9LtoxLyON3urUkNX3YZ8ffScRzIHm3jUqhhSJLKmcmvL4N9ZsswIY2LrjUXVnrf
         B+qZzEHADwWB0xz5lsBFsN7m0OBQRV3PsqrSQiLYZ+Emfn1GeYX40U9LLDmMaS8ec3iE
         ToIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xllkAR10+Ad4RnA3sI1ID2LFaDLBur6PdGcE7Y4hVrM=;
        b=hCE24LwtBC0rTj4z+gANCZsitFyehjMl+bmGJqMH1WjVc63lFP29x/qE/sJr+/lcJr
         Itv0FK2ER5j1nBxbhbKqb/oQB1gcvbcj7UTxsqoNOeSKG/7MXwsDpnqXU6ICeTIdZ1at
         puDdshXg+Ezzbr3ftD+gNHtug77+NRYiWVHXnKRVCERYR6yYdQ6jVKdfUIYf95bdL6dn
         9HR9hn6d2XbcN/ggKdxN6dSv8SaKVjjxwR8Fa/74bQwCMFZDJsLgbRYC20/xZzWPXudh
         wQjJDURqq3GGW48IqhVM1paf03nAoKoSO7Hozc+y9GjUYjM9Kyvr0S1lDU0cFFKbYVGS
         locw==
X-Gm-Message-State: AElRT7HEGFXuLrCC01qU14vLwjoUWwvJcYd8GZzwCK+IUSfXz432ORte
        4G5B2Zz3uA01iYlvhx5QwGpz1g==
X-Google-Smtp-Source: AG47ELsB5mQ7htFhKHp1tPlAHCjd9CpwnVYO0dnd5Kl1ob87JV2ePVa+/gjThNcP/dp3GT6c6E12bw==
X-Received: by 10.200.8.56 with SMTP id u53mr48258830qth.315.1520608404864;
        Fri, 09 Mar 2018 07:13:24 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:24 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH 07/14] mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
Date:   Fri,  9 Mar 2018 12:12:12 -0300
Message-Id: <20180309151219.18723-8-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62884
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

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
---
 drivers/mmc/host/jz4740_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index c54861037481..7d4dcce76cd8 100644
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
