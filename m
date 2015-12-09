Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:39:14 +0100 (CET)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34599 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007132AbbLINjM0vUq9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 14:39:12 +0100
Received: by lbbcs9 with SMTP id cs9so30075305lbb.1
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HGuqBvb16iul3XQ6EsbBlPDWr3Quph4et65LJrfbZrU=;
        b=fyscu2QO3uzKC6KBeMeUK9iSC8FYWMzwFvBdCsDS1CBScR/6SKcPeHIeu9GfUgzphG
         aP1wTDpg19Io7pE56t+qKsZJ+26CYm0cER49EotBYlt24aMMitkocLMAyc0w/4ODYGYe
         AcIu/PGwlT+qlq7AC926Qs09M3aK5aFkXK52IlLzcpBmhhkkYPBoXYndBGW7rzKYAEF9
         aC9UAt0YsQTRP03GpbbKEb6OhzCUoK8I+btcvPZRWmAeu9XGXNPkexuBURyhrZwe1di+
         K6nxxHiPkY2mILDMwTU/SP0QrmLTjcvHA9Wl+XGUZND/wSjIgw1ptk1KZyJtwf99IiA0
         ce9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HGuqBvb16iul3XQ6EsbBlPDWr3Quph4et65LJrfbZrU=;
        b=TZ6xsInPhSWfX6AGWuiK2FWAXNqcTlJ6ddSIH4m4nmwc9a+LSO8hdXk8sq/LxfnFYW
         Pjzo7kug7oPzg5rhyP9nE9s6P4K6ET8HtnW+bP4EdHKXjBGlKGwl3/0uQvUieNeYVYqj
         2rcAsfSNbCmZ6KJfqLjCzdDVS+XggH7EGyy9Ju9I1mu3Bbx13uq1GkRIISqgAorO88Ez
         hUjKWdOxLCCbGCxShQEUmFqc3lpkQJgHu65J2AxgiK1JrKO3TTPn6xcOg3KimaTCMfoo
         h2332jBtiVnqYDTdwvacjGV5269vFrC8+trwI/jnDQX3Ma8JQgG0E/FTHeRxLFWWZnNt
         ZPCA==
X-Gm-Message-State: ALoCoQmFVmTo0BAeo+7vZXixdKUAJKc4qboLwMRRRjwf7uEMMstmZeSjEg6JoKe3ZRnIAFoJN8bdqmg5b2OlIjTwikTAAmTTAA==
X-Received: by 10.112.218.5 with SMTP id pc5mr2437995lbc.76.1449668346993;
        Wed, 09 Dec 2015 05:39:06 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t12sm1449333lbs.5.2015.12.09.05.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 05:39:06 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-mips@linux-mips.org
Subject: [PATCH 135/182] MIPS: alchemy: switch to gpiochip_add_data()
Date:   Wed,  9 Dec 2015 14:39:02 +0100
Message-Id: <1449668342-4446-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50467
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
to drivers/gpio in the long run.
---
 arch/mips/alchemy/common/gpiolib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/alchemy/common/gpiolib.c b/arch/mips/alchemy/common/gpiolib.c
index f9bc4f520440..e2606f8eb2fa 100644
--- a/arch/mips/alchemy/common/gpiolib.c
+++ b/arch/mips/alchemy/common/gpiolib.c
@@ -160,14 +160,14 @@ static int __init alchemy_gpiochip_init(void)
 
 	switch (alchemy_get_cputype()) {
 	case ALCHEMY_CPU_AU1000:
-		ret = gpiochip_add(&alchemy_gpio_chip[0]);
+		ret = gpiochip_add_data(&alchemy_gpio_chip[0], NULL);
 		break;
 	case ALCHEMY_CPU_AU1500...ALCHEMY_CPU_AU1200:
-		ret = gpiochip_add(&alchemy_gpio_chip[0]);
-		ret |= gpiochip_add(&alchemy_gpio_chip[1]);
+		ret = gpiochip_add_data(&alchemy_gpio_chip[0], NULL);
+		ret |= gpiochip_add_data(&alchemy_gpio_chip[1], NULL);
 		break;
 	case ALCHEMY_CPU_AU1300:
-		ret = gpiochip_add(&au1300_gpiochip);
+		ret = gpiochip_add_data(&au1300_gpiochip, NULL);
 		break;
 	}
 	return ret;
-- 
2.4.3
