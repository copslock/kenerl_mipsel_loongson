Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:40:51 +0100 (CET)
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36400 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013549AbbLINkKS7uK9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 14:40:10 +0100
Received: by lfs39 with SMTP id 39so34598607lfs.3
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 05:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=DapTIGfKV12u1PbvFg8CPKZWivl+01aV+88DpkulEc8=;
        b=CJfxPbyUEhaa0BGMfoEyrqZGFa/IM3OWMGAPY+z+SO4NqX8rgYoH5KFeYveH2n3YXE
         uGh4GxPZi2JyalROIQ0xh4tD7Lr9VC9MAkXZojD4dmVYacte5VZIhE6AB+kh50OUobsC
         8jAq+LVEo4nEfoZVwXxdabxG3XwRxLN94/AcwrhSFZic03sXVn5CmzJnR4x7RIOtTwfh
         5OfzqfuI1qAnD5xUoRCfSGH/W/XA2QZv6Mkrq1T16SkVhwxz8hz1ShM4AyiaHQaG3wTF
         kMlkTxUBy1SLKZKkR2DF0yIj0cOFM3hMNUbIuFB8P3gr69i2Sef7yI6rgOTddV4VckDx
         3q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DapTIGfKV12u1PbvFg8CPKZWivl+01aV+88DpkulEc8=;
        b=V28LGpTYX0MMBDVIPYHZEzAIbmy7y0d79GherdUgohZ/nP3VpQC71x0YwpA3859LQ5
         wD2Q42OQSbeW3ZV1PzJ6lR/hjDQxdpSbUxcUbrpnFtRPE3/YMTxiTF1wRyusDbMceAkf
         sXeMmFEcF/Mwz9km9JZtPLIo58NpQ3JSgCY7rLVVE/CZuxiI1W+WaY4FXjRcLfnAM/iI
         TzGrngbl6Clt0dlWJPTVWaSxR68FYiVivmpDQ2j6Skre5ihazAgjcV7MurOljZ5pSUq1
         Qcmy9yo2e+4sOYfg93O/x8tbyxAnTe8V3yvsTTsYZlgRD/0cSYusPArpgmhKD8yvFi1F
         EV/g==
X-Gm-Message-State: ALoCoQkTwBEcGz6TVZBmuNyA3IFbZaNaFHNnFpIJL6ckQFOag1HdO9S4DNSXqFjUSRNquB7ugHyv9ZLSnIjU3VBFo17U9PMbAw==
X-Received: by 10.25.15.22 with SMTP id e22mr2262752lfi.92.1449668404946;
        Wed, 09 Dec 2015 05:40:04 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id d130sm1458709lfe.18.2015.12.09.05.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 05:40:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org
Subject: [PATCH 140/182] MIPS: rb532: use gpiochip data pointer
Date:   Wed,  9 Dec 2015 14:40:01 +0100
Message-Id: <1449668401-4687-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50472
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
to drivers/gpio in the long run. This should compile with
just #include <linux/gpio/driver.h>, I hope that works.
---
 arch/mips/rb532/gpio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 650d5d39f34d..97a5e2c3797b 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -32,7 +32,7 @@
 #include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 
 #include <asm/mach-rc32434/rb.h>
 #include <asm/mach-rc32434/gpio.h>
@@ -88,7 +88,7 @@ static int rb532_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct rb532_gpio_chip	*gpch;
 
-	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	gpch = gpiochip_get_data(chip);
 	return rb532_get_bit(offset, gpch->regbase + GPIOD);
 }
 
@@ -100,7 +100,7 @@ static void rb532_gpio_set(struct gpio_chip *chip,
 {
 	struct rb532_gpio_chip	*gpch;
 
-	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	gpch = gpiochip_get_data(chip);
 	rb532_set_bit(value, offset, gpch->regbase + GPIOD);
 }
 
@@ -111,7 +111,7 @@ static int rb532_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct rb532_gpio_chip	*gpch;
 
-	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	gpch = gpiochip_get_data(chip);
 
 	/* disable alternate function in case it's set */
 	rb532_set_bit(0, offset, gpch->regbase + GPIOFUNC);
@@ -128,7 +128,7 @@ static int rb532_gpio_direction_output(struct gpio_chip *chip,
 {
 	struct rb532_gpio_chip	*gpch;
 
-	gpch = container_of(chip, struct rb532_gpio_chip, chip);
+	gpch = gpiochip_get_data(chip);
 
 	/* disable alternate function in case it's set */
 	rb532_set_bit(0, offset, gpch->regbase + GPIOFUNC);
@@ -200,7 +200,7 @@ int __init rb532_gpio_init(void)
 	}
 
 	/* Register our GPIO chip */
-	gpiochip_add(&rb532_gpio_chip->chip);
+	gpiochip_add_data(&rb532_gpio_chip->chip, rb532_gpio_chip);
 
 	return 0;
 }
-- 
2.4.3
