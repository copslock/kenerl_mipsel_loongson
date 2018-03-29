Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 00:21:34 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:46839
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbeC2WV1hHWyz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2018 00:21:27 +0200
Received: by mail-pg0-x243.google.com with SMTP id t12so3934327pgp.13;
        Thu, 29 Mar 2018 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ADFaJMwdlzFvNSbWVLdPM97dVq/rEeW0+raYjFTrVrU=;
        b=NtO8qs6zBgDdYJBY+JSesp/164xJSYlGY2smytDefJyD36jb04LaF1mTtVIXBoMsAx
         zxVli6bAiUyJfV4NGafawBxqOlL1mg6Rm6BxvISP1fMigpiWbGSPqOh/3QplBEf9WsA8
         2iyR+TdvUZxTfHsaCpJ8yfcYKO0VydWalPVttU/gp5gMQwdXmAb+oAZ1LdMqhPteozLJ
         g4Z+j47soXDFK2ZKZlp+FQQj6IRQJDf/nbAFITuV1TOYOhM5WNleOM7TpO7Dkeh83oMK
         r4e5rB1HjmZV2SrmswCI8Pkm+Wgl8aaS49hyzqyA5w83db9UDbepZivOjDcWX7XMp97J
         jSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ADFaJMwdlzFvNSbWVLdPM97dVq/rEeW0+raYjFTrVrU=;
        b=edIKbKUFNUqhdBsZB83kM1wEzEK2eIk5+p1fDYRakyeYAov/Y2k2X8gBhKrQTBJTgi
         1RDJ3yTT5ujWNVOsCHH7zzZqFu1MBagDx+6OegA1ONRpi7YtmXGsV9PwREqnwlx0h591
         fJZXtHpCpiEXoGUekHYZVI9/GFM7gT3azJYcu/qJncQT2QHLuALnQOTnxLHtivxKtLFM
         a21l+pD5UlnLjXt4Jk6Dv6ITE51RyuSaaJO3R8j+U3tCVCtUYuly2eJpiMNFQsYy+VKM
         pHEtjJtJBpR1btALB0M98QpnN0kkcE9MF5f20rprOToAO3KXQ2PTVtiZTwz8o/xIWcuM
         +YpA==
X-Gm-Message-State: AElRT7GeVqXP586XpIiCjBet3dU6iCsu9QMUFZUo+ShFoM02xfbIjuD2
        ytoRFCIlfR56xgvG3MpWkbOyqNuC
X-Google-Smtp-Source: AIpwx48HAeyXJzEwepAoN+vGhTwCmd/aEm4exHmpTJiFO83rBdDfH5LIw8Ekm3f71IlXhgelXxXzuw==
X-Received: by 10.99.96.210 with SMTP id u201mr6870671pgb.124.1522362080789;
        Thu, 29 Mar 2018 15:21:20 -0700 (PDT)
Received: from localhost.localdomain ([67.139.187.132])
        by smtp.gmail.com with ESMTPSA id r21sm11976020pfj.58.2018.03.29.15.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Mar 2018 15:21:19 -0700 (PDT)
From:   Dan Haab <riproute@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Dan Haab <dan.haab@luxul.com>
Subject: [PATCH] MIPS: BCM47XX: Use standard reset button for Luxul XWR-1750
Date:   Thu, 29 Mar 2018 16:21:47 -0600
Message-Id: <1522362107-3363-1-git-send-email-riproute@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <riproute@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riproute@gmail.com
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

From: Dan Haab <dan.haab@luxul.com>

The original patch submitted for support of the Luxul XWR-1750 used a
non-standard button handler for the reset button. This patch will allow
using the standard KEY_RESTART

Signed-off-by: Dan Haab <dan.haab@luxul.com>
---
 arch/mips/bcm47xx/buttons.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 88a8fb2..88d400d 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -355,7 +355,7 @@
 
 static const struct gpio_keys_button
 bcm47xx_buttons_luxul_xwr_1750_v1[] = {
-	BCM47XX_GPIO_KEY(14, BTN_TASK),
+	BCM47XX_GPIO_KEY(14, KEY_RESTART),
 };
 
 /* Microsoft */
-- 
1.9.1
