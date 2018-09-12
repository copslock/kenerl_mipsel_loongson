Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2018 13:32:40 +0200 (CEST)
Received: from mail-lj1-x244.google.com ([IPv6:2a00:1450:4864:20::244]:42640
        "EHLO mail-lj1-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993030AbeILLcYH7522 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2018 13:32:24 +0200
Received: by mail-lj1-x244.google.com with SMTP id f1-v6so1294132ljc.9
        for <linux-mips@linux-mips.org>; Wed, 12 Sep 2018 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WmDKNuVL2nQEOx4lnKKMauhr7amwXHX432D2ciaX0bw=;
        b=HrD+V0EsTf+MrjTIH4eYswSpyPOL7PSO08bFHpYQVdrzZ1PORD4B6NmdS0uXwm0MRO
         ahzgswREMBpiDcO9d6xjUleZSNRHYPy/g+wo7xaEprCb/HSS0y07tgEJlWYYyVCURDWE
         VdR+6pjuO6H5eC7iTaB/T9/8vfqwKqRDJFcpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WmDKNuVL2nQEOx4lnKKMauhr7amwXHX432D2ciaX0bw=;
        b=uhgDTEf0kd68SAt/AfiT+ObbDP2yWFWkpZilkw45utv4SVt/iJJMxYdLNSxevW5SZ1
         8MFtcMlRJrV3vE0iwYlp6nILgkTVByq27dZBtU81yHK0Xeakwj09JDJhFjpqFzIeHhfq
         M1ZKTdt1rhawIbtp68Z/ocalTP37ERZ+H48tuWnFVFWaqsNQejhYQfQ2awz2Qe8BQev3
         m0pljf4nHuOcGgnRv4vheJBtWlJoeaMnD1WnJ6aUohAPp7vg82eUKA74gbvAXsqmliJ1
         Ofj7RqS7+9uX5xrD8dKVAwLSBGYkc3pJqbEqMs7ZNtPevmE6kC/uZ0kf2PJxmRP/7n9V
         mSLw==
X-Gm-Message-State: APzg51A5EppysBowwgY36n5ukiQXtL+pXtvMSb4H1/9wNEvNCvgW8KtJ
        qfZ8JyONa/Lfjp3Ry4Z7WBg86Q==
X-Google-Smtp-Source: ANB0Vdah9MVHlSN4EzBxG0L6XtAdIelBzktmjZlICGvIJKiSIxWDpqYzWG56Ki11VPdC3cwxZWjq6A==
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr1090903ljj.103.1536751938551;
        Wed, 12 Sep 2018 04:32:18 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id q19-v6sm144182lje.29.2018.09.12.04.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:32:17 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/3] gpio: vr41xx: Delete vr41xx_gpio_pullupdown() callback
Date:   Wed, 12 Sep 2018 13:32:04 +0200
Message-Id: <20180912113204.1064-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180912113204.1064-1-linus.walleij@linaro.org>
References: <20180912113204.1064-1-linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66217
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

This API is not used anywhere in the kernel and has remained
unused for years after being introduced.

Over time, we have developed a subsystem to deal with pin
control and this now managed pull up/down.

Delete the old and unused API. If this platform needs it,
we should implement a proper pin controller for it instead.

Cc: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/mips/include/asm/vr41xx/giu.h |  8 -------
 drivers/gpio/gpio-vr41xx.c         | 38 ------------------------------
 2 files changed, 46 deletions(-)

diff --git a/arch/mips/include/asm/vr41xx/giu.h b/arch/mips/include/asm/vr41xx/giu.h
index 6a90bc1d916b..ecda4cf300de 100644
--- a/arch/mips/include/asm/vr41xx/giu.h
+++ b/arch/mips/include/asm/vr41xx/giu.h
@@ -51,12 +51,4 @@ typedef enum {
 
 extern void vr41xx_set_irq_level(unsigned int pin, irq_level_t level);
 
-typedef enum {
-	GPIO_PULL_DOWN,
-	GPIO_PULL_UP,
-	GPIO_PULL_DISABLE,
-} gpio_pull_t;
-
-extern int vr41xx_gpio_pullupdown(unsigned int pin, gpio_pull_t pull);
-
 #endif /* __NEC_VR41XX_GIU_H */
diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index 7d40104b8586..b13a49c89cc1 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -371,44 +371,6 @@ static int giu_set_direction(struct gpio_chip *chip, unsigned pin, int dir)
 	return 0;
 }
 
-int vr41xx_gpio_pullupdown(unsigned int pin, gpio_pull_t pull)
-{
-	u16 reg, mask;
-	unsigned long flags;
-
-	if ((giu_flags & GPIO_HAS_PULLUPDOWN_IO) != GPIO_HAS_PULLUPDOWN_IO)
-		return -EPERM;
-
-	if (pin >= 15)
-		return -EINVAL;
-
-	mask = 1 << pin;
-
-	spin_lock_irqsave(&giu_lock, flags);
-
-	if (pull == GPIO_PULL_UP || pull == GPIO_PULL_DOWN) {
-		reg = giu_read(GIUTERMUPDN);
-		if (pull == GPIO_PULL_UP)
-			reg |= mask;
-		else
-			reg &= ~mask;
-		giu_write(GIUTERMUPDN, reg);
-
-		reg = giu_read(GIUUSEUPDN);
-		reg |= mask;
-		giu_write(GIUUSEUPDN, reg);
-	} else {
-		reg = giu_read(GIUUSEUPDN);
-		reg &= ~mask;
-		giu_write(GIUUSEUPDN, reg);
-	}
-
-	spin_unlock_irqrestore(&giu_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(vr41xx_gpio_pullupdown);
-
 static int vr41xx_gpio_get(struct gpio_chip *chip, unsigned pin)
 {
 	u16 reg, mask;
-- 
2.17.1
