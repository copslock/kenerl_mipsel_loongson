Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2017 11:42:14 +0200 (CEST)
Received: from mail-lf0-x232.google.com ([IPv6:2a00:1450:4010:c07::232]:54280
        "EHLO mail-lf0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993022AbdIQJkWYWuJP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2017 11:40:22 +0200
Received: by mail-lf0-x232.google.com with SMTP id k23so5571233lfi.11
        for <linux-mips@linux-mips.org>; Sun, 17 Sep 2017 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y1VLeRKXOxFcngVRxxUIqqi7JFtX1kvthA2oNKtATuI=;
        b=MSWejNoohC5PPHM0DMfoZpDvQmq0B3GA6vrjmZqDwCvAl7TqA1MH+6WZ45E/7Enqu6
         dHWwmoeIkVtQZTABUE1yfDHhRcL99JN5BctIAUYY9NhpeHYEOEhw6sUKMBf/yq3X9575
         Tboefojb6wMQkF3id0L3JYdyOaU72IWy81ZQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1VLeRKXOxFcngVRxxUIqqi7JFtX1kvthA2oNKtATuI=;
        b=EvXsYDHY6GLEAkaiGpVz1xuvoOjWS3NwEKD0oV1bqhSl1VuN/aPcuZTb5T37cum9kB
         wuP6F8OfSRqt4p/fEqYTIuV/V7+KhGNOtCfcS/LCZJX1xuZ5A8zpGpHr0OWrI+TDML17
         5yRY5VHznOgI53+ERShW2kVukvBCAl4xV9aT2Dh6f486LSAoUfBKLwe+bcxblOAGXWYk
         nDcbHpJfcIvhSSbusrVh9qVNUYTT274D5qXx7pY1wO8YtN1DMhkZ18Ys9NrSlwkMUzbC
         cwx0jMJbU5xnS+WS2eatlW0Pqe2qGXGnG9Q8rwoFEhxxkP1qGSNl7DeDs2hXKQy6ANOm
         NPQw==
X-Gm-Message-State: AHPjjUijW8yZ20yK7oxWwhn603aDHyY2aSo/ID7FySqtJKT00MGrq5Qn
        D6/bZbruBACVOB/t
X-Google-Smtp-Source: AOwi7QAmOLGzGESEjkytdRvn7bxaaTHsN1+LSWjF7+CDybZq/niGRNPrVjIxoUk3U/Uq/vJiRI2M/w==
X-Received: by 10.25.79.8 with SMTP id d8mr2202310lfb.118.1505641216590;
        Sun, 17 Sep 2017 02:40:16 -0700 (PDT)
Received: from fabina.bredbandsbolaget.se (c-2209e055.014-348-6c756e10.cust.bredbandsbolaget.se. [85.224.9.34])
        by smtp.gmail.com with ESMTPSA id t84sm974559lfi.21.2017.09.17.02.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Sep 2017 02:40:15 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 7/7] i2c: gpio: Add support for named gpios in DT
Date:   Sun, 17 Sep 2017 11:39:06 +0200
Message-Id: <20170917093906.16325-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60044
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

This adds support for using the "sda" and "scl" GPIOs in
device tree instead of anonymously using index 0 and 1 of
the "gpios" property.

We add a helper function to retrieve the GPIO descriptors
and some explicit error handling since the probe may have
to be deferred. At least this happened to me when moving
to using named "sda" and "scl" lines (all of a sudden this
started to probe before the GPIO driver) so we need to
gracefully defer probe when we ge -ENOENT in the error
pointer.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This is pretty much a rewrite of Geerts patch on top of
my own changes to support descriptors.
---
 drivers/i2c/busses/i2c-gpio.c | 59 +++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index beb5ce523684..2738b851f470 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -82,6 +82,42 @@ static void of_i2c_gpio_get_props(struct device_node *np,
 		of_property_read_bool(np, "i2c-gpio,scl-output-only");
 }
 
+static struct gpio_desc *i2c_gpio_get_desc(struct device *dev,
+					   const char *con_id,
+					   unsigned int index,
+					   enum gpiod_flags gflags)
+{
+	struct gpio_desc *retdesc;
+	int ret;
+
+	retdesc = devm_gpiod_get(dev, con_id, gflags);
+	if (!IS_ERR(retdesc)) {
+		dev_dbg(dev, "got GPIO from name %s\n", con_id);
+		return retdesc;
+	}
+
+	retdesc = devm_gpiod_get_index(dev, NULL, index, gflags);
+	if (!IS_ERR(retdesc)) {
+		dev_dbg(dev, "got GPIO from index %u\n", index);
+		return retdesc;
+	}
+
+	ret = PTR_ERR(retdesc);
+
+	/* FIXME: hack in the old code, is this really necessary? */
+	if (ret == -EINVAL)
+		retdesc = ERR_PTR(-EPROBE_DEFER);
+
+	/* This happens if the GPIO driver is not yet probed, let's defer */
+	if (ret == -ENOENT)
+		retdesc = ERR_PTR(-EPROBE_DEFER);
+
+	if (ret != -EPROBE_DEFER)
+		dev_err(dev, "error trying to get descriptor: %ld\n", ret);
+
+	return retdesc;
+}
+
 static int i2c_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_gpio_private_data *priv;
@@ -125,14 +161,10 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_HIGH;
 	else
 		gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
-	priv->sda = devm_gpiod_get_index(dev, NULL, 0, gflags);
-	if (IS_ERR(priv->sda)) {
-		ret = PTR_ERR(priv->sda);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
+	priv->sda = i2c_gpio_get_desc(dev, "sda", 0, gflags);
+	if (IS_ERR(priv->sda))
+		return PTR_ERR(priv->sda);
+
 	/*
 	 * If the SCL line is marked from platform data or device tree as
 	 * "open drain" it means something outside of our control is making
@@ -144,14 +176,9 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_LOW;
 	else
 		gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
-	priv->scl = devm_gpiod_get_index(dev, NULL, 1, gflags);
-	if (IS_ERR(priv->scl)) {
-		ret = PTR_ERR(priv->scl);
-		/* FIXME: hack in the old code, is this really necessary? */
-		if (ret == -EINVAL)
-			ret = -EPROBE_DEFER;
-		return ret;
-	}
+	priv->scl = i2c_gpio_get_desc(dev, "scl", 1, gflags);
+	if (IS_ERR(priv->scl))
+		return PTR_ERR(priv->scl);
 
 	bit_data->setsda = i2c_gpio_setsda_val;
 	bit_data->setscl = i2c_gpio_setscl_val;
-- 
2.13.5
