Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:41:07 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:32833 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007845AbbLINkRpsZ29 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 14:40:17 +0100
Received: by lbbkw15 with SMTP id kw15so30175635lbb.0
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 05:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dFknQS4+YNnN0Kv6JGsPWRleE/nlW4vLORKquc+oi4M=;
        b=tHaZiDOqhDa+YmVyH4TXCqKvvFXRKFnPya4l0bfb87jxjDiP1iSLI3qSuhsa2yZjTj
         3Om+OoaxLt1egVdyH4g2wSrAa/S/Mp/baTvGQw/QoQsrYCedBmELG+Y5KqOxzolZqZjn
         SSrea2JB7zZsL/LeNuvq6DyWixyt6zLKJLZ2jieAYF/ESa4aZM0Nf1zdRYyzV1cgVC99
         zcTT+c1wFOFf3puiFSNphiubDdEsz1YM6G+Jg8e6QOd7t/ShS0F0yABKC8MiMgP0I6/l
         AYTCSg4aP8v2qTWWd/atkFCljnA0L2vROrAf3/A1jpChVrgEMsvuecqmLbXqkT6+f5Rd
         JKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dFknQS4+YNnN0Kv6JGsPWRleE/nlW4vLORKquc+oi4M=;
        b=B+5RaXiz3ygER0zBp0jOitCULPNLIbb98jKuBy3Fqu7WjCqRbHYtrFqWBb4huPolnA
         JATtoc56/RRBCdqZpGO7+26vOwussg9ZX2LrynNiwHyuxfJsWX2ZxLUskC/zeWvGuQdz
         /2KBiTmjkHTIDkLLwgERdlG/7C50qjFWKq7d1vGKTk1oaDRa0uRjeKHQ4qtu945Eym22
         LiAZchijhQIPeWOaRW4cJnwySBEPFInaWGnCEMebjR4/oKqaSDhfbO6gMI3y2hxuqrOP
         SVaCC1ATXR9Dk2p5BSXC0bXk8mmBNLRQlogwg7FxLn20eCLBTD1PDb/hRx++ldAdEUk9
         3RVg==
X-Gm-Message-State: ALoCoQkv9oQL1B/cNpUlv7UlS9jbLoU52RvqDLontkkm+D7ryiCpSbnRH4/BCR8IVmPeJ+8MyXXAD1+b4e5yYXpYT50jpxQ/HQ==
X-Received: by 10.112.99.199 with SMTP id es7mr2394335lbb.25.1449668412446;
        Wed, 09 Dec 2015 05:40:12 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id l67sm1444286lfl.26.2015.12.09.05.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 05:40:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org
Subject: [PATCH 141/182] MIPS: txx9: iocled: use gpiochip data pointer
Date:   Wed,  9 Dec 2015 14:40:09 +0100
Message-Id: <1449668409-4738-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50473
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
 arch/mips/txx9/generic/setup.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 9d9962ab7d25..78cffd8e63d3 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/mtd/physmap.h>
@@ -687,16 +687,14 @@ struct txx9_iocled_data {
 
 static int txx9_iocled_get(struct gpio_chip *chip, unsigned int offset)
 {
-	struct txx9_iocled_data *data =
-		container_of(chip, struct txx9_iocled_data, chip);
+	struct txx9_iocled_data *data = gpiochip_get_data(chip);
 	return data->cur_val & (1 << offset);
 }
 
 static void txx9_iocled_set(struct gpio_chip *chip, unsigned int offset,
 			    int value)
 {
-	struct txx9_iocled_data *data =
-		container_of(chip, struct txx9_iocled_data, chip);
+	struct txx9_iocled_data *data = gpiochip_get_data(chip);
 	unsigned long flags;
 	spin_lock_irqsave(&txx9_iocled_lock, flags);
 	if (value)
@@ -749,7 +747,7 @@ void __init txx9_iocled_init(unsigned long baseaddr,
 	iocled->chip.label = "iocled";
 	iocled->chip.base = basenum;
 	iocled->chip.ngpio = num;
-	if (gpiochip_add(&iocled->chip))
+	if (gpiochip_add_data(&iocled->chip, iocled))
 		goto out_unmap;
 	if (basenum < 0)
 		basenum = iocled->chip.base;
-- 
2.4.3
