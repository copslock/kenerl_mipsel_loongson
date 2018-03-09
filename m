Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:14:26 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:44780
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994813AbeCIPNYv0lWw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:24 +0100
Received: by mail-qt0-x241.google.com with SMTP id g60so10992105qtd.11
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pi7vsQJafTBHjHSj559Un0l1rUuB5wXd4oHqRUxKmHU=;
        b=c57w2F+rXlLxz5tJCObZPS6pAM3m6wwDGuRN69IsH4P42gJ+mMRTQ6mJta9iytIMTx
         6+Uv2GOIFlT1T+FXlN+KOWAr7FSXvtELn/cNYSD69CfaT8R5jZIpvuI2YYodtj9jQZyx
         NHLNMzy+6a/07b2vjz58eGmIbOcGp3afaQFDdbDDM08QUL3350b/yle9RPwy3bBS4zmG
         LmR7IwJrH2xfDU7VNpaNcUwqg6lg1K+uQERDRU0XiaTAMG9IsGVFLO73tZlif08oQxLi
         FxISkq7LyNxQfuxq3T0C7bBGyxOvITL2EpJSuVEv6HrvTcjcTitwY42bRs6jbR6fVATj
         nslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pi7vsQJafTBHjHSj559Un0l1rUuB5wXd4oHqRUxKmHU=;
        b=fnW0Ow7lg9yMZOQruc+6hKM8iy4Sdkhm/3Q53N6jVcPh+qvG6OGsinGplPsAMYxwIG
         F+W5tgTEUKY2K2YfVclxICLWHwyXNdnnr1R+rwa7hzwtAiJsO2X+h/+cFpoueJ9nB6Y+
         503WoslV2s1An/rOodIz+PlofD7PdPggdsWe3bcWlq8x/JoQ0rEkRYq7n/D9F/qpQCxP
         5qpcuhsUiUbxxYbU946RVM8SNRhv7N1aPskgv7mLiN7S/vh08QW8JsxK8iBuySR49kkH
         X41xb/YmNOPRbvmPEMpueVVUEKkTKEuydS8tQIjf6BIzxajf3XD9BHPmu9aHjOgvULA8
         1Lzw==
X-Gm-Message-State: AElRT7EXuYh71WCLRb9a4c/qtUOIwpRpGaBJH7+kNqxJT+RQlYl9mKxy
        UDQpHqELFB7d2tjXv564V093LA==
X-Google-Smtp-Source: AG47ELtICdy3/reQfFLWPmR/4H2wja/tetuDU6E3HKTiqNrRbg6odVqCNmvgsjxMPQYirdKOj3tB2Q==
X-Received: by 10.237.40.67 with SMTP id r61mr47212269qtd.233.1520608397415;
        Fri, 09 Mar 2018 07:13:17 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:16 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 04/14] mmc: jz4740: Reset the device requesting the interrupt
Date:   Fri,  9 Mar 2018 12:12:09 -0300
Message-Id: <20180309151219.18723-5-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62881
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

From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

In case a bootloader leaves the device in a bad state,
requesting the interrupt before resetting results in a bad
interrupt loop.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
[Ezequiel: cleanup commit description]
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mmc/host/jz4740_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 636741ac9031..0a8edd5b4052 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1027,6 +1027,8 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	spin_lock_init(&host->lock);
 	host->irq_mask = 0xffff;
 
+	jz4740_mmc_reset(host);
+
 	ret = request_threaded_irq(host->irq, jz_mmc_irq, jz_mmc_irq_worker, 0,
 			dev_name(&pdev->dev), host);
 	if (ret) {
@@ -1034,7 +1036,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_gpios;
 	}
 
-	jz4740_mmc_reset(host);
 	jz4740_mmc_clock_disable(host);
 	timer_setup(&host->timeout_timer, jz4740_mmc_timeout, 0);
 
-- 
2.16.2
