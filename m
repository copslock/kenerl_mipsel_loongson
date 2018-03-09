Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 16:14:39 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:33151
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994814AbeCIPN1AHzAw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 16:13:27 +0100
Received: by mail-qk0-x243.google.com with SMTP id f25so3999412qkm.0
        for <linux-mips@linux-mips.org>; Fri, 09 Mar 2018 07:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M6pjdZFB1H2jouXaDqN2xkfR9ciNjQnNkBj9x9wnOzk=;
        b=N0I6E31RaOaQ2Vrox35jl3R0h99HH5MtWtKqt6PjEpu8Z1PWalTIPBfnpFEON5aq9i
         Ov9gh8E+U/rNmLhkb/cpEj5S+AmfS85vJQdAADCxI3phS3qknTWAc9U6W7cCxDmViJw3
         hAMS91OeJ6wNWBEAX/W19D+cNm0WTS7FVZMs0OQ/o8nVB2Pj0lgH6qj8ddjx5rFPj4q9
         QjWeYonTp/fxNuj2dJ+eapzEFGpvpwJwmvmcKUGXrKrQrWkgjoZyADzQ3guHOviEqLol
         u82V8o9cbxAUx+uqeESecRa9Wc4r/NdaqvmtF8XDlp2We0HkYHAnbjQzLGHVRf8gKciF
         JaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M6pjdZFB1H2jouXaDqN2xkfR9ciNjQnNkBj9x9wnOzk=;
        b=YYZ1YG0WrzYQ1EZOGfUIp3807sV8jsJLyNOF7nfMRt9Qk5SWO02BdcJk9UxO8DdReE
         GNVDs+yhDWEeQ6D8TObycKoy8i4vVeSJlHg4hm7G65+cLfQJb2AbCV4aMQE1VWA4sNMw
         3mcfnj9kg1GnVFutq6beABD9RrXyHkQdBGBDoZS8iWT1+Pv1Yzehb8EwYfCsqUD712XJ
         1zWNSuDG2j6d600TYomY9Ee4mmwhKR/VV89SB6+uAsQD/5+2KnJkjrEad8gPlZOa2iV+
         RIRzsQaJK6JHaMKf72ldzumb42z5a0GH76m+0IQa0HnDOYkYRFI/YmSNQeTndVkALHm0
         LV2A==
X-Gm-Message-State: AElRT7Gofs3Qv53ZMFXd7VH3biyLC2IA2w9jOPQ/5RcoFsoQ7LievAVW
        ZYIfrtTinMBR7iv/OcvFXrq8zw==
X-Google-Smtp-Source: AG47ELs1fMATa18wv3lRe+7wvj9vCe3qNKGSMsk/KJ7PBHJRFqpQxfghwIBwhvy+/dXVHocSfxGNpw==
X-Received: by 10.55.132.67 with SMTP id g64mr309382qkd.28.1520608399720;
        Fri, 09 Mar 2018 07:13:19 -0800 (PST)
Received: from localhost.localdomain ([190.210.56.45])
        by smtp.gmail.com with ESMTPSA id d186sm682187qkf.37.2018.03.09.07.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Mar 2018 07:13:19 -0800 (PST)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 05/14] mmc: jz4740: Introduce devicetree probe
Date:   Fri,  9 Mar 2018 12:12:10 -0300
Message-Id: <20180309151219.18723-6-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
Return-Path: <ezequiel@vanguardiasur.com.ar>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62882
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

This commit introduces support to probe the device
via devicetree, which will be used to support other
SoCs such as the JZ4780.

Based on commits from the CI20 repo, by Paul Cercueil
and Alex Smith.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/mmc/host/jz4740_mmc.c | 51 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 0a8edd5b4052..c54861037481 100644
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
