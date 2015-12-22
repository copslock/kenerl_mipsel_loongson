Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 15:40:19 +0100 (CET)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33757 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014339AbbLVOkRjxSF9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 15:40:17 +0100
Received: by mail-lf0-f52.google.com with SMTP id p203so131915795lfa.0
        for <linux-mips@linux-mips.org>; Tue, 22 Dec 2015 06:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6fF21fS+icBxv/HXRanKYxR+5fZDrJSQ6+lMyPEpLXY=;
        b=ZAAtlSfoSPXxVWoGg/dgNdT4JeES9Yld0NrElkmXAGAM2E/FrWkfCe0S5nnvi3C8Fw
         RKgG5BTd9QIHsll4omwY8r1R6q178iv9BG7UFq3LbCKP15svtdZ4/XxJbrg1x0RDDDok
         flfmeTbMnwfYG5zxWP4Fhv9a7OiZRxSnJ86pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6fF21fS+icBxv/HXRanKYxR+5fZDrJSQ6+lMyPEpLXY=;
        b=P1YIjhSCzT9UP1CNsrRJbe8Pbve2kdNJZUUmjJYmTAp4BMxOJpJfjJEwz1cOcTR+lI
         NlFuXvJvVL3YjYetUB5jy3vl5G7ZmFUKrdg2UrLtO7D933jkKxBJzLWXqajuN9m89TX5
         9bWV9QJ3IZFYcIMVvyPyY5Yf5QmVeq1I0isO8bDwgGuk3KOOBNvk9EtlZ9eF6oRdiRDk
         bPtLIut7xg8yjHpOroKqYl1dH8a+QcckM4nKObvV4dZ8eiiRE4MI/yW5gXaZbYB+MIAo
         9ztqPGqf8IGHhiQTR+abvafTwx42IaN6w5DPuSlQ/FfhqTrPTPQCJHdQreBSI/Nb99zz
         BT6w==
X-Gm-Message-State: ALoCoQmbt5xDe0sNVXaV/I85pncF2djFz9CD5IDugZWfDAK29GpwSO6iDfqsqx9F+Oj07jFj1Nz8ZTADbOQEjRywhI3VeUMT/w==
X-Received: by 10.25.19.154 with SMTP id 26mr8950681lft.127.1450795212257;
        Tue, 22 Dec 2015 06:40:12 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id xn8sm5755167lbb.41.2015.12.22.06.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 06:40:11 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 36/54] mips: alchemy: Be sure to clamp return value
Date:   Tue, 22 Dec 2015 15:40:02 +0100
Message-Id: <1450795202-27345-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50732
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

As we want gpio_chip .get() calls to be able to return negative
error codes and propagate to drivers, we need to go over all
drivers and make sure their return values are clamped to [0,1].
We do this by using the ret = !!(val) design pattern.

Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
MIPS folks: as mentioned in 00/54: either apply this directly
or ACK it and I will take it into the GPIO tree.
---
 arch/mips/alchemy/common/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/common/gpiolib.c b/arch/mips/alchemy/common/gpiolib.c
index f9bc4f520440..84548f704035 100644
--- a/arch/mips/alchemy/common/gpiolib.c
+++ b/arch/mips/alchemy/common/gpiolib.c
@@ -40,7 +40,7 @@
 
 static int gpio2_get(struct gpio_chip *chip, unsigned offset)
 {
-	return alchemy_gpio2_get_value(offset + ALCHEMY_GPIO2_BASE);
+	return !!alchemy_gpio2_get_value(offset + ALCHEMY_GPIO2_BASE);
 }
 
 static void gpio2_set(struct gpio_chip *chip, unsigned offset, int value)
@@ -68,7 +68,7 @@ static int gpio2_to_irq(struct gpio_chip *chip, unsigned offset)
 
 static int gpio1_get(struct gpio_chip *chip, unsigned offset)
 {
-	return alchemy_gpio1_get_value(offset + ALCHEMY_GPIO1_BASE);
+	return !!alchemy_gpio1_get_value(offset + ALCHEMY_GPIO1_BASE);
 }
 
 static void gpio1_set(struct gpio_chip *chip,
@@ -119,7 +119,7 @@ struct gpio_chip alchemy_gpio_chip[] = {
 
 static int alchemy_gpic_get(struct gpio_chip *chip, unsigned int off)
 {
-	return au1300_gpio_get_value(off + AU1300_GPIO_BASE);
+	return !!au1300_gpio_get_value(off + AU1300_GPIO_BASE);
 }
 
 static void alchemy_gpic_set(struct gpio_chip *chip, unsigned int off, int v)
-- 
2.4.3
