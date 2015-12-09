Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:40:31 +0100 (CET)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36106 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013547AbbLINkAudgo9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 14:40:00 +0100
Received: by lbblt2 with SMTP id lt2so30278091lbb.3
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 05:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=U5OL3xYDe+pTva7+HLU905tltq1+HmzDrEqpJjqmGlY=;
        b=JrbbTnFVL3svh/apqFFt1x0TpbP2SK70ipBranL5gAWGT8A1NLgl82cjsFD4gc5SlE
         0P1VLgq0B6beCZ8+K4pp5VJbIKLnLSmRTCbtMEptujDzBYNeIdoYwKx2hKtiXeVeBc49
         NVfK7tNqgGnJLJ/On/vsmiQESPKZnTJ8UTlTHf7cxW7uzucS+f884XXswN6f9GD3HQWa
         wWFF7Dd/m4IR329G7gzAbL0AYHsYjg0oKQwfXaQUs6N/31bd2EJrYIFvIrZ9TwZo0zFP
         rKuwG1BcnJwn86a1kiv4qGLKrWU+Q9J2717pcNSqoeBdcb29wqCPdYWn8iKZSTvA+UYn
         TyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U5OL3xYDe+pTva7+HLU905tltq1+HmzDrEqpJjqmGlY=;
        b=QpNr1BEHQBn4iYJ7iDM2fml7EKFq7wmOAcdrUb3TdVgFKQd7u88i3cXjCELcTjb4RW
         j4rPMcLVWgJKLPHQp5Z+JEJGe8AXKi+oscwxUaRFjojoAZhHd5wObAzQKPQbImOXZlBg
         /bbymkvRoJyyosVJPEsDYwF0kvWuf26RiJehVLX7aoKH67i/9XvzRo91JP+6Gchgt9cw
         M5r3Ic7577CYPYmOJQLG+01FVZNkCMXkmWtrnm+NSwOG5X6pcggWMRuOAZkSuMtpyEBi
         tC18aJ4LUILnW11/eAbohecxQf9p1Sp++xR0O2ImFHeUXaiaRk9Da4+3jFFBm11n6Gcu
         Z6GQ==
X-Gm-Message-State: ALoCoQkixliBrAjFS+yNRS51ExL11K5eYuhEydDn9l19q2pYlCnW76T53Tco3uhvthQkSB3uVV1vY5qHSCgpfn1gpMP2J2Vxlg==
X-Received: by 10.112.168.106 with SMTP id zv10mr2410141lbb.127.1449668395512;
        Wed, 09 Dec 2015 05:39:55 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id sv10sm1406291lbb.46.2015.12.09.05.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 05:39:54 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org
Subject: [PATCH 139/182] MIPS: txx9: switch to gpiochip_add_data()
Date:   Wed,  9 Dec 2015 14:39:44 +0100
Message-Id: <1449668384-4634-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50471
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
 arch/mips/kernel/gpio_txx9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/gpio_txx9.c b/arch/mips/kernel/gpio_txx9.c
index c6854d9df926..2cfde19b6893 100644
--- a/arch/mips/kernel/gpio_txx9.c
+++ b/arch/mips/kernel/gpio_txx9.c
@@ -10,7 +10,7 @@
 
 #include <linux/init.h>
 #include <linux/spinlock.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <asm/txx9pio.h>
@@ -85,5 +85,5 @@ int __init txx9_gpio_init(unsigned long baseaddr,
 		return -ENODEV;
 	txx9_gpio_chip.base = base;
 	txx9_gpio_chip.ngpio = num;
-	return gpiochip_add(&txx9_gpio_chip);
+	return gpiochip_add_data(&txx9_gpio_chip, NULL);
 }
-- 
2.4.3
