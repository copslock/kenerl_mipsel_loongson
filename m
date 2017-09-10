Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Sep 2017 23:46:55 +0200 (CEST)
Received: from mail-lf0-x233.google.com ([IPv6:2a00:1450:4010:c07::233]:33803
        "EHLO mail-lf0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992933AbdIJVo4W0vlu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Sep 2017 23:44:56 +0200
Received: by mail-lf0-x233.google.com with SMTP id l196so14429944lfl.1
        for <linux-mips@linux-mips.org>; Sun, 10 Sep 2017 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=erzgjhU0ezSIivaubwnwB+XCJNNifZqiUpJZ7kylSg0=;
        b=CbcTVlfm6t23WEwprTHtw710tIDAdxGwWka0o+xOgBycTzqXNZKDNR5fbiA3oHkE2G
         2lebTDU8LviJoEVLCafNaOFpcUGMEKmmvD9AXbjh8ULStwz7WlBx+YRW37ziK1WafTgo
         zuCFJgUV1oPd89LhIqPQDZUX3BbJy1K5kSOOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=erzgjhU0ezSIivaubwnwB+XCJNNifZqiUpJZ7kylSg0=;
        b=lIliR0qZngyw14Yf+IHQZgwcWi+doYaogiMcFJEkJfxXOs686QnsIwUcuh78RJm4F2
         X8GKQ19JTF47O+fAhfK9kNo1Q4VywYwUinXDvbNIlynlQfi7zMg7XUtBbhSACZdN+Rzv
         N05al146rIYlpJmyGo0VlfddzsEtiCrBYJzHE9S/ghHUsakELH4rn/BkUCJcmZuObqiK
         N8uG5SJyhh4aT2ES66V1IvMQ0TAnrmJhQBfiQm0cHV+kxpuklAlO03vmEBEQ8htZ5nfJ
         TaAqZWJjHTTMf6YZ5FnZe0Wjj7n4slU1cyq1bl4mYlFI2QLZrVay4nzcqHTDaHe2igXe
         MFbg==
X-Gm-Message-State: AHPjjUiumuH7Ck8AqWGK/+dgJdzqdD8Ro/RCFsr/KBKzGX4MiTkt52zV
        8RI3HzcoyTQLsvwZ
X-Google-Smtp-Source: ADKCNb773bhIteqT6T7lwK2r6V3lBceeQP/MPy84KM/y3ABleZhZdlj59GSA5uxCX1qJ3spg9lGxKg==
X-Received: by 10.46.6.18 with SMTP id 18mr3081395ljg.117.1505079890970;
        Sun, 10 Sep 2017 14:44:50 -0700 (PDT)
Received: from fabina.bredbandsbolaget.se (c-2209e055.014-348-6c756e10.cust.bredbandsbolaget.se. [85.224.9.34])
        by smtp.gmail.com with ESMTPSA id c69sm1461546ljd.42.2017.09.10.14.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Sep 2017 14:44:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5] i2c: gpio: Local vars in probe
Date:   Sun, 10 Sep 2017 23:44:24 +0200
Message-Id: <20170910214424.14945-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20170910214424.14945-1-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59982
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

By creating local variables for *dev and *np, the code become
much easier to read, in my opinion.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I put this at the end of the series because compared to the
rest of the patches it is completely unimportant.
---
 drivers/i2c/busses/i2c-gpio.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 18ac4cf2ee75..7fe599f4fdb0 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -88,10 +88,12 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	struct i2c_gpio_platform_data *pdata;
 	struct i2c_algo_bit_data *bit_data;
 	struct i2c_adapter *adap;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	enum gpiod_flags gflags;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -99,15 +101,15 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	bit_data = &priv->bit_data;
 	pdata = &priv->pdata;
 
-	if (pdev->dev.of_node) {
-		of_i2c_gpio_get_props(pdev->dev.of_node, pdata);
+	if (np) {
+		of_i2c_gpio_get_props(np, pdata);
 	} else {
 		/*
 		 * If all platform data settings are zero it is OK
 		 * to not provide any platform data from the board.
 		 */
-		if (dev_get_platdata(&pdev->dev))
-			memcpy(pdata, dev_get_platdata(&pdev->dev),
+		if (dev_get_platdata(dev))
+			memcpy(pdata, dev_get_platdata(dev),
 			       sizeof(*pdata));
 	}
 
@@ -123,7 +125,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_HIGH;
 	else
 		gflags = GPIOD_OUT_HIGH_OPEN_DRAIN;
-	priv->sda = devm_gpiod_get_index(&pdev->dev, NULL, 0, gflags);
+	priv->sda = devm_gpiod_get_index(dev, NULL, 0, gflags);
 	if (IS_ERR(priv->sda)) {
 		ret = PTR_ERR(priv->sda);
 		/* FIXME: hack in the old code, is this really necessary? */
@@ -142,7 +144,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		gflags = GPIOD_OUT_LOW;
 	else
 		gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
-	priv->scl = devm_gpiod_get_index(&pdev->dev, NULL, 1, gflags);
+	priv->scl = devm_gpiod_get_index(dev, NULL, 1, gflags);
 	if (IS_ERR(priv->scl)) {
 		ret = PTR_ERR(priv->sda);
 		/* FIXME: hack in the old code, is this really necessary? */
@@ -173,15 +175,15 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	bit_data->data = priv;
 
 	adap->owner = THIS_MODULE;
-	if (pdev->dev.of_node)
-		strlcpy(adap->name, dev_name(&pdev->dev), sizeof(adap->name));
+	if (np)
+		strlcpy(adap->name, dev_name(dev), sizeof(adap->name));
 	else
 		snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
 
 	adap->algo_data = bit_data;
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
-	adap->dev.parent = &pdev->dev;
-	adap->dev.of_node = pdev->dev.of_node;
+	adap->dev.parent = dev;
+	adap->dev.of_node = np;
 
 	adap->nr = pdev->id;
 	ret = i2c_bit_add_numbered_bus(adap);
@@ -195,7 +197,7 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 	 * get accessors to get the actual name of the GPIO line,
 	 * from the descriptor, then provide that instead.
 	 */
-	dev_info(&pdev->dev, "using lines %u (SDA) and %u (SCL%s)\n",
+	dev_info(dev, "using lines %u (SDA) and %u (SCL%s)\n",
 		 desc_to_gpio(priv->sda), desc_to_gpio(priv->scl),
 		 pdata->scl_is_output_only
 		 ? ", no clock stretching" : "");
-- 
2.13.5
