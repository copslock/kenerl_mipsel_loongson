Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 12:25:07 +0200 (CEST)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:46901
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991534AbeDMKYfgYlid (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 12:24:35 +0200
Received: by mail-lf0-x241.google.com with SMTP id j68-v6so11848867lfg.13
        for <linux-mips@linux-mips.org>; Fri, 13 Apr 2018 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8kpapX5/6q7JgjDTgbScLYzNEYYEt7mBHjkOq7DOL0=;
        b=beZbYCRxPsjzEwS8KpJp+SQZqD2BCvny4P7fnCjOVuTjFvBgQozAoMnnrTngekSYyk
         eC3Q0/Jpefcmz2IxYfPGkRgO70eOSYBiwnTDyxg7SJRBKTzrVf/gpUP1gW9bZrXmkRKe
         Qlpb1xOAY/o5+fO3OdrBPtSYAap7L7NdV1UIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z8kpapX5/6q7JgjDTgbScLYzNEYYEt7mBHjkOq7DOL0=;
        b=ekG4z9E4SqF+dd+vvPWumZ7OQU86Dicz2Ub79TI1JP9FbtjZVkd+IYrEtqYUfQGdLW
         b/o3NeQeKXHWtS1/JVcHDJEUgVIQlS1c2gm5ELSufGeTEQ0c5GzBybWez/+8ki+3L8sl
         gpPrIV3MWczCrGkSTLDA+2aLIeXYZKSzJRg1gHCAgx64VZR1dlg6emFG6H8oNzJP479a
         mCCX7Ija4F+WR0QJ/DzoPwN3aOtHZa6dlS/oFW30O4GOs5yPP9hrJReBqVuDqCMAxLiE
         mvIas5ZYQyii0Jthbnnam/CDjNG5tjLGOUUhmQzKAgQWZQ09JM5VMiYij+eACDFuqLan
         RPGQ==
X-Gm-Message-State: ALQs6tANgvS+7ZrtKnegI6c3OW0OBOewCupVhYsrEkADheBa29s4chiB
        tRSg8WbGMj/HP4VbMNa3lt6Ztg==
X-Google-Smtp-Source: AIpwx4+PKx/IdnKUDvrwP7dUkm0XuVSzzFmOAnhP8PWN0MuKj/HlUGFIRwzpV+j6xBog/6559yFsAQ==
X-Received: by 2002:a19:921a:: with SMTP id u26-v6mr7565563lfd.112.1523615070210;
        Fri, 13 Apr 2018 03:24:30 -0700 (PDT)
Received: from genomnajs.payandsurf.com ([192.36.80.8])
        by smtp.gmail.com with ESMTPSA id c4sm915360lja.97.2018.04.13.03.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Apr 2018 03:24:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: [PATCH 3/3] gpio: loongson: Use BIT() macros
Date:   Fri, 13 Apr 2018 12:24:21 +0200
Message-Id: <20180413102421.23939-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413102421.23939-1-linus.walleij@linaro.org>
References: <20180413102421.23939-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63522
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

This switches the Loongson driver over to using the bitops BIT()
macros and drops some local variables and make the code easier
to read (in my opinion).

Cc: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-loongson.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-loongson.c b/drivers/gpio/gpio-loongson.c
index 3c9d4f3ed550..16cfbe9e72fe 100644
--- a/drivers/gpio/gpio-loongson.c
+++ b/drivers/gpio/gpio-loongson.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
+#include <linux/bitops.h>
 #include <asm/types.h>
 #include <loongson.h>
 
@@ -31,6 +32,11 @@
 #define LOONGSON_N_GPIO	STLS2F_N_GPIO
 #endif
 
+/*
+ * Offset into the register where we read lines, we write them from offset 0.
+ * This offset is the only thing that stand between us and using
+ * GPIO_GENERIC.
+ */
 #define LOONGSON_GPIO_IN_OFFSET	16
 
 static DEFINE_SPINLOCK(gpio_lock);
@@ -38,30 +44,25 @@ static DEFINE_SPINLOCK(gpio_lock);
 static int loongson_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 {
 	u32 val;
-	u32 mask;
 
-	mask = 1 << (gpio + LOONGSON_GPIO_IN_OFFSET);
 	spin_lock(&gpio_lock);
 	val = LOONGSON_GPIODATA;
 	spin_unlock(&gpio_lock);
 
-	return (val & mask) != 0;
+	return !!(val & BIT(gpio + LOONGSON_GPIO_IN_OFFSET));
 }
 
 static void loongson_gpio_set_value(struct gpio_chip *chip,
 		unsigned gpio, int value)
 {
 	u32 val;
-	u32 mask;
-
-	mask = 1 << gpio;
 
 	spin_lock(&gpio_lock);
 	val = LOONGSON_GPIODATA;
 	if (value)
-		val |= mask;
+		val |= BIT(gpio);
 	else
-		val &= (~mask);
+		val &= ~BIT(gpio);
 	LOONGSON_GPIODATA = val;
 	spin_unlock(&gpio_lock);
 }
@@ -69,12 +70,10 @@ static void loongson_gpio_set_value(struct gpio_chip *chip,
 static int loongson_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
 	u32 temp;
-	u32 mask;
 
 	spin_lock(&gpio_lock);
-	mask = 1 << gpio;
 	temp = LOONGSON_GPIOIE;
-	temp |= mask;
+	temp |= BIT(gpio);
 	LOONGSON_GPIOIE = temp;
 	spin_unlock(&gpio_lock);
 
@@ -85,13 +84,11 @@ static int loongson_gpio_direction_output(struct gpio_chip *chip,
 		unsigned gpio, int level)
 {
 	u32 temp;
-	u32 mask;
 
 	loongson_gpio_set_value(chip, gpio, level);
 	spin_lock(&gpio_lock);
-	mask = 1 << gpio;
 	temp = LOONGSON_GPIOIE;
-	temp &= (~mask);
+	temp &= ~BIT(gpio);
 	LOONGSON_GPIOIE = temp;
 	spin_unlock(&gpio_lock);
 
-- 
2.14.3
