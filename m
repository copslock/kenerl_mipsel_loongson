Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 15:40:39 +0100 (CET)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34405 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014339AbbLVOkhFvFu9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 15:40:37 +0100
Received: by mail-lb0-f169.google.com with SMTP id pv2so46223032lbb.1
        for <linux-mips@linux-mips.org>; Tue, 22 Dec 2015 06:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ti+yH1KIw5N2AgY1Id5bmyFlHBdjzzI3lBMCNNPO3Z0=;
        b=GsYdXXaUW/i8Tk6v7k5cHYozacOaG/MVDvEzcI6eYq8srREkU39aZgO2qOs95FbZeM
         bVurmy+8/hxIpLAC3QYimLMvsh9P04lXPxNe3fd3LqoVB3FAY3NZGQPpWotLkvDu4/+p
         A8r+cVHd00cbb5C5OmvtMopnKLBJI9Z6lB3Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ti+yH1KIw5N2AgY1Id5bmyFlHBdjzzI3lBMCNNPO3Z0=;
        b=PfGbMginU8iKO7yrF4Qtf2KYXHtdANEgojlQksiER8V0IRW7ksasQHvqimcBQZm34a
         vcW7qwhT2fCtcF0J7SYjyg/Zl0ve/QyB/2hZPxGJVIpqu9g5PMWmnHSmosOs4j6w1AF+
         r3yqqtEvVR5NMXiup5ZuoLXXWh+g/KfKqwe7SZcluEwOzqSrH2YbuyzsibTzgDAaj7Qd
         eLm0eLYgGXmCw9jBA6ba4YcwYizHWAPnI+TywnLT8ikkZgC1lSuo3lO7TDPPcUobPtaW
         r5IC6MbMNuPAGqS/uKNKdlmisE/97l6prYBnk1WueGFdsaz0N13RwaYwXE4EkQzFK+Dq
         ysfg==
X-Gm-Message-State: ALoCoQngyF8ExO0PuyYeKmUqRfDEUyNxuqNwTZis7TZG1iBBRr8iP1SE1LqUHa1SZjHMqfgpMMegYQCPKP5ZU0OeS+vnhIqIAQ==
X-Received: by 10.112.161.228 with SMTP id xv4mr8958226lbb.60.1450795231512;
        Tue, 22 Dec 2015 06:40:31 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id pd9sm5726524lbc.48.2015.12.22.06.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 06:40:30 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 37/54] mips: ar7/gpio: Be sure to clamp return value
Date:   Tue, 22 Dec 2015 15:40:27 +0100
Message-Id: <1450795227-27411-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50733
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
Cc: Alban Bedel <albeu@free.fr>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/mips/ar7/gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index f4930456eb8e..f969f583c68c 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -37,7 +37,7 @@ static int ar7_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 				container_of(chip, struct ar7_gpio_chip, chip);
 	void __iomem *gpio_in = gpch->regs + AR7_GPIO_INPUT;
 
-	return readl(gpio_in) & (1 << gpio);
+	return !!(readl(gpio_in) & (1 << gpio));
 }
 
 static int titan_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
-- 
2.4.3
