Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Sep 2017 23:46:05 +0200 (CEST)
Received: from mail-lf0-x235.google.com ([IPv6:2a00:1450:4010:c07::235]:36379
        "EHLO mail-lf0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994066AbdIJVov6iVAu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Sep 2017 23:44:51 +0200
Received: by mail-lf0-x235.google.com with SMTP id m199so14415648lfe.3
        for <linux-mips@linux-mips.org>; Sun, 10 Sep 2017 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qamg7dzUxgSbxr03vx7pNM+c8xh7ROyHnpPPQZG2SdY=;
        b=K9wnJTVxh3aqlGk5rMXhFJ7HDpxxJjICrNJEnSzuZSl6Lkt3A0TZ532jflbhaUOyPj
         XZoF0GOJJZOLE3T028lJFYtpPDkOKGh+s1IaM1RiAGcw+6KJ9GuRc8h5xGmWt6rZr8wI
         oxUlXRBYh7k0EWhEdAkiaTPRGpTugN6PN/c6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qamg7dzUxgSbxr03vx7pNM+c8xh7ROyHnpPPQZG2SdY=;
        b=Frw+rqPFqnwwgrM8gSh9aQwU/TWyGC6rKnT8N2eYZzeaZnGfqVKfBTY3kxnEXdWRmx
         5DgXNCeiZTtRTC+W3tIE2evFBQDeVVkx9w1gwUvi8FbwOWGvHIkp6OhvNB2D3GeB03Ip
         Sa/9ljJW+vCiO8dY2IxLWEwmYmxGEpohJpxUfTzYTWRAqZai8J/Jb1pqQD3O8hHEWbma
         ueyaZJv7KPPiMsznwpVN8470NPV01i0wbGiGmTFCwxI1xLkMx0BX/8taff2/4cc686x+
         AjrVZpgfnV80n+myzK8Uq0mkUgFBCZJeOVC4q3nSn7HYNczmkuFjukj8VQF8RDy1omUe
         dR2g==
X-Gm-Message-State: AHPjjUgXBimTxV+Zx4wmOxC3cCSMr3BrfAuXl+2fTbQuRn67yq7VHHzT
        wHpJIUrN5ouAIa/a
X-Google-Smtp-Source: AOwi7QBsTEddbKcMVr9lo+LaMZfjoo6hYJNH57JHWlX93mwIvqoJWaPKSy/3QAxs6VZJOd6Hktb3/g==
X-Received: by 10.46.4.220 with SMTP id a89mr3530476ljf.40.1505079886476;
        Sun, 10 Sep 2017 14:44:46 -0700 (PDT)
Received: from fabina.bredbandsbolaget.se (c-2209e055.014-348-6c756e10.cust.bredbandsbolaget.se. [85.224.9.34])
        by smtp.gmail.com with ESMTPSA id c69sm1461546ljd.42.2017.09.10.14.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Sep 2017 14:44:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] i2c: gpio: Enforce open drain through gpiolib
Date:   Sun, 10 Sep 2017 23:44:22 +0200
Message-Id: <20170910214424.14945-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20170910214424.14945-1-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59980
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
 drivers/i2c/busses/i2c-gpio.c | 102 ++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 63 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 49e8b3ab30be..18ac4cf2ee75 100644
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
-		ret = PTR_ERR(priv->sda);
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
+		ret = PTR_ERR(priv->sda);
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
