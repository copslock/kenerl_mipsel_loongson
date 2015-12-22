Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 15:41:32 +0100 (CET)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36562 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008618AbbLVOl2n8bu9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 15:41:28 +0100
Received: by mail-lb0-f173.google.com with SMTP id oh2so32178063lbb.3
        for <linux-mips@linux-mips.org>; Tue, 22 Dec 2015 06:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M+32zIeBIXpZubZrwlVDsxGr1hUkVrXDwtryZ3GHAeA=;
        b=VTZYK07CC1xODfSOHPJ9hQBJAjbgaJxR2DzMCG8FpueaK1i8ET2BEgAfl5QJwqXr36
         nWzCgGw0A769OQK7Z9wLtGGPX8ZOeooW/I2OGQUa7HqpcS0Ii5Xol/zzPbYjEPd/72Fh
         FoPamzDa9MlL4RNVwpb2H1ZPIiGcQhYXL1B6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M+32zIeBIXpZubZrwlVDsxGr1hUkVrXDwtryZ3GHAeA=;
        b=IT2GuvBC+IWGOCwuXH0ReU6imAj0F5+F3jxZem/Z3N2JcXNAU0WQ9IRsSiyIw7d0LS
         EXHQVpETv8dIvUQh+YFH4LHkvaohlv1nTldyeAQy+Wl1NLE9V1Kh8LjHtA8UQyGFcgIz
         jggQB/1L4ag+BJspTYUnsoRJcUqyZDDKyduI2jHjojkXVdRBDwU90DWpYYf0YkLAOpMI
         z3T4j8B7JOb2iwIGIYL7X4Wt5Ng1AQBQuaG3Xv68GlhsInHMjhCC0Khj4lK7598JqM16
         VKaUq/DMBHRWvmsShAPEKGwSCb/VCi+GGZmXOEIMvspA0dLdKPushMc8Gyl4cKL4AMBj
         p7zA==
X-Gm-Message-State: ALoCoQniU4UaFVs6LFN397hOV3wzOk5IbrPkz5jT1A7+DlOscLjqaa5QNh1zgIIAUKSwo2LrVV7QlZ7oyTpUmqpdwRjPW8ue1w==
X-Received: by 10.112.126.42 with SMTP id mv10mr8632857lbb.98.1450795283416;
        Tue, 22 Dec 2015 06:41:23 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id xo4sm984943lbb.27.2015.12.22.06.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 06:41:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 39/54] mips: rb532: Be sure to clamp return value
Date:   Tue, 22 Dec 2015 15:41:19 +0100
Message-Id: <1450795279-27515-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50735
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
 arch/mips/rb532/gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 650d5d39f34d..fd1108543a71 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -89,7 +89,7 @@ static int rb532_gpio_get(struct gpio_chip *chip, unsigned offset)
 	struct rb532_gpio_chip	*gpch;
 
 	gpch = container_of(chip, struct rb532_gpio_chip, chip);
-	return rb532_get_bit(offset, gpch->regbase + GPIOD);
+	return !!rb532_get_bit(offset, gpch->regbase + GPIOD);
 }
 
 /*
-- 
2.4.3
