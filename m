Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 20:33:50 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:39231
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994691AbeCUT2xWC6BZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 20:28:53 +0100
Received: by mail-qk0-x244.google.com with SMTP id j73so6687874qke.6
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2018 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NpGtWgKk6wobEFvNo72BCQ/Aq6YGxh6e2l34gdEA53g=;
        b=oH+ymEDfxSVfE4HmcA+ZX/75ax7bgtyvSLilzlyURKyTi8y7OoFC/veBRxGAGwxd7V
         xwoOsk6OZ+uJWjoN7NEJ+paUeNLrUXNVy7ZkIPIGF2/QKwfhnTwRh3Qo0rzucdHv9CyU
         UmexaDSo0t9XgzLRijvVa6oQMZHR+iqWi3l7OoEuJoe6tRZ74uol+HaribJGFo396yl+
         KxhFpRsDUoDpWolWt0I3hmEtsfi/hozTpv+SF7ieaOOIDAgUqaXYlsavszp2Jg2VrSJk
         stNoA5neyjwgUMNPd99DC+VlZSPbGDhCFhRPsrAQxuZyPuRqkg2BWXxGu+0VeCWjr43C
         I2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NpGtWgKk6wobEFvNo72BCQ/Aq6YGxh6e2l34gdEA53g=;
        b=QwX28/x1oz7YUlL+mO8x2RrJzE4zgXVDRi1gOkb1Z0LRihr8gGXiOjrrP498IvTlSc
         wF6Aiyz/UDlcuv7S1+OkIitirc540V8ki3wwmYJ5GgFS6rACwnIXNOiVQMv7X/f+7XrD
         csGtqAaDHuKU1Am+jyzLDC/HEixvNiXCviIWNG4VJnocBiU4kd4yJ/MILvXLNO43h1my
         yI/3/NDVq5ys5XtoctSm44bSWLh6JZGwDYJpoK0sFjCYIFnqHPUTyIBuK94bg8T2PrbZ
         ig03V2egFSWZMXrzxzppg/DzVXFotzfFNMaCMSJMnG7nKd5BIy2tU0T2ZzvXaa3Jk1vF
         FOjA==
X-Gm-Message-State: AElRT7FMHHk9rgO4tNm1XbMZBM70+KA+edJWm0uVsY96vw4mym5teN05
        qlqwU892k8VwZwgbEcNUx5/+cQ==
X-Google-Smtp-Source: AG47ELuMiLSCc7a2oREVEHjcuOhAIvhA88G67hfEjJ/t7CBOE7IPA2ylcrHOW1aZGIcW8g9R1JaLVQ==
X-Received: by 10.55.33.144 with SMTP id f16mr31524248qki.158.1521660527630;
        Wed, 21 Mar 2018 12:28:47 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id h184sm3859601qkc.78.2018.03.21.12.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 12:28:46 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>, kernel@collabora.com,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH 04/14] mmc: jz4740: Use dev_get_platdata
Date:   Wed, 21 Mar 2018 16:27:31 -0300
Message-Id: <20180321192741.25872-5-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
References: <20180321192741.25872-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63127
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
