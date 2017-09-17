Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2017 11:40:40 +0200 (CEST)
Received: from mail-lf0-x233.google.com ([IPv6:2a00:1450:4010:c07::233]:47007
        "EHLO mail-lf0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992899AbdIQJjcHXiEP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2017 11:39:32 +0200
Received: by mail-lf0-x233.google.com with SMTP id m199so5590654lfe.3
        for <linux-mips@linux-mips.org>; Sun, 17 Sep 2017 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sMEO26rO/HVCUOd9MrbeOMiq+/TQB6bwmfsePMgFblE=;
        b=SRGZkUh+jlmM1XcDRuKpPEAYVkJ+SmUKXMGlF9mXtDjVD+KI5JI3D8s7uWgDrahZTz
         paTo5ppD9lotyHZB0YR299RAMoSHrWc9v75d8nJZoFPypKMRS99g8GsDPqbZ+XlrYTfN
         lXixBBk3vfSEeSwNuv90/MnjIcYBFvm0xoFwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sMEO26rO/HVCUOd9MrbeOMiq+/TQB6bwmfsePMgFblE=;
        b=D7+eJCZxRt+PGyr4UyyfRrYwJWCAOcs9d5brUtO9D7HBho0sZB1zYhXAm4bdlMh03i
         WCLoW7094g/jdfGiY4I11RNxA7wX4hQGvmKfih6gMEoLPJs7jEpxld4cRUuM9CeV+sj3
         qfeUG0RXlNWyJSPUda6hTHdyi9vDZLCVgbmK9TqYrHuv/gHBuXRgwrchuhHBfPvTt5rR
         HFKTtiuW5KK6MtjjL5a113lJgayLIFEmos0v63ey4fBYDAiVvhJ71B1/KhVnS7oREfyT
         09QEijdQwzzj4GxR2riQcQ0lkw9fYc7RQLjjMmtFGtipoiJye2hLXYq8SduSJfgpoIHA
         NIeA==
X-Gm-Message-State: AHPjjUh3ux3Yz0JTYsCpHkdemDb3cIzi4z+fKrOF3x7vsp1lyh7IjrHe
        M6qWYTYgDuY0XgAQ
X-Google-Smtp-Source: AOwi7QBrPfO+kzp6ycm0cRuVHanAWqPQ/X0J1Kr/TXlL5xuEoNy6Yt6LzJRRUA0sUwp2c/fQTssX3A==
X-Received: by 10.46.80.17 with SMTP id e17mr4685246ljb.78.1505641166623;
        Sun, 17 Sep 2017 02:39:26 -0700 (PDT)
Received: from fabina.bredbandsbolaget.se (c-2209e055.014-348-6c756e10.cust.bredbandsbolaget.se. [85.224.9.34])
        by smtp.gmail.com with ESMTPSA id t84sm974559lfi.21.2017.09.17.02.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Sep 2017 02:39:25 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/7] i2c: gpio: Enforce open drain through gpiolib
Date:   Sun, 17 Sep 2017 11:39:02 +0200
Message-Id: <20170917093906.16325-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60040
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

The I2C GPIO bitbang driver currently emulates open drain
behaviour by implementing what the gpiolib already does:
not actively driving the line high, instead setting it to
input.

This makes no sense. Use the new facility in gpiolib to
request the lines enforced into open drain mode, and let
the open drain emulation already present in the gpiolib
kick in and handle this.

As a bonus: if the GPIO driver in the back-end actually
supports open drain in hardware using the .set_config()
callback, it will be utilized. That's correct: we never
used that hardware feature before, instead relying on
emulating open drain even if the GPIO controller could
actually handle this for us.

Users will sometimes get messages like this:
gpio-485 (?): enforced open drain please flag it properly
  in DT/ACPI DSDT/board file
gpio-486 (?): enforced open drain please flag it properly
  in DT/ACPI DSDT/board file
i2c-gpio gpio-i2c: using lines 485 (SDA) and 486 (SCL)

Which is completely proper: since the line is used as
open drain, it should actually be flagged properly with
e.g.

gpios = <&gpio0 5 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>,
        <&gpio0 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

Or similar facilities in board file descriptor tables
or ACPI DSDT.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix a minor typo in error path (copy-paste scl was sda)
---
 drivers/i2c/busses/i2c-gpio.c | 102 ++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 63 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index b4664037eded..97b9c29e9429 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -25,23 +25,6 @@ struct i2c_gpio_private_data {
 	struct i2c_gpio_platform_data pdata;
 };
 
-/* Toggle SDA by changing the direction of the pin */
-static void i2c_gpio_setsda_dir(void *data, int state)
-{
-	struct i2c_gpio_private_data *priv = data;
-
-	/*
-	 * This is a way of saying "do not drive
-	 * me actively high" which means emulating open drain.
-	 * The right way to do this is for gpiolib to
-	 * handle this, by the function below.
-	 */
-	if (state)
-		gpiod_direction_input(priv->sda);
-	else
-		gpiod_direction_output(priv->sda, 0);
-}
-
 /*
  * Toggle SDA by changing the output value of the pin. This is only
  * valid for pins configured as open drain (i.e. setting the value
@@ -54,17 +37,6 @@ static void i2c_gpio_setsda_val(void *data, int state)
 	gpiod_set_value(priv->sda, state);
 }
 
-/* Toggle SCL by changing the direction of the pin. */
-static void i2c_gpio_setscl_dir(void *data, int state)
-{
-	struct i2c_gpio_private_data *priv = data;
-
-	if (state)
-		gpiod_direction_input(priv->scl);
-	else
-		gpiod_direction_output(priv->scl, 0);
-}
-
 /*
  * Toggle SCL by changing the output value of the pin. This is used
  * for pins that are configured as open drain and for output-only
@@ -116,30 +88,13 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
 	struct i2c_adapter *adap;
+	enum gpiod_flags gflags;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	/* First get the GPIO pins; if it fails, we'll defer the probe. */
-	priv->sda = devm_gpiod_get_index(&pdev->dev, NULL, 0, GPIOD_OUT_HIGH);
-	if (IS_ERR(priv->sda)) {
-		ret = PTR_ERR(priv->sda);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
-	priv->scl = devm_gpiod_get_index(&pdev->dev, NULL, 1, GPIOD_OUT_LOW);
-	if (IS_ERR(priv->scl)) {
-		ret = PTR_ERR(priv->scl);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
-
 	adap = &priv->adap;
 	bit_data = &priv->bit_data;
 	pdata = &priv->pdata;
@@ -157,27 +112,48 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * FIXME: this is a hack emulating the open drain emulation
-	 * that gpiolib can already do for us. Make all clients properly
-	 * flag their lines as open drain and get rid of this property
-	 * and the special callback.
+	 * First get the GPIO pins; if it fails, we'll defer the probe.
+	 * If the SDA line is marked from platform data or device tree as
+	 * "open drain" it means something outside of our control is making
+	 * this line being handled as open drain, and we should just handle
+	 * it as any other output. Else we enforce open drain as this is
+	 * required for an I2C bus.
 	 */
-	if (pdata->sda_is_open_drain) {
-		gpiod_direction_output(priv->sda, 1);
-		bit_data->setsda = i2c_gpio_setsda_val;
-	} else {
-		gpiod_direction_input(priv->sda);
-		bit_data->setsda = i2c_gpio_setsda_dir;
+	if (pdata->sda_is_open_drain)
+		gflags = GPIOD_OUT_HIGH;
+	else
+		gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
+	priv->sda = devm_gpiod_get_index(&pdev->dev, NULL, 0, gflags);
+	if (IS_ERR(priv->sda)) {
+		ret = PTR_ERR(priv->sda);
+		/* FIXME: hack in the old code, is this really necessary? */
+		if (ret == -EINVAL)
+			ret = -EPROBE_DEFER;
+		return ret;
 	}
-
-	if (pdata->scl_is_open_drain || pdata->scl_is_output_only) {
-		gpiod_direction_output(priv->scl, 1);
-		bit_data->setscl = i2c_gpio_setscl_val;
-	} else {
-		gpiod_direction_input(priv->scl);
-		bit_data->setscl = i2c_gpio_setscl_dir;
+	/*
+	 * If the SCL line is marked from platform data or device tree as
+	 * "open drain" it means something outside of our control is making
+	 * this line being handled as open drain, and we should just handle
+	 * it as any other output. Else we enforce open drain as this is
+	 * required for an I2C bus.
+	 */
+	if (pdata->scl_is_open_drain)
+		gflags = GPIOD_OUT_LOW;
+	else
+		gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
+	priv->scl = devm_gpiod_get_index(&pdev->dev, NULL, 1, gflags);
+	if (IS_ERR(priv->scl)) {
+		ret = PTR_ERR(priv->scl);
+		/* FIXME: hack in the old code, is this really necessary? */
+		if (ret == -EINVAL)
+			ret = -EPROBE_DEFER;
+		return ret;
 	}
 
+	bit_data->setsda = i2c_gpio_setsda_val;
+	bit_data->setscl = i2c_gpio_setscl_val;
+
 	if (!pdata->scl_is_output_only)
 		bit_data->getscl = i2c_gpio_getscl;
 	bit_data->getsda = i2c_gpio_getsda;
-- 
2.13.5
