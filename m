Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2016 07:03:35 +0200 (CEST)
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36625 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990508AbcIXFD2IBuQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Sep 2016 07:03:28 +0200
Received: by mail-pf0-f175.google.com with SMTP id q2so48133016pfj.3
        for <linux-mips@linux-mips.org>; Fri, 23 Sep 2016 22:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6zh1rGS9DGYQ5E5vbMsBUQQ1OJTWD/wuC0JmE3u+qq0=;
        b=KaKYa+qJwFreXzafuUoYX9KeoPP4cAG1gjXYA88JRej20ifrvJai26Nb+5r+b1IrRW
         pxuwH6AKF24jxZv74GZ0eU7Ot6iZ713EwIcuTYy6+hXTEz1s5qnzh6uRTx9+2/d/cQcY
         NJILGdh3+Xmu05NIy+zgh93s57u02Ar8I7LLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6zh1rGS9DGYQ5E5vbMsBUQQ1OJTWD/wuC0JmE3u+qq0=;
        b=cOFNgzdLKzSd6KwjFCI9QzjGlKoJhn5+tgBI+LUIoAI+TxnYQd4Djr71nS8vbyva51
         RWUsvdlmBScWjmCJH5t94JxAS99/h93XxEU9yUKp3ylv4/MOB2y8b4ii3VNw68B2IJ/n
         4EVhypg0AF9kJ9FQh7fIOXOjc7Jsk++Uq8bXnExppIXvQZMEy7S+OZ3nVXdO1tpAEe81
         bVVbPgqLsb42m99gTOMP8D0T2MRRovfF2kpeFSrCVZERt8G9mTD1oOY89Hjoku8cbDmE
         NIyxuK/3N1HXM888SOcDrpEAHYANlLFvRjhD+NvPi+3OQyIt8M6aV2XJVCjgooYknejc
         I4Pg==
X-Gm-Message-State: AE9vXwMZqo11C56XarnvHRDbiyySAfZRJsLs/lM3CPbnEjRa6oQ5YvL8FVJzSVGCdJ+kgTNL
X-Received: by 10.98.193.193 with SMTP id i184mr18623359pfg.69.1474693399639;
        Fri, 23 Sep 2016 22:03:19 -0700 (PDT)
Received: from localhost.localdomain ([45.56.152.27])
        by smtp.gmail.com with ESMTPSA id i4sm14963804pav.27.2016.09.23.22.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Sep 2016 22:03:19 -0700 (PDT)
From:   Baoyou Xie <baoyou.xie@linaro.org>
To:     zajec5@gmail.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn
Subject: [PATCH] firmware/broadcom: add missing header dependencies
Date:   Sat, 24 Sep 2016 13:03:09 +0800
Message-Id: <1474693389-16315-1-git-send-email-baoyou.xie@linaro.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <baoyou.xie@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baoyou.xie@linaro.org
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

We get 1 warning when building kernel with W=1:
drivers/firmware/broadcom/bcm47xx_sprom.c:717:5: warning: no previous prototype for 'bcm47xx_sprom_register_fallbacks' [-Wmissing-prototypes]

In fact, this function is declared in include/linux/bcm47xx_sprom.h,
so this patch adds missing header dependencies.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/firmware/broadcom/bcm47xx_sprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/broadcom/bcm47xx_sprom.c b/drivers/firmware/broadcom/bcm47xx_sprom.c
index 62aa3cf..3471b86 100644
--- a/drivers/firmware/broadcom/bcm47xx_sprom.c
+++ b/drivers/firmware/broadcom/bcm47xx_sprom.c
@@ -27,6 +27,7 @@
  */
 
 #include <linux/bcm47xx_nvram.h>
+#include <linux/bcm47xx_sprom.h>
 #include <linux/bcma/bcma.h>
 #include <linux/etherdevice.h>
 #include <linux/if_ether.h>
-- 
2.7.4
