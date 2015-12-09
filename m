Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:40:12 +0100 (CET)
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35250 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013553AbbLINjqAobI9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 14:39:46 +0100
Received: by lfdl133 with SMTP id l133so34261954lfd.2
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 05:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HfL5T8Hbnyj2DI50W10FAhciZjvO4f2+euThIwtKe/c=;
        b=VG6SRoEOHN1QOPMNAXCrV1pXBNkjCCeZKtQNbMDyGFboAJngWtPXvlPSwtJEaHmQlO
         30WRW//yXCOjDAJTYsXCeOpNPPu++bNzcyTl8OOc8BYqTiRyO6S0iKWjxblOyPl2Csvi
         yRPHl68oDaTatUREofBjKahtEIw1GZ1JaIqf3TNWraWlkJoyvtMQ+XKBDHjLXylconGp
         VbjHTIHDXCWnsqkBrDrfSfNp4KH/NQSDmBWP0uL/87/8kt7C7jUzP8BGiy7DXwhahiPE
         B45j/IYbwAlKMw5rHnAVCs2GCGiw61SWt6HSWj7KLI1P1UDRQ6tIadSArYF1Gbt29gjS
         WSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HfL5T8Hbnyj2DI50W10FAhciZjvO4f2+euThIwtKe/c=;
        b=CMYRplWWnXgYDLsE3rLFEtAa71f34M8dcMLVyrntNkMZQ+bvugkmsXzpjl8B+whTIP
         eQXdmG19OoyYvHYgQifFcXQAjMExpQagJI9+k2i2i7QTbsSXvq5v+qCvHHRhWtdxe+bI
         1t5LYU6IYRs+Uop5aKOIZdasZtLlREuuCbYYHTE7PJ+xnmjhzHGIBon9KZvI0Fv7Pm2i
         GCoaHbp7Z3GemYAyW47HYj6UhUSXgRrf+As5QnhRtzgprZ7Kgq9prh3O/AUijxidHzme
         t3ak2yEIcRhF1B4AXja2Vjr5QuqR0oNL3XM7HNwXD/7zLVZX0K3EpCpQ5+udcha5z2Ag
         +Ozw==
X-Gm-Message-State: ALoCoQkje/m5CPMMvIPjx1qeoJsTI/9f0k/mX11jRWaqtsPTtvxISv6PvMm+vFYV9lSg7Gr+9aXNubtyF7uAi+VIiBMxrQkNKw==
X-Received: by 10.25.209.77 with SMTP id i74mr2225336lfg.143.1449668380644;
        Wed, 09 Dec 2015 05:39:40 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id a2sm1432268lbp.37.2015.12.09.05.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 05:39:40 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org
Subject: [PATCH 138/182] MIPS: jz4740: use gpiochip data pointer
Date:   Wed,  9 Dec 2015 14:39:32 +0100
Message-Id: <1449668372-4587-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50470
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

This makes the driver use the data pointer added to the gpio_chip
to store a pointer to the state container instead of relying on
container_of().

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Ralf: please ACK this so I can take it through the GPIO tree.
BTW: would be nice if the MIPS GPIO drivers could move down
to drivers/gpio in the long run.
---
 arch/mips/jz4740/gpio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 8c6d76c9b2d6..c2607e8ec758 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -18,6 +18,8 @@
 #include <linux/init.h>
 
 #include <linux/io.h>
+#include <linux/gpio/driver.h>
+/* FIXME: needed for gpio_request(), try to remove consumer API from driver */
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -91,9 +93,9 @@ static inline struct jz_gpio_chip *gpio_to_jz_gpio_chip(unsigned int gpio)
 	return &jz4740_gpio_chips[gpio >> 5];
 }
 
-static inline struct jz_gpio_chip *gpio_chip_to_jz_gpio_chip(struct gpio_chip *gpio_chip)
+static inline struct jz_gpio_chip *gpio_chip_to_jz_gpio_chip(struct gpio_chip *gc)
 {
-	return container_of(gpio_chip, struct jz_gpio_chip, gpio_chip);
+	return gpiochip_get_data(gc);
 }
 
 static inline struct jz_gpio_chip *irq_to_jz_gpio_chip(struct irq_data *data)
@@ -234,7 +236,7 @@ static int jz_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 
 static int jz_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
 {
-	struct jz_gpio_chip *jz_gpio = gpio_chip_to_jz_gpio_chip(chip);
+	struct jz_gpio_chip *jz_gpio = gpiochip_get_data(chip);
 
 	return jz_gpio->irq_base + gpio;
 }
@@ -449,7 +451,7 @@ static void jz4740_gpio_chip_init(struct jz_gpio_chip *chip, unsigned int id)
 	irq_setup_generic_chip(gc, IRQ_MSK(chip->gpio_chip.ngpio),
 		IRQ_GC_INIT_NESTED_LOCK, 0, IRQ_NOPROBE | IRQ_LEVEL);
 
-	gpiochip_add(&chip->gpio_chip);
+	gpiochip_add_data(&chip->gpio_chip, chip);
 }
 
 static int __init jz4740_gpio_init(void)
-- 
2.4.3
