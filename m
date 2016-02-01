Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 01:11:31 +0100 (CET)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35203 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011924AbcBAAK4CHBXA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 01:10:56 +0100
Received: by mail-lf0-f44.google.com with SMTP id l143so18959229lfe.2
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nYpaZIKToQ5zOTcT2/pGAI9ZFvtkdKLtOKFngU0V6n4=;
        b=mPZnfZKx0P+x9m03y234URDgEyGCsTnnCKk432dzxOcdPGBEk6PXWPEXpXepvpUl82
         G/4R/Ys9A+hD66caB4F68lkPm+Cqhnh5uwXpLCg2cPV7Pre1AOaBF5M008VbkSa+9QPN
         6+Jyj70VYBoOi7gzrkLREeuUMQpWmmHwweccrvw0O2F0c/6SwuXpMiHcxr6OClzdEHcz
         GjVNBrchJ/eGMhNDdoadJWBDFdH5XFkzWKUfLcnYV5r+0ZtOF5ZOGOgmT6+AkDJqrtLu
         DPfl9kqsANYezkE2bg2PMzaqczcZAxIC5Q6tUz+bQ4Y04ow3QPkTt+lHdfXCVGzi+LEe
         7KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nYpaZIKToQ5zOTcT2/pGAI9ZFvtkdKLtOKFngU0V6n4=;
        b=JsnwN7fDPXOINUYfGrApt0WLUiHxnUOEEq/ZDQzN8yukQMmXQRl+hb2rLUmJfX6ZgI
         ZesgPP3MO6XFVKdJYZHBHcWcEOUemSuhXC/L7GXZmtZ/sO7IWhWG6Qy/E0znfuaTKpJv
         glVht3X4WNtdvcCfBTe5b6mO6oXPg1TlpHqT6PdUQoS8q7BAdQG5jDHeiL6lWyGIivZi
         HvJUBRSnmXUQEOxGeME69flGZeYDJwrXVSKJHqnIZzOlSbo8vKVCsWqZdjl5HVqeViE5
         LDW1qrSOdHxE7p14IRNqJUnUbgOIV1iHiH0vDo2HNV96t8RZuJucXMjcIlTe6ZEL6t1z
         7TRA==
X-Gm-Message-State: AG10YORT3ZgKu2UtDFAEO6fcJnPjmBhHRfe/s3sj45uQQDtB2SUZoyLG3wy4MRLJiw8fOg==
X-Received: by 10.25.155.81 with SMTP id d78mr5902142lfe.77.1454285450717;
        Sun, 31 Jan 2016 16:10:50 -0800 (PST)
Received: from localhost.localdomain (ppp109-252-26-184.pppoe.spdop.ru. [109.252.26.184])
        by smtp.gmail.com with ESMTPSA id o97sm2807958lfi.25.2016.01.31.16.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 16:10:50 -0800 (PST)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Antony Pavlov <antonynpavlov@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, Alban Bedel <albeu@free.fr>
Subject: [RFC v4 02/15] MIPS: ath79: use clk-ath79.c driver for AR913X/AR933X
Date:   Mon,  1 Feb 2016 03:10:27 +0300
Message-Id: <1454285440-18916-3-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
References: <1454285440-18916-1-git-send-email-antonynpavlov@gmail.com>
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Alban Bedel <albeu@free.fr>
Cc: linux-mips@linux-mips.org
---
 arch/mips/ath79/clock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index eb5117c..3289073 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -24,6 +24,7 @@
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
 #include "common.h"
+#include "machtypes.h"
 
 #define AR71XX_BASE_FREQ	40000000
 #define AR724X_BASE_FREQ	5000000
@@ -441,7 +442,9 @@ static void __init qca955x_clocks_init(void)
 
 void __init ath79_clocks_init(void)
 {
-	if (soc_is_ar71xx())
+	if (IS_ENABLED(CONFIG_OF) && mips_machtype == ATH79_MACH_GENERIC_OF) {
+		/* pass */
+	} else if (soc_is_ar71xx())
 		ar71xx_clocks_init();
 	else if (soc_is_ar724x())
 		ar724x_clocks_init();
@@ -483,8 +486,6 @@ static void __init ath79_clocks_init_dt(struct device_node *np)
 
 CLK_OF_DECLARE(ar7100, "qca,ar7100-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar7240, "qca,ar7240-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9130, "qca,ar9130-pll", ath79_clocks_init_dt);
-CLK_OF_DECLARE(ar9330, "qca,ar9330-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9340, "qca,ar9340-pll", ath79_clocks_init_dt);
 CLK_OF_DECLARE(ar9550, "qca,qca9550-pll", ath79_clocks_init_dt);
 #endif
-- 
2.7.0
