Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2018 15:14:11 +0100 (CET)
Received: from mail-lf1-x144.google.com ([IPv6:2a00:1450:4864:20::144]:34881
        "EHLO mail-lf1-x144.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeKLOMxuIhz9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Nov 2018 15:12:53 +0100
Received: by mail-lf1-x144.google.com with SMTP id e26so4488168lfc.2
        for <linux-mips@linux-mips.org>; Mon, 12 Nov 2018 06:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xfe46Bmt0854EQhFRugeAp0o8UPMhV6L1Gu8vX/QvIg=;
        b=c9l3U/2dQOsUCgj8BbxfoO1yESceLkvc6v7qoWiFGZKRwjtsgfnrmk6jvclVFFuZSr
         Swr0+CzCXCHP2a1JnHgjuJuXS6MRUg2LTt1uE1Nwkgw1vNYkvby/x02nJx0Sbij/snjj
         0Ry+ITxsc7Uu12MB6uLPLpkGImMr0wvLzde1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xfe46Bmt0854EQhFRugeAp0o8UPMhV6L1Gu8vX/QvIg=;
        b=L1T6MoCoObbA21R566CcgK9wS3Z9LGOuBERqXatlhxdyP/5abu7YO9yEqPvf/rAv89
         bb6ZbPlGDF+QD5iiw8pLtsq7pdsscsEcq7d9IU4p6+A5Y9nDpWHxHnh7+9CAZP83vL4S
         wdwRumReLFM/jVQPFLxusTDAlYldgFH6J6BFa0aM5Cw3aVRU8vp91AYDktBOAd7+1vJH
         oNyWWh+HkemdrivybhvUoBKe8DYA/WipdOyKNZJt2ZsTvCW0xZ/HnPa5rR2C5GqdjWP8
         x6tCUCNZ7vs751UP/lEXJD+q7EulGqOetxR4PNnvwEh8SF3uJqW7BBCsh6io6TJ6X6IK
         szFA==
X-Gm-Message-State: AGRZ1gJjiiG0ZNZKuKuYC4qbbjE720M+v12ekGsRvYEneWMfNcw3W/KX
        B6JV4aRhSAZjvKlBUyTLeJYkrQ==
X-Google-Smtp-Source: AJdET5ccbDBIF7DsCuGTNKlVvYLfoaN+YgP9FEs5dQg5TD7AyA0YK+qKQ6vZy+iCMYmrLmwOzJR+Rw==
X-Received: by 2002:a19:d9d6:: with SMTP id s83mr741245lfi.57.1542031973074;
        Mon, 12 Nov 2018 06:12:53 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id m14-v6sm3056889lji.29.2018.11.12.06.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 06:12:52 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-mips@linux-mips.org
Subject: [PATCH 02/10] mmc: jz4740: Get CD/WP GPIOs from descriptors
Date:   Mon, 12 Nov 2018 15:12:31 +0100
Message-Id: <20181112141239.19646-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181112141239.19646-1-linus.walleij@linaro.org>
References: <20181112141239.19646-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67246
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

Modifty the JZ4740 driver to retrieve card detect and write
protect GPIO pins from GPIO descriptors instead of hard-coded
global numbers. Augment the only board file using this in the
process and cut down on passed in platform data.

Preserve the code setting the caps2 flags for CD and WP
as active low or high since the slot GPIO code currently
ignores the gpiolib polarity inversion semantice and uses
the raw accessors to read the GPIO lines, but set the right
polarity flags in the descriptor table for jz4740.

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../mips/include/asm/mach-jz4740/jz4740_mmc.h |  2 --
 arch/mips/jz4740/board-qi_lb60.c              | 12 ++++++++---
 drivers/mmc/host/jz4740_mmc.c                 | 20 +++++++++----------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
index e9cc62cfac99..ff50aeb1a933 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
@@ -4,8 +4,6 @@
 
 struct jz4740_mmc_platform_data {
 	int gpio_power;
-	int gpio_card_detect;
-	int gpio_read_only;
 	unsigned card_detect_active_low:1;
 	unsigned read_only_active_low:1;
 	unsigned power_active_low:1;
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index af0c8ace0141..705593d40d12 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -43,7 +43,6 @@
 #include "clock.h"
 
 /* GPIOs */
-#define QI_LB60_GPIO_SD_CD		JZ_GPIO_PORTD(0)
 #define QI_LB60_GPIO_SD_VCC_EN_N	JZ_GPIO_PORTD(2)
 
 #define QI_LB60_GPIO_KEYOUT(x)		(JZ_GPIO_PORTC(10) + (x))
@@ -386,12 +385,18 @@ static struct platform_device qi_lb60_gpio_keys = {
 };
 
 static struct jz4740_mmc_platform_data qi_lb60_mmc_pdata = {
-	.gpio_card_detect	= QI_LB60_GPIO_SD_CD,
-	.gpio_read_only		= -1,
 	.gpio_power		= QI_LB60_GPIO_SD_VCC_EN_N,
 	.power_active_low	= 1,
 };
 
+static struct gpiod_lookup_table qi_lb60_mmc_gpio_table = {
+	.dev_id = "jz4740-mmc.0",
+	.table = {
+		GPIO_LOOKUP("GPIOD", 0, "cd", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /* beeper */
 static struct pwm_lookup qi_lb60_pwm_lookup[] = {
 	PWM_LOOKUP("jz4740-pwm", 4, "pwm-beeper", NULL, 0,
@@ -500,6 +505,7 @@ static int __init qi_lb60_init_platform_devices(void)
 	gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
 	gpiod_add_lookup_table(&qi_lb60_nand_gpio_table);
 	gpiod_add_lookup_table(&qi_lb60_spigpio_gpio_table);
+	gpiod_add_lookup_table(&qi_lb60_mmc_gpio_table);
 
 	spi_register_board_info(qi_lb60_spi_board_info,
 				ARRAY_SIZE(qi_lb60_spi_board_info));
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 0c1efd5100b7..44ea452add8e 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -983,17 +983,17 @@ static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 	if (!pdata->read_only_active_low)
 		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
-	if (gpio_is_valid(pdata->gpio_card_detect)) {
-		ret = mmc_gpio_request_cd(mmc, pdata->gpio_card_detect, 0);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * Get optional card detect and write protect GPIOs,
+	 * only back out on probe deferral.
+	 */
+	ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0, NULL);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
-	if (gpio_is_valid(pdata->gpio_read_only)) {
-		ret = mmc_gpio_request_ro(mmc, pdata->gpio_read_only);
-		if (ret)
-			return ret;
-	}
+	ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0, NULL);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	return jz4740_mmc_request_gpio(&pdev->dev, pdata->gpio_power,
 			"MMC read only", true, pdata->power_active_low);
-- 
2.17.2
