Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:41:27 +0100 (CET)
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35614 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013554AbbLINkZ4bCs9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 14:40:25 +0100
Received: by lfdl133 with SMTP id l133so34274910lfd.2
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 05:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=YFi/THFSXA+Ztzk7Use8qUJ7hWeefKTM02OWp/MSoCg=;
        b=xocLugglxA3FNVORuR5bemtjECu/B4XZ6TYBZi+18deG1DDpbJ9+5V5nFrkZJeyXkl
         jNn3TwD6hqUxbYPsSFyhFisGeuNm4VgYiFbD5OrXCT2JBqzf+6qYx7M8r425FruCV+RZ
         fYhf8/WwX6PqwVW2emlFLiGiwBquK+1KiBSC9NSGlY7QX9k71jxT3PMQQr3XGncmf47L
         rO2IWUGfKDR0tUW7gZyMocpaRBH6qIVO7ObAVdIESixmiQcgihJv7oFQZcUSXYbIM8wr
         m/4R/V4U67JnAOP61ZUoFPbKO3U7aIenEH++j16M/VBq6ELi6ib4UyGhOzZnsyg09LfC
         SV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YFi/THFSXA+Ztzk7Use8qUJ7hWeefKTM02OWp/MSoCg=;
        b=imEnj68DOnAfc0/qtw0pbj4onSAU46o4Af27T+4FbYUE/035rwLB1aYsEgdqoqgMvb
         NxqxtvF4WC4/5jIa0OJVJ8Sry9GGLaHTwIN6RQcGF6bSSY0PLaTaJ85H7MUfVA3u2AnO
         8njIsB5SI5trYRlm9bTfTNo18Pfz66zaKSrsmwFMVmGgza077ppzJyIBcNUXoURXSV8P
         n1KWyS6siHvy8zSwsOsoauPJrthD1O3xa2m1APY/lp0GRoEfTkK5gor8vdXsKb9AZEPY
         Jsxqpwtpr9ugd9D9fvE5hL/r8oOj2z3+Hhqslnddb/MvJnEkZgh/rrDXfrnwR1ZGHWKs
         7mnw==
X-Gm-Message-State: ALoCoQlPIWw5tB3pBiahO2MD2YF/Wci7PcBWI41mGP3OpCWt2mx5rojrF8DSRSQaX50jvr6H4p8Pb0k4KyU6C03M41Lc0IcvnQ==
X-Received: by 10.25.43.138 with SMTP id r132mr2254719lfr.103.1449668420549;
        Wed, 09 Dec 2015 05:40:20 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id zm10sm1432158lbb.49.2015.12.09.05.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 05:40:19 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org
Subject: [PATCH 142/182] MIPS: txx9: rbtx4938: switch to gpiochip_add_data()
Date:   Wed,  9 Dec 2015 14:40:16 +0100
Message-Id: <1449668416-4785-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50474
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

This one needs to include both <linux/gpio/driver.h> and
<linux/gpio.h> since it is using both the driver and consumer
interface, and looks like one of those cases where the gpio
implementations should be kept local to this file.
---
 arch/mips/txx9/rbtx4938/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index c9afd05020e0..54de66837103 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -14,6 +14,7 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio.h>
 #include <linux/mtd/physmap.h>
 
@@ -335,7 +336,7 @@ static void __init rbtx4938_mtd_init(void)
 
 static void __init rbtx4938_arch_init(void)
 {
-	gpiochip_add(&rbtx4938_spi_gpio_chip);
+	gpiochip_add_data(&rbtx4938_spi_gpio_chip, NULL);
 	rbtx4938_pci_setup();
 	rbtx4938_spi_init();
 }
-- 
2.4.3
