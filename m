Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2018 13:32:22 +0200 (CEST)
Received: from mail-lj1-x243.google.com ([IPv6:2a00:1450:4864:20::243]:38873
        "EHLO mail-lj1-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992925AbeILLcTtHyj2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2018 13:32:19 +0200
Received: by mail-lj1-x243.google.com with SMTP id p6-v6so1311494ljc.5
        for <linux-mips@linux-mips.org>; Wed, 12 Sep 2018 04:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3NDQXcdXcfEDAbxxV89gwSIl7m2F4uMsFBrhFLub3cI=;
        b=Xdz+9IVJ4SObNaS++vS4tx4bA4DEyvZBUcfHwOZCMwLx7ZRIXzUixcrN7cRgwEs4lm
         7+Hdl7hRfGXh5ni2iIwVoq7rEjiSS7s9/03KNPfo/L+1kcC9l4OJ+K2XqETEzAx87UxN
         qXrm3iXc+N+1gQMTkG0/acnFdtxTacofCM0Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3NDQXcdXcfEDAbxxV89gwSIl7m2F4uMsFBrhFLub3cI=;
        b=myz31LhNqQVb5VH9nyMx4T8fONRKFWWVsSfbDh+AeQcj9lLQG8Ff5glUFzFkGg7NSL
         wGrfoc6MybfKM+Jq00QZT9MCsBWL+bdpijCR3xg8mZhZiGWlc8mtoAkgkBSAZjoM1281
         ib/PGWsQfdBkKUQiLPSihj3IKbTEi7PxVibf8e/tLcP5xcUvjo800+oqL7DTbf8L6KJQ
         pjIbAzMPvFtnQHfxscS6iyKnLwnH2R51Sp4jD5ZFd2tQwuXfV1LCdZGesyOArkZTc1O/
         ADikv76K57ugfYJMByPJcgDx99s1OPOZl5tjWMyOEQquP4/OxyUTkywyZza/CFqum3fU
         n/jQ==
X-Gm-Message-State: APzg51CfdD3xXIvlJJ+yryphCtpquasqhJNQakLNq9RungxS7K+RDczn
        VXoc5g022QSdu8cBJhN+nm6idg==
X-Google-Smtp-Source: ANB0VdYJgFuriFTKv/0Y1TOVYSD/O5BdmRNO0Oov1QoRG1OH1nqF4Zn9Gdi0CKekeG/QeCuY9SdwPA==
X-Received: by 2002:a2e:6301:: with SMTP id x1-v6mr1158929ljb.9.1536751933575;
        Wed, 12 Sep 2018 04:32:13 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id q19-v6sm144182lje.29.2018.09.12.04.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:32:12 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     linux-mips@linux-mips.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 1/3] gpio: vr41xx: Include the right header
Date:   Wed, 12 Sep 2018 13:32:02 +0200
Message-Id: <20180912113204.1064-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66215
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

This is a GPIO driver so include only <linux/gpio/driver.h>.

Cc: Yoichi Yuasa <yuasa@linux-mips.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-vr41xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index 027699cec911..7ffb58b0d239 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -21,7 +21,7 @@
  */
 #include <linux/errno.h>
 #include <linux/fs.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-- 
2.17.1
