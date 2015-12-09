Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:39:50 +0100 (CET)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34774 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013549AbbLINjgQQHx9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 14:39:36 +0100
Received: by lbbcs9 with SMTP id cs9so30081543lbb.1
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ZbuWQfM33F/SGx2hYwyjkrUw0ejn5djfWJ57Eg+dqgo=;
        b=xk4boast76JHSV+tbTCeLLese6bsWZbAiWFtjp6Cl/xcy+B8O3EeUTHZYs1/dUCWvk
         2VNoj9ZOs+9Qe9o4xHFGYVch4v+YAtM/EHC8QuuBm7UQMOSoIxl1gVJkRIuFUGyhDwwZ
         mtW8SSa7AN7kIO+Ey1GJsN0KLbN/VcEIX+9/0jUTxlUOg+nr/2bhipUWShCpTyH7I8mF
         j/aJUtTBEzim77nBpjapHENw/0IfbN7EHLE6uX4+28H57BXWD0sUDbROplKUxcezr7JD
         pjvKtsyl+D44BAOVTF+Ys/T6gY5g9wVnjbvckSnh7ke002zgFIOj+d+APcWcc/PuDP6R
         BaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZbuWQfM33F/SGx2hYwyjkrUw0ejn5djfWJ57Eg+dqgo=;
        b=a1v9FbB2h0sUqV0CEeBdo1uCcjqT+KewxzJKa+KSB4r3v5OD7npaEgUF9CCLZeLUc9
         iS0siELuaGen7b/ABVNy3CpwFkBxouwYa8gL8cXKygn1mMWmSmxyrysvfJBRRsVDjHxJ
         4WShS7vmGIb2C8ATERxTHmEW9XhNoKvLo5+0WOAa8TKp1ebDxPJtbE/gVWLYVt14DlZ6
         96KU1JbgyUq0qb3F+vr6ujmaxYaWHIfBv2jI7vahmrtqTjBAbu7sv+ZgX4Ck5DzhaSjg
         KN8M+WIaVGZxAMXmHa2iY/Nmi3mggB2Xi6Ou/Zwukq+h+ua9taEN8zyTglaYnFXLa798
         6MHg==
X-Gm-Message-State: ALoCoQlM0esgXo6fQYOD5HarFbMd8TLtRQqGSULyIDs+XHmtwopkcd/MYRNaEanx0+HEeqXPa+4czPGGc2FxKrc/qhwNC/tT+Q==
X-Received: by 10.112.120.212 with SMTP id le20mr2041153lbb.134.1449668368275;
        Wed, 09 Dec 2015 05:39:28 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id mt2sm1422452lbc.9.2015.12.09.05.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 05:39:27 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org
Subject: [PATCH 137/182] MIPS: bcm63xx: switch to gpiochip_add_data()
Date:   Wed,  9 Dec 2015 14:39:19 +0100
Message-Id: <1449668359-4540-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50469
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

We're planning to remove the gpiochip_add() function to swith
to gpiochip_add_data() with NULL for data argument.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Ralf: please ACK this so I can take it through the GPIO tree.
BTW: would be nice if the MIPS GPIO drivers could move down
to drivers/gpio in the long run. This should compile with
just #include <linux/gpio/driver.h>, I hope that works.
---
 arch/mips/bcm63xx/gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index 468bc7b99cd3..7c256dadb166 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_gpio.h>
@@ -147,5 +147,5 @@ int __init bcm63xx_gpio_init(void)
 	bcm63xx_gpio_chip.ngpio = bcm63xx_gpio_count();
 	pr_info("registering %d GPIOs\n", bcm63xx_gpio_chip.ngpio);
 
-	return gpiochip_add(&bcm63xx_gpio_chip);
+	return gpiochip_add_data(&bcm63xx_gpio_chip, NULL);
 }
-- 
2.4.3
