Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 23:01:01 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:35844
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbeCLV7bJcj-f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2018 22:59:31 +0100
Received: by mail-qk0-x243.google.com with SMTP id d206so13243929qkb.3
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iwHKDDFJ/QYfLeSBVgZ0kWOqtItUVEogr8yyjukUykQ=;
        b=cf8B24vW4LAla8azZUNxwGuQi4CY1TIQZay/2FAavK4eIYI4QZw7MqA3IeZKh8q72M
         hI9/vtZukMtd/2GrkURuWx41lxPK40bCPJHFtBsz5fdm/L605rv6Kj2Q282Fxq5ifKW0
         VTJ8i7qARsx7j55I/gOyllrNsmc9N3UdSzwitFI6IHDB8nXnvO9yyA3yPiA6F8L4MW+G
         ZCYJKsiiZjdqoRrmqGuW/ntyuN0JmjUhSyUIgQpNczmw0KSbIH6hHhZuV3jgC6enwRTi
         zPfhRJPy8SiQJ+r/vr3FtZer3Z/eHhxCBwZlBBMixs/RCafr+PvWAZWMZ3kC+jRgeg39
         aNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iwHKDDFJ/QYfLeSBVgZ0kWOqtItUVEogr8yyjukUykQ=;
        b=CpEAthCbD+2u1Bcs8Si1syZ9TchzaFx9UtWGxP1vzs0aZBKux4Wi3tE46NreQdW7ct
         lnBW9tLc4XCVdHVJwTKg+Nis0nXZ4SYlpNDXuwaM7taY3zMcgCsMeag5nAMOqw8tvU9R
         3RUngAZDXlJ51Awx44RXpZCS0J8iu01iCEmx/2UXRgsTkaGHlVW3Y5XcZ/Z9ZfmIfNH8
         XQgsCap2Si2JSCAKKtVwKnFTUHiJkmK1iGpiZcSyuqGtbMuPsFH3+/ZZlf75DLDeHy3C
         XpSEaxu+P66B4M346rzOBxOwHNkyJD+b/TnbnfApYOmwadX0DLCVmJpVEwRTdCcff7o6
         3TVw==
X-Gm-Message-State: AElRT7HnCUSDZFyNaFx0MA0Ws0tfcmezpXCflFpCUwbOLSsd7Hiuhkv8
        RQ9k5Tjwaoc5fcZJiRxKrizK6w==
X-Google-Smtp-Source: AG47ELtTPUd9SJFxnMh7Y+FnjzYnpffi2z4ev6Xe80axPKuUulny4Tiuf71/G8VxI9dFhYvST3j5bA==
X-Received: by 10.55.95.133 with SMTP id t127mr13390791qkb.273.1520891965309;
        Mon, 12 Mar 2018 14:59:25 -0700 (PDT)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id c5sm2756961qkf.93.2018.03.12.14.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 14:59:24 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Subject: [PATCH v2 06/14] mmc: jz4740: Introduce devicetree probe
Date:   Mon, 12 Mar 2018 18:55:46 -0300
Message-Id: <20180312215554.20770-7-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
References: <20180312215554.20770-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62937
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

Add support to probe the device via devicetree, which
will be used to support other SoCs such as the JZ4780.

Based on commits from the CI20 repo, by Paul Cercueil
and Alex Smith. Binding document based on work by
Zubair Lutfullah Kakakhel.

Tested-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 drivers/mmc/host/jz4740_mmc.c | 51 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 9f316d953b30..03757cc55f52 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -26,6 +26,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
@@ -107,6 +108,10 @@
 
 #define JZ_MMC_CLK_RATE 24000000
 
+enum jz4740_mmc_version {
+	JZ_MMC_JZ4740,
+};
+
 enum jz4740_mmc_state {
 	JZ4740_MMC_STATE_READ_RESPONSE,
 	JZ4740_MMC_STATE_TRANSFER_DATA,
@@ -125,6 +130,8 @@ struct jz4740_mmc_host {
 	struct jz4740_mmc_platform_data *pdata;
 	struct clk *clk;
 
+	enum jz4740_mmc_version version;
+
 	int irq;
 	int card_detect_irq;
 
@@ -857,7 +864,7 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		jz4740_mmc_reset(host);
-		if (gpio_is_valid(host->pdata->gpio_power))
+		if (host->pdata && gpio_is_valid(host->pdata->gpio_power))
 			gpio_set_value(host->pdata->gpio_power,
 					!host->pdata->power_active_low);
 		host->cmdat |= JZ_MMC_CMDAT_INIT;
@@ -866,7 +873,7 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_ON:
 		break;
 	default:
-		if (gpio_is_valid(host->pdata->gpio_power))
+		if (host->pdata && gpio_is_valid(host->pdata->gpio_power))
 			gpio_set_value(host->pdata->gpio_power,
 					host->pdata->power_active_low);
 		clk_disable_unprepare(host->clk);
@@ -964,11 +971,18 @@ static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 		gpio_free(pdata->gpio_power);
 }
 
+static const struct of_device_id jz4740_mmc_of_match[] = {
+	{ .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4740_mmc_of_match);
+
 static int jz4740_mmc_probe(struct platform_device* pdev)
 {
 	int ret;
 	struct mmc_host *mmc;
 	struct jz4740_mmc_host *host;
+	const struct of_device_id *match;
 	struct jz4740_mmc_platform_data *pdata;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -982,6 +996,27 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	host = mmc_priv(mmc);
 	host->pdata = pdata;
 
+	match = of_match_device(jz4740_mmc_of_match, &pdev->dev);
+	if (match) {
+		host->version = (enum jz4740_mmc_version)match->data;
+		ret = mmc_of_parse(mmc);
+		if (ret) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(&pdev->dev,
+					"could not parse of data: %d\n", ret);
+			goto err_free_host;
+		}
+	} else {
+		/* JZ4740 should be the only one using legacy probe */
+		host->version = JZ_MMC_JZ4740;
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
+		if (!(pdata && pdata->data_1bit))
+			mmc->caps |= MMC_CAP_4_BIT_DATA;
+		ret = jz4740_mmc_request_gpios(mmc, pdev);
+		if (ret)
+			goto err_free_host;
+	}
+
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = host->irq;
@@ -1004,16 +1039,11 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		goto err_free_host;
 	}
 
-	ret = jz4740_mmc_request_gpios(mmc, pdev);
-	if (ret)
-		goto err_free_host;
-
 	mmc->ops = &jz4740_mmc_ops;
-	mmc->f_min = JZ_MMC_CLK_RATE / 128;
-	mmc->f_max = JZ_MMC_CLK_RATE;
+	if (!mmc->f_max)
+		mmc->f_max = JZ_MMC_CLK_RATE;
+	mmc->f_min = mmc->f_max / 128;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-	mmc->caps = (pdata && pdata->data_1bit) ? 0 : MMC_CAP_4_BIT_DATA;
-	mmc->caps |= MMC_CAP_SDIO_IRQ;
 
 	mmc->max_blk_size = (1 << 10) - 1;
 	mmc->max_blk_count = (1 << 15) - 1;
@@ -1118,6 +1148,7 @@ static struct platform_driver jz4740_mmc_driver = {
 	.remove = jz4740_mmc_remove,
 	.driver = {
 		.name = "jz4740-mmc",
+		.of_match_table = of_match_ptr(jz4740_mmc_of_match),
 		.pm = JZ4740_MMC_PM_OPS,
 	},
 };
-- 
2.16.2
