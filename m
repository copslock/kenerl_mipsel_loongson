Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:13:50 +0100 (CET)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:34743
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994810AbeCIPNS00JBw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:18 +0100
Received: by mail-qk0-x241.google.com with SMTP id z184so2447063qkc.1
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jeY07KjBSfT25uez4N1r+KcpnElhUV0zrUoBslyVkDg=;
        b=x6XpTnf/ENfvs9CiQCrzGrN5UPzRzQfK0v3mRbyMJ286D9kerFiA4/g6nV6XRhsiL2
         qDrAMXGepWC/YOckNBEvBBUR21U75jWXPjCvJbtmBoiY2QiP0jcHNXwgzEOZzKH/wn8h
         /mxCAwu6fRywKXGyqB35tMocglvxYD/VymMxmcWjkuZBb01DrCNwtr6NmTYIfbDi6kcb
         uwpsVFMZ3efT9YQ9LF0ZNxMBK5krppbWdxupiIheMlL7OWpDhTjkItGcHgvPlkdYWgVa
         0B3OCeTfWNkaEcv/dE8LX1A8XhCYbScS72Vm0qP9RbW8PLm82PLhc6KivJbvvnKlO4rU
         xGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jeY07KjBSfT25uez4N1r+KcpnElhUV0zrUoBslyVkDg=;
        b=p9UYeXZz9+aEWvAsncvN2Y5lKgQLr4KN49eRb+H0YAnqmhPqnubfg5BKV+NiPkpWIW
         waCHlW/WGVBfsa9kK9Im4EeoKR/2nKbkEtPOd96XlBic1I0NgX4zl5Pppspf+kYz9Pxq
         S6KtVbFIi7YihaDeSXlFsgVGXmq78WvqY/ioALOzMn3G0Q98bNBCAwD+8RY2ZmjLGHEJ
         s1T0DgGQr0Tyb0XbfLUMBMFFXMZLppBz+d9HNpDlG8FKW+VTQpRfAhBwmMbqV7emNi+f
         uO+4XAS8bGcg0jhOwG71zpvQt8uZ+4RDUGczNwIl5x1wm6+4SpDcINroxTubijZgx5MW
         Capw==
X-Gm-Message-State: AElRT7EuxY/Qclh09TYMIdB/g5kOGdQOjvLFSNwKmi84B7a0if0fxohX
        9LquUpdGDRfqvc3wyAgaKVG4Hg==
X-Google-Smtp-Source: AG47ELuVkfhviNTXmLW8b4wgHq9vI84mAYarHgxppSMyls4fbE3GRuciFhWIwIxHbo1EZPnoKvjnqA==
X-Received: by 10.55.192.208 with SMTP id v77mr41227978qkv.173.1520608392559;
        Fri, 09 Mar 2018 07:13:12 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:11 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 02/14] mmc: jz4740: Use dev_get_platdata
Date:   Fri,  9 Mar 2018 12:12:07 -0300
Message-Id: <20180309151219.18723-3-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62879
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

Instead of accessing the platform data pointer directly,
use the dev_get_platdata() helper.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mmc/host/jz4740_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 8da2bfe82781..5a85a3017711 100644
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
