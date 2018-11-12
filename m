Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2018 15:13:03 +0100 (CET)
Received: from mail-lf1-x141.google.com ([IPv6:2a00:1450:4864:20::141]:45454
        "EHLO mail-lf1-x141.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbeKLOMzgmaF9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2018 15:12:55 +0100
Received: by mail-lf1-x141.google.com with SMTP id b20so6248380lfa.12
        for <linux-mips@linux-mips.org>; Mon, 12 Nov 2018 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uyjO+El3MvuzjjZ225bk+ZX6NPv73zT4TF8rtrL6ozw=;
        b=E7ULJOoS9VqJCsh8FXBvOvv6E7+kbFqeTbqHByoKAkGkqrJizrPlqkBTn34JG6j2e/
         fa98zG0kg6oxLmOP9wEa5LOoX24nz++pnDqAQaRIKKi6WzHqgy17qGYPvf9tvUIPqUbC
         BhFVf1QZv51XGD5UR17Nvz00qyQKWQQ5iUZKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uyjO+El3MvuzjjZ225bk+ZX6NPv73zT4TF8rtrL6ozw=;
        b=fJ/Yp/p4x0HrFr2pfPYE0yjkwvsjcfCJ565zpTyivb3MK2Qgev5jWvb7bG6yVXAE2W
         it6Zs9GFzusmsyObDj7HP/xsppJp72FNgN4AWMVPoMM+qzYM62KfrbOU6YrvAiAt/MF/
         4Z3UeiShC1BCs4OkfwO82GZ67O2IyTo4aBO0Mo6/W4ECZ4QeVK12GgBHtbLG+V4ZymGF
         h9VTeJrsUBT8COlyEFDiTejHUcpy/WZt9k14K+nx1QL82dSNCsSkxfRd9YnKhikhIjOh
         I08aZklHX3/2aoopr5v5JCtN2lD7uV3AwQUzDeK5++iCOVHu49LBY2hAV7OeF1uJ6p/x
         dEpg==
X-Gm-Message-State: AGRZ1gKjAsfKXcR3zWyURXoswQHg5D6kPmCvVXtKK3jY4a566/6dE1gQ
        fFGTOXlXlxwO/nHyXXSwGH9tpg==
X-Google-Smtp-Source: AJdET5eFws6yQhT7zSDcAZYL3vLKYRQzBQUl0cy8RbfwiJtfCP97kdMGymA0e02x+0uiw/ouiaqJZA==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr687899lff.141.1542031975042;
        Mon, 12 Nov 2018 06:12:55 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id m14-v6sm3056889lji.29.2018.11.12.06.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 06:12:54 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-mips@linux-mips.org
Subject: [PATCH 03/10] mmc: jz4740: Use GPIO descriptor for power
Date:   Mon, 12 Nov 2018 15:12:32 +0100
Message-Id: <20181112141239.19646-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181112141239.19646-1-linus.walleij@linaro.org>
References: <20181112141239.19646-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

The power GPIO line is passed with inversion flags and all from
the platform data. Switch to using an optional GPIO descriptor and
use this to switch the power.

Augment the only boardfile to pass in the proper "power" descriptor
in the GPIO descriptor machine table instead.

As the GPIO handling is now much simpler, we can cut down on some
overhead code.

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../mips/include/asm/mach-jz4740/jz4740_mmc.h |  2 -
 arch/mips/jz4740/board-qi_lb60.c              |  6 +-
 drivers/mmc/host/jz4740_mmc.c                 | 65 +++++--------------
 3 files changed, 18 insertions(+), 55 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
index ff50aeb1a933..9a7de47c7c79 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
@@ -3,10 +3,8 @@
 #define __LINUX_MMC_JZ4740_MMC
 
 struct jz4740_mmc_platform_data {
-	int gpio_power;
 	unsigned card_detect_active_low:1;
 	unsigned read_only_active_low:1;
-	unsigned power_active_low:1;
 
 	unsigned data_1bit:1;
 };
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 705593d40d12..6718efb400f4 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -43,8 +43,6 @@
 #include "clock.h"
 
 /* GPIOs */
-#define QI_LB60_GPIO_SD_VCC_EN_N	JZ_GPIO_PORTD(2)
-
 #define QI_LB60_GPIO_KEYOUT(x)		(JZ_GPIO_PORTC(10) + (x))
 #define QI_LB60_GPIO_KEYIN(x)		(JZ_GPIO_PORTD(18) + (x))
 #define QI_LB60_GPIO_KEYIN8		JZ_GPIO_PORTD(26)
@@ -385,14 +383,14 @@ static struct platform_device qi_lb60_gpio_keys = {
 };
 
 static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
-	.gpio_power		= QI_LB60_GPIO_SD_VCC_EN_N,
-	.power_active_low	= 1,
+	/* Intentionally left blank */
 };
 
 static struct gpiod_lookup_table qi_lb60_mmc_gpio_table = {
 	.dev_id = "jz4740-mmc.0",
 	.table = {
 		GPIO_LOOKUP("GPIOD", 0, "cd", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOD", 2, "power", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 44ea452add8e..6f7a99e54af0 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -21,7 +21,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -136,6 +136,7 @@ struct jz4740_mmc_host {
 	struct platform_device *pdev;
 	struct jz4740_mmc_platform_data *pdata;
 	struct clk *clk;
+	struct gpio_desc *power;
 
 	enum jz4740_mmc_version version;
 
@@ -903,18 +904,16 @@ static void jz4740_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 		jz4740_mmc_reset(host);
-		if (host->pdata && gpio_is_valid(host->pdata->gpio_power))
-			gpio_set_value(host->pdata->gpio_power,
-					!host->pdata->power_active_low);
+		if (host->power)
+			gpiod_set_value(host->power, 1);
 		host->cmdat |= JZ_MMC_CMDAT_INIT;
 		clk_prepare_enable(host->clk);
 		break;
 	case MMC_POWER_ON:
 		break;
 	default:
-		if (host->pdata && gpio_is_valid(host->pdata->gpio_power))
-			gpio_set_value(host->pdata->gpio_power,
-					host->pdata->power_active_low);
+		if (host->power)
+			gpiod_set_value(host->power, 0);
 		clk_disable_unprepare(host->clk);
 		break;
 	}
@@ -947,30 +946,9 @@ static const struct mmc_host_ops jz4740_mmc_ops = {
 	.enable_sdio_irq = jz4740_mmc_enable_sdio_irq,
 };
 
-static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
-	const char *name, bool output, int value)
-{
-	int ret;
-
-	if (!gpio_is_valid(gpio))
-		return 0;
-
-	ret = gpio_request(gpio, name);
-	if (ret) {
-		dev_err(dev, "Failed to request %s gpio: %d\n", name, ret);
-		return ret;
-	}
-
-	if (output)
-		gpio_direction_output(gpio, value);
-	else
-		gpio_direction_input(gpio);
-
-	return 0;
-}
-
-static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
-	struct platform_device *pdev)
+static int jz4740_mmc_request_gpios(struct jz4740_mmc_host *host,
+				    struct mmc_host *mmc,
+				    struct platform_device *pdev)
 {
 	struct jz4740_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int ret = 0;
@@ -995,19 +973,12 @@ static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
-	return jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_power,
-			"MMC read only", true, pdata->power_active_low);
-}
-
-static void jz4740_mmc_free_gpios(struct platform_device *pdev)
-{
-	struct jz4740_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
-
-	if (!pdata)
-		return;
+	host->power = devm_gpiod_get_optional(&pdev->dev, "power",
+					      GPIOD_OUT_HIGH);
+	if (IS_ERR(host->power))
+		return PTR_ERR(host->power);
 
-	if (gpio_is_valid(pdata->gpio_power))
-		gpio_free(pdata->gpio_power);
+	return 0;
 }
 
 static const struct of_device_id jz4740_mmc_of_match[] = {
@@ -1053,7 +1024,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		mmc->caps |= MMC_CAP_SDIO_IRQ;
 		if (!(pdata && pdata->data_1bit))
 			mmc->caps |= MMC_CAP_4_BIT_DATA;
-		ret = jz4740_mmc_request_gpios(mmc, pdev);
+		ret = jz4740_mmc_request_gpios(host, mmc, pdev);
 		if (ret)
 			goto err_free_host;
 	}
@@ -1104,7 +1075,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 			dev_name(&pdev->dev), host);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
-		goto err_free_gpios;
+		goto err_free_host;
 	}
 
 	jz4740_mmc_clock_disable(host);
@@ -1135,8 +1106,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 		jz4740_mmc_release_dma_channels(host);
 err_free_irq:
 	free_irq(host->irq, host);
-err_free_gpios:
-	jz4740_mmc_free_gpios(pdev);
 err_free_host:
 	mmc_free_host(mmc);
 
@@ -1155,8 +1124,6 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 
 	free_irq(host->irq, host);
 
-	jz4740_mmc_free_gpios(pdev);
-
 	if (host->use_dma)
 		jz4740_mmc_release_dma_channels(host);
 
-- 
2.17.2
