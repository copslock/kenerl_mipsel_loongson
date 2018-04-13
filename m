Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 12:24:51 +0200 (CEST)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:36014
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992105AbeDMKYeAA8V2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 12:24:34 +0200
Received: by mail-lf0-x244.google.com with SMTP id d20-v6so11871783lfe.3
        for <linux-mips@linux-mips.org>; Fri, 13 Apr 2018 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4xSDZrFhiVzNg6qzME55uTU6osxICtcjU5z/C/QSRg0=;
        b=KmS2YPrVmdYxxXdZCzp1Veul3qpngyf4jdcloqc7MvqhU4uLhM6MaP5b/5bypRUXM1
         /7VehM+3CN6osJfNil12Z8zpWU3C7sCIOtiTPucuFntVVnMXCDF7yiqyMte7b2yZ8XmC
         kvQhc+muA1f8TMfaiiUNFXMIiHRl3va/ADTRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4xSDZrFhiVzNg6qzME55uTU6osxICtcjU5z/C/QSRg0=;
        b=BP8NVztRfowk1KiDP+zgkSx/bT/vfNTnaxNgW9sCkah3fvPJKO3w7vteMcnNYgJkv/
         5l7IGvl6HleluF4BCLD/eW7CRRdN9hqHP6u0nDXmw0uM9/hYTFvyi5M7HUBksyOqbJrp
         9+uFbvHdWAAgAvXrZrcjwiSewm6DwaJ8YZeXZTTkK0Rg0IySbNtVTHMYfNWs+nZJ0dYY
         kWIwRbNu+sWkazkMSb1ptPNoR9HxQ6ECbPSqklKzJJ7me95lsGEMQ/EEqkjRnq+1InWk
         80pRIUprWQ7IujYsjLYIzvGfyMeKc4QxjTcLQowz8pXfro2+5uwmypJIJ7DTDm6drcN9
         b3oQ==
X-Gm-Message-State: ALQs6tCKsWqJbzhZL4szB8yjvePX2nXPX5Y3sy9sHW00YscgzLBekknH
        YXaYzAgV98YcKZBYksXcpoTvzQ==
X-Google-Smtp-Source: AIpwx4+0OllI8gihGgxYaUOCr3MiCvwJuI8UZgzR4oRcycIQDQ6Ny5UXsscdiTiNYH7sN2kOFAz3SQ==
X-Received: by 2002:a19:d085:: with SMTP id h127-v6mr7634531lfg.29.1523615068602;
        Fri, 13 Apr 2018 03:24:28 -0700 (PDT)
Received: from genomnajs.payandsurf.com ([192.36.80.8])
        by smtp.gmail.com with ESMTPSA id c4sm915360lja.97.2018.04.13.03.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 03:24:27 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: [PATCH 2/3] gpio: loongson: Create a dynamic platform device
Date:   Fri, 13 Apr 2018 12:24:20 +0200
Message-Id: <20180413102421.23939-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413102421.23939-1-linus.walleij@linaro.org>
References: <20180413102421.23939-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63521
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

It is pretty helpful to create some kind of device for backing the
GPIO chips, especially when preparing the driver for using
GENERIC_GPIO, so let's create a simple platform device and a simple
platform device driver and create the gpiochip in the .probe() routine
for the device driver. Keep all at the core initcall so the behaviour
is the same as before.

Cc: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-loongson.c | 47 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-loongson.c b/drivers/gpio/gpio-loongson.c
index 973d82a29442..3c9d4f3ed550 100644
--- a/drivers/gpio/gpio-loongson.c
+++ b/drivers/gpio/gpio-loongson.c
@@ -18,6 +18,7 @@
 #include <linux/spinlock.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
 #include <asm/types.h>
 #include <loongson.h>
 
@@ -97,19 +98,45 @@ static int loongson_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static struct gpio_chip loongson_chip = {
-	.label                  = "Loongson-gpio-chip",
-	.direction_input        = loongson_gpio_direction_input,
-	.get                    = loongson_gpio_get_value,
-	.direction_output       = loongson_gpio_direction_output,
-	.set                    = loongson_gpio_set_value,
-	.base			= 0,
-	.ngpio                  = LOONGSON_N_GPIO,
-	.can_sleep		= false,
+static int loongson_gpio_probe(struct platform_device *pdev)
+{
+	struct gpio_chip *gc;
+	struct device *dev = &pdev->dev;
+
+	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
+	if (!gc)
+		return -ENOMEM;
+
+	gc->label = "loongson-gpio-chip";
+	gc->base = 0;
+	gc->ngpio = LOONGSON_N_GPIO;
+	gc->get = loongson_gpio_get_value;
+	gc->set = loongson_gpio_set_value;
+	gc->direction_input = loongson_gpio_direction_input;
+	gc->direction_output = loongson_gpio_direction_output;
+
+	return gpiochip_add_data(gc, NULL);
+}
+
+static struct platform_driver loongson_gpio_driver = {
+	.driver = {
+		.name = "loongson-gpio",
+	},
+	.probe = loongson_gpio_probe,
 };
 
 static int __init loongson_gpio_setup(void)
 {
-	return gpiochip_add_data(&loongson_chip, NULL);
+	struct platform_device *pdev;
+	int ret;
+
+	ret = platform_driver_register(&loongson_gpio_driver);
+	if (ret) {
+		pr_err("error registering loongson GPIO driver\n");
+		return ret;
+	}
+
+	pdev = platform_device_register_simple("loongson-gpio", -1, NULL, 0);
+	return PTR_ERR_OR_ZERO(pdev);
 }
 postcore_initcall(loongson_gpio_setup);
-- 
2.14.3
