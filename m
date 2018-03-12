Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:00:31 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:37373
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeCLV7ZSvp7f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:25 +0100
Received: by mail-qk0-x244.google.com with SMTP id y137so13247271qka.4
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NpGtWgKk6wobEFvNo72BCQ/Aq6YGxh6e2l34gdEA53g=;
        b=uEAbvl9N4xR1Y0FvMRcnoNv2pTS5t0G/DcYcYGttYhAmYD0kl2M7HooGX3wVVD45xm
         dPftyyudKsXwzrWN7taESfsd+CgyGt7x+l3ntpIPM6n9UyoIsvQuCJn0IOQg/vc1rQP/
         wV9ii92bP9szmt5adp3qzUOLAg5iVn+nPAsk1HKSSjU6I+jbY6u+wPSNXQ6FlZZnSJ0P
         mF/Vcv+j3VmFqg2wJFwDlWQ/2s6dPcNw56EGTtx24ZSJPEUBtR1mB/omMzRfgkzX6gpL
         m/hoWXmYt78bvtPs0FwH8K4yadRt6BIskP3UkqA6ihv42nlnF0XZvu55J07TTaTy3oYw
         Ifjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NpGtWgKk6wobEFvNo72BCQ/Aq6YGxh6e2l34gdEA53g=;
        b=H+RMVwY7zX0gDRdc9h6XhuR5QxGZlzsE2hwoB71j7MNs+QKZzdgvkioZZ4slXimjSE
         M75Xs8NiVgugQw1P+UKggOPY9fgxiZdUatrvlMrmLOJGKw1sN7k3/ofuC8O9qGSJB8En
         h7iszwP4PEPEoMIt+kV7ApjfAoTceyB72/TrnX8h/wu/AZjJI43fR7HozTYMj1y/iExV
         507J4p8qz48fGhtjivmuZkV1j8URTqToaYogwgzqUpXwQOpwneBAKXHoh0p0reklKeM0
         FVCoqvxzqO9GJsGR4qvqSG2/XUn4xijBbYzezbh5SAHilvYeYQnFj6THa67MZslRcmhM
         flPA==
X-Gm-Message-State: AElRT7H0iMm5xw7fs0NFXcHJL2vz9bGzeRFD0yMeCRPnJ0VZCPzxZQFj
        fz0DvYnOaDB+Hu6vzobBoqU6Mg==
X-Google-Smtp-Source: AG47ELsCZEHIE77HiPtG7g6Z5GgFApdMv6cbr6bOijVGD8pMA288cBzRQ5E0vLTNAyrzpW2xqoRWaQ==
X-Received: by 10.55.152.133 with SMTP id a127mr14659315qke.100.1520891959464;
        Mon, 12 Mar 2018 14:59:19 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:18 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 04/14] mmc: jz4740: Use dev_get_platdata
Date:   Mon, 12 Mar 2018 18:55:44 -0300
Message-Id: <20180312215554.20770-5-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62935
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

Instead of accessing the platform data pointer directly,
use the dev_get_platdata() helper.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index eb57f514a459..b11f65077ce7 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -926,7 +926,7 @@ static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
 static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 	struct platform_device *pdev)
 {
-	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct jz4740_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int ret = 0;
 
 	if (!pdata)
@@ -955,7 +955,7 @@ static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 
 static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 {
-	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct jz4740_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (!pdata)
 		return;
@@ -971,7 +971,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	struct jz4740_mmc_host *host;
 	struct jz4740_mmc_platform_data *pdata;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 
 	mmc = mmc_alloc_host(sizeof(struct jz4740_mmc_host), &pdev->dev);
 	if (!mmc) {
-- 
2.16.2
