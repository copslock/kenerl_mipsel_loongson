Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2017 11:41:30 +0200 (CEST)
Received: from mail-lf0-x235.google.com ([IPv6:2a00:1450:4010:c07::235]:53291
        "EHLO mail-lf0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992994AbdIQJjgnTyzP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2017 11:39:36 +0200
Received: by mail-lf0-x235.google.com with SMTP id k9so5568843lfe.10
        for <linux-mips@linux-mips.org>; Sun, 17 Sep 2017 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k9Vob8DYJi4kyczGDuJoNvHeLrUQ0luZju+XmU3lJ2A=;
        b=ByXEK4sZwjERuOS4GecH6NQisOG0/0cMeE/ZCdR7k6clxbasEjLhfIKcim/JAQyfdb
         6k5Wpo04Raeb/I+Ab22NCi7ADGTX+mf2ZVGSl7TjKkQl5yYa5z6PYKtfci2yi/QLAMMb
         ISkV3PDbr6gTdDok6xH/rRUXbaKZkZ8G+echE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k9Vob8DYJi4kyczGDuJoNvHeLrUQ0luZju+XmU3lJ2A=;
        b=FwtleUeiWPhiHfp5S8q5ZAAzn2k+9DpCdrpdu8L1NBEkOGAM23mn5YnwUpkxVbrpDt
         Mj6WVtAjnLf1qyduIs8ekYkXUqFFHwGDTzpI2DvGhBSH6dlz4LLpDOjdrkiPwSDizLJC
         38p6iSuBH8GuPxtLl88cpvWGAJprsR+VDkd5LJZJYoACJxe+QWo5x1fMp1z56QrdZ8sB
         pWwWAL63B99k8wQ9K8nZzRCZPWcy+ENMjH/ERLJ5NGjKc4sVtt9L8CNjaJmtJ5fVM/90
         b1iq+0ad3r3ny4t7HLeLpVRAJ2VVzLZJY7IyqxT7B+jVirlRYbDKZQOXUKVQScl+Po3j
         LD/A==
X-Gm-Message-State: AHPjjUhf03rv1/6qQMHzQPU9rljNBplWTEzlIkBSvFj+nHXhY2tDTxyG
        6sl8yjfcMOEVXYzx
X-Google-Smtp-Source: AOwi7QAhujHlkyg3HrDPPY7p3HUgGExvhaf/62cPMT48V3sqO6jiQLq18cQ/RnAR4Uo7IKE1Mzctgg==
X-Received: by 10.25.181.26 with SMTP id e26mr2481381lff.91.1505641171276;
        Sun, 17 Sep 2017 02:39:31 -0700 (PDT)
Received: from fabina.bredbandsbolaget.se (c-2209e055.014-348-6c756e10.cust.bredbandsbolaget.se. [85.224.9.34])
        by smtp.gmail.com with ESMTPSA id t84sm974559lfi.21.2017.09.17.02.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Sep 2017 02:39:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/7] i2c: gpio: Local vars in probe
Date:   Sun, 17 Sep 2017 11:39:04 +0200
Message-Id: <20170917093906.16325-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20170917093906.16325-1-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60042
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
index 97b9c29e9429..beb5ce523684 100644
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
 		ret = PTR_ERR(priv->scl);
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
