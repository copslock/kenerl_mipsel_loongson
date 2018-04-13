Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 12:24:38 +0200 (CEST)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:41818
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991702AbeDMKYbrWNQl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 12:24:31 +0200
Received: by mail-lf0-x241.google.com with SMTP id o102-v6so11845674lfg.8
        for <linux-mips@linux-mips.org>; Fri, 13 Apr 2018 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sI4KHeJmJJitIJprqm3skr6oFmAjI0sQMaj0NB/vNz4=;
        b=XL0JSUsL5p4eHi4ygivCZ+H3RnSRKVIzR1pnWlhXUpT1GQ32tGYo5suiZY8RLRQGPe
         go5/dDza7D5ulXf49lENNBTOoZLS6aI2ScbjYp01/K7scrsH9Bvo3tfTo+CGYinpdWUd
         238axNdzMy1DSJTudCUfa5oJN63Xy2BUhNAOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sI4KHeJmJJitIJprqm3skr6oFmAjI0sQMaj0NB/vNz4=;
        b=dVSyGX5Dj11aj9hKegMSS83GwBGiMnyT8go2o9XISt9AjTvJjW7vGH9RaQHY1tDyic
         l7aFAso+RHBFnqf+88ikcWZsCi4uxZvIfJmNUQrhzUYDwx+XANZLRBbLmQdo6Z2H8wLt
         RZeNLUe+GWrt/rrasIDabQYFN7w0Dn2SU+rW+XspR4zBTkN5jOWEniMdCZorfdSl4/A6
         J325cngLiTSAkoaMoUJ0POfgU3pH6WTkXQx3JPbZXBN0r+KJsutTnnGyKIoY/6XvuY5m
         EQO3GOV77YjNxbtAbnhj1/yoUGXZzMGknKF6ujKamTSIHFI+FMTTEmEoTP1Byzhpi8Yq
         T6eQ==
X-Gm-Message-State: ALQs6tA/thz11XYWlbXKDrdVCq8gFlNEkwGaTojAn8hJ+LJgfz7q9oQS
        mmNAE9+LK5gl3U5uwiN6fx9liA==
X-Google-Smtp-Source: AIpwx49EafV2fO+PQtFnQgSQaZcgL0XvLrGmJz6Z3DWiFUpMb36ftFYRgIWe4nRxUswnqkLnZa70iw==
X-Received: by 2002:a19:1754:: with SMTP id n81-v6mr6912435lfi.113.1523615066125;
        Fri, 13 Apr 2018 03:24:26 -0700 (PDT)
Received: from genomnajs.payandsurf.com ([192.36.80.8])
        by smtp.gmail.com with ESMTPSA id c4sm915360lja.97.2018.04.13.03.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 03:24:25 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: [PATCH 1/3] gpio: loongson: Use right include
Date:   Fri, 13 Apr 2018 12:24:19 +0200
Message-Id: <20180413102421.23939-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63520
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

The driver includes <linux/gpio.h> which is wrong, rely on
<linux/gpio/driver.h> and remove to call to gpio_set_value() in
favor of calling the internal function. Move functions around to
avoid forward declarations.

Cc: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-loongson.c | 66 ++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpio-loongson.c b/drivers/gpio/gpio-loongson.c
index 92c4fe7b2677..973d82a29442 100644
--- a/drivers/gpio/gpio-loongson.c
+++ b/drivers/gpio/gpio-loongson.c
@@ -17,9 +17,9 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <asm/types.h>
 #include <loongson.h>
-#include <linux/gpio.h>
 
 #define STLS2F_N_GPIO		4
 #define STLS3A_N_GPIO		16
@@ -34,38 +34,6 @@
 
 static DEFINE_SPINLOCK(gpio_lock);
 
-static int loongson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
-{
-	u32 temp;
-	u32 mask;
-
-	spin_lock(&gpio_lock);
-	mask = 1 << gpio;
-	temp = LOONGSON_GPIOIE;
-	temp |= mask;
-	LOONGSON_GPIOIE = temp;
-	spin_unlock(&gpio_lock);
-
-	return 0;
-}
-
-static int loongson_gpio_direction_output(struct gpio_chip *chip,
-		unsigned gpio, int level)
-{
-	u32 temp;
-	u32 mask;
-
-	gpio_set_value(gpio, level);
-	spin_lock(&gpio_lock);
-	mask = 1 << gpio;
-	temp = LOONGSON_GPIOIE;
-	temp &= (~mask);
-	LOONGSON_GPIOIE = temp;
-	spin_unlock(&gpio_lock);
-
-	return 0;
-}
-
 static int loongson_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 {
 	u32 val;
@@ -97,6 +65,38 @@ static void loongson_gpio_set_value(struct gpio_chip *chip,
 	spin_unlock(&gpio_lock);
 }
 
+static int loongson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
+{
+	u32 temp;
+	u32 mask;
+
+	spin_lock(&gpio_lock);
+	mask = 1 << gpio;
+	temp = LOONGSON_GPIOIE;
+	temp |= mask;
+	LOONGSON_GPIOIE = temp;
+	spin_unlock(&gpio_lock);
+
+	return 0;
+}
+
+static int loongson_gpio_direction_output(struct gpio_chip *chip,
+		unsigned gpio, int level)
+{
+	u32 temp;
+	u32 mask;
+
+	loongson_gpio_set_value(chip, gpio, level);
+	spin_lock(&gpio_lock);
+	mask = 1 << gpio;
+	temp = LOONGSON_GPIOIE;
+	temp &= (~mask);
+	LOONGSON_GPIOIE = temp;
+	spin_unlock(&gpio_lock);
+
+	return 0;
+}
+
 static struct gpio_chip loongson_chip = {
 	.label                  = "Loongson-gpio-chip",
 	.direction_input        = loongson_gpio_direction_input,
-- 
2.14.3
